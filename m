Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94870C1975A
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 21:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C93E206BE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 21:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ttrENun0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgCLVRr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 17:17:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61087 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgCLVRr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 17:17:47 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1726ECE8B9;
        Thu, 12 Mar 2020 17:17:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=B8AX6UU6EfB8hnYb/sncIbxxZlQ=; b=ttrENu
        n0ZTGuh+Fi/IYCuvSE4QG3zOzXFStu0+Id4RVfxqvwKashAT6yX89ZUKev4IZGZE
        C3qXvaYGO2JIBvp8HHNyb0qoiSPuJTDZRf3zJ/XQTRcTa9vucH2lr13egX3hLbR1
        mdPVu7blXX35sXxJ/5a72miCvPNvyKKfvX/XY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=d66uj9uATogFPk5+WWPmJfgLGlgS7dX/
        La6p5Kt30fJsnuXjKy30rMXsyNAqucdnk3BcWOUfDHz1ZyuTRgBYB7R8oCv/8AtD
        GkWmOd2ly9IdjbtU8wcW3r9ufUEVN0418DwnUNdeCcTEjZdCaX5K+KTXkw/b9+ow
        YZU0tsikqVE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0FD28CE8B8;
        Thu, 12 Mar 2020 17:17:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5C883CE8B6;
        Thu, 12 Mar 2020 17:17:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, stolee@gmail.com,
        git@vger.kernel.org, christian.couder@gmail.com
Subject: Re: [Question] Is extensions.partialClone defunct?
References: <5981c317-4b39-de15-810b-a781aa79189d@gmail.com>
        <20200312170714.180996-1-jonathantanmy@google.com>
        <20200312175151.GB120942@google.com>
        <20200312210954.GA13644@syl.local>
Date:   Thu, 12 Mar 2020 14:17:40 -0700
In-Reply-To: <20200312210954.GA13644@syl.local> (Taylor Blau's message of
        "Thu, 12 Mar 2020 15:09:54 -0600")
Message-ID: <xmqqsgide0i3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8F53F0E-64A6-11EA-ABB7-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Thu, Mar 12, 2020 at 10:51:51AM -0700, Jonathan Nieder wrote:
>> Jonathan Tan wrote:
>> > Derrick Stolee wrote:
>>
>> >> but it appears that we rely on the "remote.<name>.promisor = true"
>> >> setting instead of this extension.
>> >
>> > Hmm...besides giving the name of the promisor remote, the
>> > extensions.partialClone setting is there to prevent old versions of Git
>> > (that do not know this extension) from manipulating the repo.
>
> Manipulating it how?

Presumably if the version of Git does not assume that sometimes
missing objects are OK, its "fsck" and "repack" would become very
upset when a repository lacks very many objects because the version
of Git that created it assumes they can be lazily fetched, no?
