From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/21] np/pack-v4 updates
Date: Wed, 11 Sep 2013 13:06:01 +0700
Message-ID: <1378879582-15372-1-git-send-email-pclouds@gmail.com>
References: <xmqqtxhswexg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 11 08:06:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJdZi-0004Fh-8p
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 08:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754534Ab3IKGGq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Sep 2013 02:06:46 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:47501 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784Ab3IKGGp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 02:06:45 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb10so8718649pad.23
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 23:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=KP84He1lOkwcc8xnVlfwrrfdFQyVXivpJ6xEwWiz4yg=;
        b=bDR9O1zu7+u3I5mLnedc/uSghCclxYVE4qyPgKrS3JS9PBcvEAz271lGrIcCTXUTez
         C0JdRCRIgsVDo6X6JK+7nY0XYS3dOtgeu2uKCjb3NgXwQRq2t+3H/2+e7r5fJ0IdMb2t
         V3Q9g02zhAgLx62P2kSYR8dw6XAOv6JrJ9Kl+6cgutCRrypyGy3RBWTDhDEuIDxTugn3
         2ZOr196zlX+5tfEcROk9lfykf5AFXUvKR5Y/JqNku1NcDMv+bOCGwgBm3kqhJJhS+yRU
         LxqB0awOW8lm+kxRJkvX4RTyGx56RnN5ZSJZuxS3u5PgME+JeRdIFQrIp1w38mc2Je7k
         Ebrw==
X-Received: by 10.68.238.104 with SMTP id vj8mr13331161pbc.149.1378879605430;
        Tue, 10 Sep 2013 23:06:45 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id om2sm27430980pbc.30.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 23:06:44 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 11 Sep 2013 13:06:38 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <xmqqtxhswexg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234524>

This contains fixups for some of my patches, some of Nico's, adds v4
support to unpack-objects because the test suite needs it. With these,
when force generating pack v4 unconditionally, the remaining failed
tests are:

 - t5300-pack-object: ofs-delta tests fail (not surprising).
   core.packsizelimit also fails. Kinda expected, but not my top
   priority.

 - t5302-pack-index: mainly to test .idx v2, expected

 - t5303-pack-corruption-resilience: if I force generating .idx v2
   with .pack v4, I could get to 1/3 of it. Need a deeper look.

So v4 code is in pretty good shape in terms of correctness and near
function complete. Brave souls should try it out.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (21):
  fixup! pack-objects: prepare SHA-1 table in v4
  fixup! pack-objects: support writing pack v4
  fixup! pack v4: support "end-of-pack" indicator in index-pack and pac=
k-objects
  fixup! index-pack: parse v4 header and dictionaries
  fixup! index-pack: record all delta bases in v4 (tree and ref-delta)
  pack v4: lift dict size check in load_dict()
  pack v4: move pv4 objhdr parsing code to packv4-parse.c
  pack-objects: respect compression level in v4
  pack-objects: recognize v4 as pack source
  pack v4: add a note that streaming does not support OBJ_PV4_*
  unpack-objects: report missing object name
  unpack-objects: recognize end-of-pack in v4 thin pack
  unpack-objects: read v4 dictionaries
  unpack-objects: decode v4 object header
  unpack-objects: decode v4 ref-delta
  unpack-objects: decode v4 commits
  unpack-objects: allow to save processed bytes to a buffer
  unpack-objects: decode v4 trees
  index-pack, pack-objects: allow creating .idx v2 with .pack v4
  show-index: acknowledge that it does not read .idx v3
  t1050, t5500: replace the use of "show-index|wc -l" with verify-pack

 builtin/index-pack.c     |  19 ++-
 builtin/pack-objects.c   |  60 +++++--
 builtin/unpack-objects.c | 395 +++++++++++++++++++++++++++++++++++++++=
+++++---
 packv4-create.c          |  17 +-
 packv4-create.h          |   6 +-
 packv4-parse.c           |  16 +-
 packv4-parse.h           |   7 +
 sha1_file.c              |   9 +-
 show-index.c             |   4 +-
 streaming.c              |   2 +-
 t/t1050-large.sh         |   9 +-
 t/t5500-fetch-pack.sh    |   4 +-
 test-packv4.c            |   9 +-
 13 files changed, 480 insertions(+), 77 deletions(-)

--=20
1.8.2.82.gc24b958
