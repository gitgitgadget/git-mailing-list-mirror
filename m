Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7F48207DF
	for <e@80x24.org>; Tue, 13 Sep 2016 03:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751608AbcIMDgA (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 23:36:00 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38269 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750975AbcIMDf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 23:35:59 -0400
Received: by mail-wm0-f43.google.com with SMTP id 1so177522550wmz.1
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 20:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VhcjvuTrLl+W0xf2/tp84vX2+Ycl1GnOXqVptc5Zs7A=;
        b=gXzKQKZ7BGMDJegpP82hYNOST6SJQxuIYjejtojSmXfepiU9/O9HRP4YG3TG1vQsko
         i9d0s26oYo4qA/fpm/tmAx6/qmPUWKM12emijDCcfu635M4ixj9xXPPVsc6JGE6LhFeQ
         JK4PoFyrDYIJR1qUXhuNE51luUWlqKFVYzwPxpY8lzNxziuQb/hqEiRVCQ4QmmaBZwWY
         q+JNBtDxxgifk2fFZLsjRo8PJhD7oHGrt0LVWjoJdyrVdayFbGofsEScAcnXHSdx0Ih3
         QFL56qCk+bhjwFF8+9rqJEpAMde5Tzl9OBK4kZlqjMI/Eubwgts1TuL07wmpRBB3/Ppc
         6qpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VhcjvuTrLl+W0xf2/tp84vX2+Ycl1GnOXqVptc5Zs7A=;
        b=TWvXCz5qf62jOcgJ4vBSa+QlJRObghu2YFzBHKrV80niX84kw6eGJlO/mNREGlwzUr
         9TzxhhRq3Z4S9wWgZTTNbnR9FDz4SqyroVppmY6E+KNtwUtsEEYtZpH5FBxE4xxLm6nU
         8MOYTYwT4UKD9XxlYuFHIKNeamxWKPVckfuXnvhiKeMUjnYrChNK6CflicjtOapkdaPp
         4ozX3eYZ2/s4X3H39TnEFAPgl4p7lTDd6Rkkg5tV2iT/835Go9IR7ysw3I+BlgTqmMLo
         jgdgGb+jPZ9Mb8U+8T1iA8cK1np/0o13jlUTQp71TTi+W6LLB+Myo1EVoCrcK9Ak4Tk0
         fIng==
X-Gm-Message-State: AE9vXwM5BLHmOYarMYNnff4RBiTcdP3Ka/zTSlLC6Ltbbl9JF5XXTNtlbLPFw3mquTyEOJOZUTsYGWl3xxW+GQil
X-Received: by 10.194.123.35 with SMTP id lx3mr19945433wjb.126.1473737758036;
 Mon, 12 Sep 2016 20:35:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.15.79 with HTTP; Mon, 12 Sep 2016 20:35:57 -0700 (PDT)
In-Reply-To: <1473726835-143289-1-git-send-email-bmwill@google.com>
References: <1473458004-41460-1-git-send-email-bmwill@google.com> <1473726835-143289-1-git-send-email-bmwill@google.com>
From:   Brandon Williams <bmwill@google.com>
Date:   Mon, 12 Sep 2016 20:35:57 -0700
Message-ID: <CAKoko1pc7bB85cjho7mg0mDQrDjmfvpAVC8FS=VtQ+Dwk6eCYA@mail.gmail.com>
Subject: Re: [PATCH v2] ls-files: adding support for submodules
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>  static void write_name(const char *name)
>  {
>         /*
> +        * NEEDSWORK: To make this thread-safe, full_name would have to be owned
> +        * by the caller.
> +        *
> +        * full_name get reused across output lines to minimize the allocation
> +        * churn.
> +        */
> +       static struct strbuf full_name = STRBUF_INIT;
> +       if (output_path_prefix != '\0') {

It was pointed out to me that this should be:
    if (*output_path_prefix != '\0') {


> +               strbuf_reset(&full_name);
> +               strbuf_addstr(&full_name, output_path_prefix);
> +               strbuf_addstr(&full_name, name);
> +               name = full_name.buf;
> +       }
