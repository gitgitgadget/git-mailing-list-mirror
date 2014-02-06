From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/6] Fix the shallow deepen bug with no-done
Date: Thu,  6 Feb 2014 22:10:33 +0700
Message-ID: <1391699439-22781-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 06 16:11:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBQbu-0005L3-I8
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 16:11:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811AbaBFPLW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Feb 2014 10:11:22 -0500
Received: from mail-pb0-f47.google.com ([209.85.160.47]:45625 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356AbaBFPLV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 10:11:21 -0500
Received: by mail-pb0-f47.google.com with SMTP id rp16so1862088pbb.20
        for <git@vger.kernel.org>; Thu, 06 Feb 2014 07:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=etf0jbSFjBPPGgfh0lYQZJWb7RhmB2VmT+Iya0ug+P4=;
        b=vXG4p2aBSUewZ0MQLqg8QQu5rglcBysR22S7W75+UUn1Ah/h/sE+as1tKNww9SyUTj
         ktKVUZ6uYM+yQZ1D+BlsW/D40gURW9Y6FiHExH7DWgs+eGZJIDNI3tSpLL4OOzTSsNVp
         flvDcSbGViY1P9CrIHSMKaWdnJdH1H3cVqfBl8uDsAw/ebQHb300hdpOy9vYXbP32tJx
         YrplGtVBuFGCj0yqG+8/NuU9Bplqzy2gKZr5xMubp4t6B5L2kbxIM7ojdKf8IRSisLVF
         ySq+G2i5sDkRYvJ6Z6NdG8YWHWvN9KoathM1/9tZkcbsqaHU3g4eEgn8GIIkuy5sHns9
         /mjQ==
X-Received: by 10.66.243.103 with SMTP id wx7mr1160269pac.107.1391699480849;
        Thu, 06 Feb 2014 07:11:20 -0800 (PST)
Received: from lanh ([115.73.207.183])
        by mx.google.com with ESMTPSA id sy2sm4347355pbc.28.2014.02.06.07.11.17
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 06 Feb 2014 07:11:20 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 06 Feb 2014 22:11:20 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241694>

Reported by Jeff [1]. Junio spotted it right but nobody made any move
since then. The main fix is 6/6. The rest is just updates while I was
looking at it. 2/6 may need fast track though.

[1] http://thread.gmane.org/gmane.comp.version-control.git/219914

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (6):
  test: rename http fetch and push test files
  t5538: fix default http port
  pack-protocol.txt: clarify 'obj-id' in the last ACK after 'done'
  protocol-capabilities.txt: refer multi_ack_detailed back to pack-prot=
ocol.txt
  protocol-capabilities.txt: document no-done
  fetch-pack: fix deepen shallow over smart http with no-done cap

 Documentation/technical/pack-protocol.txt          |  3 ++-
 Documentation/technical/protocol-capabilities.txt  | 18 ++++++++++++++=
++
 fetch-pack.c                                       |  3 ++-
 t/t5537-fetch-shallow.sh                           | 24 ++++++++++++++=
++++++++
 t/t5538-push-shallow.sh                            |  2 +-
 ...5540-http-push.sh =3D> t5540-http-push-webdav.sh} |  0
 t/{t5541-http-push.sh =3D> t5541-http-push-smart.sh} |  0
 ...5550-http-fetch.sh =3D> t5550-http-fetch-dumb.sh} |  0
 ...551-http-fetch.sh =3D> t5551-http-fetch-smart.sh} |  0
 9 files changed, 47 insertions(+), 3 deletions(-)
 rename t/{t5540-http-push.sh =3D> t5540-http-push-webdav.sh} (100%)
 rename t/{t5541-http-push.sh =3D> t5541-http-push-smart.sh} (100%)
 rename t/{t5550-http-fetch.sh =3D> t5550-http-fetch-dumb.sh} (100%)
 rename t/{t5551-http-fetch.sh =3D> t5551-http-fetch-smart.sh} (100%)

--=20
1.8.5.2.240.g8478abd
