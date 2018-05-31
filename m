Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7159D1F42D
	for <e@80x24.org>; Thu, 31 May 2018 17:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755826AbeEaRsS (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 13:48:18 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:63999 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755796AbeEaRsR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 13:48:17 -0400
Received: from [192.168.2.201] ([89.242.184.94])
        by smtp.talktalk.net with SMTP
        id ORgMfoiiQpXFjORgMfxt5U; Thu, 31 May 2018 18:48:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1527788895;
        bh=/EP91pQhV3EGovN7IbAdySzZ2QjaOnWT3OUG6Tlb3bA=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=cmLIhcdxhcT01P9QcrGUhQUITliSWiRgFyeQ1rCAtv5dMS1d8AT/9oKyS6LGtjHnv
         d5B5MURbIiGCD4FC6KTklUJ5uxgesQeMKW7JQbrikKOc8RQ5C9wz/M+0Faqr+kA22m
         zAu7qhY1MBKAi/T3jIS4NA19pFLC+FRm2JM17gZI=
X-Originating-IP: [89.242.184.94]
X-Spam: 0
X-OAuthority: v=2.3 cv=Ob228CbY c=1 sm=1 tr=0 a=SNYNCI/Ed5RqTX+Z+9mojA==:117
 a=SNYNCI/Ed5RqTX+Z+9mojA==:17 a=IkcTkHD0fZMA:10 a=zEFx3JUFB4X-6XZ9rFIA:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH 0/2] rebase -i: rewrite append_todo_help() in C
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
References: <20180531110130.18839-1-alban.gruin@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <a6d6e5c1-e7ea-1131-c798-9d5e44603d87@talktalk.net>
Date:   Thu, 31 May 2018 18:48:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180531110130.18839-1-alban.gruin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfHspCjnoE4fQ16zm32TmV6A4ofjI4l6ZOUCSa4OhT9GLKhR1nOWwTSR4/1+f1E9Svn/+PyX6poqWHQV/CsKzU1sPoJMYOgQbDajhhjsFljSrLfBjSP3O
 mMBnTS4MOUTvascUdMncS+hfH8+jQR0L1xiZUS0mk+HfL+ZK9dklV/Dqf5gF20HiIXLcQcn5O2n6uSYXhi9q6cMxh35GA+3ELStium/3sAO8k4PSACJFMLZ8
 ny5Kyn/zmin6uLlwKDTri3Qojx6GBqOZUU7aHqreWMADsenIrsM1WNcrdzeM7/D9trIh+Si8wR1ybV4OInuGJW3YK2XyAN6tFu/3lygN3gVHC0tLvtO+75mb
 nLAH389H
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban, it's great to see you working on this

On 31/05/18 12:01, Alban Gruin wrote:
> This series rewrites append_todo_help() from shell to C. This is part
> of the effort to rewrite interactive rebase in C.
> 
> The first commit rewrites append_todo_help() in C (the C version
> covers a bit more than the old shell version), adds some parameters to
> rebase--helper, etc.

I've had a read of the first patch and I think it looks fine, my only
comment would be that the help for '--edit-todo' is a bit misleading at
the moment as currently it's just a flag to tell rebase-helper that the
todo list is being edited rather than actually implementing the
functionality to edit the list (but hopefully that will follow in the
future).

> 
> The second one strips newlines from append_todo_help() messages, which
> require to update the translations. This change was advised to me by
> Stefan Beller, but Johannes Schindelin voiced concerns. I don’t really
> have a strong opinion about it, so feel free to give yours.

I'm not sure I understand what the point of this patch is, if the
newlines are unnecessary then I'd just omit them from the first patch -
am I missing something?

Best Wishes

Phillip

> Alban Gruin (2):
>   rebase--interactive: rewrite append_todo_help() in C
>   sequencer: remove newlines from append_todo_help() messages
> 
>  builtin/rebase--helper.c   | 10 ++++++--
>  git-rebase--interactive.sh | 52 ++-----------------------------------
>  sequencer.c                | 64 ++++++++++++++++++++++++++++++++++++++++++++++
>  sequencer.h                |  1 +
>  4 files changed, 75 insertions(+), 52 deletions(-)
> 

