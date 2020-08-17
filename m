Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFE8C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 18:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3A4E20658
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 18:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u+QQqLmH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390306AbgHQSKr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730237AbgHQSK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 14:10:27 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BABFC061343
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 11:10:27 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l2so15874582wrc.7
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 11:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cRalOlriif3z6cxzVgA5CoycAdB4v2Pz0Kz77A3aYd8=;
        b=u+QQqLmH3RN7FwY9yo58VSJAsn6uDYl5cSk1Ys3safkj3wmjKSPGX14vLsYlhZ0xFr
         Wu8OnzmqitGaHm0FuYF163dpwgAWHoezR7aAnCu7IPBZvQWbrlYtKgcJv2SPcDmRIRIu
         VRktodXbNa0cCvGsT+JWzcHfPOxG0aPuXKmJA1jftpqVIwXFJgxp65bPmz5q3DeE2cV9
         xhSsa8Fbpa2+CooTPzYQSQLgPZpDHvISN9Xi2PGeXR84fwygHijkXpNAckiBk+Sx8nPa
         lYhXwxF1lzjS6CC9NsuMHjuZqdYjGc6GXeFTluWlgaC54ymTaeXseHn7jb2uP5uPoV0c
         O0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cRalOlriif3z6cxzVgA5CoycAdB4v2Pz0Kz77A3aYd8=;
        b=evE2NYOduGvG+YssqqnwT4mMWe5vxWS/ZqSHyB8kzsliebLOKHQ97FRm6s556muBhG
         K95tSWktgVF+9AWmNrK6kaUgFtuR9XypaIpz9CL+tgahHjSRTMRXTK5dod0v/h3JvG2z
         dx237a6KsFYw/bs8T5ts+YWSWiV0tR/Cr3HBmba3WWOLnqbVrrKUdUj6WMM9fBx2NuOQ
         amrgTccoGSrP5tg+c8Eeu8ULlL/Qbi/3bPtW2Iur32bdq1rNg+3OZu4Fc95zgW9JxsLQ
         4+lOi6kJF2Gxddmzrw55vo89XIge+MgEKFYRh41xYd4IFbl+9vcdb181zygTsE4hwzVU
         P0HA==
X-Gm-Message-State: AOAM532OZ5FKC7SkrqoCrBOPiucYdgq/GJkZh34+8dL7ebQD8dKyWjd0
        o96YIXyNgHYqUT2/Ce4Wt4SyAjGf3GE=
X-Google-Smtp-Source: ABdhPJx1C9SV+ej5cIMwVhR91Gd24TRaKL1odebEesi6P5+7iOzgdsKPU8Q08ATgtZoz9k/B8pATmw==
X-Received: by 2002:adf:ab0d:: with SMTP id q13mr15675925wrc.134.1597687825930;
        Mon, 17 Aug 2020 11:10:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j145sm33502795wmj.12.2020.08.17.11.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 11:10:25 -0700 (PDT)
Message-Id: <4a12ff821020ceab5195e406461e00cecbb8e1fb.1597687822.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.684.v3.git.1597687822.gitgitgadget@gmail.com>
References: <pull.684.v2.git.1596664305.gitgitgadget@gmail.com>
        <pull.684.v3.git.1597687822.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Aug 2020 18:10:16 +0000
Subject: [PATCH v3 3/9] ref-filter: modify error messages in
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

