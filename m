Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C918FC3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 13:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFA6821974
	for <git@archiver.kernel.org>; Sat,  2 May 2020 13:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgEBNZg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 09:25:36 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:30659 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727818AbgEBNZg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 May 2020 09:25:36 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 49DqcX3Qvgz5tlB;
        Sat,  2 May 2020 15:25:32 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 6390416AB;
        Sat,  2 May 2020 15:25:31 +0200 (CEST)
Subject: Re: [PATCH 2/3 v3] Teach git-rev-list --ignore-merge-bases
To:     Antonio Russo <antonio.e.russo@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Derrick Stolee <dstolee@microsoft.com>
References: <df0b9e59-e6d7-8839-ca3b-86145dc3bdf3@gmail.com>
 <d3079ba8-33e1-3b68-23d2-ea97b9ca1e97@gmail.com>
 <1716d20d-6f0d-3872-cf36-6fc8d7bdb457@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <37b157a3-f2d6-f459-2f2c-2ab53ba2f7ac@kdbg.org>
Date:   Sat, 2 May 2020 15:25:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1716d20d-6f0d-3872-cf36-6fc8d7bdb457@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.05.20 um 16:22 schrieb Antonio Russo:
> +--ignore-merge-bases::
> +	Show commits that are introduced by each merge before showing
> +	the first parent of the merge but remove edges from those commits
> +	to commits reachable from the first parent. When used with
> +	`--graph`, this can help visualize repositories with many merges
> +	when you are not interested in the merge base used for each
> +	merge. It also reduces the width of the graph visualization
> +	when used with `--graph`.

I wonder whether there is some potential to prettify another aspect of
--graph once this feature is in place: In particular, when I *am*
interested in merge-bases, I use --boundary, and I get this chart:

$ git log --graph --boundary --oneline --no-decorate 7d28d69174~4..7d28d69174

*   7d28d69174 Merge branch 'jc/allow-strlen-substitution-in-shell-scripts'
|\  
| * 78725ebda9 CodingGuidelines: allow ${#posix} == strlen($posix)
* |   dfdce31ce6 Merge branch 'en/pull-do-not-rebase-after-fast-forwarding'
|\ \  
| * | fbae70ddc6 pull: avoid running both merge and rebase
| |/  
* |   b660a76d0f Merge branch 'dl/wrapper-fix-indentation'
|\ \  
| * | 7cd54d37dc wrapper: indent with tabs
* | |   3d6c56dd66 Merge branch 'ag/sequencer-i18n-messages'
|\ \ \  
| * | | 4d55d63bde sequencer: mark messages for translation
| o | | 3bab5d5625 The second batch post 2.26 cycle
|  / /  
o / / 9f471e4b95 Merge branch 'rs/pull-options-sync-code-and-doc'
 / /  
o / 0b6806b9e4 xread, xwrite: limit size of IO to 8MB
 /  
o b6d4d82bd5 msvc: accommodate for vcpkg's upgrade to OpenSSL v1.1.x

but I would prefer to see something like this:

*   7d28d69174 Merge branch 'jc/allow-strlen-substitution-in-shell-scripts'
|\  
| * 78725ebda9 CodingGuidelines: allow ${#posix} == strlen($posix)
* |   dfdce31ce6 Merge branch 'en/pull-do-not-rebase-after-fast-forwarding'
|\ \  
| * | fbae70ddc6 pull: avoid running both merge and rebase
| |/
| o b6d4d82bd5 msvc: accommodate for vcpkg's upgrade to OpenSSL v1.1.x  
*   b660a76d0f Merge branch 'dl/wrapper-fix-indentation'
|\  
| * 7cd54d37dc wrapper: indent with tabs
| o 0b6806b9e4 xread, xwrite: limit size of IO to 8MB
*   3d6c56dd66 Merge branch 'ag/sequencer-i18n-messages'
|\  
| * 4d55d63bde sequencer: mark messages for translation
| o 3bab5d5625 The second batch post 2.26 cycle
o 9f471e4b95 Merge branch 'rs/pull-options-sync-code-and-doc'

Maybe that is just an easy fall-out?

> diff --git a/object.h b/object.h
> index b22328b838..0bf6fb0d55 100644
> --- a/object.h
> +++ b/object.h
> @@ -59,7 +59,7 @@ struct object_array {
> 
>  /*
>   * object flag allocation:
> - * revision.h:               0---------10         15                   25----28
> + * revision.h:               0---------10         15                   23----28

I think the intent is that the line is like a ruler with marks: you
should move "23" sufficiently far to the left, because the "23" mark
cannot be at the same spot where the "25" mark was.

(I'm not reviewing this patch as I am illiterate when it comes to the
revision walker, I just happened to notice this when I skimmed the
patch.)

>   * fetch-pack.c:             01
>   * negotiator/default.c:       2--5
>   * walker.c:                 0-2

-- Hannes
