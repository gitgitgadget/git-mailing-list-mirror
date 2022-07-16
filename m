Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C79AC433EF
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 00:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiGPAR4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 20:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiGPARz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 20:17:55 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E43A8B487
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 17:17:54 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id m16so559975qka.12
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 17:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OP2iJrXs74aO+ZnwLOo1JXxB+ZlMwP3YgpJMhMNoe8E=;
        b=Lpi9uGpO5GPxdZfoX0qXcpezMTSdjty7Yh/Gy1cEgul388ErUO2FMgBn69CEvr4Fho
         n9vr74mrgYFE9cJMCE9CKCo4GkswYweKGhOSd+26U/T1Up1lGmW2rEfqGycqhm1CFTw9
         0m3SHPEe4rgWe+cgspIQT06Dzu9YlDAJ65o9ARLQCmaOQ1EFJs28n6kZXCFTTP97Mrw9
         K9UxUgn/l9W7bpQFy755WEeCGe0/50JkvWT3sGS45PWe6Gz8JAwZ3H6RhSvQdBJcI9bi
         Pn6fBHXdtQ3zGT3lmSoKMQ7s+xNvBJzM3B7are9kbK3dKey+o4vzm6e3bE8XPgrM9lIV
         cmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OP2iJrXs74aO+ZnwLOo1JXxB+ZlMwP3YgpJMhMNoe8E=;
        b=wFi7iAXlpxMpJSLe2cnPSz4oIjDvs9MdVeZQbeWuExeZd02KkNipK1iUjOufvFHa9U
         179yhKRycLZAYL1eCsoX190ssEBh3Hgev8gFr2VzWULPao5CBF22SVWOimaGKzilKHt7
         O8au9VwUXfEjC3eA6J2m8Es+KKJdPC7Ki69/EAWJwvi0VWUCo6YrQIEbzO6L7mJ6w2nl
         JuJbuq4etmCfi/jZ9hZiYbP9zGoAYZ0bVceYb+FWLUrZKJLBtWjoAlAnyeOoxyuY8RHj
         N9sajiL4BGCk9JyCrbmy3WoMtNTcv/aqMeCfzU6vrxUd8aH1oOoDEr+fuHHHmZGKoBJX
         eZww==
X-Gm-Message-State: AJIora+4VAQelrz/m/Ml//+KYm6ftMxTDT4t7PeVi72m4K4NPDHxtr7/
        l8jqgWzc9v5+xOZJ7FG+DHWn7A==
X-Google-Smtp-Source: AGRyM1t+xVVm3XADnrhpCjYDMcRAcF9PPIKXDpaVPlksrqknyBs+8Kya1MLE1TBeap3a51+7lLOKlw==
X-Received: by 2002:a05:620a:2996:b0:6af:2c34:423f with SMTP id r22-20020a05620a299600b006af2c34423fmr11229664qkp.679.1657930673295;
        Fri, 15 Jul 2022 17:17:53 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t13-20020a37ea0d000000b006af147d4876sm4957707qkj.30.2022.07.15.17.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 17:17:53 -0700 (PDT)
Date:   Fri, 15 Jul 2022 20:17:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        peff@peff.net, ps@pks.im, wfc@wfchandler.org
Subject: Re: [PATCH 1/3] t5318: demonstrate commit-graph generation v2
 corruption
Message-ID: <YtIDsIVCJ8XgF1eJ@nand.local>
References: <cover.1657667404.git.me@ttaylorr.com>
 <0a49c86037bac200bb23e1abf9f67363e99c4b7c.1657667404.git.me@ttaylorr.com>
 <10d12d6f-6d86-743f-518b-eb45871509a7@github.com>
 <YtHkmb4Qwvo9n00A@nand.local>
 <xmqqo7xqx6wj.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo7xqx6wj.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 15, 2022 at 05:01:16PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > On Thu, Jul 14, 2022 at 11:15:42PM -0400, Derrick Stolee wrote:
> >> > +		# This commit will have a date at two seconds past the Epoch,
> >> > +		# and a (v1) generation number of 1, since it is a root commit.
> >> > +		#
> >> > +		# The offset will then be computed as 2-1, which will underflow
> >>
> >> I have verified that your test works, but this explanation is confusing me.
> >> "2 - 1" is 1, which does not underflow. There must be something else going
> >> on.
> >>
> >> Looking ahead, you describe the situation correctly in Patch 3 to show that
> >> we take "generation - date", so you really just need s/2-1/1-2/ here.
> >
> > Yes, absolutely. Thanks for catching it.
> >
> > Junio: you may want to s/2-1/1-2 in this patch's message, or I can send
> > you a replacement or reroll, whatever is easier.
>
> I've already done "rebase -i" to do so.

Thanks very much.

> But for future reference, the easiest for me is if the author said,
> after saying "Thanks for catching it", "Will reroll after waiting
> for a bit to see if there are other comments".  That way, I only
> have to edit the latest draft of "What's cooking" report to mark the
> topic to be expecting a reroll (which will prevent me from merging
> the topic down to 'next' prematurely by mistake) and forget about
> it, until I actually see the updated set of patches.  It would be
> even easier if the updated set of patches said which topic it is
> meant to replace.  That way, I can trust other reviewers about the
> details of the change between iterations and play a patch monkey,
> when I am short of time.

Makes sense. I appreciate you clarifying it explicitly, I've wondered
over the years what is easiest for you when fixing a trivial issue in a
larger series.

I've tended to try and avoid resubmitting a whole series when there is
just a typo hoping to avoid flooding the list with too many (mostly
unchanged) messages. But that requires you to do more work to futz with
the patches before they hit your tree, so I try not to do it too often.

In any case, I'll try to err more often on the side of resubmitting a
series after acking the typo in the hopes it makes your life easier ;-).

Thanks,
Taylor
