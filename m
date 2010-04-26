From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: MIME problem when using git format-patch / git am
Date: Sun, 25 Apr 2010 20:49:41 -0500
Message-ID: <20100426014941.GA29220@progeny.tock>
References: <20100425233549.GA8737@triton>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?iso-8859-1?B?2Hl2aW5kIEEu?= Holm <sunny@sunbase.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 26 03:49:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6DRV-0000TJ-2z
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 03:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754250Ab0DZBsz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Apr 2010 21:48:55 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36614 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536Ab0DZBsz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 21:48:55 -0400
Received: by gyg13 with SMTP id 13so6087465gyg.19
        for <git@vger.kernel.org>; Sun, 25 Apr 2010 18:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=uXNa4GGbC06n2lgvVBKkI4ZAijvv2D7EiRA1pyETtLw=;
        b=FAA0Fd8XmfIXdtI5LLVwb9T/Ka8jPAzexxslN15vRhIfsVV5a9HuLsklM5SgxlM/yc
         fXmcwRyT47pIdEWw4UdT/mBevoShd03fiC1GDomcFnGNxtBsDtQaQm+pWsNQ2zkTbvsl
         K3MghocefQFDQx+Joi+OiRCEQAH8SEmyOJx7E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Xs5Hb09+z7tVF1QydKazWxXZ7+Lo/suYt/zMNn6/vu6yI+lgqx1eUWBRXB/dTXv62b
         jJbhjVqiIvepzLZf55dFKu5oqWULpmdLjM4ka5ig3ghOfXfg3toNvPbZcWkmG+nbELcu
         p68N+FLHO6mS9EiGaV0k6346KlvLOxA1EC8wU=
Received: by 10.90.236.8 with SMTP id j8mr1737710agh.5.1272246534020;
        Sun, 25 Apr 2010 18:48:54 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm2679766iwn.9.2010.04.25.18.48.53
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Apr 2010 18:48:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100425233549.GA8737@triton>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145778>

Hi,

=C3=98yvind A. Holm wrote:

| git commit -m "Initial commit" --allow-empty
| git tag firstrev
| echo First line >foo.txt
| git add foo.txt
| git commit -m "First commit without 8-bit chars"
| echo Second line >>foo.txt
| git commit -m "Second commit with =C2=A9 in first line of logmsg" -a
| echo Third line >>foo.txt
| git commit -m "Third commit with no 8-bit in first line`echo; echo bu=
t =E2=82=ACuro further down`" -a
| echo Fourth line >>foo.txt
| git commit -m "Fourth commit with =C2=A9 in first line again" -a
| git format-patch firstrev
| git checkout -b patches firstrev
| git am 0*
| git log
[...]
|    Applying: =3D?UTF-8?q?Third=3D20commit=3D20with=3D20no=3D208-bit=3D=
20in=3D20first=3D20line
|    Applying: Fourth commit with =C2=A9 in first line again

On this machine, it=E2=80=99s even worse:

    =3D?UTF-8?q?Third=3D20commit=3D20with=3D20no=3D208-bit=3D20in=3D20f=
irst=3D20line
   =20
    =3D20but=3D20=3DE2=3D82=3DACuro=3D20further=3D20down?=3D
    MIME-Version: 1.0
    Content-Type: text/plain; charset=3DUTF-8
    Content-Transfer-Encoding: 8bit

An encoded-word [1] is defined to be at most 75 characters long and not
to contain whitespace.  On the other hand, multiple encoded-words
within a field are required to be separated by whitespace.

[1] http://tools.ietf.org/html/rfc2047

This leads to a question: what if one wants to include a word that
quotes to more than 75 characters?  How about more than 997 ASCII
characters without whitespace?  No can do.

Ideally, I would like to see git quoting single words, though I admit
I have not seen how well various user agents cope with this.

Maybe this patch would give you some joy until then.  Feel free to pick
it up and take it somewhere more useful.

Thanks,
Jonathan

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

diff --git a/pretty.c b/pretty.c
index d493cad..b822e24 100644
--- a/pretty.c
+++ b/pretty.c
@@ -131,7 +131,7 @@ needquote:
 		 * many programs do not understand this and just
 		 * leave the underscore in place.
 		 */
-		if (is_rfc2047_special(ch) || ch =3D=3D ' ') {
+		if (is_rfc2047_special(ch) || ch =3D=3D ' ' || ch =3D=3D '\n') {
 			strbuf_add(sb, line + last, i - last);
 			strbuf_addf(sb, "=3D%02X", ch);
 			last =3D i + 1;
