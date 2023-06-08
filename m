Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E1CC7EE25
	for <git@archiver.kernel.org>; Thu,  8 Jun 2023 08:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbjFHIVX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jun 2023 04:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbjFHIVR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2023 04:21:17 -0400
X-Greylist: delayed 2754 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 08 Jun 2023 01:21:14 PDT
Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FDBE43
        for <git@vger.kernel.org>; Thu,  8 Jun 2023 01:21:14 -0700 (PDT)
Received: from bsmtp1.bon.at (unknown [192.168.181.104])
        by bsmtp5.bon.at (Postfix) with ESMTPS id 4QcGFy6dxdz5trc
        for <git@vger.kernel.org>; Thu,  8 Jun 2023 09:35:18 +0200 (CEST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4QcGFt2VVhz5tl9;
        Thu,  8 Jun 2023 09:35:14 +0200 (CEST)
Message-ID: <67c66cd7-fb6c-3fa0-82c8-0e778f377f96@kdbg.org>
Date:   Thu, 8 Jun 2023 09:35:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/2] shortlog: introduce `--email-only` to only show
 emails
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <cover.1686178917.git.me@ttaylorr.com>
 <44179d28fa7676965a28734e20584d54b44e051b.1686178917.git.me@ttaylorr.com>
Content-Language: en-US
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <44179d28fa7676965a28734e20584d54b44e051b.1686178917.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.06.23 um 01:02 schrieb Taylor Blau:
> When a shortlog caller wants to group output by, say, author email, they
> can easily express this with:
> 
>     $ git shortlog --group=format:%ae
> 
> and restrict output to specific email(s) with the new `--group-filter`
> option introduced by the previous commit.
> 
> But they are not able to apply the same treatment to identities that
> appear in trailers. Doing:
> 
>     $ git shortlog -e --group=format:%ae --group=trailer:Co-authored-by
> 
> will produce funky results, interspersing proper emails with full "Name
> <email>" identities from the Co-authored-by trailer (or anything else
> that might appear there), like:
> 
>     461  me@ttaylorr.com
>      11  Taylor Blau <me@ttaylorr.com>
> 
> So if the caller wants to restrict output to a set of matching email
> addresses (say, "me@ttaylorr.com"), they cannot do it with a
> `--group-filter`, since it would discard the group "Taylor Blau
> <me@ttaylorr.com>".
> 
> Introduce a new `--email-only` option, which extracts the email
> component of an identity from all shortlog groups, including trailers.
> It behaves similarly to the `-e` option, but replaces its output with
> just the email component, instead of adding it on to the end.
> 
> Now, `shortlog` callers can perform:
> 
>     $ git shortlog -s --group=author --group=trailer:Co-authored-by \
>         --email-only --group-filter="<me@ttaylorr.com>"
>        472  <me@ttaylorr.com>
> 
> to obtain the output they want.

A note from the peanut gallery: "--email-only" sounds like an option
that affects the output of the command. But it does not (IIUC), there is
no hint that it affects grouping and filtering. It is named too
generically, IMHO. Can we not have the desired effect by specifying some
token to one of the --group* options?

-- Hannes

