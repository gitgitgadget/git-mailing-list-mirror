Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D1FC28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 04:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbiHVE5a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 00:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiHVE53 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 00:57:29 -0400
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180D624BD6
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 21:57:29 -0700 (PDT)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id CFDCD1F54E;
        Mon, 22 Aug 2022 04:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1661144248;
        bh=cGx7vnhszwmui26xMQTsZzhqTMMrPshKjAkzDmwPZ8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MrboHFjh7SRGYa6rDnDk2JHzuoeNzESF4y4Qi24gIQeVzRydHmfu4J/M3HH/B58oz
         mooem3c03UAvZJfp8spOhBhV6U2BjgZvIB/IIayrx23d3981TfUbUaPigtcbDz7GR0
         7Z5aTxh9XL91WvhO/A72KLcxtgngjoyui3PEVALw=
Date:   Mon, 22 Aug 2022 04:57:28 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        meta@public-inbox.org
Subject: Re: `git patch-id --stable' vs quoted-printable
Message-ID: <20220822045728.GA453@dcvr>
References: <20220822022503.M873583@dcvr>
 <xmqqczcsgbvn.fsf@gitster.g>
 <xmqq7d30gbcd.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq7d30gbcd.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> So, I'm wondering if the search indexing code of public-inbox
> >> should s/^$/ /mgs before feeding stuff to `git patch-id'; and/or
> >> if `git patch-id' should be assuming empty lines and lines with a
> >> single SP are the same...
> 
> Another potential source of issues (not for the patch from René that
> was used as an example) is that a patch producer can use different
> diff algorithm from the setting you would use to index resulting
> commits via "git show | git patch-id".
> 
>     $ git show -U5 | git patch-id
>     $ git show | git patch-id
> 
> likely result in different patch IDs.  
> 
> The --patience and the --histogram options affect how common lines
> are matched up, again affecting the shape of the patches you compute
> patch-ids over.

Yes, you're right; though I suppose most users use git defaults.
I'm not sure how useful patchid ends up being, actually...
The old use of dfpre/dfpost blob OIDs seems to have been working
well for years, already.

Possibly OR-ing them with patchid in Xapian will end up getting
good enough search engine coverage.
