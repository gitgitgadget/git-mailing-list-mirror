From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 0/3] Fix code issues spotted by clang
Date: Sun,  6 Nov 2011 13:06:21 +0100
Message-ID: <1320581184-4557-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jim Meyering <jim@meyering.net>,
	Fredrik Gustafsson <iveqy@iveqy.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 06 13:06:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RN1Uu-00070z-Jn
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 13:06:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637Ab1KFMGo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Nov 2011 07:06:44 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49619 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493Ab1KFMGn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2011 07:06:43 -0500
Received: by faao14 with SMTP id o14so4247439faa.19
        for <git@vger.kernel.org>; Sun, 06 Nov 2011 04:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=0aFKO7DfO4aVz6Nw5rspLPDSoDGVFuvLbxmKicBeISo=;
        b=Rt+CbV2OmKkOLhYlM8NsfXISuI9Oz7ABZDMChwY4j7/6PghurzCimMYC8GEFCRIoK1
         JV3ajKUm+5Hwnb+BXiB1maY/CMPB4dtdrnIrvRPjk6mLAZLCPxEnJGVDyyk/cQYD0WWe
         VAfhBh+XljQ1F49ze8A3KJpndu03I0igy+eRg=
Received: by 10.223.75.15 with SMTP id w15mr39098751faj.9.1320581201809;
        Sun, 06 Nov 2011 04:06:41 -0800 (PST)
Received: from snth.ams7.corp.booking.com ([62.140.137.119])
        by mx.google.com with ESMTPS id f14sm3038218fah.6.2011.11.06.04.06.40
        (version=SSLv3 cipher=OTHER);
        Sun, 06 Nov 2011 04:06:41 -0800 (PST)
X-Mailer: git-send-email 1.7.6.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184908>

This series fixes some of the code issues raised by clang. This leaves
the following warnings that I haven't addressed:

    revision.c:766:25: warning: implicit truncation from 'unsigned int'=
 to bitfield changes value from 4294967279 to 134217711
          [-Wconstant-conversion]
                    p->item->object.flags &=3D ~TMP_MARK;
                                          ^  ~~~~~~~~~
    revision.c:768:25: warning: implicit truncation from 'unsigned int'=
 to bitfield changes value from 4294967279 to 134217711
          [-Wconstant-conversion]
                    p->item->object.flags &=3D ~TMP_MARK;
                                          ^  ~~~~~~~~~
    revision.c:1875:25: warning: implicit truncation from 'unsigned int=
' to bitfield changes value from 4294967279 to 134217711
          [-Wconstant-conversion]
                    p->item->object.flags &=3D ~TMP_MARK;
                                          ^  ~~~~~~~~~
    revision.c:2202:25: warning: implicit truncation from 'unsigned int=
' to bitfield changes value from 4294967158 to 134217590
          [-Wconstant-conversion]
                            commit->object.flags &=3D ~(ADDED | SEEN | =
SHOWN);
                                                 ^  ~~~~~~~~~~~~~~~~~~~=
~~~~
    upload-pack.c:115:12: warning: implicit truncation from 'unsigned i=
nt' to bitfield changes value from 4294967293 to 134217725
          [-Wconstant-conversion]
                    o->flags &=3D ~UNINTERESTING;
                             ^  ~~~~~~~~~~~~~~
    upload-pack.c:689:19: warning: implicit truncation from 'unsigned i=
nt' to bitfield changes value from 4294705151 to 133955583
          [-Wconstant-conversion]
                                    object->flags &=3D ~CLIENT_SHALLOW;
                                                  ^  ~~~~~~~~~~~~~~~
    builtin/checkout.c:676:16: warning: implicit truncation from 'unsig=
ned int' to bitfield changes value from 4294967293 to 134217725
          [-Wconstant-conversion]
            object->flags &=3D ~UNINTERESTING;
                          ^  ~~~~~~~~~~~~~~
    builtin/reflog.c:173:32: warning: implicit truncation from 'unsigne=
d int' to bitfield changes value from 4294965247 to 134215679
          [-Wconstant-conversion]
                    found.objects[i].item->flags &=3D ~STUDYING;
                                                 ^  ~~~~~~~~~
    builtin/reflog.c:232:31: warning: implicit truncation from 'unsigne=
d int' to bitfield changes value from 4294963199 to 134213631
          [-Wconstant-conversion]
                    pending->item->object.flags &=3D ~REACHABLE;
                                                ^  ~~~~~~~~~~
    bisect.c:66:24: warning: implicit truncation from 'unsigned int' to=
 bitfield changes value from 4294901759 to 134152191
          [-Wconstant-conversion]
                    commit->object.flags &=3D ~COUNTED;
                                         ^  ~~~~~~~~
   =20
=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (3):
  apply: get rid of useless x < 0 comparison on a size_t type
  diff/apply: cast variable in call to free()
  grep: get rid of useless x < 0 comparison on an enum member

 builtin/apply.c |    3 ---
 builtin/diff.c  |    2 +-
 grep.c          |    2 +-
 submodule.c     |    2 +-
 4 files changed, 3 insertions(+), 6 deletions(-)

--=20
1.7.6.3
