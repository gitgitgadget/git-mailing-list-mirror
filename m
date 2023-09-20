Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308E0C04AA7
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 15:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbjITPne (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 11:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbjITPnd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 11:43:33 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F69B4
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 08:43:27 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0BA8E1AA477;
        Wed, 20 Sep 2023 11:43:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=64qlMB/N72yCOrymFJLvXvL6pXPo5VY0DSgGnZ
        DzcJk=; b=Lj054X7crpM0HM5P6/k6vuGEduSfwd+XdVwtaxYwg+14k/HGVmdfWs
        5wzOkOKzuGkSa+vsq+uyyfGU28TPI2l48oz7sJuIUYiFI0x6jsst+uKdxo+3LJc/
        EJMHMCwuy9+OlfO3i3/WdeyFsZKGxLumZmn6NEQlJIOhP8IdZJI44=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 00B2F1AA475;
        Wed, 20 Sep 2023 11:43:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5CC711AA473;
        Wed, 20 Sep 2023 11:43:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Michael Strawbridge <michael.strawbridge@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [REGRESSION] uninitialized value $address in git send-email
In-Reply-To: <ZQrQsa5GJEVhBttT@debian.me> (Bagas Sanjaya's message of "Wed, 20
        Sep 2023 18:00:01 +0700")
References: <ZQhI5fMhDE82awpE@debian.me>
        <8fcd6d2a-2c16-adf9-da1f-6b9d6fdcc87a@amd.com>
        <ZQknHjKdGZV3vJpV@debian.me>
        <4eb0d21b-be43-529a-bfdd-3f1d2b4d3e84@amd.com>
        <118975ef-c07f-c397-5288-7698e60516a7@amd.com>
        <ZQrQsa5GJEVhBttT@debian.me>
Date:   Wed, 20 Sep 2023 08:43:24 -0700
Message-ID: <xmqq7cokc0kj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6FB2C266-57CC-11EE-B66A-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Originally, I was intended to report regression on handling multiple
> addresses passed in a single --to/--cc/--bcc option.

You refer to v2.40 and v2.41 in the message I am responding to, but
do you have a bisection?  There seem to have been five topics around
send-email during that timeperiod.

 $ git log --oneline --first-parent v2.40.0..v2.41.0 git-send-email.perl
 b04671b638 Merge branch 'jc/send-email-pre-process-fix'
 64477d20d7 Merge branch 'mc/send-email-header-cmd'
 b6e9521956 Merge branch 'ms/send-email-feed-header-to-validate-hook'
 c4c9d5586f Merge branch 'rj/send-email-validate-hook-count-messages'
 647a2bb3ff Merge branch 'jc/spell-id-in-both-caps-in-message-id'
