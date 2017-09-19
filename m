Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F21C2047F
	for <e@80x24.org>; Tue, 19 Sep 2017 12:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751920AbdISMrC (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 08:47:02 -0400
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:41248
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751859AbdISMrA (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Sep 2017 08:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1505825219;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=h8PCnNDdurpSXoNh9m6IlRl7uZ8wKMEChHy//MWvK5A=;
        b=AqQinNHJbJ/+WUM7Loxme6l4guM3ckbjpjJSBc4AV+PsUIYmpHSb6/GBUW0M0bRL
        IweTqoi8oyOP3e+v9cPpfZYUTyQOiAB/BFMk+vV0h0E5K0Zq7EjsUdQ6U7oF5e3tY00
        Zrwq1WVfRz4IhYxnBi8zr1cUE9SiX4GjipkJlME8=
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015e9a2d5d25-e34b7c98-1662-4cfe-9eb8-50dc56c36240-000000@eu-west-1.amazonses.com>
Subject: [PATCH] t4014: strengthen search patterns
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 19 Sep 2017 12:46:57 +0000
X-SES-Outgoing: 2017.09.19-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The regex patterns for some failing test cases were a bit loose
giving way for a few incorrect outputs being accepted as correct
outputs.

To avoid such incorrect outputs from being flagged as correct ones
use fixed string matches when possible and strengthen regex when
it's not.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 t/t4014-format-patch.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 482112ca339f0..7dff7996c9e1f 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -163,7 +163,7 @@ test_expect_failure 'additional command line cc (rfc822=
)' '
 =09git config --replace-all format.headers "Cc: R E Cipient <rcipient@exam=
ple.com>" &&
 =09git format-patch --cc=3D"S. E. Cipient <scipient@example.com>" --stdout=
 master..side | sed -e "/^\$/q" >patch5 &&
 =09grep "^Cc: R E Cipient <rcipient@example.com>,\$" patch5 &&
-=09grep "^ *\"S. E. Cipient\" <scipient@example.com>\$" patch5
+=09grep "^ *\"S\. E\. Cipient\" <scipient@example\.com>\$" patch5
 '
=20
 test_expect_success 'command line headers' '
@@ -191,13 +191,13 @@ test_expect_success 'command line To: header (ascii)'=
 '
 test_expect_failure 'command line To: header (rfc822)' '
=20
 =09git format-patch --to=3D"R. E. Cipient <rcipient@example.com>" --stdout=
 master..side | sed -e "/^\$/q" >patch8 &&
-=09grep "^To: \"R. E. Cipient\" <rcipient@example.com>\$" patch8
+=09grep -F "To: \"R. E. Cipient\" <rcipient@example.com>" patch8
 '
=20
 test_expect_failure 'command line To: header (rfc2047)' '
=20
 =09git format-patch --to=3D"R =C3=84 Cipient <rcipient@example.com>" --std=
out master..side | sed -e "/^\$/q" >patch8 &&
-=09grep "^To: =3D?UTF-8?q?R=3D20=3DC3=3D84=3D20Cipient?=3D <rcipient@examp=
le.com>\$" patch8
+=09grep "^To: =3D?UTF-8?q?R=3D20=3DC3=3D84=3D20Cipient?=3D <rcipient@examp=
le\.com>\$" patch8
 '
=20
 test_expect_success 'configuration To: header (ascii)' '
@@ -211,14 +211,14 @@ test_expect_failure 'configuration To: header (rfc822=
)' '
=20
 =09git config format.to "R. E. Cipient <rcipient@example.com>" &&
 =09git format-patch --stdout master..side | sed -e "/^\$/q" >patch9 &&
-=09grep "^To: \"R. E. Cipient\" <rcipient@example.com>\$" patch9
+=09grep -F "To: \"R. E. Cipient\" <rcipient@example.com>" patch9
 '
=20
 test_expect_failure 'configuration To: header (rfc2047)' '
=20
 =09git config format.to "R =C3=84 Cipient <rcipient@example.com>" &&
 =09git format-patch --stdout master..side | sed -e "/^\$/q" >patch9 &&
-=09grep "^To: =3D?UTF-8?q?R=3D20=3DC3=3D84=3D20Cipient?=3D <rcipient@examp=
le.com>\$" patch9
+=09grep "^To: =3D?UTF-8?q?R=3D20=3DC3=3D84=3D20Cipient?=3D <rcipient@examp=
le\.com>\$" patch9
 '
=20
 # check_patch <patch>: Verify that <patch> looks like a half-sane

--
https://github.com/git/git/pull/406
