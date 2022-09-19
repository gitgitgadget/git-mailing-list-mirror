Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DEFC54EE9
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 16:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiISQHj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 12:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiISQHg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 12:07:36 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFCE11A37
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 09:07:34 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1852E1CE8AC;
        Mon, 19 Sep 2022 12:07:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DpfCNQHOtMwADgLIBNYdi+WyRlZLJayzZ8XsIp
        82HCQ=; b=rBIsu69MTihlh0zTQhOwNJ9873d2A6/Ku9Yg/3KXRywD2nYmxmX4FD
        6RiqtOrzciq/HH2ZoqKIq5I4OEVwpLkbX33JolVC7zi38Vvyd9aq5Y4lbsHMAy9T
        CcCrQxu1tbuImbSAMa34QZ0sd7Px16Rz0Pf3Lawhu20RWFZ/0CjO4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 10CC01CE8AB;
        Mon, 19 Sep 2022 12:07:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 91F9B1CE8A7;
        Mon, 19 Sep 2022 12:07:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     Erik Cervin Edin <erik@cervined.in>, git@vger.kernel.org
Subject: Re: [PATCH] sequencer: avoid dropping fixup commit that targets
 self via commit-ish
References: <YyZWDkZWAkS7q+Wf@gmail.com>
        <20220918121053.880225-1-aclopte@gmail.com>
        <xmqqh714dv7n.fsf@gitster.g>
Date:   Mon, 19 Sep 2022 09:07:27 -0700
In-Reply-To: <xmqqh714dv7n.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        18 Sep 2022 18:11:24 -0700")
Message-ID: <xmqqpmfrcpq8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28BADD74-3835-11ED-866E-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ...  But use of _by_name() that does
> not limit the input to hexadecimal _is_ a problem ...

Ah, no, sorry, this was wrong.  The original used "rev-parse -q --verify"
without restricting the "single word" to "sha1 prefix".

