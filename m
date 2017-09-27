Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8022202A5
	for <e@80x24.org>; Wed, 27 Sep 2017 06:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbdI0G71 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 02:59:27 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:47532 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751587AbdI0G70 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 02:59:26 -0400
Received: by mail-pf0-f174.google.com with SMTP id u12so6808175pfl.4
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 23:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=MxOgwMrWm8jbDMdcdps2uJ4TrsjtmAwme3AeXrTSEVE=;
        b=dhQLax8uwKCA5m3fMisWYgXwZa9ULdAJJ5u/7jWOlbuva1x82WDAeScHe6tDkBlU2/
         SBTTRjuIUpXFl65dLeka+dpoNguzoxL4PSprvIHZcrcya79VTVgkOvOoZ0UWNAchR2cJ
         BhFefjL2k3MkXiOUk3XkdfY+9Z2YhrFXwimuZg94O7y3GXkEQZG7YoSkXwmYLJg4SykQ
         o+9L8K5jZaQ4LQOV5Yl/fx2/B43zSX1LLD8/2dvE/gpGjlkfSzt8NY5KfldX5Utohm0e
         EzcZHBZOqLBBxDN/YIh57lgwOIgYl0F+VVfhuKPP2uAYUWXTT0ejwB9bXe+8sEGzl2kS
         HMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=MxOgwMrWm8jbDMdcdps2uJ4TrsjtmAwme3AeXrTSEVE=;
        b=AnStulKj8UGPds7KhmELodXgQnkc4f/2LB0GNfpyYwwOfplArcO4xQ41FZktZMlpZF
         v96/GzUeyTtU+ysJm7Up7jzxEqC8dB6xP25m5fV4vt+rm+POxDZ8EHFQxRrJTAGS/On2
         J9eQcgqZI0QSCcuFjcLeehXWHE9uKw5h/kOP8Qf2eDQgskoGUITPOD+3s6MYA7aPTiM5
         a72gikrv3F5hiM8PQOrD5WX+0QrYFB+PAj7mrzm92NyEH45h2XgxKD7qg54qWJoVx/8b
         boTNZov9V/HK6W83xV27aR47oUTfKQKOhwjr4AYC84Wf1833WdW+W59L6OIAsEJTESK2
         Qy8w==
X-Gm-Message-State: AHPjjUglqc4PvOe2Pa31noTJyH7KTBFC6ozydzZ/aXLnke/r2QriEDBw
        vyy211OkUGB6XgvqVDbC7uo=
X-Google-Smtp-Source: AOwi7QACPfFwP+tUH6nmVmT3me6JSxsCVNo0UMdawAI2kpp37RVsdCH5mSm14Eml12SuhK5FW+uxSA==
X-Received: by 10.99.146.24 with SMTP id o24mr423384pgd.217.1506495565467;
        Tue, 26 Sep 2017 23:59:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:a541:226f:6d4c:7f7a])
        by smtp.gmail.com with ESMTPSA id k78sm20690043pfb.157.2017.09.26.23.59.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 23:59:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 4/7] avoid looking at errno for short read_in_full() returns
References: <20170927055424.22ati3g24xaqtqrk@sigill.intra.peff.net>
        <20170927060107.duocwl3mf62zvgjp@sigill.intra.peff.net>
Date:   Wed, 27 Sep 2017 15:59:24 +0900
Message-ID: <xmqqk20k4ofn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> When a caller tries to read a particular set of bytes via
> read_in_full(), there are three possible outcomes:
>
>   1. An error, in which case -1 is returned and errno is
>      set.
>
>   2. A short read, in which fewer bytes are returned and
>      errno is unspecified (we never saw a read error, so we
>      may have some random value from whatever syscall failed
>      last).
>
>   3. The full read completed successfully.
>
> Many callers handle cases 1 and 2 together by just checking
> the result against the requested size. If their combined
> error path looks at errno (e.g., by calling die_errno), they
> may report a nonsense value.
>
> Let's fix these sites by having them distinguish between the
> two error cases. That avoids the random errno confusion, and
> lets us give more detailed error messages.

The resulting code might be more verbose but I personally think both
of them give a lot more clear error indication.
