Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F86CC433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 09:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238528AbiBJJ2z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 04:28:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238520AbiBJJ2v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 04:28:51 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C182B1089
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:28:52 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id t24-20020aa79398000000b004e025989ac7so3947672pfe.18
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=sPmqUnovKFAKLuQYhu1Sg3pAOs7Z4qVb4uilqbLBvJ8=;
        b=K+QKzzZZU2VBcuahZCqqbpiwqKT9qjOrVEFyBDFiR9KSWqnWAUtKvLUmmIoLZwZnJm
         dI36vzZn2xTXcjOGizcKpOFABkakvyspHJjf+pb7lLTsuMFAvcJncSBYjRZUQ5VQ5MVa
         wxMQtOgIMDFJ9Sg9MP/o4rwVuvTg+bDqmYfaM1GI21tCIR2TWwDZ/thamE4EeyWA0c9U
         qZqY75fLELft6BLVi3YRqiAUT2zTZaSd0HRdoMr3o3WZnWp7kMA8krQqUt3krWgAgFYr
         LXCNzMvb3xiwgdk4rLBn7h8gm/iPCLp2GD+CLcmKD8KoF7y8Z4hJIr+TsF4blCu9C3p3
         /afQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=sPmqUnovKFAKLuQYhu1Sg3pAOs7Z4qVb4uilqbLBvJ8=;
        b=CamAUnK+K1SK9fRtxrst6ZHUGDRHYtQMsshFr1KeGFJ2AKwXmjfYn7/pGUhpnnItym
         DQSiR4R3beHQAP/Ve4onP5W8/7172g71MIRw+lYou0gz3eoNrYVOgawfeCj1B0RF0XDU
         bpGSNrZALDmNe8UZuPdmne+bVlm2q9NaEu82jAIcLhaHiA/yUPtwb1wA2a1mfqS6rosG
         wNkU7voycMbgC0+YN6nuJdNOIh5U/lVN2bP324Dbpm4xcPUDshgDJVCJzXk0PKnjTT8n
         RRf8YGwczPoNANqz1l3zbLek7I7JNG4Jd5GqknPvWzWJ0ojMT+fBc+37boCFVVRejbrv
         MWdQ==
X-Gm-Message-State: AOAM530/Mmv5IKBBPwRr6HbukazM8ToQ+9b53v+1T1dql6CPxNF2UvlA
        3c56V1OzGUe/p7E7uKrynk01Ur7ERHS5W9YAARSYUAybW7XyKsqo3zkNc53gyxr3+BEJ3hbhLcr
        U4T5BkheREij0Fm+mgrGKYvkmT/q3lY9Zlhns6G8UG4eClbQzu0nwELCpkhcDxBM=
X-Google-Smtp-Source: ABdhPJzijBL/fc/Er3m1Wr4jKosD7DYBoRz/bp5PEIPXzGQoL2xhLm4ZKZw5V+DWcByrjh6wAPSlJREwAxkZ0Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:8018:: with SMTP id
 j24mr6544788pfi.59.1644485332215; Thu, 10 Feb 2022 01:28:52 -0800 (PST)
Date:   Thu, 10 Feb 2022 17:28:15 +0800
In-Reply-To: <20220210092833.55360-1-chooglen@google.com>
Message-Id: <20220210092833.55360-3-chooglen@google.com>
Mime-Version: 1.0
References: <20220208083952.35036-1-chooglen@google.com> <20220210092833.55360-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v7 02/20] submodule--helper: refactor get_submodule_displaypath()
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Atharva Raykar <raykar.ath@gmail.com>

We create a function called `do_get_submodule_displaypath()` that
generates the display path required by several submodule functions, and
takes a custom superprefix parameter, instead of reading it from the
environment.

We then redefine the existing `get_submodule_displaypath()` function
as a call to this new function, where the superprefix is obtained from
the environment.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 4c7c1e1432..5efceb9d46 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -261,11 +261,8 @@ static int resolve_relative_url_test(int argc, const c=
har **argv, const char *pr
 	return 0;
 }
=20
-/* the result should be freed by the caller. */
-static char *get_submodule_displaypath(const char *path, const char *prefi=
x)
+static char *do_get_submodule_displaypath(const char *path, const char *pr=
efix, const char *super_prefix)
 {
-	const char *super_prefix =3D get_super_prefix();
-
 	if (prefix && super_prefix) {
 		BUG("cannot have prefix '%s' and superprefix '%s'",
 		    prefix, super_prefix);
@@ -281,6 +278,13 @@ static char *get_submodule_displaypath(const char *pat=
h, const char *prefix)
 	}
 }
=20
+/* the result should be freed by the caller. */
+static char *get_submodule_displaypath(const char *path, const char *prefi=
x)
+{
+	const char *super_prefix =3D get_super_prefix();
+	return do_get_submodule_displaypath(path, prefix, super_prefix);
+}
+
 static char *compute_rev_name(const char *sub_path, const char* object_id)
 {
 	struct strbuf sb =3D STRBUF_INIT;
--=20
2.33.GIT

