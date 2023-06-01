Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72011C7EE23
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 13:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjFANBv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 09:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjFANBu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 09:01:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E4098
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 06:01:48 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 934C421980;
        Thu,  1 Jun 2023 13:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1685624507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EtAyEceyAN9z34KefhnBMC7VFa/xo9KgOsUzmYFYTf8=;
        b=lhJeL0Z1kb1PHSe5k6jIc2MVbQxXx38cex4qSHxST13qZB6/leh/9EJG8j5MNzPqrSYjXL
        S2dGraMQxyWwBiaR79XN/VRKXG1s34WWTUCQMlH2iDzdrne6SKE8kXWbVo9HVo4NHUDYZ+
        Rm1lWtduwYIjtYhSc/7nu78lFWVDPvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1685624507;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EtAyEceyAN9z34KefhnBMC7VFa/xo9KgOsUzmYFYTf8=;
        b=2ACnXrl+3BeCNvL0nGUCXf4kbiTIkz/E+UGT8AgkfHgg7N2oc/hELzwxHuRBI5axcZwDjx
        mwWXD8xpi/zKWUBg==
Received: from hawking.suse.de (unknown [10.168.4.11])
        by relay2.suse.de (Postfix) with ESMTP id 522192C141;
        Thu,  1 Jun 2023 13:01:47 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
        id 43DA04A0785; Thu,  1 Jun 2023 15:01:47 +0200 (CEST)
From:   Andreas Schwab <schwab@suse.de>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, derrickstolee@github.com,
        gitster@pobox.com, jrnieder@gmail.com, larsxschneider@gmail.com,
        tytso@mit.edu
Subject: Re: [PATCH v5 02/17] pack-mtimes: support reading .mtimes files
In-Reply-To: <91a9d21b0b7d99023083c0bbb6f91ccdc1782736.1653088640.git.me@ttaylorr.com>
        (Taylor Blau's message of "Fri, 20 May 2022 19:17:35 -0400")
References: <cover.1638224692.git.me@ttaylorr.com>
        <cover.1653088640.git.me@ttaylorr.com>
        <91a9d21b0b7d99023083c0bbb6f91ccdc1782736.1653088640.git.me@ttaylorr.com>
X-Yow:  I selected E5...  but I didn't hear ``Sam the Sham and the Pharaohs''!
Date:   Thu, 01 Jun 2023 15:01:47 +0200
Message-ID: <mvmv8g78hfo.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mai 20 2022, Taylor Blau wrote:

> diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
> index 6d3efb7d16..b520aa9c45 100644
> --- a/Documentation/technical/pack-format.txt
> +++ b/Documentation/technical/pack-format.txt
> @@ -294,6 +294,25 @@ Pack file entry: <+
>  
>  All 4-byte numbers are in network order.
>  
> +== pack-*.mtimes files have the format:
> +
> +All 4-byte numbers are in network byte order.
> +
> +  - A 4-byte magic number '0x4d544d45' ('MTME').

This is identified by file(1) as "Multitracker Version 4.05". ;-)

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
