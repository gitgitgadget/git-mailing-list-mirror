From: bill lam <cbill.lam@gmail.com>
Subject: smudge filter problem
Date: Sun, 1 Mar 2009 18:18:23 +0800
Message-ID: <20090301101823.GA7466@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 01 11:20:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ldim8-0008Jc-0R
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 11:20:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbZCAKSc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Mar 2009 05:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751669AbZCAKSc
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 05:18:32 -0500
Received: from ti-out-0910.google.com ([209.85.142.186]:39996 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbZCAKSb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 05:18:31 -0500
Received: by ti-out-0910.google.com with SMTP id d10so2520483tib.23
        for <git@vger.kernel.org>; Sun, 01 Mar 2009 02:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        bh=c5yvahKcrlPhX7V+lwiFiAB4C8M4PjfMN30N/ggeyD4=;
        b=aPaJfQfHsSNg1YDzXuL8z+if7NUNc/IWpi9NKk3m33v37yishxBdU19vBwhiC5twEw
         SD2ypJNLEH2BHLW++t4WmQbptF7nQKxiPXEnh9O8ZltYk6zbmWX/Gu9QXaBHs8PDYsVD
         ieipDeCjG1Z710Y4+JXVm/1SvpqxlbclheIQc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :user-agent;
        b=lA7sPbMm3CEZk99hv/x3sInuTQm8gwpvBPU5lY5z4GEeLMEBmMcAQxebIQPjXMz3uF
         xua7TFy/+FLvNuVbBZc9PKypn9GE/QrdAGXPkkMBrUuWHIS/dqePJzoP48HDWLWw1dAj
         5axeXLJu2ZRChkveNxZBhdBNt/eRBNZZnD/ZE=
Received: by 10.110.105.5 with SMTP id d5mr1609687tic.19.1235902707642;
        Sun, 01 Mar 2009 02:18:27 -0800 (PST)
Received: from localhost (n219079102208.netvigator.com [219.79.102.208])
        by mx.google.com with ESMTPS id y5sm7376720tia.17.2009.03.01.02.18.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 01 Mar 2009 02:18:26 -0800 (PST)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111835>

I track xls by using filter to convert it to gnumeric format. Inside gi=
tconfig
[filter "excelbiff"]
  clean =3D ssconvert --export-type=3DGnumeric_XmlIO:sax fd://0 fd://1 =
| zcat -f
  smudge =3D ssconvert --export-type=3DGnumeric_Excel:excel_biff8 fd://=
0 fd://1
and xls set inside gitattribute

While the clean filter works, the smudge filter does not. When git-chec=
kout it said seek error=20
 git ckeckout foo.xls

However git-show works as pipe to ssconvert
 git show HEAD:foo.xls | ssconvert --export-type=3DGnumeric_Excel:excel=
_biff8 fd://0  newfoo.xls

I guess ssconvert was mistaken to believe that all data has been flushe=
d too soon.

I tested with an xls that converted to gnumeric uncompress file size ab=
out 10MB and libgsf 1.14.11

PS. for older libgsf it needs to using a temp file to buffer data for s=
sconvert instead of using fd://0

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9019 =E5=AD=9F=E6=B5=A9=E7=84=B6  =E5=A4=8F=E6=97=A5=E5=
=8D=97=E4=BA=AD=E6=87=B7=E8=BE=9B=E5=A4=A7
    =E5=B1=B1=E5=85=89=E5=BF=BD=E8=A5=BF=E8=90=BD  =E6=B1=A0=E6=9C=88=E6=
=BC=B8=E6=9D=B1=E4=B8=8A  =E6=95=A3=E9=AB=AE=E4=B9=98=E5=A4=9C=E6=B6=BC=
  =E9=96=8B=E8=BB=92=E8=87=A5=E9=96=91=E6=95=9E  =E8=8D=B7=E9=A2=A8=E9=80=
=81=E9=A6=99=E6=B0=A3  =E7=AB=B9=E9=9C=B2=E6=BB=B4=E6=B8=85=E9=9F=BF
    =E6=AC=B2=E5=8F=96=E9=B3=B4=E7=90=B4=E5=BD=88  =E6=81=A8=E7=84=A1=E7=
=9F=A5=E9=9F=B3=E8=B3=9E  =E6=84=9F=E6=AD=A4=E6=87=B7=E6=95=85=E4=BA=BA=
  =E4=B8=AD=E5=AE=B5=E5=8B=9E=E5=A4=A2=E6=83=B3
