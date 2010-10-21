From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [long] worktree setup cases
Date: Wed, 20 Oct 2010 22:30:42 -0500
Message-ID: <20101021033042.GA1891@burratino>
References: <20101020085859.GA13135@do>
 <20101020190709.GB10537@burratino>
 <AANLkTimzfxJFz2FRVCJ7b4+icXMxpQGNo0WGm_BXzXNy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, fbriere@fbriere.net, drizzd@aon.at
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 05:34:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8lvF-00069J-Pq
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 05:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757382Ab0JUDe3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Oct 2010 23:34:29 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:62062 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757277Ab0JUDe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 23:34:28 -0400
Received: by ywi6 with SMTP id 6so2457185ywi.19
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 20:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=OykQiMeSseWwTnG1jVAGlsvauV3ZwmpqkICkdLtnMvY=;
        b=g11NBuy0B0mTRaT1JvUb0Z7fPl3ziIwJ48oh6uuGFvj2uQz9WIiyAIVhbsxXHtn+SN
         l/UgyziuMFAIfnQ//d3UJU8qOaQsMmC6823cm0n4BHDTBjvX1nUQA2UPIhHsDQWQIF/O
         5cwlmoO9Jbtbyltd14gNBd5l+RbijvkddjE+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=HKIUZKhH9tb1gDPX9YcJnlP4ygJypHaAWKUD8uDXwevxWlHou3m30Vipcen4me6g0T
         kLpmKCIznvqusE5J8+gMyYC54Pqd7o9W1HJ+qfcLhA9sKHAiCcf1eOV9P6+/dMOlOszi
         A+i7fqCVBfxRRteaKCWZuimgT4iJZxWWCJtsw=
Received: by 10.151.12.20 with SMTP id p20mr2889686ybi.14.1287632067706;
        Wed, 20 Oct 2010 20:34:27 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id q18sm7554112ybk.15.2010.10.20.20.34.25
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 20 Oct 2010 20:34:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimzfxJFz2FRVCJ7b4+icXMxpQGNo0WGm_BXzXNy@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159482>

Nguyen Thai Ngoc Duy wrote:
> On Thu, Oct 21, 2010 at 2:07 AM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:

>> =C2=A0- otherwise, if original cwd was under repository,
[...]
>> =C2=A0            GIT_WORK_TREE defaults to unset.
>
> What do you mean by "under repository"? If the repo is /tmp/git/.git,
> then cwd is at /tmp/git/.git?

I meant if the original cwd lies within the repository.

Example:

 repo		/tmp/git/.git
 starting cwd	/tmp/git/.git/objects/pack

>> D. User-supplied relative paths.
>>
>> =C2=A0- path in .git file is relative to containing directory
>> =C2=A0- path in GIT_DIR is relative to original cwd
>> =C2=A0- paths in GIT_WORK_TREE and core.worktree are relative to
>> =C2=A0 $GIT_DIR
>
> I think $GIT_WORK_TREE is relative to original cwd.

git.txt is confusing, then.  Actually it has some other insights:

 --work-tree=3D<path>
	Set the path to the working tree. The value
	will not be used in combination with
	repositories found automatically in a .git
	directory (i.e. $GIT_DIR is not set).

So GIT_WORK_TREE should be discarded or warned about when GIT_DIR is
not set. (?)

	This can also be controlled by setting the
	GIT_WORK_TREE environment variable and the
	core.worktree configuration variable. It can be
	an absolute path or relative path to the
	directory specified by --git-dir or GIT_DIR.

This is where I got the impression about relative paths.

	Note: If --git-dir or GIT_DIR are specified but
	none of --work-tree, GIT_WORK_TREE and
	core.worktree is specified, the current working
	directory is regarded as the top directory of
	your working tree.

Nice to see this case is documented.

> Yes, core.worktree
> should be relative to $GIT_DIR.

Speaking of which, it is not clear to me that core.worktree should
fall under the forbidden case discussed above.  If it does, what is
the point of making it configurable?

> Yes.

Thanks for checking.

Jonathan
