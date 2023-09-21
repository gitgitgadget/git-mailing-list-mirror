Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CE6E7D0A2
	for <git@archiver.kernel.org>; Thu, 21 Sep 2023 20:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjIUUMn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Sep 2023 16:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjIUUM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2023 16:12:29 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754CF10056D
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 12:16:39 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 130C01EE00;
        Thu, 21 Sep 2023 15:16:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=dDR0YhXHRywYDpV5TbZ5LFzOpp6b2qD80h0j4o
        4S6rQ=; b=po6yCIjTOq9D/9FjPYqMhE1DNCwu0UpDFBRDDonUaseL1f16DKkfVR
        JOBQwisuBG9z8slhXC3CnLGUo2/YVYAJdtDJyzCHgfQasg3TMzCSBejCktW/cuEN
        tKAzmkgngfi9/s6osba20ZwS6qwled/Zzc+RBdVDqGE75G4YEjj/8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0AFFB1EDFF;
        Thu, 21 Sep 2023 15:16:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8BDC01EDFE;
        Thu, 21 Sep 2023 15:16:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com
Subject: Re: [PATCH v4] revision: add `--ignore-missing-links` user option
In-Reply-To: <CAOLa=ZT_DVw4Na-rj4mk2ULkrqDyVP2_cOpgdLozFjn3RJbTvg@mail.gmail.com>
        (Karthik Nayak's message of "Thu, 21 Sep 2023 12:53:11 +0200")
References: <20230915083415.263187-1-knayak@gitlab.com>
        <20230920104507.21664-1-karthik.188@gmail.com>
        <xmqqh6noc13c.fsf@gitster.g>
        <CAOLa=ZT_DVw4Na-rj4mk2ULkrqDyVP2_cOpgdLozFjn3RJbTvg@mail.gmail.com>
Date:   Thu, 21 Sep 2023 12:16:34 -0700
Message-ID: <xmqq5y435obx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 61A8737C-58B3-11EE-8813-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Karthik Nayak <karthik.188@gmail.com> writes:

> I was thinking about this, but mostly didn't do this, because the
> interaction with `--missing` is only for non-commit
> objects. Because for missing commits, `--ignore-missing-links`
> skips the commit and the value of `--missing` doesn't make any
> difference.

Hmph, somehow that smells like an existing bug.  So does the "trees
are not shown by --missing=print, and show_object() is never called
for missing objects unless they are blobs" you mention.  When the
user asks "instead of dying, list them so that I can ask around and
fetch them to repair this repository", shouldn't we do just that?

I wonder if these bugs are something people may be taking advatage
of and cannot be fixed retroactively?  If we can fix these and nobody
complains, that would give us the ideal outcome, I would think.

Thanks.


