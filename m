Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43718ECAAD4
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 22:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbiHaWVB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 18:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiHaWU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 18:20:59 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C700B9A948
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 15:20:57 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id j9-20020a17090a3e0900b001fd9568b117so644238pjc.3
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 15:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=m+hO6WP8Tkumkm9C7cWddGPtubm2F2R4hsWLeKSxJqE=;
        b=Jl7QCMBq8UPqwFwFARHm+1sQDdAUnm2CyE0nvVTgyGiWX9KIHbmty08fYgS5YmJOCy
         6hpsu178iDXvP1RvTHzE8kt7gAVKCYDOogsvsNn+mmEUILzIxY4GPSRSUJ0Un7ElfICQ
         Nh9m9CDxkVo6GQg6jA/Ip8ydZ+o4GwobsHmHI1QZIcdyxabEZO1OQi7YSjtWLvgV/ksF
         Y+1N5CIEdg8jv7+S7wrkIg9SKSbDXkXHFl7CUrnwAjEW3cuJx83uCeFJsoR7FxxRygQL
         ystljI97ZWalxgrBhFWFV7a0QubpoU7ulkfVehvVZf4T6BTG9ztxxDebhpDXhbQWhxfu
         TOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=m+hO6WP8Tkumkm9C7cWddGPtubm2F2R4hsWLeKSxJqE=;
        b=FrjaJ9r+ZYC5JB0Sy9P+NIi6ULuYE7GqAhYwNa4m9ETGplE5LcApkTfks578TFzLe3
         wSsBmy+HWmi3Iy7/SkDvxfb7uhH1I8CNuhyt1yfFnH2jjYgDHoX+OSoePy+kKkZDo5UP
         nFJ5AJF6h0/tpj0SzJego9QH8Vpi3sXqN2ZSqnBHrTjAteyJk6JvaiRAAK4RViNct+Ze
         dIOJyeDX1PBmI5Cp8AsM/rQSrtH4M5/Dzu0gY+QYpGzcZD8uOTgrCT0XjD0vZC5AFE7P
         wtYuzJKyx+6o+WTg9WKdkYCwDXZQO/GvaGgXFRENg5lkFnipA6c03blfaH7YZW4BzxI4
         fqfg==
X-Gm-Message-State: ACgBeo1kFor7BgW4P0iAYaaBna7dBegE0HXoAD8oOQAmC2kls9dN+lcq
        qQLaNap62qODAU7s4HcQ3Ns=
X-Google-Smtp-Source: AA6agR44UaM4m6leicjEu4xZ0rOXuVb8ywpUVRy+cShgH3fzXtK+mQAH88fAuDRRNakuuLMac035dg==
X-Received: by 2002:a17:902:ce88:b0:174:9e8e:ee39 with SMTP id f8-20020a170902ce8800b001749e8eee39mr18887708plg.71.1661984457165;
        Wed, 31 Aug 2022 15:20:57 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id k5-20020a17090a148500b001faafa42a9esm1822430pja.26.2022.08.31.15.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 15:20:56 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/3] diff: have submodule_format logic avoid additional
 diff headers
References: <pull.1342.git.1661926908.gitgitgadget@gmail.com>
        <e4414cf630da284bdb11f5613ca0ce6413c6a443.1661926908.git.gitgitgadget@gmail.com>
Date:   Wed, 31 Aug 2022 15:20:56 -0700
In-Reply-To: <e4414cf630da284bdb11f5613ca0ce6413c6a443.1661926908.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Wed, 31 Aug 2022
        06:21:46 +0000")
Message-ID: <xmqqedwwdph3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> Commit 95433eeed9 ("diff: add ability to insert additional headers for
> paths", 2022-02-02) introduced the possibility of additional headers,
> created in create_filepairs_for_header_only_notifications().  These are
> represented by inserting additional pairs in diff_queued_diff which
> always have a mode of 0 and a null_oid.  When these were added, one
> code path was noted to assume that at least one of the diff_filespecs
> in the pair were valid, and that codepath was corrected.
>
> The submodule_format handling is another codepath with the same issue;
> it would operate on these additional headers and attempt to display them
> as submodule changes.  Prevent that by explicitly checking for both
> modes being 0.

It may make sense to give a concrete name for the condition these
new codepaths check, which presumably exists in the part that was
touched in 95433eeed9 when "that codepath was corrected".  I think
you want to treat a diffpair with at least one side with non-zero
mode as a "real" thing (as opposed to the phony "additional headers"
hack), so perhaps

	int diff_filepair_is_phoney(struct diff_filespec *one, 
            			    struct diff_filespec *two)
	{
		return !DIFF_FILE_VALID(one) && !DIFF_FILE_VALID(two);
	}

or something like that.  The use of the FILE_VALID macro here is
very much deliberate, and tries to match the more recent hack after
this hunk that says:

	if (!DIFF_FILE_VALID(one) && !DIFF_FILE_VALID(two)) {
		/*
		 * We should only reach this point for pairs from
		 * create_filepairs_for_header_only_notifications().  For
		 * these, we should avoid the "/dev/null" special casing
		 * above, meaning we avoid showing such pairs as either
		 * "new file" or "deleted file" below.
		 */
		lbl[0] = a_one;
		lbl[1] = b_two;
	}

We shouldn't expect readers to understand (one->mode || two->mode)
is about the same hack as the other one.


