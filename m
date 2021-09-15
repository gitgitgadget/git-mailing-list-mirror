Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A0FC433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 22:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A36660FC0
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 22:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhIOWpL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 18:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbhIOWpK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 18:45:10 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94A6C061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 15:43:50 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i4so10568068lfv.4
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 15:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cgJhEdamDpGgSkSpcxp5c0+pi1B+fFLKVbFYwjpDyz4=;
        b=W0XjbgH586ZdJ8K6V7f4J8CXvdwGTnDp9RvnSc7A0XwBM4EXas87De+T525KCzcqsA
         vR0WYBnsT2PXP2G8stwTlmXNfqA5jPWCEquRNRGNACRhi//ootlDr3AZQylntUIOJHI/
         Mva2MspSbxKmj7N+CvRgWsRF81wEbGIbAaOXX8GYxC7jFgV4JzR163plsmZFH9klS1DP
         Qpd2hszLd8tM8o9Th9CPB0SsbW751pyWT7iJ3IpAitk0iheinBUtFPhhbJgEbCmkcWQ3
         gMUZGntqNtSZMG7R1nlcJh0+8KE6IXBsDH9NTUnXzH4/Z1kaFdFWOPv4y7Jsf+03H2zb
         EOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cgJhEdamDpGgSkSpcxp5c0+pi1B+fFLKVbFYwjpDyz4=;
        b=HUcVnrLj457ruSfwM1KncNlfVmVmw9KCGLqjKjU0+yJa65SSzJW2Q0bl5zwuz+9fM/
         e4b1wDB3a8v87efAeE33bApk7TcuJ2q5F1dB2Q+THOTNTe0p1p/o+m7kvwVAajY2HxoT
         lM58nQDXjZpLFdidDEVYQQNDUP8989Q6QjSytcxbjwm5PO2cqIHglJOXOiMr4CJ1snZE
         nNW44VRG3nU88NBZRrXhY1fRfHzg/flPTsxOTuzaFgMvxfLD71Iek2b+fT8I0MtsYqQx
         t0zHLMeUv4uWxs472rrAjniufGzGCqDuROkF8V5G1moSJM7DZtps3Yg34c42Wek82x6G
         9lpw==
X-Gm-Message-State: AOAM533cRMg/n4JgTkrx4HPQlAxJ41YudVlBzz0zNzQeQUJgU/OWY3dU
        4NeeXXC0jpWKy35Z9O/VtDiLLzU7UuVqZygGGrqCsXlZ0IU=
X-Google-Smtp-Source: ABdhPJyxlaeZ67MzAklbkA+Fd7bH0lTEWsYOZv1dj15mfkUPkQ/4D17+08qb8buXp0jn2kj0+ODXK3YxUW2u4l7SrkA=
X-Received: by 2002:a2e:9849:: with SMTP id e9mr1976757ljj.315.1631745829131;
 Wed, 15 Sep 2021 15:43:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com>
 <pull.1076.v3.git.git.1631590725.gitgitgadget@gmail.com> <55a40fc8fd59df6180c8a87d93fcc9a232ff8d0a.1631590725.git.gitgitgadget@gmail.com>
 <xmqqtuilyfls.fsf@gitster.g>
In-Reply-To: <xmqqtuilyfls.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 15 Sep 2021 15:43:38 -0700
Message-ID: <CANQDOdc8F7a3ZeTDpUWrt8uUntnX4jHYxyj96SPwH-P=kMrneg@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] core.fsyncobjectfiles: enable batch mode for testing
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 15, 2021 at 9:21 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Neeraj Singh <neerajsi@microsoft.com>
> >
> > Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
> > ---
> >  environment.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/environment.c b/environment.c
> > index 3e23eafff80..27d5e11267e 100644
> > --- a/environment.c
> > +++ b/environment.c
> > @@ -43,7 +43,7 @@ const char *git_hooks_path;
> >  int zlib_compression_level = Z_BEST_SPEED;
> >  int core_compression_level;
> >  int pack_compression_level = Z_DEFAULT_COMPRESSION;
> > -enum FSYNC_OBJECT_FILES_MODE fsync_object_files;
> > +enum FSYNC_OBJECT_FILES_MODE fsync_object_files = FSYNC_OBJECT_FILES_BATCH;
> >  size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
> >  size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
> >  size_t delta_base_cache_limit = 96 * 1024 * 1024;
>
> Despite what the title of the change claims, this is not "enable for
> testing", but "enable for everybody even in production", isn't it?
>
> I'd prefer we do not do this, certainly not for "testing".
>
> If setting the variable to "batch" were meant to eventually improve
> performance for all different flavours of workload, I do not think
> we would mind if we set it to "batch" for those who opt into the
> "experimental" set of features by setting the feature.experimental
> configuration variable to true.  And after a few development cycles
> when the feature proves to be useful for everybody, we may want to
> apply this patch under a justification that is different from "for
> testing".
>
> On the other hand, if this is meant to help 85% of people while
> degrading the remainder of workflow, I do not think we would want to
> see this change without a warning that says something along the
> lines of "under rare circumstances (e.g. if you employ such and such
> workflow), the new default value used for the core.fsyncObjectFiles
> configuration variable will hurt performance."
>
> Since this is about answering the question "between performance and
> crash resilience, where do you as an end user strike the balance for
> your needs?", I do not think it falls into either of the above two
> categories.
>
> The only plausible justification I can think of to apply a "we
> default to 'batch' for everybody" patch with is something like:
>
>     Now with the 'batch' setting for core.fsyncObjectFiles, unlike
>     'true' that paid very high overhead, the overhead to ensure our
>     writes hit the disk platters has so greatly been reduced that it
>     hurts the performance only negligibly.  Let's switch the default
>     from the unsafe value of 'false' to safer and performant value
>     of 'batch'.
>
> I however doubt with the current round of patches, we are there yet.

Sorry for being unclear here (and perhaps including an improper patch).
This commit is mainly to ensure that we get coverage of batch mode on all
platforms in the CI infrastructure.  I don't believe it should be included in
mainline git without significantly more discussion and experimentation.

However, I'd hope that Git for Windows would be able to adopt batch mode
by default when they pull this series in. They are currently enabling fsync
by default.

Batch mode does have more cost, particularly on rotational media.
I think git should eventually enable batch mode by default with the proviso that
maintainers and people running ephemeral CI infrastructure should turn
fsync off
if they care more about speed than durability.

Do you think that feature.experimental is a good place to put this right away,
or should we just leave this as an option that Git for Windows can pick up and
leave the other platforms alone?

Thanks,
Neeraj
