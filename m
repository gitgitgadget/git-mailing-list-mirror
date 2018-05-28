Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BF931F42D
	for <e@80x24.org>; Mon, 28 May 2018 05:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753341AbeE1F4K (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 01:56:10 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55157 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753233AbeE1Fz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 01:55:58 -0400
Received: by mail-wm0-f66.google.com with SMTP id f6-v6so28903036wmc.4
        for <git@vger.kernel.org>; Sun, 27 May 2018 22:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=cTPibRzwkIyvHDN3x0S2qqGR4IO81HR9q6E2VZmnzD8=;
        b=UqZzRvlnYsqtEyks6i+3Klfo4FXdbyLk2R/B9oRQJ3PSdJuqmGB2QquwDC/hrLuKkf
         vAXMy13BUWizsjMVN2Q40CA6JkuWzOU3C+ahHapOzXBj/1Ugex0jcD8mEBCHVe/ep/jF
         g9wEkT6u4eKn++V82w5jKLuGxcO3yICQP3h+dSh9S3CmiWWt61kE+xG3DCTGd969aB8a
         m8LDQBiYvTbbisWLbaV7tR/VENHbDOPwV8xLICqaU17EwrIa2fDlQ1MXfMnfN1WlR7NK
         PJDj5Jsm9Zdd7AfQjl9HnoO4+7It+JVCMBCmPlCHpc9EPKP6//jPPmO15RgiJR9CFwvB
         gaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=cTPibRzwkIyvHDN3x0S2qqGR4IO81HR9q6E2VZmnzD8=;
        b=GeKbQI5SMO5g7yncud9Vx1pOYIVX+Iu3YurntAl/dW7ZgP7/HLLofxKfluupsdWsu7
         CHitP7hpJyJ8QqH3koSH33dnOYwPgtei8cOcXa1szuukWlcAjsEWQ1PoKkeWbZa3209w
         Amsh0gW1CxMrE8E1gcByODJsh7elF+rtGdZ5LmVYz3a4yKGddbpJRyHY3eNkVsuDoOdQ
         X1sBFAYpagx8I00ePd8kEOt00PyNfMlCGVF41F5EIy7dAEsxiqb1+34Ir5GwR+cEiyK2
         oZujgQMO5guLBJdf+EJFKHSizsjG1j2piyK7198RYKMZhVPSWvkH+resp8Tu9k3BrscV
         xWDQ==
X-Gm-Message-State: ALKqPwczrbyV7UJouxNlEEZChiTNU5ustqST6Jc/m3Gc3YWwI+dkkyBx
        FCoigQh5FyHTPUiyNJXPI4JP6ySe
X-Google-Smtp-Source: ADUXVKJt+CCkh6LEVPhbo0Wl7aOeCfmdX356esOEBzrCPf4orlN1kjjJrTG80/Xp8n8btYZUl9NSNg==
X-Received: by 2002:a1c:f509:: with SMTP id t9-v6mr9168982wmh.13.1527486956937;
        Sun, 27 May 2018 22:55:56 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z18-v6sm37326842wrc.36.2018.05.27.22.55.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 May 2018 22:55:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, a.krey@gmx.de
Subject: Re: [PATCH] upload-pack: reject shallow requests that would return nothing
References: <20180522194854.GA29564@inner.h.apk.li>
        <20180526113518.22403-1-pclouds@gmail.com>
Date:   Mon, 28 May 2018 14:55:55 +0900
In-Reply-To: <20180526113518.22403-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sat, 26 May 2018 13:35:18 +0200")
Message-ID: <xmqqy3g4jpck.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> To avoid this, if rev-list returns nothing, we abort the clone/fetch.
> The user could adjust their request (e.g. --shallow-since further back
> in the past) and retry.

Yeah, that makes sense.

> Another possible option for this case is to fall back to a default
> depth (like depth 1). But I don't like too much magic that way because
> we may return something unexpected to the user.

I agree that it would be a horrible fallback.  I actually am
wondering if we should just silently return no objects without even
telling the user there is something unexpected happening.  After
all, the user may well be expecting with --shallow-since that is too
recent that the fetch may not result in pulling anything new, and
giving a "die" message, which now needs to be distinguished from
other forms of die's like network connectivity or auth failures, is
not all that helpful.

> Note that we need to die() in get_shallow_commits_by_rev_list()
> instead of just checking for empty result from its caller
> deepen_by_rev_list() and handling the error there. The reason is,
> empty result could be a valid case: if you have commits in year 2013
> and you request --shallow-since=year.2000 then you should get a full
> clone (i.e. empty result).

Yup, that latter example makes me more convinced that it also is a
valid outcome if we end up requesting "no" object when shallow-since
names too recent date, e.g. against a project that is dormant since
2013 with --shallow-since=2018/01/01 or something like that, instead
of dying.

> Reported-by: Andreas Krey <a.krey@gmx.de>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  shallow.c             |  3 +++
>  t/t5500-fetch-pack.sh | 11 +++++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/shallow.c b/shallow.c
> index df4d44ea7a..44fdca1ace 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -175,6 +175,9 @@ struct commit_list *get_shallow_commits_by_rev_list(int ac, const char **av,
>  		die("revision walk setup failed");
>  	traverse_commit_list(&revs, show_commit, NULL, &not_shallow_list);
>  
> +	if (!not_shallow_list)
> +		die("no commits selected for shallow requests");
> +
>  	/* Mark all reachable commits as NOT_SHALLOW */
>  	for (p = not_shallow_list; p; p = p->next)
>  		p->item->object.flags |= not_shallow_flag;
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index 0680dec808..c8f2d38a58 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -711,6 +711,17 @@ test_expect_success 'fetch shallow since ...' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'clone shallow since selects no commits' '
> +	test_create_repo shallow-since-the-future &&
> +	(
> +	cd shallow-since-the-future &&
> +	GIT_COMMITTER_DATE="100000000 +0700" git commit --allow-empty -m one &&
> +	GIT_COMMITTER_DATE="200000000 +0700" git commit --allow-empty -m two &&
> +	GIT_COMMITTER_DATE="300000000 +0700" git commit --allow-empty -m three &&
> +	test_must_fail git clone --shallow-since "900000000 +0700" "file://$(pwd)/." ../shallow111
> +	)
> +'
> +
>  test_expect_success 'shallow clone exclude tag two' '
>  	test_create_repo shallow-exclude &&
>  	(
