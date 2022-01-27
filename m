Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBEBC433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 18:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238332AbiA0S0h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 13:26:37 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50428 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236144AbiA0S0e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 13:26:34 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8A878174868;
        Thu, 27 Jan 2022 13:26:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BS+qBLhlkj/N+UPU2orIvzUaKvLLbCKeO0Q8YM
        siB3I=; b=Q2pWceYtYhDIOh6ytQLl7LE6aNeJmU7Y8pWAhfQRr6+YuHQ7mh1YCl
        aw+3ox8oCNQm+lnDYoXqWucUsJPPPSvzNNEqed4hASpIp/Jj0Sffibz9B2nDSfyd
        cX9NqY0rhfpExucezkzBAbtRFuxn7R2uRtVxniTk8oKAe+nBRLh/E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 82C00174867;
        Thu, 27 Jan 2022 13:26:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ED973174838;
        Thu, 27 Jan 2022 13:26:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robin Jarry" <robin.jarry@6wind.com>
Cc:     "Emily Shaffer" <emilyshaffer@google.com>, <git@vger.kernel.org>,
        "Nicolas Dichtel" <nicolas.dichtel@6wind.com>,
        "Patryk Obara" <patryk.obara@gmail.com>,
        "Jiang Xin" <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v2] receive-pack: add option to interrupt pre-receive
 when client exits
References: <20220125095445.1796938-1-robin.jarry@6wind.com>
        <20220126214438.3066132-1-robin.jarry@6wind.com>
        <xmqqv8y54wxc.fsf@gitster.g> <CHGCP9P33XDQ.3FEWHU0PBMNU6@diabtop>
Date:   Thu, 27 Jan 2022 10:26:30 -0800
In-Reply-To: <CHGCP9P33XDQ.3FEWHU0PBMNU6@diabtop> (Robin Jarry's message of
        "Thu, 27 Jan 2022 10:32:12 +0100")
Message-ID: <xmqqr18t2fxl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6B21A6C-7F9E-11EC-BC57-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robin Jarry" <robin.jarry@6wind.com> writes:

> Indeed it is a partial reversion of that commit. Maybe the "keepalive
> before migrating to permanent storage" solution is better.
>
> What do you think?

Sorry, but I was (and am) questioning why we want to do more than
"let it be killed by SIGPIPE, just like we used to do before
ec7dbd14 (receive-pack: allow hooks to ignore its standard input
stream, 2014-09-12) introduced the current behaviour", so the answer
is still "why do we even need to complicate the thing with keepalive
or anything we don't have, and we didn't have before ec7dbd14, in
the code paths that are involved?"
