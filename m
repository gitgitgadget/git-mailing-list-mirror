Return-Path: <SRS0=hWrV=5D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B93C10F29
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 19:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7C820772
	for <git@archiver.kernel.org>; Wed, 18 Mar 2020 19:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZObK/c9R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgCRTks (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Mar 2020 15:40:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50892 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgCRTkr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Mar 2020 15:40:47 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 94277568C9;
        Wed, 18 Mar 2020 15:40:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jx03wrw+JJ9j5pILmnrMRamCFwg=; b=ZObK/c
        9RYhKeFA0JdvQSWDpX24RalReld877j/3kPZYhGUVOesS5A/VowYS8O8/TRT0en+
        YQfQphB6DPmBLIioXjIQ4tx1NDUVMFhEbTrjGLt8pdaguTFdGJEHUWdLzqXbdgqw
        arlrgQu4rOsWf4SCX1ZwLt6Via4e/H0rmvMrU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ycsuO8GeIHyFhZWcPTY6c+uPLnIERzaT
        z82x2CbrNbANh4wbwy8TSJoGzQzt5Z2HsVnF61YeyglJluTDGzizyvhd9CX+iyO8
        86WQQSZ0j9bQhiFSrd08SDBxGLAHMGzYZz9AT9U3uCiNC5FZmw4Rrctpc5Ft0zu3
        VBm3cPF8HZY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A9AF568C7;
        Wed, 18 Mar 2020 15:40:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EA1D5568C5;
        Wed, 18 Mar 2020 15:40:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        james@jramsay.com.au
Subject: Re: [RFC PATCH 1/2] list_objects_filter_options: introduce 'list_object_filter_config_name'
References: <CAP8UFD0wJo4onz0_Vw4-bcX1h61=J=ZiKfM-fMXLj4B9q0aveg@mail.gmail.com>
        <cover.1584477196.git.me@ttaylorr.com>
        <c75806d011b04f2ad7efbbec01613a2d0b1f570b.1584477196.git.me@ttaylorr.com>
        <CAPig+cTVtv+uzzpoZ-BT=F=srdt1ewvgeBAAr9R+OUCYSov65A@mail.gmail.com>
        <20200318100327.GA1227946@coredump.intra.peff.net>
Date:   Wed, 18 Mar 2020 12:40:43 -0700
In-Reply-To: <20200318100327.GA1227946@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 18 Mar 2020 06:03:27 -0400")
Message-ID: <xmqqlfnxfo3o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5BFC5A98-6950-11EA-808F-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But the cost is that we have to enumerate the set of values that are
> defined but not handled here (LOFC__COUNT, for instance, isn't a real
> enum value but rather a placeholder to let other code know how many
> filter types there are).
>
> So...I dunno. Worth it as a general technique?

"This is a possible value in the enum we are switching on, so I
write a case arm for it, but we do nothing for it here" is OK, but
if it were "we do nothing for it here or anywhere" (i.e. the maximum
enum value defined as a sentinel), the resulting code would be ugly.

I am not sure if the tradeoff is good to force such an ugliness on
readers' eyes to squelch the -Wswitch warnings.

So, I dunno.
