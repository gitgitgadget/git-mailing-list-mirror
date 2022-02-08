Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C444DC433F5
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 08:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350688AbiBHIkX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 03:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350652AbiBHIkN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 03:40:13 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93772C03FEDB
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 00:40:09 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id z3-20020a170903408300b0014d891103aaso1941585plc.0
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 00:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=EN32OlSdIPLW/h0ox/yybskI+VjrxA2w7zI+99muzsA=;
        b=a6DouT54OftLNNSO0Av49QOEDTtPxqSo03HAbbjWT33oSOWBOyCnfEommhcim5mAXG
         6EMLH6308rbPrJFMjV1drgcL/JWffcPXrTAR1GU/6ipkuOKE6iAJKnmdA12+t0ap1usX
         3z+Kww+UzRfxGMlTWgd7tRwL1hp8ZU3vIJrQT3kq660pYHF7aZeZmPpYXeefBBfTYu/n
         XLq8+XXaZZIsLVDrjBvfoRMWzRRHD9dHyhNX7lmwpjViUjR4DLnpY8h+0ZgfSh0umFVg
         w7rXY8db5hIp+Oye6SMIkOPcifgyXKUUrwIQVTqARVjwdPA7dej3GVRZFAX4ALpUCNGW
         RN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=EN32OlSdIPLW/h0ox/yybskI+VjrxA2w7zI+99muzsA=;
        b=FNczJalXIOa3VqVYtRef/FC1hGF06iBBvLT6siIXwfTJeMaCIQy6OW0Iyu26LkAkfC
         2JKquqLLRjsBsJqDoivnO3v3WcoQeNd4LwL05iH0s7pUPppHnAX3i9OmywT8Nea2Mwzd
         RPYkhHwfaPNFuXeNZFoRfLsVPY/KiIpexAOviGyYIAF+z453BS2bnBPfXVI59XM7anq2
         KoDwRmueEtlvns/JGlbCA7iMSr0Cb+zyUfuENtJ0vPk337y3MMjAZxhfY5Zs8I8ZZk2n
         SEhBHi00mOjaIQdueCRNngCd4yHasO2iSxnr8JD9nwzXIu+zOXIMSHoARYGL5oI4p+52
         Gj6w==
X-Gm-Message-State: AOAM532RHAXs0/jEH2wJJTl8LVFEJEpr/5/5LQoNUt9Z22kW0xOFcx3N
        9YJJJQma/OWYmPWcD1AJeHwtHeHGc6AuNt+vQxMexYUDZTcUDhoi81oEVRqz+8udsLCIOeWYqrr
        9uXeQQbt238n6LLeAFddL18k3x3Wv0BJLAbc3bOnz8u6Uu5aKyOriCAnzLZCbarc=
X-Google-Smtp-Source: ABdhPJxau1HTrGeZq5Wj9Ui9dVtRCFalVxgUpnMkLIyRw/Ym5uBfIawBZYss4Th/Vu8KqV29hiiwFttbputkDw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:10c1:: with SMTP id
 d1mr3392382pfu.84.1644309608880; Tue, 08 Feb 2022 00:40:08 -0800 (PST)
Date:   Tue,  8 Feb 2022 16:39:41 +0800
In-Reply-To: <20220208083952.35036-1-chooglen@google.com>
Message-Id: <20220208083952.35036-6-chooglen@google.com>
Mime-Version: 1.0
References: <cover-v5-0.9-00000000000-20220128T125206Z-avarab@gmail.com> <20220208083952.35036-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v6 05/16] builtin/submodule--helper.c: reformat designated initializers
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

The second hunk here will make a subsequent commit's diff smaller, and
let's do the first and third hunks while we're at it so that we
consistently format all of these.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index db71e6f4ec..9f79bdf4d5 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1654,7 +1654,10 @@ struct module_clone_data {
 	unsigned int require_init: 1;
 	int single_branch;
 };
-#define MODULE_CLONE_DATA_INIT { .reference =3D STRING_LIST_INIT_NODUP, .s=
ingle_branch =3D -1 }
+#define MODULE_CLONE_DATA_INIT { \
+	.reference =3D STRING_LIST_INIT_NODUP, \
+	.single_branch =3D -1, \
+}
=20
 struct submodule_alternate_setup {
 	const char *submodule_name;
@@ -2047,7 +2050,9 @@ struct update_data {
 	unsigned int nofetch: 1;
 	unsigned int just_cloned: 1;
 };
-#define UPDATE_DATA_INIT { .update_strategy =3D SUBMODULE_UPDATE_STRATEGY_=
INIT }
+#define UPDATE_DATA_INIT { \
+	.update_strategy =3D SUBMODULE_UPDATE_STRATEGY_INIT, \
+}
=20
 static void next_submodule_warn_missing(struct submodule_update_clone *suc=
,
 		struct strbuf *out, const char *displaypath)
@@ -3013,7 +3018,9 @@ struct add_data {
 	unsigned int progress: 1;
 	unsigned int dissociate: 1;
 };
-#define ADD_DATA_INIT { .depth =3D -1 }
+#define ADD_DATA_INIT { \
+	.depth =3D -1, \
+}
=20
 static void append_fetch_remotes(struct strbuf *msg, const char *git_dir_p=
ath)
 {
--=20
2.33.GIT

