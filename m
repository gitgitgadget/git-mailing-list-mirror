Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48F7320899
	for <e@80x24.org>; Thu, 17 Aug 2017 19:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753442AbdHQTF7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 15:05:59 -0400
Received: from mail-yw0-f169.google.com ([209.85.161.169]:36692 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753407AbdHQTF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 15:05:58 -0400
Received: by mail-yw0-f169.google.com with SMTP id u207so46732101ywc.3
        for <git@vger.kernel.org>; Thu, 17 Aug 2017 12:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/J+xBHcgHahfvYS1oJvfkmp1mjcs1/Eec9YWxBDgQCc=;
        b=J8vYp+LWorAJjLs5s/P+GKPqtx1ECOhHmGjvlQJ5WmxYLeM+1Y9ki/GVbQ9Q3MEY4U
         vt815IixRJhilJWRXHSj0/tykrF2Cz2r3czRmtebqZK8YI7WkhWasFn8XQEP7qJNBQL4
         3eW3Yf9WrXugioJoNmRUwpO54TGgIggcuYQsfSaAAuet6oQcdK1KhVg3mrmDriZzpOmB
         6EnyODd8L+XZUboIqbfK0pXH97gFiIINJG8msAjuVislqAgnjWtowQp93psXUI9LKwdH
         mPlpbTpxGAnYQjYBNPeuH61lWtX2QLt6BNe5tFKlqsdRU0r/KrQ4J9mYg76VJeMaPFDF
         SJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/J+xBHcgHahfvYS1oJvfkmp1mjcs1/Eec9YWxBDgQCc=;
        b=XUKMmfZiTrKrvyWimCejvLUTfDCQLA2V/XaUPe2ozH1kkD2gWkBCaY92UkAI2NdlZa
         px0c7W+/E2K40pgga0ad/wri68JCymS6qL7liGTVmzOJ2PaMGjDcpW6cpFSGGtp15Vsf
         vr53Uy7F09mzSb/earb3eUGLZG28CH/G/SkHZaQxt4rtWPujb7R0WuN+VrYwKY8WVNmP
         2tn+QNrgekIpj1ndzk2z3DzicEtXCZjurDTZCwsTtoMGH0HkF6+zR+RU2zrvzLXJSogZ
         CD7k7XV/kJJ0qI6iEhbsLs8otfSD/2YXIsAAKo8d7O8pVPWYu4AXsPlipg6kjk05aMzB
         ANDA==
X-Gm-Message-State: AHYfb5g5ztbXCxms5I1qHTPIymf/7lqRTrYLhAieocKqBAy8Cn/4WAnH
        BeuLlIhIOoh6MVH6+0UELqyJm0yxIwoP
X-Received: by 10.37.123.129 with SMTP id w123mr5519218ybc.305.1502996757203;
 Thu, 17 Aug 2017 12:05:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Thu, 17 Aug 2017 12:05:56 -0700 (PDT)
In-Reply-To: <20170817103413.GA52233@book.hvoigt.net>
References: <20170817103413.GA52233@book.hvoigt.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 17 Aug 2017 12:05:56 -0700
Message-ID: <CAGZ79kZhUO95oSEzARqXi3+dm5Ow5Jwm-O1adowh0nkbqHdhMw@mail.gmail.com>
Subject: Re: [PATCH] add test for bug in git-mv with nested submodules
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 17, 2017 at 3:34 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> When using git-mv with a submodule it will detect that and update the
> paths for its configurations (.gitmodules, worktree and gitfile). This
> does not work for nested submodules where a user renames the root
> submodule.
>
> We discovered this fact when working on on-demand fetch for renamed
> submodules. Lets add a test to document.
>
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
>  t/t7001-mv.sh | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
> index e365d1f..39f8aed 100755
> --- a/t/t7001-mv.sh
> +++ b/t/t7001-mv.sh
> @@ -491,4 +491,13 @@ test_expect_success 'moving a submodule in nested directories' '
>         test_cmp actual expect
>  '
>
> +test_expect_failure 'moving nested submodules' '
> +       git commit -am "cleanup commit" &&
> +       git submodule add ./. sub_nested &&

If possible, I would avoid adding the repo itself
as a submodule as it is unrealistic in the wild.

While it may be ok for the test here, later down the road
other tests making use of it it may become an issue with
the URL of the submodule.

> +       git commit -m "add sub_nested" &&
> +       git submodule update --init --recursive &&
> +       git mv sub_nested sub_nested_moved &&
> +       git status
> +'
> +
>  test_done
> --
> 2.0.0.274.g6b2cd91
>
