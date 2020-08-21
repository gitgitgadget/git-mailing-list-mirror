Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E669C433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56D1220724
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8Y5hqa1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgHUVmH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgHUVl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 17:41:56 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D130BC061575
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:41:55 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l2so3191790wrc.7
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cRalOlriif3z6cxzVgA5CoycAdB4v2Pz0Kz77A3aYd8=;
        b=h8Y5hqa19BbjHAmI4mKX5IysKkasZlStRHKa+SSxo3wRa1gPVQTU2bodFWyf8YcEZw
         KHysO+nyC2kjIW1aiE4J8fI301p0iEK5BTnTxlNhgcP90/sbX6IipiuMORPVM8zMGjtw
         b06cJA3+MF8HOiEPSVXJLLws1wOhPSiHG9Rzz1VhvLibE8UQMFHSv4wzZC5Itdot1XNC
         lyP4Ij0bHrb2ohFWt/lXQcHErN4MLsnleKExeINwRPvu7ZQAQBNXz9x/mssWKUAzEL06
         wjdO5OuXSj/07n4rR7wy3T7w4xTZwlVpIRUCqzGZX3sKEWcbAGuFRl4a2DY0p1FOm8Lx
         +TGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cRalOlriif3z6cxzVgA5CoycAdB4v2Pz0Kz77A3aYd8=;
        b=f+Y45cz82qB1q2RZHxpGEcEq9XyjY7ipYzX7PQ/ZD2tYaERiR6XRdgYc9bAi/ikYYn
         3+BnLWRRFSlFU0vjvOXbUS/UfcINlnRAeyO212Zb3t1Xwg4Y0kZJUdH0dwE5ucN+8/AU
         tckQkuE5Llb0h/+8zYDWxpYB6YhZZzhtmzN/jgWaRhybP8u/XoVBSpqTyYVWX5cavhUz
         vzgwCdd9ZUQwSbmW6ashTcvnJHkQk9sC2F4j+Q8t+NNei44wgjjV9qVocaM2wnS2gs35
         8fIjFkUfjtr6HyxO5mfQOTxvLr2le+sSx56Rb+mg8ZX0dZL21kPsl1VzWuQAeOHmXX6+
         cErg==
X-Gm-Message-State: AOAM5334Da/cThompQjAR3mfJYHUvnvz5wTNqU2/e1iZJdk8UKLJgM0i
        +5jGawXeSUSJRWqCl55jRunAqcbSTFI=
X-Google-Smtp-Source: ABdhPJxY6pwHTg3OXHFkBLNVVo9bnC0E+l/bCMiN3kTptPsldvCEiZAok8CMv37ovD8d9GMfQOrR9A==
X-Received: by 2002:adf:e911:: with SMTP id f17mr4289353wrm.397.1598046114411;
        Fri, 21 Aug 2020 14:41:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m16sm6348608wrr.71.2020.08.21.14.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 14:41:54 -0700 (PDT)
Message-Id: <582f00ace6b3173cfebb3f6e5d859f471ea01ab7.1598046110.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.684.v4.git.1598046110.gitgitgadget@gmail.com>
References: <pull.684.v3.git.1597687822.gitgitgadget@gmail.com>
        <pull.684.v4.git.1598046110.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Aug 2020 21:41:45 +0000
Subject: [PATCH v4 3/8] ref-filter: modify error messages in
 `grab_objectname()`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Hariom Verma <hariom18599@gmail.com>

As we plan to use `grab_objectname()` for `tree` and `parent` atom,
it's better to parameterize the error messages in the function
`grab_objectname()` where "objectname" is hard coded.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Heba Waly <heba.waly@gmail.com>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 ref-filter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 9bf92db6df..4f4591cad0 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -372,11 +372,11 @@ static int objectname_atom_parser(const struct ref_format *format, struct used_a
 		atom->u.objectname.option = O_LENGTH;
 		if (strtoul_ui(arg, 10, &atom->u.objectname.length) ||
 		    atom->u.objectname.length == 0)
-			return strbuf_addf_ret(err, -1, _("positive value expected objectname:short=%s"), arg);
+			return strbuf_addf_ret(err, -1, _("positive value expected '%s' in %%(%s)"), arg, atom->name);
 		if (atom->u.objectname.length < MINIMUM_ABBREV)
 			atom->u.objectname.length = MINIMUM_ABBREV;
 	} else
-		return strbuf_addf_ret(err, -1, _("unrecognized %%(objectname) argument: %s"), arg);
+		return strbuf_addf_ret(err, -1, _("unrecognized argument '%s' in %%(%s)"), arg, atom->name);
 	return 0;
 }
 
-- 
gitgitgadget

