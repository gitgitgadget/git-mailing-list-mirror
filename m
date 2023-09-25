Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE173CE7AA3
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 16:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjIYQ5V (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 12:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjIYQ5U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 12:57:20 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D140CFF
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 09:57:12 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9740B1B6D71;
        Mon, 25 Sep 2023 12:57:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=4qinfMVdIiJbuYMaan03HpqjWQ5Qh4Mwsz2wlu
        8DYhE=; b=szgopdbMBMjxoNcyUPRt24RR4P/yWM8WOkxQZilzMkNgak5rmzDrb5
        7Q6fai+JDYge36f78W1B31+jfs5m51EF+pqw1Vyh4750mnbJuvwjfCxnWj/hOFUr
        mjG4CPERhGdddeMnXtrJXoYICxCT7uoZ4j1VJ/kSO5mWp/82aBNNI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8DE241B6D70;
        Mon, 25 Sep 2023 12:57:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0409B1B6D6F;
        Mon, 25 Sep 2023 12:57:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com
Subject: Re: [PATCH v4] revision: add `--ignore-missing-links` user option
In-Reply-To: <CAOLa=ZThB0DrRKg98tr7JLu8yPRyDXe_ngkpS3ZfesHQ-f1DLg@mail.gmail.com>
        (Karthik Nayak's message of "Sun, 24 Sep 2023 18:14:30 +0200")
References: <20230915083415.263187-1-knayak@gitlab.com>
        <20230920104507.21664-1-karthik.188@gmail.com>
        <xmqqh6noc13c.fsf@gitster.g>
        <CAOLa=ZT_DVw4Na-rj4mk2ULkrqDyVP2_cOpgdLozFjn3RJbTvg@mail.gmail.com>
        <xmqq5y435obx.fsf@gitster.g>
        <CAOLa=ZThB0DrRKg98tr7JLu8yPRyDXe_ngkpS3ZfesHQ-f1DLg@mail.gmail.com>
Date:   Mon, 25 Sep 2023 09:57:08 -0700
Message-ID: <xmqq5y3yw5qz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 910D68DE-5BC4-11EE-AF82-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Karthik Nayak <karthik.188@gmail.com> writes:

> Let me prefix with saying that I was partly wrong. `--missing` does work for
> trees, only that it's ineffective when used along with the
> `ignore_missing_links` bit.
>
> But for commits, `--missing` was never configured to work with. I
> did a quick look at the code, we can do something like this for
> commits too, i.e.  add support for the `--missing` option. We'll
> have to add a new flag (maybe MISSING) so it can be set during
> within `repo_parse_commit_gently` so we can parse this as a
> missing object in rev-list.c and act accordingly.

Do you mean that process_parents() would now throw such a commit to
the resulting list successfully instead of omitting when "--missing"
is requested?  That sounds like a right thing to do but at the same
time is a fix with major impact.  I do not offhand know what the
ramifications are, for example, when bitmap traversal is in use (I
assume such a missing commit would not be catalogued in the bitmap?).

Taylor, what do you think?
