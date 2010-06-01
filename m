From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/8] revert: change help_msg() to take no argument
Date: Tue, 1 Jun 2010 00:08:15 -0500
Message-ID: <20100601050815.GB22441@progeny.tock>
References: <20100531193359.28729.55562.chriscool@tuxfamily.org>
 <20100531194240.28729.49459.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Jun 01 07:08:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJJiD-0000Zk-GR
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 07:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840Ab0FAFIU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 01:08:20 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49733 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573Ab0FAFIT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 01:08:19 -0400
Received: by gye5 with SMTP id 5so829522gye.19
        for <git@vger.kernel.org>; Mon, 31 May 2010 22:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=t7xVZJaOobw3ZEAnCJFT1VoGXIsBflYgGcL8Ezk9V6s=;
        b=edeONiP4O5/erO1c2E7pGi/vVEP9WEb0CQKUWN2NmHWLjsBkPKvL7AUE3fo/x9ZXlu
         7rZckTGN6G8Zgiz6mabH20nb4oB/G/ZbNb3BfhTjPrmojm0Q1SN6kjfOn32WHxgRI3EZ
         EegCbI8OTx2URuMLzNJjg1xmBhqRAfE2demk0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=vtREkgXY5UbjFzfkts5BYF7O6Khzey08/+dPMeumBHjGRtu+cFiplbUYTH/jKfCDCf
         0xAXY7u5uWv9V9V7/9D21iORiL5ecPllQaPR9gWwShPPFD5mhWFd5K9HLGsHhEBWKMfE
         bZok28J29A4AcaH0OL4ER2zDkKe8izOswqCLw=
Received: by 10.42.7.17 with SMTP id c17mr231993icc.10.1275368898664;
        Mon, 31 May 2010 22:08:18 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id a8sm29620461ibi.23.2010.05.31.22.08.17
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 31 May 2010 22:08:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100531194240.28729.49459.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148077>

Christian Couder wrote:

> +++ b/builtin/revert.c
> @@ -239,7 +239,7 @@ static void set_author_ident_env(const char *mess=
age)
>  			sha1_to_hex(commit->object.sha1));
>  }
> =20
> -static char *help_msg(const char *name)
> +static char *help_msg(void)
>  {
>  	struct strbuf helpbuf =3D STRBUF_INIT;
>  	char *msg =3D getenv("GIT_CHERRY_PICK_HELP");
> @@ -255,7 +255,7 @@ static char *help_msg(const char *name)
>  		strbuf_addf(&helpbuf, " with: \n"
>  			"\n"
>  			"        git commit -c %s\n",
> -			name);
> +			    sha1_to_hex(commit->object.sha1));
>  	}
>  	else
>  		strbuf_addch(&helpbuf, '.');

producing a message like

  Automatic cherry-pick failed.
    After resolving the conflicts,
  mark the corrected paths with 'git add <paths>' or 'git rm <paths>'
  and commit the result with:=20

  	git commit -c 8a7cdf

Is there any reason not to suggest =E2=80=98git commit=E2=80=99 without=
 the -c?  This
way, the template message includes a helpful Conflicts: string, too.

---
 builtin/revert.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index f0d78e5..bbafc41 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -254,8 +254,7 @@ static char *help_msg(void)
 	if (action =3D=3D CHERRY_PICK) {
 		strbuf_addf(&helpbuf, " with: \n"
 			"\n"
-			"        git commit -c %s\n",
-			    sha1_to_hex(commit->object.sha1));
+			"        git commit\n");
 	}
 	else
 		strbuf_addch(&helpbuf, '.');
--=20
1.7.1
