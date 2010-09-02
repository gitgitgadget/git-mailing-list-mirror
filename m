From: Jonathan Nieder <jrnieder@gmail.com>
Subject: git instaweb for Debian squeeze (Re: Bug#592733: git instaweb
 broken)
Date: Thu, 2 Sep 2010 17:12:11 -0500
Message-ID: <20100902221211.GA4789@burratino>
References: <20100812131152.2333.9604.reportbug@octopus.hi.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: 592733@bugs.debian.org, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Fri Sep 03 00:14:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrI2s-00043B-3d
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 00:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755312Ab0IBWOD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 18:14:03 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:46355 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753460Ab0IBWOB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 18:14:01 -0400
Received: by qyk36 with SMTP id 36so2540973qyk.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 15:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=iBXC/zTpqRcQSRljSyKh5TTy372HfXST4rRwQrrCKP8=;
        b=fjjr3/xOjYGqBNyOMNGIvUF64I283BxnZv5OI9ewXlUFP5s2aMav+SdXpKbZs/xroq
         lYIl9MR+X0d9npL+mweK8WA0rLiCGX30fjsuoRk/eedNzXBgzlqoL5HFeqcp7Q4n54/N
         N7KJvAJOgF+xoXlR8TWbVOy9iHXJgRm0XU0dQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Ivv8g6prfn7YRXVtJ8lSgc541PxwuVebICfV5ipLV3CAET6Xx+SefmiHvaW8nnmR1m
         sBWV/HQoZNo6b4e4xcgvcRF7AvB7wnpWSqN4bFyvlFk3xxB77PBNO0sQDUhbiVYRA9OV
         XsHPkbyq+O0g9QQ5NAnNFBris+AfGot1w47+k=
Received: by 10.224.10.197 with SMTP id q5mr7121024qaq.129.1283465640770;
        Thu, 02 Sep 2010 15:14:00 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r38sm1010346qcs.26.2010.09.02.15.13.59
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 15:13:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100812131152.2333.9604.reportbug@octopus.hi.pengutronix.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155214>

Hi again,

Uwe Kleine-K=C3=B6nig wrote:

> when I start git instaweb on a git repository, I get a crippled view
> (no style sheets, no images) that doesn't include the current project=
=2E

Ok, so the proper fix is v1.7.2-rc0~55^2~3, but that seems too dramatic
to try at the moment for squeeze (for which the plan is to basically
go with gitweb and instaweb 1.7.1).  Does this workaround help?

Eric, do you think it is worth duplicating the logo and favicon within
pre-v1.7.2 instaweb?  The script already takes 252 KiB, so an extra
10 KiB might not be such a big deal.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/git-instaweb.sh b/git-instaweb.sh
index 0c6e103..95d3d0a 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -387,7 +387,11 @@ script=3D'
 s#^(my|our) \$projectroot =3D.*#$1 \$projectroot =3D "'$(dirname "$fqg=
itdir")'";#;
 s#(my|our) \$gitbin =3D.*#$1 \$gitbin =3D "'$GIT_EXEC_PATH'";#;
 s#(my|our) \$projects_list =3D.*#$1 \$projects_list =3D \$projectroot;=
#;
-s#(my|our) \$git_temp =3D.*#$1 \$git_temp =3D "'$fqgitdir/gitweb/tmp'"=
;#;'
+s#(my|our) \$git_temp =3D.*#$1 \$git_temp =3D "'$fqgitdir/gitweb/tmp'"=
;#;
+s#(my|our) \$logo =3D.*#$1 \$logo =3D "/usr/share/gitweb/git-logo.png"=
;#;
+s#(my|our) \$favicon =3D.*#$1 \$favicon =3D "/usr/share/gitweb/git-fav=
icon.png";#;
+s#(my|our) \$GITWEB_CONFIG_SYSTEM =3D.*#$1 \$GITWEB_CONFIG_SYSTEM =3D =
"";#;'
+
=20
 gitweb_cgi () {
 	cat > "$1.tmp" <<\EOFGITWEB
--=20
