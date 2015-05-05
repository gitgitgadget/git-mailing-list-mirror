From: Steffen Nurpmeso <sdaoden@gmail.com>
Subject: Compiling 2.4.0 doesn't seem to honour
 C_INCLUDE_PATH
Date: Tue, 05 May 2015 11:49:09 +0200
Message-ID: <20150505094909.rzitmjWhT6g=%sdaoden@yandex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 05 12:09:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpZmt-0000XD-Aq
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 12:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753349AbbEEKJL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 May 2015 06:09:11 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34434 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488AbbEEKJJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 May 2015 06:09:09 -0400
Received: by wicmx19 with SMTP id mx19so96950380wic.1
        for <git@vger.kernel.org>; Tue, 05 May 2015 03:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:subject:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=OCL2Z7SXKzK/hijBvorbAJtmIESf8/6mOrmG8v9a2Jw=;
        b=q6uZYHZcP9HHRvsbELn0stakne67j1Q5sugtupaSOe8UYfjlkB4jqLDGU1A/9bUKmh
         ReiMuYI8L9uSG+RrAjjchnrHbpdN4eri/X7Qxje3UuO1GvU0HoED3gD/bx0Gs/pyCrMs
         OK9jo/tMuHrHAC5TMe/QtvUC1PmsR69c1SCisb0Llqip7Tsoeswrce8x88guwZNMjzJ2
         9iOMrvaOZtbf3Kg82QzbDCQB6GNAWqXQ8p/s/bNgizgwawDV92boXbxXiYfhlzhIUUT7
         plwiTx+GZ8lkvdAPfti9q17UqdJ2qfSVWR/AS9D6EIOVOKhynjmXenR/2nKnlqbH3EON
         MScg==
X-Received: by 10.194.216.230 with SMTP id ot6mr6902141wjc.68.1430820547847;
        Tue, 05 May 2015 03:09:07 -0700 (PDT)
Received: from gmail.com ([89.15.239.237])
        by mx.google.com with ESMTPSA id wr2sm24755779wjb.45.2015.05.05.03.09.05
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2015 03:09:07 -0700 (PDT)
X-Google-Original-From: Steffen Nurpmeso <sdaoden@yandex.com>
User-Agent: s-nail v14.8.0-10-g6fd1f69
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268389>

Hello,

i've tried to compile 2.4.0 yesterday with my usual recipe

  git:
    cd git.git-no_reduce &&\
    (for i in GETTEXT PYTHON TCLTK; do echo NO_$${i}=3D1; done;\
    cat Makefile) > Makefile.2nd &&\
    $(GMAKE) -f Makefile.2nd prefix=3D$(MYPREFIX) all &&\
    $(SUDO) $(GMAKE) -f Makefile.2nd prefix=3D$(MYPREFIX) install;\
    git clean -fxd; git reset --hard HEAD

but it failed:

      CC imap-send.o
  imap-send.c: In function =E2=80=98setup_curl=E2=80=99:
  imap-send.c:1428: error: =E2=80=98CURLOPT_LOGIN_OPTIONS=E2=80=99 unde=
clared (first use\
 in this function)
  imap-send.c:1428: error: (Each undeclared identifier is reported only=
 \
once
  imap-send.c:1428: error: for each function it appears in.)
  Makefile.2nd:1894: recipe for target 'imap-send.o' failed
  gmake[1]: *** [imap-send.o] Error 1
  gmake[1]: Leaving directory '/Volumes/UDF/arena/code.extern/git.git-n=
o\
_reduce'

It turned out that the C_INCLUDE_PATH setting doesn't seem to get
honoured, resulting in the wrong curl version to be used.  The
PATH setting seems to get honoured still, though:

  ?0[steffen@sherwood roff.git]$ curl --version
  curl 7.42.1..
  ?0[steffen@sherwood roff.git]$ /usr/bin/curl --version
  curl 7.19.7..

I'm right that CURLDIR shouldn't be needed here?
Compilation succeeded after explicitly setting that, but shouldn't
C_INCLUDE_PATH be honoured just as PATH is?
Thanks and Ciao,

--steffen
