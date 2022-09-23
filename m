Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FF5C6FA82
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 15:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbiIWPre (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 11:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiIWPrC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 11:47:02 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6AF111DEB
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 08:46:59 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 416291B72AB;
        Fri, 23 Sep 2022 11:46:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FzkTMNllgggEdQca6DJUMmGRuTyIvcBT4NIPwL
        efIUs=; b=RDmEeaV6EjTxPMuM0D6XjxahokyHcSkcN/+AUEai118jG0koD1bVzu
        ZHEpGzyhG1q/cxS7KyZXHLiJ0vCJ9sJfJiRjjUnjtveChPS2tijewx1SsLFnswqM
        H5uIt5nuPy5jkl47YWv1dsAQ6NSEgDdFVD9hdxRTQqditKz+1D/xk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 399131B72AA;
        Fri, 23 Sep 2022 11:46:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BC6111B72A6;
        Fri, 23 Sep 2022 11:46:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren <newren@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>
Subject: Re: Question relate to collaboration on git monorepo
References: <CAOLTT8SHo66kGbvWr=+LQ9UVd1NHgqGGEYK2qq6==QgRCgLZqQ@mail.gmail.com>
        <CAJoAoZnm8jE9rT+rrze-zP7KZNW=oCZjcrFWqjDssW3LzxrKPg@mail.gmail.com>
        <CAOLTT8TwdwfHCCv+x51++Aanf3tipMegfZiTKFbQtfh7b_EY0A@mail.gmail.com>
        <CABPp-BEBB1oqdVcXrWwMAdtb0TwHZvr-6KDa210j5ncw54Di_g@mail.gmail.com>
        <1c2f6cfe-a6db-c06e-5313-f5b31be42c8d@github.com>
Date:   Fri, 23 Sep 2022 08:46:53 -0700
In-Reply-To: <1c2f6cfe-a6db-c06e-5313-f5b31be42c8d@github.com> (Derrick
        Stolee's message of "Thu, 22 Sep 2022 10:24:57 -0400")
Message-ID: <xmqqzgeqw0sy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2F79162-3B56-11ED-9764-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 9/21/2022 7:36 PM, Elijah Newren wrote:
>> On Wed, Sep 21, 2022 at 8:22 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
>> Here, we do have an object download, which occurred after the merge
>> completed, so there must be something happening after the merge which
>> needs the extra blob; if we keep reading...
>> 
>>>  project1/file1 | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>> 
>> Ah, the 'helpful' diffstat.  It downloads blobs from a promisor remote
>> just so we can see what has changed, including in the area of the
>> project we don't care about.
>> ...
> This is an interesting find! I wonder how many people are hitting this
> in the wild. Perhaps merge.stat should be added to the optional, but
> recommended config options in scalar.c.

Hmph.  It somehow sounds like throwing the baby out with the
bathwater, doesn't it.

You are only interested in a few directories in the project.  You
pull from somebody else (or the central repository), and end up
getting updates to both inside and outside the areas of your
interest.

As a project gets larger and better modularized, does it become more
likely that such an update will happen more often?

I am very tempted to suggest that the diffstat after a merge in such
a project should use the sparse cone(s) as pathspec.  Disabling the
"what happened in this merge" report altogether is a way too blunt
instrument, isn't it?
