From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] i18n: leave \n out of translated diffstat
Date: Sun, 24 Jun 2012 11:04:11 -0500
Message-ID: <20120624160411.GA18791@burratino>
References: <1340541692-10834-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 18:04:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SipIV-0006Qy-Oy
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jun 2012 18:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600Ab2FXQEU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Jun 2012 12:04:20 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:49283 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491Ab2FXQET convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Jun 2012 12:04:19 -0400
Received: by yenl2 with SMTP id l2so2355717yen.19
        for <git@vger.kernel.org>; Sun, 24 Jun 2012 09:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7kIQPp+KBVYxGnQMn1LvvQO9GcPpjllqAf36wZOKf6c=;
        b=BXeDIDEDyQazPngOnu4mKx7PVg3j5nQM/iAkqbIjYjBq0uyeVMdA92ZkYlmiKudF3Q
         KjSMym0CvvXaz5F6ML4ykLkHXIW3i8XX4MG7xKubFZh6mNGgL1jt0Flg9hqd0o18rjq7
         3y5H3y2ZH6JfUD4g43q0k2UQ8AGtOte3Kbip4ExCqt31jVy2LV4xG9jj33vhns99ekoL
         lfaXXGEhxu77AE8G4sENGYURtiWydEikRrj9xP5ajqIEFo7LpZsBJv5Yu8nhOOa0QA6Q
         GDyZawG1e5oT/yHpRyY2ZFFvUoR5whIYiHKUiYPWKOJeZnPF3CQMYmKlXLLekZAGSooL
         MrPg==
Received: by 10.42.87.75 with SMTP id x11mr3848015icl.25.1340553858334;
        Sun, 24 Jun 2012 09:04:18 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id k6sm4335054igz.9.2012.06.24.09.04.17
        (version=SSLv3 cipher=OTHER);
        Sun, 24 Jun 2012 09:04:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1340541692-10834-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200535>

Hi,

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> GETTEXT_POISON scrapes everything in translated strings, including \n=
=2E
> t4205.12 however needs this \n in matching the end result. Keep this
> \n out of translation to make t4205.12 happy.
[...]
> --- a/diff.c
> +++ b/diff.c
> @@ -1397,7 +1397,7 @@ int print_stat_summary(FILE *fp, int files, int=
 insertions, int deletions)
> =20
>  	if (!files) {
>  		assert(insertions =3D=3D 0 && deletions =3D=3D 0);
> -		return fputs(_(" 0 files changed\n"), fp);
> +		return fprintf(fp, "%s\n", _(" 0 files changed"));

More importantly, this makes the string more similar to other
translated strings in the same file and saves translators from having
to remember to worry about appropriate whitespace at the end of the
string.

Actually, it should be possible to make their lives even easier.  How
about this?

diff --git i/diff.c w/diff.c
index 1a594df4..c53eea50 100644
--- i/diff.c
+++ w/diff.c
@@ -1395,11 +1395,6 @@ int print_stat_summary(FILE *fp, int files, int =
insertions, int deletions)
 	struct strbuf sb =3D STRBUF_INIT;
 	int ret;
=20
-	if (!files) {
-		assert(insertions =3D=3D 0 && deletions =3D=3D 0);
-		return fputs(_(" 0 files changed\n"), fp);
-	}
-
 	strbuf_addf(&sb,
 		    Q_(" %d file changed", " %d files changed", files),
 		    files);
