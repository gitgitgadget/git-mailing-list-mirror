Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E02C432C3
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 00:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A5922449
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 00:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="us0xBzb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfKTAcU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 19:32:20 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61856 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfKTAcT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 19:32:19 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF33828DAA;
        Tue, 19 Nov 2019 19:32:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KGiGD08opaICvMUzyTaJ76FGuXA=; b=us0xBz
        b5DHaPH3XRdlGxF6ejMwM6Dedu6o9COcd/o6ZyVdx77otWceu9U9+VxjbW+auPk4
        ckPOQsacLVsh8wm2ATF+snhVPdOWJ0R6GDT7OlUAIhvbMJz7Id/1LDPs2e13Tn24
        vhCc5VXg17/uf/14BldQMu9K0kVDW9Ap/Guxs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DgXjyTifq2eXYIqziNF+z79RYp7UCzub
        X0BuZV/Ph3riUup0rDmZzJ+0ZDSnW/Re5JMR9Af5fdUgWBsQaMyjKSr0eR5fHsx5
        PkE5RlLJnLC8lQSM0g81h8xQjkUt0xFRwXZV/vHl6ichiuNUTkmMhU3WnJsOJ6VQ
        6RslOcFMfLo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A775428DA9;
        Tue, 19 Nov 2019 19:32:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0BC0928DA5;
        Tue, 19 Nov 2019 19:32:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/9] bugreport: add tool to generate debugging info
References: <20191025025129.250049-1-emilyshaffer@google.com>
        <20191025025129.250049-2-emilyshaffer@google.com>
        <xmqqr2284is5.fsf@gitster-ct.c.googlers.com>
        <20191119202542.GB36377@google.com>
Date:   Wed, 20 Nov 2019 09:32:14 +0900
In-Reply-To: <20191119202542.GB36377@google.com> (Emily Shaffer's message of
        "Tue, 19 Nov 2019 12:25:42 -0800")
Message-ID: <xmqq8sobfkvl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 33EA235E-0B2D-11EA-B051-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>> Can you make it a standalone binary instead to avoid bloat of the
>> main "git" binary?
>
> Sure. This would fix some other issues (needing to link against curl to
> get the curl version, which is exactly what you implied).

Hmph, I actually was not thinking about the cURL library.  

I imagined that your tool may need to learn more about the system in
order to make the report and for that there may be libraries that
makes it easy than say reading directly from the /proc filesystem
etc. that you may end up using.  Unlike cURL, such a library would
have no use in the rest of Git anywhere.
