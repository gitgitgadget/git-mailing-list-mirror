From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 00/16] First class shallow clone
Date: Sat, 20 Jul 2013 16:57:54 +0700
Message-ID: <1374314290-5976-1-git-send-email-pclouds@gmail.com>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 20 11:58:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0Tve-0001Cg-CH
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 11:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416Ab3GTJ55 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Jul 2013 05:57:57 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:43187 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768Ab3GTJ5z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jul 2013 05:57:55 -0400
Received: by mail-ie0-f177.google.com with SMTP id w15so3060182iea.36
        for <git@vger.kernel.org>; Sat, 20 Jul 2013 02:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=26u9ktzlAUwSfeKYFIGGAKCjAi/pegWtkMEGiT5YC9g=;
        b=R8ehWaRPkKNW4nnggryieKrkhYBB8F/SjRV6WUHXF2uIiIs5QekwCE4bTXz66Hl6fy
         93q3ieu3LPe1D8HYbxqqd0dUWNOIM766of6OtolAevhdHc8xd6G/tKGtqW3nJkDQEnoa
         bMWN7FByAZJU1NXPAFrlTpQRZYmn+QNN9N2jFZ6+QhmOLR4R+jycA+eROGJ24QMcl8kK
         UXAc8RfJbcBcgYA644lR3+6bOIcRfKunyDFDbFMQHCruNm8QqucqZPGh89d10EBd7HB9
         H7+6HquU7bv92p43PTkpxFb5524hQCJi3yBXPGsL7UWMzV9K62ROiE/B9j3I333/WTNp
         oZew==
X-Received: by 10.50.50.202 with SMTP id e10mr5298040igo.54.1374314275462;
        Sat, 20 Jul 2013 02:57:55 -0700 (PDT)
Received: from lanh ([115.73.248.127])
        by mx.google.com with ESMTPSA id nr4sm21121815igb.0.2013.07.20.02.57.52
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Jul 2013 02:57:54 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 20 Jul 2013 16:58:13 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1374065234-870-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230878>

v2 includes:

 - fix Junio comments, especially the one that may lead to incomplete
   commit islands.
 - fix send-pack setting up temporary shallow file, but never passes
   it to index-pack/unpack-objects (also fix the tests to catch this)
 - support smart http
 - add core.noshallow for repos that wish to be always complete
 - fix locally cloning a shallow repository
 - make upload-pack pass --shallow-file to pack-objects in order to
   remove duplicate object counting code just for shallow case.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (16):
  send-pack: forbid pushing from a shallow repository
  {receive,upload}-pack: advertise shallow graft information
  connect.c: teach get_remote_heads to parse "shallow" lines
  Move setup_alternate_shallow and write_shallow_commits to shallow.c
  fetch-pack: support fetching from a shallow repository
  {send,receive}-pack: support pushing from a shallow clone
  send-pack: support pushing to a shallow clone
  upload-pack: let pack-objects do the object counting in shallow case
  pack-protocol.txt: a bit about smart http
  Add document for command arguments for supporting smart http
  {fetch,upload}-pack: support fetching from a shallow clone via smart =
http
  receive-pack: support pushing to a shallow clone via http
  send-pack: support pushing from a shallow clone via http
  git-clone.txt: remove shallow clone limitations
  config: add core.noshallow to prevent turning a repo into a shallow o=
ne
  clone: use git protocol for cloning shallow repo locally

 Documentation/config.txt                  |   5 +
 Documentation/git-clone.txt               |   7 +-
 Documentation/git-fetch-pack.txt          |  11 +-
 Documentation/git-receive-pack.txt        |  16 ++-
 Documentation/git-send-pack.txt           |   9 +-
 Documentation/git-upload-pack.txt         |  13 ++-
 Documentation/technical/pack-protocol.txt |  76 ++++++++++++-
 builtin/clone.c                           |  14 ++-
 builtin/fetch-pack.c                      |   6 +-
 builtin/receive-pack.c                    |  76 +++++++++++--
 builtin/send-pack.c                       |   7 +-
 cache.h                                   |   4 +-
 commit.h                                  |  27 +++++
 config.c                                  |   5 +
 connect.c                                 |  12 +-
 environment.c                             |   1 +
 fetch-pack.c                              |  90 ++++++---------
 fetch-pack.h                              |   1 +
 remote-curl.c                             |   4 +-
 send-pack.c                               |  57 +++++++++-
 send-pack.h                               |   4 +-
 shallow.c                                 | 147 ++++++++++++++++++++++=
+++
 t/t5530-upload-pack-error.sh              |   3 -
 t/t5536-fetch-shallow.sh (new +x)         | 141 ++++++++++++++++++++++=
++
 t/t5537-push-shallow.sh (new +x)          | 176 ++++++++++++++++++++++=
++++++++
 t/t5601-clone.sh                          |   7 ++
 transport.c                               |  14 ++-
 upload-pack.c                             | 132 ++++++----------------
 28 files changed, 858 insertions(+), 207 deletions(-)
 create mode 100755 t/t5536-fetch-shallow.sh
 create mode 100755 t/t5537-push-shallow.sh

--=20
1.8.2.83.gc99314b
