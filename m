Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE49AC433DB
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 17:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 918C7651F3
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 17:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237898AbhCARTg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 12:19:36 -0500
Received: from mout.web.de ([212.227.15.4]:47235 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237832AbhCARQC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 12:16:02 -0500
X-Greylist: delayed 494 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Mar 2021 12:16:00 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1614618821;
        bh=n0cCdISK8ZFAQod2sk6g6AYf1pWDfcZY9S+0dR8WoFA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=URoPuCHkH88flBjgZiaF27ZDfivjNGcWTIB8Vv+7PzqKLbRzWbjTedINDX5bvmCC4
         ufy/v9LxAklZQarmAAkUtqH60U++z8Hki1vXZfENdSgMoz91E3Ai/BbWeTBp1NfTWm
         cuQl4yL3jXRttHEZ50c2uEbMdZ9LE8XfrHKygy2I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([195.198.252.176]) by smtp.web.de
 (mrweb003 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0LcgYZ-1lgVol2iX9-00k8CX; Mon, 01 Mar 2021 18:05:36 +0100
From:   tboegi@web.de
To:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        Dan.Moseley@microsoft.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 1/1] git mv foo FOO ; git mv foo bar gave an assert
Date:   Mon,  1 Mar 2021 18:05:36 +0100
Message-Id: <20210301170536.12265-1-tboegi@web.de>
X-Mailer: git-send-email 2.30.0.155.g66e871b664
In-Reply-To: <xmqq7doqwvzx.fsf@gitster.c.googlers.com>
References: <xmqq7doqwvzx.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bTs2FqAAcgx/8ZN6tguuyJBVgTTJj1W6PYRcQzCPIBIGeyKOjkn
 h3YHRiYD/g+zs+lfecjkl4SOjogv1Zfv3LrDXuBHIElaQL5xuTmxAgS+X8Cpdj+j0JgxDT0
 /0rbQ4UN9Dw8fhk0wsZ0JIgRFSBlxk1rCaht/R71jXNDs5zTDQZpASt5dHeqvEVE0c86AXy
 0WX1qlXGDDpjxEgaqJmpA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0k1Q5tnYJqk=:9zeYIBKLjbe3PHKvUBwfyU
 uYcchM4+e8y2/lIDRK3XNILkeYrH4zfRvyG10SGHlH+uRh2ce3hQucSMVC2osukxxVsbd3gfq
 1VdT9ZHTBF5IbwMdq4EAnNb7UNY+etMVzY1K7nxXAVULkSOhkfzCGlYef2WtHyG6IFYnpoxbZ
 0vU/OJSv3qvlXpU33p/EDHiUFRhZGegoOTUhCLmZyV6sD8uJHZ4SnCn39zqEuegxsx2MhosLP
 FgdRN+yZVRCuIrgqNiwL6C9QyNQQ/LtyrotXKhtsTJbTw+8s7ZVtJhrMx9ulm9yRare8ZaiDX
 KuN3n+1EelMJfstrpxkjNkwmnr+cDxggVwKSBymFwvsteiFJQ/Spg+zUC4mMVJupefnxgzY77
 S7LjNevc2JxKi/9TMgCKoq+4fIGUsq4EpQauDVhvkAHHb+cfPqDzmU5oyZ7TLrZsdcfOfsuMq
 scmlchI3jOrBOwaOike2Yw+GE/LWxzwRpRpxyizEMZDR7lUlmzidEubdEunAIMrY2zble0viB
 0y3EYL02UDQmolt5RC8wd1S5pKXr6eYyjZ+ikqOCKa0XOw/mKuHcPzooJ25Gvn48SQL9ACnWw
 T8NuLkCUzKJwvFmdIf7GQw/V5A/AKibiaI8n8bBf27j80dS77JaDsqKs1sacnCkeKFpqdEXiV
 3PTJk9zedd6GFlM+mvcrXNw2gRfjSdBb3spkrgZccfQcDZpe5k0WioIMnbA1Rs2KoXCIumqDk
 hnpSTo4eflCbBE/Mkje4tUvgZOsQewpwjXnFoh4PiJkR1M3z6X4aLQolnyhDwOevqjj0W6sdz
 kQW95xsCqjAqFbHjJGGr1avrNI7MNiKdUaUcbabrZMKly0h+T4BO1t9WBKrAdPIbZ5KzKv7Ew
 0ZWja3hP/oHXPRosBD8A==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten B=C3=B6gershausen <tboegi@web.de>

The following sequence, on a case-insensitive file system,
(strictly speeking with core.ignorecase=3Dtrue)
leads to an assertion, and leaves .git/index.lock behind.

git init
echo foo >foo
git add foo
git mv foo FOO
git mv foo bar

This regression was introduced in Commit 9b906af657,
"git-mv: improve error message for conflicted file"

The bugfix is to change the "file exist case-insensitive in the index"
into the correct "file exist (case-sensitive) in the index".
This avoids the "assert".

Reported-By: Dan Moseley <Dan.Moseley@microsoft.com>

This fixes
https://github.com/git-for-windows/git/issues/2920

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--
 builtin/mv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 7dac714af9..3fccdcb645 100644
=2D-- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -221,7 +221,7 @@ int cmd_mv(int argc, const char **argv, const char *pr=
efix)
 				}
 				argc +=3D last - first;
 			}
-		} else if (!(ce =3D cache_file_exists(src, length, ignore_case))) {
+		} else if (!(ce =3D cache_file_exists(src, length, 0))) {
 			bad =3D _("not under version control");
 		} else if (ce_stage(ce)) {
 			bad =3D _("conflicted");
=2D-
2.30.0.155.g66e871b664

