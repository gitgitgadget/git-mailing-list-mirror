Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74CC61F42D
	for <e@80x24.org>; Thu, 24 May 2018 15:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971025AbeEXP6M (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 11:58:12 -0400
Received: from ikke.info ([178.21.113.177]:50216 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S971003AbeEXP6K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 11:58:10 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 5609B4400C0; Thu, 24 May 2018 17:58:08 +0200 (CEST)
Date:   Thu, 24 May 2018 17:58:08 +0200
From:   Kevin Daudt <me@ikke.info>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: BUG: No way to set fsck.<msg-id> when cloning
Message-ID: <20180524155807.GA11253@alpha>
References: <87vabd6pp2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87vabd6pp2.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 24, 2018 at 05:25:29PM +0200, Ævar Arnfjörð Bjarmason wrote:
> When I do:
> 
>     git -c fetch.fsckObjects=true clone git@github.com:robbyrussell/oh-my-zsh.git
> 
> I get:
> 
>     error: object 2b7227859263b6aabcc28355b0b994995b7148b6: zeroPaddedFilemode: contains zero-padded file modes
>     fatal: Error in object
>     fatal: index-pack failed
> 
> The docs (https://git-scm.com/docs/git-config#git-config-fsckltmsg-idgt)
> say you can override this with -c fsck.zeroPaddedFilemode = ignore, but
> I see in builtin/fsck.c that just fsck_config() knows about this, and
> indeed this works *after* you clone the repo when you use 'git fsck'.
> 
> I don't have time to fix this now, but what's the best approach here?
> Make all the relevant commands copy what fsck_config() is doing, or
> should fsck_object() be lazily looking up this config by itself?

Apparently someone reported this earlier[0]. Johannes replied:

>  Well, you can apparently have your cake and eat it too (see
> https://git-scm.com/docs/git-config#git-config-receivefsckltmsg-idgt):
> 
> receive.fsck.<msg-id>::
>         When `receive.fsckObjects` is set to true, errors can be switched
>         to warnings and vice versa by configuring the `receive.fsck.<msg-id>`
>         setting where the `<msg-id>` is the fsck message ID and the value
>         is one of `error`, `warn` or `ignore`. For convenience, fsck prefixes
>         the error/warning with the message ID, e.g. "missingEmail: invalid
>         author/committer line - missing email" means that setting
>         `receive.fsck.missingEmail = ignore` will hide that issue.
> 
> In your case, use receive.fsck.zeroPaddedFilemode=ignore=warn (or
> =ignore).

[0]https://public-inbox.org/git/alpine.DEB.2.21.1.1801042125430.32@MININT-6BKU6QN.europe.corp.microsoft.com/

Hope this helps, Kevin.
