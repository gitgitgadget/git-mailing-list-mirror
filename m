Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78926C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 16:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 307EB23B6C
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 16:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgLRQFw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 11:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgLRQFw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 11:05:52 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A46C0617B0
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 08:05:11 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id s26so6662926lfc.8
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 08:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0XgkTV+wqrNirWi6FcsAkll0eB+7y4BACD67ue1QuAs=;
        b=gNbCqbkUHHq28Vj52Y1y3S4JkoYAAqvVXsdpSp8T7puZDLug+iCovSfI0kYsQz9iyX
         aJz8SCsOvEke07R/+qacAil5Ek5Y51anuZRb/aV72g1SE2+Fn40R+JSOvodqNOPf9Qmz
         mApCSyGSDlUYzAY2yyg65NgCbJASKiHsnQrNWekMP2B4i1KLuJUb3WyopRJEoIo89qTm
         JmvdRzQN2GUElTcQqQpDqFb+E3UOo90XnvbhpreIIw268GfK/z3Z018+IdNWS0fi6E3g
         q7p915gT6mlKmW4gVWRVr3WEgAKYLaD22aK9PK30iKoAbz0pAZz0AQCTHt3z/n/WXlmu
         SnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=0XgkTV+wqrNirWi6FcsAkll0eB+7y4BACD67ue1QuAs=;
        b=OpJztvN5V/QYFtkG0P6HZJSLYdsa5GC+orgnhWObj7ygvTTa/Jn0UMD8dxGGX2fvyz
         7d/L9VqWIb4Jy7YhrYcjm4bJPubQYS0cw3E7CnouCXAlTV+GSGC7MbisQP2+EZ1fSRGJ
         Z7zf3V3MfbFR56dhMx8yj+NFFzbHKUtLw/05rpGFohPy4vcXyTTKeKhiCn0jqLWgs0ut
         TwFk92wu0jd83pLo3v4BtAA2vn0ZStvLQ69MYj5U9YCYudEyEVD5pQgEhalz9blaqXvL
         qJucMutYFXJioUeXtyeVc5/u1Ll7D08V0HQaxixs+8Wpd0GK59catScDqQlsBOFYr2UW
         TpWg==
X-Gm-Message-State: AOAM5338mKCVK1lBaR3HJaMmdqgewLlRKLKDws7tAwdwmq9rIOB2Xkbp
        jy0Tdy7oLZZ7g31ehj3OYDZ5EgUsjws=
X-Google-Smtp-Source: ABdhPJxHDpMMBPvipew//TTrxhw7A/vqaMNJxyQVHvoMdbm3GD6SOh+kMSKgnUWqR0w7ViIBmy2vDA==
X-Received: by 2002:a2e:8e94:: with SMTP id z20mr2026733ljk.450.1608307509540;
        Fri, 18 Dec 2020 08:05:09 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id i19sm969411lfl.98.2020.12.18.08.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 08:05:05 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 29/33] doc/git-log: describe new --diff-merges options
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201216184929.3924-1-sorganov@gmail.com>
        <20201216184929.3924-30-sorganov@gmail.com>
        <CABPp-BFRPFxm=SuJFwfG+QYCivMKp2VRpnHGwxNL+extK7UdtA@mail.gmail.com>
Date:   Fri, 18 Dec 2020 19:05:04 +0300
In-Reply-To: <CABPp-BFRPFxm=SuJFwfG+QYCivMKp2VRpnHGwxNL+extK7UdtA@mail.gmail.com>
        (Elijah Newren's message of "Thu, 17 Dec 2020 21:53:51 -0800")
Message-ID: <87lfdvaymn.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Wed, Dec 16, 2020 at 10:50 AM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Describe all the new --diff-merges options in the git-log.txt and
>> adopt description of originals accordingly.
>
> You also took care to explain interactions of options with -p that
> were previously undocumented, which is a nice bonus.  That wording
> could still be improved a bit, though, as noted below.
>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  Documentation/git-log.txt | 85 ++++++++++++++++++++++++---------------
>>  1 file changed, 52 insertions(+), 33 deletions(-)
>>
>> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
>> index 2b8ac5ff882a..27bc619490c6 100644
>> --- a/Documentation/git-log.txt
>> +++ b/Documentation/git-log.txt
>> @@ -120,45 +120,64 @@ DIFF FORMATTING
>>  By default, `git log` does not generate any diff output. The options
>>  below can be used to show the changes made by each commit.
>>
>> -Note that unless one of `-c`, `--cc`, or `-m` is given, merge commits
>> -will never show a diff, even if a diff format like `--patch` is
>> -selected, nor will they match search options like `-S`. The exception is
>> -when `--first-parent` is in use, in which merges are treated like normal
>> -single-parent commits (this can be overridden by providing a
>> -combined-diff option or with `--no-diff-merges`).
>> +Note that unless one of `--diff-merges` variants (including short
>> +`-m`, `-c`, and `--cc` options) is explicitly given, merge commits
>> +will not show a diff, even if a diff format like `--patch` is
>> +selected, nor will they match search options like `-S`. The exception
>> +is when `--first-parent` is in use, in which case `first-parent` is
>> +the default format.
>
> Thanks for fixing this up.  :-)

Don't mention it :-)

>
>>
>> --c::
>> -       With this option, diff output for a merge commit
>> -       shows the differences from each of the parents to the merge result
>> -       simultaneously instead of showing pairwise diff between a parent
>> -       and the result one at a time. Furthermore, it lists only files
>> -       which were modified from all parents.
>> -
>> ---cc::
>> -       This flag implies the `-c` option and further compresses the
>> -       patch output by omitting uninteresting hunks whose contents in
>> -       the parents have only two variants and the merge result picks
>> -       one of them without modification.
>> +--diff-merges=(off|none|first-parent|1|separate|m|combined|c|dense-combined|cc)::
>> +--no-diff-merges::
>> +       Specify diff format to be used for merge commits. Default is
>> +       `off` unless `--first-parent` is in use, in which case
>> +       `first-parent` is the default.
>> ++
>> +--diff-merges=(off|none):::
>> +--no-diff-merges:::
>> +       Disable output of diffs for merge commits. Useful to override
>> +       implied value.
>> ++
>> +--diff-merges=first-parent:::
>> +--diff-merges=1:::
>> +       This option makes merge commits show the full diff with
>> +       respect to the first parent only.
>
> Does it imply -p?

No, none of --diff-merges options do. This one is not any special. Why
the question?

>> ++
>> +--diff-merges=separate:::
>> +--diff-merges=m:::
>> +-m:::
>> +       This makes merge commits show the full diff with respect to
>> +       each of the parents. Separate log entry and diff is generated
>> +       for each parent. `-m` is different in that it doesn't produce
>> +       any output without `-p`.
>
> Different from what?  From --first-parent?  From flags that haven't
> been covered yet?  (-c and --cc show up below)

Well, from --diff-merges=m and --diff-merges=separate, that, as any
other --diff-merge option, do produce output (for merge commits) even
without -p.

>
>> ++
>> +--diff-merges=combined:::
>> +--diff-merges=c:::
>> +-c:::
>> +       With this option, diff output for a merge commit shows the
>> +       differences from each of the parents to the merge result
>> +       simultaneously instead of showing pairwise diff between a
>> +       parent and the result one at a time. Furthermore, it lists
>> +       only files which were modified from all parents. Historically,
>> +       `-c` enables diff output for non-merge commits as well.
>
> "Historically"?  Does that mean it doesn't anymore?

Eh, I don't think "historically" means that, but I'm not sure, being
non-native English speaker.

> (Maybe, "The short form, `-c`, also enables diff output for non-merge
> commits as well." or something like that?)

... and then try to explain why this otherwise illogical behavior is
there? I thought "historically" would cover that.

>
>> ++
>> +--diff-merges=dense-combined:::
>> +--diff-merges=cc:::
>> +--cc:::
>> +       With this option the output produced by
>> +       `--diff-merges=combined` is further compressed by omitting
>> +       uninteresting hunks whose contents in the parents have only
>> +       two variants and the merge result picks one of them without
>> +       modification.  Historically, `--c` enables diff output for
>> +       non-merge commits as well.
>
> Same note as above.

Yep.

>
>>  --combined-all-paths::
>>         This flag causes combined diffs (used for merge commits) to
>>         list the name of the file from all parents.  It thus only has
>> -       effect when -c or --cc are specified, and is likely only
>> -       useful if filename changes are detected (i.e. when either
>> -       rename or copy detection have been requested).
>> +       effect when `--diff-merges=[dense-]combined` is in use, and
>> +       is likely only useful if filename changes are detected (i.e.
>> +       when either rename or copy detection have been requested).
>>
>> --m::
>> -       This flag makes the merge commits show the full diff like
>> -       regular commits; for each merge parent, a separate log entry
>> -       and diff is generated. An exception is that only diff against
>> -       the first parent is shown when `--first-parent` option is given;
>> -       in that case, the output represents the changes the merge
>> -       brought _into_ the then-current branch.
>> -
>> ---diff-merges=off::
>> ---no-diff-merges::
>> -       Disable output of diffs for merge commits (default). Useful to
>> -       override `-m`, `-c`, or `--cc`.
>>
>>  :git-log: 1
>>  include::diff-options.txt[]
>> --
>> 2.25.1
>
> The rest looks good.

Thanks,
-- Sergey
