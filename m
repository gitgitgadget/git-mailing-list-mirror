Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7339BC433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 21:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344031AbiCJVlJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 16:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbiCJVlH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 16:41:07 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49105C116B
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 13:40:05 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d2d45c0df7so53114057b3.1
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 13:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MNurDcELtB6qqav0CGFVdjSnBfzsuw5PkIDxq19K7j8=;
        b=gElny1E2VdYe3aEz0i+0p3h6Dxc9NX8QLE7B1zntZ3P3UJWA8fRfaHdVzcEyf8PUdL
         hFlpH7yECuv1pQAkj5ShYuvAzpXLn0BngW9ksZrkBJiUInzKhA/YwCFm/UpHZdQn6cox
         e+QCp52xspX39tuFRmDiZy02lr7KjWMb712NZ5NMBuEzpXCBuJ5gj6j4ZWzZmLHgz/HJ
         lU0omcjJPQehHK5zZ1ss3kVOgtye+ZdcuZ3+YqhxRkIBZn0P57eLXhQRICqpr+v4r3W/
         KzdNvd1dWeF+ZH6QugFtRrylMSM01CG435TzGZYgJaaFhiAQa5KgHY+DYEs+n/oakVxZ
         PMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MNurDcELtB6qqav0CGFVdjSnBfzsuw5PkIDxq19K7j8=;
        b=NPhxdK1ae+eY52yMRbhl4w12Do4oHDWdGl3lBCisq0ieWGJ8XTemwDMy7m4UnpApi5
         pMzeTSPy5pA6Z22ugMaRz/TrfPQhg8ISgFEn+ezt1gOjfNEua4oD/rmU9Tp5/epIWkXQ
         uC41jTll6cJguJQ8EDH08QsNJtOK6eVa6PX73tAO8Sj+BKsk1kZVfA41llZin1ZGt6pb
         y7LOzWUnDfQqSQ0FQE4fOkZx3ShTaaft5pVJ4pYf5fdC4CwVfWXMbFNQAzHS0DoEcPgc
         mOoVyeicOIuGpOxWeUaA1HL6vuT7FPaFQLaAFGP49zKfrqf1Gsv/DVVfaFbgvl7yxI9p
         1oKQ==
X-Gm-Message-State: AOAM5301WFORdoOmjs/fJJuLLE62u/oYGVnSPf8TIuERQ7wuUsBQkaVQ
        yRnkm8dY03Wx9vslwSnFJA0MUa0nP473VQ==
X-Google-Smtp-Source: ABdhPJy3TMu0rnDI1FD80LCELZFDoM6wjJ5kv6fvn+8Iybc66BiTLZnIwWB+OJh5/AzVFHkbi65gD463CfXq5A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:1f88:0:b0:628:4ae3:b7a5 with SMTP id
 f130-20020a251f88000000b006284ae3b7a5mr5526874ybf.435.1646948404494; Thu, 10
 Mar 2022 13:40:04 -0800 (PST)
Date:   Thu, 10 Mar 2022 13:40:02 -0800
In-Reply-To: <xmqqtuc6h83m.fsf@gitster.g>
Message-Id: <kl6la6dxsczx.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220310004423.2627181-1-emilyshaffer@google.com>
 <20220310004423.2627181-3-emilyshaffer@google.com> <xmqqtuc6h83m.fsf@gitster.g>
Subject: Re: [PATCH v9 2/3] introduce submodule.hasSuperproject record
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Emily Shaffer <emilyshaffer@google.com> writes:
>
>> @@ -2617,6 +2622,12 @@ static int run_update_procedure(int argc, const char **argv, const char *prefix)
>>  
>>  	free(prefixed_path);
>>  
>> +	/*
>> +	 * This entry point is always called from a submodule, so this is a
>> +	 * good place to set a hint that this repo is a submodule.
>> +	 */
>> +	git_config_set("submodule.hasSuperproject", "true");
>> +
>>  	if (!oideq(&update_data.oid, &update_data.suboid) || update_data.force)
>>  		return do_run_update_procedure(&update_data);
>
> In Glen's update to rewrite "submodule update" in C, this part is
> replaced with a call to update_submodule2().  I am not sure what the
> current repository is at this point of the code with and without
> Glen's topic, but are we sure we are in a submodule we discovered?

Rereading this, I realize you probably meant that this conflicts with
part1, not part2...

At the end of part1, update_submodule2() is called from inside the
submodule (specifically from run_update_procedure()). So a good merge
conflict resolution would be to set the config _before_ calling
update_submodule2(). e.g.

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index bef9ab22d4..f53808d995 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2672,6 +2677,11 @@ static int run_update_procedure(int argc, const char **argv, const char *prefix)
                                            &update_data.update_strategy);

        free(prefixed_path);
+       /*
+        * This entry point is always called from a submodule, so this is a
+        * good place to set a hint that this repo is a submodule.
+        */
+       git_config_set("submodule.hasSuperproject", "true");
        return update_submodule2(&update_data);
 }
