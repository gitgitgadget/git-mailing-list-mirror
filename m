Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15659C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 21:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352339AbiHSVVh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 17:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351418AbiHSVVg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 17:21:36 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5092E104B37
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 14:21:35 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n7so6501384wrv.4
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 14:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=5M/cVm8zqW1nWLMcMtcajjeRyWXiITZWxq36axJkGKg=;
        b=IqseUt7OJFN+HESeIqZ4bHfGAmFfj37rlreUPDi5dm44+9bILkH6CWVKb74c//+xwW
         AkfvrZlOiBAPRqOcEsIuN8wahEBD6cUCtQVklgrZnF+A/WPL/b2j7Efd1DnytzLctWu1
         Q8J9TUsR5HAFnT7TXCcreoYth5e8n07OSiCEzaFQ6MCJyqtOBqs59jlCoCae0nXjeX/D
         04OqZAB+wjL2UOA41l9qO8t6wBlyw4ATQm71U0vFgBuuE5uE9R6wKaX6diZz6jA3SMPL
         KCOWVy8EDjRq5937tp7cQ1NBE2fKHYYukXVz+TJfbZfT2cSBROQXVnQ+XWZTQRsezonJ
         Tv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=5M/cVm8zqW1nWLMcMtcajjeRyWXiITZWxq36axJkGKg=;
        b=h5+YAWZ5iU8mKX/u6o0SWNP21iZE/+YVSSg0cBDZMDGTCouys2dkxqXltLcRivojYV
         +hxaw8PRCk7c0oIXfuNuS6kjSzSkdMaseljezxARNwoSV7qPzs6JIq2AyujTHH1V8OhW
         DvB4EyZsipxx2wJ/22B5TV4owyhEkzo1zOHMPnODclYTjY99szcZPrU8do+0JICf7x96
         ICePTIEWWcXi7ccbm/Zxf9rpDnCyLR3U8i2qQMRZF97wfr3LXX0lhbbvMIlCD7FTTBoJ
         PzWfJ2SN45PGzyVjkxSnt9SyinMUt1Fd4kHPLH+5Tf6EgK6mczmoK5ug0T9sIkwYXbVQ
         J6Ow==
X-Gm-Message-State: ACgBeo2KK/4iktvsSMT7aXlt31RSYNrdEZIVzzapeDA4Jrc7+rXvdSJZ
        j5Zn5vqbJMMtbUWrLE1a+GVeenWaCOHokw==
X-Google-Smtp-Source: AA6agR75GxQQ1B5phlVmDZrKp/TjyLKf5Eh9IYLVNqfYNQNqY3QLEHVXI+c3WSRcGUnSQup3P4kRSA==
X-Received: by 2002:a5d:58f3:0:b0:225:1c88:90d5 with SMTP id f19-20020a5d58f3000000b002251c8890d5mr5105493wrd.231.1660944093869;
        Fri, 19 Aug 2022 14:21:33 -0700 (PDT)
Received: from gmgdl ([213.220.124.15])
        by smtp.gmail.com with ESMTPSA id d7-20020a05600c34c700b003a53731f273sm6544186wmq.31.2022.08.19.14.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 14:21:33 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oP9Qp-000w8z-22;
        Fri, 19 Aug 2022 23:21:31 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael J Gruber <git@grubix.eu>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 1/4] sequencer: do not translate reflog messages
Date:   Fri, 19 Aug 2022 23:13:21 +0200
References: <09rn6r61-38qo-4s1q-q7qq-p5onp6p87o44@tzk.qr>
 <cover.1660828108.git.git@grubix.eu>
 <ea6c65c254bb08b20ea6c4d81200b847755b555c.1660828108.git.git@grubix.eu>
 <220818.86zgg18umf.gmgdl@evledraar.gmail.com>
 <6oqr69o7-qsps-sr86-o4r9-16r7no9n5424@tzk.qr>
 <220819.86o7wg6zci.gmgdl@evledraar.gmail.com> <xmqq8rnkklon.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq8rnkklon.fsf@gitster.g>
Message-ID: <220819.864jy853qc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 19 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Doesn't that also mean that the relevant functionality is now also (and
>> still?) broken on any repository where these translations ended up
>> on-disk?
>
> It may, but the first response to that problem is not to make the
> breakage in repositires worse by keep adding unparseable data to
> them.

*nod*, but where is that breakage specifically? I don't see where we're
parsing this message out again. I tried to test it out with the below
(making the message as un-helpful as possible). All our tests pass, but
of course our coverage may just be lacking...

diff --git a/sequencer.c b/sequencer.c
index 5f22b7cd377..9e039e26b5a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -391,19 +391,24 @@ int sequencer_remove_state(struct replay_opts *opts)
 	return ret;
 }
=20
-static const char *action_name(const struct replay_opts *opts)
+static const char *action_name_1(const struct replay_opts *opts, int rever=
t)
 {
 	switch (opts->action) {
 	case REPLAY_REVERT:
-		return N_("revert");
+		return revert ? N_("trever") : N_("revert");
 	case REPLAY_PICK:
-		return N_("cherry-pick");
+		return revert ? N_("kcip-yrrehc") : N_("cherry-pick");
 	case REPLAY_INTERACTIVE_REBASE:
-		return N_("rebase");
+		return revert ? N_("esaber") : N_("rebase");
 	}
 	die(_("unknown action: %d"), opts->action);
 }
=20
+static const char *action_name(const struct replay_opts *opts)
+{
+	return action_name_1(opts, 0);
+}
+
 struct commit_message {
 	char *parent_label;
 	char *label;
@@ -575,7 +580,7 @@ static int fast_forward_to(struct repository *r,
 	if (checkout_fast_forward(r, from, to, 1))
 		return -1; /* the callee should have complained already */
=20
-	strbuf_addf(&sb, _("%s: fast-forward"), _(action_name(opts)));
+	strbuf_addf(&sb, _("drawrof-tsaf: %s"), _(action_name_1(opts, 1)));
=20
 	transaction =3D ref_transaction_begin(&err);
 	if (!transaction ||
