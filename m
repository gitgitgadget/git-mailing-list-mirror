From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/2] Makefile: header dependency checker fixes
Date: Sat, 8 May 2010 22:55:36 -0500
Message-ID: <20100509035536.GA8118@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 09 05:57:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAxdY-0001YG-F6
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 05:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754238Ab0EIDyf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 May 2010 23:54:35 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:40315 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742Ab0EIDyf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 23:54:35 -0400
Received: by gwj19 with SMTP id 19so1378598gwj.19
        for <git@vger.kernel.org>; Sat, 08 May 2010 20:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=ufRTDZ0kBpgmXoRpbzolL1Mcy5GBmVn8ZI22oagUnxA=;
        b=su9AgQ17Y/42THYelCWAurVxgjncfmxwukXPwgUIE21wkVv9/6zyk9a3VWBHD90+78
         A0wdgA0bxtkmkJ2reD35da96NHNwb41SJKHjnFfWsMkD5EipF5Nsgmu8SITl5RbizpIS
         SK0OBC7YS7GaZ1DK4UTOhNKV6gylTUPCRqclg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=ED0fCAPzjVD2vVWKKSGOmH4ltmyc/KUY/20YbQpmnuDNbRmmlBSHKZi9pOt4+TCooD
         EUv2VXDCSMLSy8v1tovOOyOQgNx+fyr1I7dP8V7Z1olDB8+jL9k1fWjogl5UF0T3rgWt
         qQEGp6+1ifbIqcZYIpypveZrL7BeePssrTW7Y=
Received: by 10.91.163.11 with SMTP id q11mr1123269ago.90.1273377274240;
        Sat, 08 May 2010 20:54:34 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm2590309yxe.11.2010.05.08.20.54.33
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 08 May 2010 20:54:33 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146701>

Two fixes to make the CHECK_HEADER_DEPENDENCIES facility more
usable.  Now you can

 echo >>config.mak NO_CURL =3D YesPlease
 echo >>config.mak COMPUTE_HEADER_DEPENDENCIES =3D YesPlease
 make -j16
 make -j16 CHECK_HEADER_DEPENDENCIES=3DYep

on some super-fast machine without libcurl-dev installed and
it will check the header dependencies for the rest of the makefile.

Previously it would error out for two reasons:

 - COMPUTE_HEADER_DEPENDENCIES and CHECK_HEADER_DEPENDENCIES
   are incompatible

 - the safety to make sure the automatically computed header
   dependencies were present did not understand that HTTP support
   is missing

This is nothing urgent, just nice to have.  I=E2=80=99d be glad to carr=
y
them locally if that=E2=80=99s more convenient.

Jonathan Nieder (2):
  Makefile: fix header dependency checker to allow NO_CURL builds
  Makefile: let header dependency checker override
    COMPUTE_HEADER_DEPENDENCIES

 Makefile |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)
