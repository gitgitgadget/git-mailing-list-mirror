Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74893C43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 18:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD26206A5
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 18:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="H5xt8Djg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbfLKSqY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 13:46:24 -0500
Received: from mout.web.de ([212.227.17.12]:37183 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728078AbfLKSqY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 13:46:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1576089980;
        bh=wlCmgq9m6O5jA7jpgGiAU4U7hzxqfeiSM/xVSo7pOtU=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=H5xt8DjgE7yeIA9lP4q2vhk/KcjBmdZf/vYUu0D1APtUWo3A96MwyG1cBVaNGR3i0
         kuXQ9yqtG/wMcNluOXXZjJyiRaBQw1fqP83uVGU/Vvw6XxxxBiUC0Ljq1mJq4zvf2y
         hjZbtCrRjLfgxuq5K26JMgAgsI0QFu5P8osAQ2bs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.158.92]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MQNma-1iI2jP3tVc-00TmGf; Wed, 11
 Dec 2019 19:46:19 +0100
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] refs: pass NULL to refs_read_ref_full() because object ID is
 not needed
Message-ID: <a762958e-324b-f9a5-96e4-fab0b4b91df8@web.de>
Date:   Wed, 11 Dec 2019 19:46:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wLeo1R609F2pCxedXXIOmzLGj8FE3VWWIPXj/cL/NXleeV0Efr7
 p9tlNEmukM+2GDNqr3oVpbXvtjuYxt+8Lb22bMj5gf5HJEjiVzYDUL/SMCnSAIXcEQrwkkz
 u27PaiKmNlmDsIVswjfiI/lkoV4Sj61+1CjzGOiXhAnoHV7/IjKrBzjc4CtaDqi1Iut6cBY
 8osgZuFT6I2E5rqKMnfzw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MD9G01r5LYg=:TZW1VMGT70XG06AWqefXcl
 TOq263f4SJbT1J3gJZhvdzKEpB2OvBYyP+fc3kjJvjKYKl54l3EZK2roSPcqz+d5PrZGNXNPz
 dAiFFGVKjvQ8fDIG10qhc7ltrmeptU3ew/LImWF3zYvkEu+8Ev8FTRPajIRmQ0LR+c+P5qxWm
 pbZ1Tsd/2HIN8BcFArP6CO5vgf49KALtofjEvvE/o89AhjlckJbFnsSuqWF5UvP5os341QasV
 GrL1G2abgDKv9R4zEKbIA6ybzApYcCiprvxEABjjFBDAQzyIit2Ov/2oUC1ac6iZT3fAWCuVV
 tUwXO9OUlEl1cvdaPlJ4Is9NZ8t2acKwmiv+a1eQTB7fN+ULlarmJyeSfejLbRAHN1pStZU8S
 eetrBCNBrn7YB+5sdyvWOEuEBQotWNhP76oLUs+Kw5ls9N06fDN25fpdMUqgGeQTvLrmDUHud
 IyXebgBNTguP4Ye1AB/2RQQ1xk67LK1/TS5PfpvmJVvYpOVoes3S3SH8oa1OB5fdKXpLrYKIL
 yA/Qkwahj6/XxWYYBNcpm3rqU2XfYzL556UTtRV/W8JU3oVKrdGcI5sMqg/FA30vOM1JEqaRy
 Xh+IJ2o/7CV2suX2201kmdzDLqWXZy6HkoejonJ0h5NBUp366Bt4SFEXFe1DUpboQEyySFPXP
 hZR8BJwZ0bPVh++E++Nz/mD6y6E6wiXeLTOSuzBaL0HOS9j23c231PlUBGFASQiZkLfM/jamX
 VYupgyKGr4kME7PmUrYB4m4IRWThA92n6mkh++4PmzAhvcytekOCJaMX8x69hn5EzX8umen4B
 gSCZXwDF41jLN3cb+LgJIucNDgZOuhnlGgEaWJv28IF048bPM1TOpJdYTHi6RlUdmn0ebI/Ro
 Z6lW1mFl1nWRf4c46KF4xd5WPYwXA0hagP77QQIgB3vC/jKTPz5LJ8KIwh3tO9OaiLvC2meWL
 JeSS/Q7PBvQhAuf0xg7UcgHw13JD0R5mzpin61hursvgTLau6qCDztkJq6+Qksc2M/m+rGFrc
 xZMEYTgS2bndaXiGKVeuUuBOesTKWqmDH5+wjBnP0DkjoSAvlTMfhKHZOlU08bhZyPOK2Cg5a
 xyKydeSoOKPC+puIggEWn8iUKu5X5tXGU01BG2tiBNjaeNuNRvJZreCUYokY+B6k/3PoCfUSH
 7varRZdQJYoW3+QQvMCltHseqW4YOnXhXEAcwFNQBod2rNzXJfIHt4sYGkMi/Oeel4g4E6p6s
 2gwONBfaWtTJNqti8GFmNK9PNB1M0UFTtkAp5nQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

refs_read_ref_full() wraps refs_resolve_ref_unsafe(), which handles a
NULL oid pointer of callers not interested in the resolved object ID.
Pass NULL from files_copy_or_rename_ref() to clarify that it is one
such caller.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 refs/files-backend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index d60767ab73..0ea66a28b6 100644
=2D-- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1327,7 +1327,7 @@ static int files_copy_or_rename_ref(struct ref_store=
 *ref_store,
 {
 	struct files_ref_store *refs =3D
 		files_downcast(ref_store, REF_STORE_WRITE, "rename_ref");
-	struct object_id oid, orig_oid;
+	struct object_id orig_oid;
 	int flag =3D 0, logmoved =3D 0;
 	struct ref_lock *lock;
 	struct stat loginfo;
@@ -1395,7 +1395,7 @@ static int files_copy_or_rename_ref(struct ref_store=
 *ref_store,
 	 */
 	if (!copy && !refs_read_ref_full(&refs->base, newrefname,
 				RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-				&oid, NULL) &&
+				NULL, NULL) &&
 	    refs_delete_ref(&refs->base, NULL, newrefname,
 			    NULL, REF_NO_DEREF)) {
 		if (errno =3D=3D EISDIR) {
=2D-
2.24.1
