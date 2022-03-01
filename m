Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CB1C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 03:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiCADJU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 22:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiCADJT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 22:09:19 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4495862E3
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 19:08:39 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BC84B196CD3;
        Mon, 28 Feb 2022 22:08:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BBudVBrbNNIYq7bTsKhB7sW+ZqjpBGuxWDOFDA
        6E8qs=; b=eDqreWGj9Wl+9D3xRF/rDUl9JUL9k3rMURHIVAT4G80hIE47cEpIc3
        /YPJruyCvQvniHjb+Cn3GS8x7BnHkWBEG2kyXhQ+yDhxsOCp1r3kZcAj7n6S93Uw
        qaI4Vi6zp0qjnPpm+ddIfqRJ4u3hf/Nvgqpc+TzsyXYrOFg3MAjF4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B47DE196CD2;
        Mon, 28 Feb 2022 22:08:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 44264196CD1;
        Mon, 28 Feb 2022 22:08:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Albert Cui <albertcui@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bja?= =?utf-8?Q?rmason?= 
        <avarab@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v8 0/3] teach submodules to know they're submodules
References: <20220203215914.683922-1-emilyshaffer@google.com>
        <20220301002613.1459916-1-emilyshaffer@google.com>
Date:   Mon, 28 Feb 2022 19:08:35 -0800
In-Reply-To: <20220301002613.1459916-1-emilyshaffer@google.com> (Emily
        Shaffer's message of "Mon, 28 Feb 2022 16:26:10 -0800")
Message-ID: <xmqq7d9ewerw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E2A828D6-990C-11EC-A2F4-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> One thing I'm not sure about: in the tests, I check whether the config
> is set, but not what the boolean value of it is. Is there a better way
> to do that?

Are you looking for value normalization during both setting and
retrieving, i.e.

	$ git config vari.able 0 ;# or "no" or "off"
	$ git config --type=bool vari.abble
	false
	$ git config vari.able 1 ;# or "yes" or "on"
	$ git config --type=bool vari.abble
	true

	$ git config --type=bool vari.able yes ;# or "1" or "on"
	$ git config vari.able
	true

