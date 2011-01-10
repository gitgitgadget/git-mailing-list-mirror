From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Fix wrong failures in config test
Date: Mon, 10 Jan 2011 15:59:33 -0600
Message-ID: <20110110215933.GB12030@burratino>
References: <20110110194242.GA11801@burratino>
 <4d2b7b68.47102a21.bm000@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
X-From: git-owner@vger.kernel.org Mon Jan 10 22:59:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcPmM-0004qY-3D
	for gcvg-git-2@lo.gmane.org; Mon, 10 Jan 2011 22:59:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754915Ab1AJV7r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jan 2011 16:59:47 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34706 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754325Ab1AJV7p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jan 2011 16:59:45 -0500
Received: by vws16 with SMTP id 16so8298535vws.19
        for <git@vger.kernel.org>; Mon, 10 Jan 2011 13:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=WT5/2OISy9IyNj089AWVCpl9JC1TxJldC/rFHM1ELX8=;
        b=ZmW33vRZluacFstrleamRqW/SNbDSa08G+LRvgXWHdc/lnj2wAUJONsUo2xWpL+VuF
         7WwDdIL9LrCrakTkmGfCTOmjM7EfbgDTSJ7VLa1DVEEFiKGhJAUN2WyuvyZUYkYovjN6
         hfkjubcRvN/F9GIS45qFF8QLSSQdPdMFqloH0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=xIQGCGUCiPRqn1s/SKrIhu6wwnBTdk00YXnvZmV27miZ2YvE0ktyzFeZc6kJ7eAOJL
         LvfdmzEr1JfyoGPdtfQBNVU6kGYHuCgvIgYpFl5wEgh2hRnUdtKaNEeoJt8UQIIZiZDM
         ds/nll4p9RmEHzWUxxOAtEtusr9ywhYZ3fnn4=
Received: by 10.220.199.130 with SMTP id es2mr2074745vcb.192.1294696782673;
        Mon, 10 Jan 2011 13:59:42 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id u4sm6474475vch.12.2011.01.10.13.59.39
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 10 Jan 2011 13:59:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4d2b7b68.47102a21.bm000@wupperonline.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164901>

Ingo Br=C3=BCckl wrote:

> It's a function (available in login shells and thus during the test s=
uite):

The test suite doesn't run in a login shell.  As I hinted before, you c=
an
put

	case "$-" in
	*i*)	# interactive shell
		;;
	*)
		return 0
	esac

in your .bashrc before the function definition and all should be well.

> From what I've learned from you now, if 'git' is an exported bash fun=
ction,
> 'VAR=3Dval git' will always automatically result in VAR being exporte=
d

I didn't understand at first why this particular vintage of bash makes
VAR leak into the current environment.  I tried to reproduce it with
Debian bash 3.2-4 (which is based on bash 3.2.39(1)-release) with no
success.

In any event git avoids

	VAR=3Dval fn

when fn is a function for this and possibly other reasons (see [1]).

I do not think git ought to guard against a git function (or alias) in
the user's environment, even though doing so might lead to a better
user experience and less confusion on the mailing list.  git does not
protect against 'rm' being an alias to 'rm -i' or 'svn' being an
alias, either.

Regards,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/135766/focus=
=3D137095
