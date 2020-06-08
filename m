Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4D1C433E0
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 16:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A929206A4
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 16:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TFfA/Gkp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387409AbgFHQsC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 12:48:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65286 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730600AbgFHQsB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 12:48:01 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 667DA60573;
        Mon,  8 Jun 2020 12:47:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hvI5Nmv8SXaB5ObY37+inuRhzpE=; b=TFfA/G
        kp3nkO0yHmKVIyX4gbgwwGyLgry8DvYog5cHWkoRqrF5u9Grv3DnvvCs+lnypW4r
        sWgNUQ7QKrg6SoVKhYLVhoS/ugiXugJbXGjYiBPoVxvhPs2I2qnsPkp6lr5T5QS2
        7vlWiToiYhpwqu/aj7MjpGa82jmQSfIR2wd9U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=szZXPo7YaeYjknc/LQPNGj52RZcOja7Y
        4nJfUp9ieoVmo1jOssVbuXUpiXLD4evFF4c/KBQ0nzbh1rlOGf7WvfJ4ZLfoLZ0K
        QtCSR162B8YekUbkv8YWemLfLqdhXmsL7w3GMPbq8/BGx7OxlTszT0rfNJsXrHd0
        0VZ1xWlDe+8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D48860572;
        Mon,  8 Jun 2020 12:47:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CECAF60571;
        Mon,  8 Jun 2020 12:47:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tibor Billes <tbilles@gmx.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH] fast-import: fix incomplete conversion with multiple mark files
References: <c53bb69b-682d-3b47-4ed0-5f4559e69e37@gmx.com>
        <20200606002241.1578150-1-sandals@crustytoothpaste.net>
        <alpine.DEB.2.21.2006081739520.9949@serpens>
Date:   Mon, 08 Jun 2020 09:47:58 -0700
In-Reply-To: <alpine.DEB.2.21.2006081739520.9949@serpens> (Tibor Billes's
        message of "Mon, 8 Jun 2020 17:52:16 +0200 (CEST)")
Message-ID: <xmqqtuzlld1d.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF2C3D3E-A9A7-11EA-A781-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tibor Billes <tbilles@gmx.com> writes:

> On Sat, 6 Jun 2020, brian m. carlson wrote:
>
>> When ddddf8d7e2 ("fast-import: permit reading multiple marks files",
>> 2020-02-22) converted fast-import to handle multiple marks files in
>> preparation for submodule support, the conversion was incomplete.
>...
>
> Thanks for the quickly patching it! I tested the patch and I can confirm this
> solves the memory leak for me.

Tibor, thanks for testing.

Brian, I notice that the singleton global "marks_set_count", even
though the number could be counted per instance of the mark_set
structure, is still singleton.  I didn't bother thinking about it
when I wrote my "perhaps along this line" patch, but now I read it
again, I think it is OK to leave it (and other stats counters) as
is, primarily because we don't have a need (yet) to show stats per
mark_set.  Did you leave it as a global for the same reason?  Just
sanity-checking.

Thanks.
