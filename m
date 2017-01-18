Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 701C51F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 20:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751850AbdARUsu (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 15:48:50 -0500
Received: from mail-it0-f44.google.com ([209.85.214.44]:34046 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbdARUsa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 15:48:30 -0500
Received: by mail-it0-f44.google.com with SMTP id k200so374863itb.1
        for <git@vger.kernel.org>; Wed, 18 Jan 2017 12:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SO8bvi/rtxSFF+Pgt8PgbgGgE4xFR8ld2KjU5NrlBOE=;
        b=W36oECBIFjeyi9ifXgx47PaSfMLSeKBGNSjVjG6BxiLtwZAwyqvgi8DT8k2pEAqett
         iiLrXcTgLAvFKgCXNChEsB0z9JZtcv8rOi3JS2KQB8+FVUk12it6zy0CG3GUW8z/Wma1
         8e6vh3KAV06Xaxw6x/FvUnCgaxTYOz54l4CGNRoENhs6XKCI03ilRUyMYq0g5e6TYPXK
         /qT3E/aoS5D4TGRNWAnBEJ62aI9r5ASBIhkk7R3mkjXOtC6nx8Ah178PqTvSyGllhe2X
         La1leaDXsCNNHvpdXQtT8eGDF5xhPdWQJV0cAOVascLnMxEfffL2KKNhW7Fv7G4ljFew
         dSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SO8bvi/rtxSFF+Pgt8PgbgGgE4xFR8ld2KjU5NrlBOE=;
        b=FElYZ3X3SduTGEzThPXXSJf6KNYox0TwBabdAUAUs8uyQyZFfMBnqyCsfMWkWVeUMv
         gR1stY2KiE/QHWoilIw6635Pt/beTxZ+wMnFr9VNrGE5aA6eTkQD64h1lxljyWcuQZws
         t7BPAzQuoe9kZoXYKK837iINn5BoNXh19Ys0GpvXZIvr7jilZGyAtPzJrD5GkDNZf9d7
         U25dME7Wh7Gk35BbewnHH2529YamCUDBj8+iou3MZiUfyfOBfYE5apBhzww+3xD52E7i
         meaIfSVIghIbrGxjGvIFs7xVvZimE+O7LJppMnY7XOiC06rsQWOYSHwD1NcIC1a2m3Jz
         0zwA==
X-Gm-Message-State: AIkVDXI0CkhA2OiYzeYpcTR4ZbBLPhpyZJ1D514/z3uhe8nebZLFPPUrkhSM5Z9YY4CdxHZ01IIWJa/jPgoGP+lq
X-Received: by 10.36.4.2 with SMTP id 2mr25570920itb.116.1484771972002; Wed,
 18 Jan 2017 12:39:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Wed, 18 Jan 2017 12:39:31 -0800 (PST)
In-Reply-To: <20170112235354.153403-26-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com> <20170112235354.153403-26-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 18 Jan 2017 12:39:31 -0800
Message-ID: <CAGZ79kZv2=dNt=TeJXbac4S20WcdOZo=iVa-b+4zkOoGVM1OFA@mail.gmail.com>
Subject: Re: [PATCH 25/27] attr: store attribute stacks in hashmap
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 12, 2017 at 3:53 PM, Brandon Williams <bmwill@google.com> wrote:
> -static void prepare_attr_stack(const char *path, int dirlen)
> +/*
> + * This funciton should only be called from 'get_attr_stack()', which already

"function"

> +               /* system-wide frame */
> +               if (git_attr_system()) {
> +                       e = read_attr_from_file(git_etc_gitattributes(), 1);

read_attr_from_file may return NULL, so we'd have to treat this similar
to below "root directory", i.e. xcalloc for an empty frame?

> +
> +               /* root directory */
> +               if (!is_bare_repository() || direction == GIT_ATTR_INDEX) {
> +                       e = read_attr(GITATTRIBUTES_FILE, 1);
> +               } else {
> +                       e = xcalloc(1, sizeof(struct attr_stack));
> +               }
> +               key = "";
> +               push_stack(&core, e, key, strlen(key));

If this is a bare repo, could we just omit this frame instead of pushing
an empty xcalloc'd frame? (Same for the stack frames of system wide
and home dir) ?
