From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 01/10] add: do not rely on dtype being NULL behavior
Date: Mon, 15 Nov 2010 20:42:52 -0600
Message-ID: <20101116024252.GA29358@burratino>
References: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
 <1289817410-32470-2-git-send-email-pclouds@gmail.com>
 <20101115121415.GB14729@burratino>
 <AANLkTikkArsu=NLJWQcP61uf3yrQmdxRQtB+3AmC9tHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 16 03:43:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIBWF-0005r5-Rm
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 03:43:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759190Ab0KPCnf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Nov 2010 21:43:35 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:53646 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753494Ab0KPCne (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 21:43:34 -0500
Received: by qwb8 with SMTP id 8so205445qwb.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 18:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=O1psDhPSQoya1NljN9Vbelck80FIHOqIqv0rbTzHtfE=;
        b=f7k+nR2oSdhN9+wQxdjJuvH1wlbw7jH06MX+vjPE0rCbEVG3KwvL5KHoUFT2sAbxkM
         1SbQb+pSZKo05HVr817AQHry46M0aZ1SPD/gewKNZjbSn4dLs9J7wkvQMENyC72m4TNh
         Y6dReoqmqScVE4kXizdWupRZNcjSJyyjya7g4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=OWJPVvQbJ/shZwC5lyg96TgNkhoNlTmYQLhRU5+TGG5EtgZJzwrcCIRD7eEQWILq4s
         o7ohbVdeHAXNkK9ksAKWbgpTSV+3ak2pqo+Jho7ZEOuWq42oAy6RUNKrkZy7ixvP41l9
         ai0t3t9cgg2Cg8N+2mSwguULOXC6CRfyf0Uyw=
Received: by 10.224.177.6 with SMTP id bg6mr6085157qab.120.1289875413665;
        Mon, 15 Nov 2010 18:43:33 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id s28sm437129qcp.33.2010.11.15.18.43.29
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 15 Nov 2010 18:43:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikkArsu=NLJWQcP61uf3yrQmdxRQtB+3AmC9tHQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161532>

Nguyen Thai Ngoc Duy wrote:
> On Mon, Nov 15, 2010 at 7:14 PM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:

>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Surely what was really wanted is to check=
 paths against the
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0index and work tree, defaulting to "regul=
ar file".
>>
>> Wait --- that's not true. =C2=A0In the "git submodule add" case, we =
really
>> want to default to (or even better, force) "directory".
>
> Hmm.. get_index_dtype() would return DT_DIR if the submodule exists i=
n
> index. If it does not it must be a directory in worktree, right?
> Call flow: excluded_from_list() -> get_dtype() -> get_index_dtype()

based on

	git ls-files --error-unmatch "$path" >/dev/null 2>&1 &&
	die "'$path' already exists in the index"

	if test -z "$force" && ! git add --dry-run --ignore-missing "$path" > =
/dev/null 2>&1
	then
		echo >&2 "The following path is ignored by one of your .gitignore fil=
es:" &&
		echo >&2 $path &&
		echo >&2 "Use -f if you really want to add it."
		exit 1
	fi

	# perhaps the path exists and is already a git repo, else clone it
	if test -e "$path"

I'd say no, the usual case is that the potential submodule does not
exist in the index or worktree, which is why that call site uses
--ignore-missing.
