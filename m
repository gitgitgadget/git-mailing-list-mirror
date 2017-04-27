Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B32D207BD
	for <e@80x24.org>; Thu, 27 Apr 2017 00:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754690AbdD0AlG (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 20:41:06 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33494 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751469AbdD0AlF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 20:41:05 -0400
Received: by mail-pf0-f194.google.com with SMTP id c198so4077293pfc.0
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 17:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9X7XQWlG5DqfjU/z8+thg6XT7rE2PivqTyGqvtsArlQ=;
        b=bk1mxIn9w0cq0TWz37PnAe58meJhE7+mXSVLE3w5UHqhV8QDUSYwFfbO+QiSj2Qx9M
         I5HPfg5Mfn7xD9+PVpUa8gdKZTHe/e9V7FTHDmffT+Krq3oToXHQpWQ3ps9e359+83PG
         Yr8NfGZ/qzAlhrm6mgnSHrYnor7ksI3r8L8VoSS0ClWwawdWJ1xodkm2BVRAVW/dyntW
         5ulD5tUaW/AG52v1rwrD4xwsX+BkHUHlCSteLlBXKLYKYiG0NgeoLLjz9pPJpEMnzFZe
         WXUQDNRe9JosurEW8lDkvLAVS8fIA64jbOXkBgm5r0WHuxRpO4BdAzUw5XjD8/XiZ/Ug
         3RJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9X7XQWlG5DqfjU/z8+thg6XT7rE2PivqTyGqvtsArlQ=;
        b=XEFNkIyxoMxMs5nBnB5ATHGdXm2RaUQspSkaS4978yL+EX3Bd38DLhvZepHdz2iLUg
         QqUs+ejPGJnOjkw+vNwp8NhyX+IMtfR+t0vxffjvDN8wbNcLMk9hAU6fCt9dcIEwoJRG
         8rF2OjeCBPzWBtW4NHGVSVMplgF581zcR1YQzE1jaqa+0jqFQvZaaeRs+HQiK1/tvyty
         TKDYqRMaEoo3Hlc+Y6wt71g7Sd30P9cgpope77eCeo0b7jsCyUaIsA9aP/Qq9JeB6r0r
         bQUW6UEzJ2H/dPsjf/fj4KYqG8P/4N3UIqM4hccv3T20PMUX3rv608yaQNi+SRE6Pids
         DdaA==
X-Gm-Message-State: AN3rC/7DDVgyJdxu8vBGDcWoCUQKj5KMvLnEwIzFfIR+uFG+5qYXw6Lv
        esq2In2BANOV5Q==
X-Received: by 10.98.15.73 with SMTP id x70mr2875164pfi.86.1493253664347;
        Wed, 26 Apr 2017 17:41:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d550:ca2:cfe6:6d97])
        by smtp.gmail.com with ESMTPSA id e24sm758121pfd.17.2017.04.26.17.41.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 17:41:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, peff@peff.net, j6t@kdbg.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v8] read-cache: call verify_hdr() in a background thread
References: <20170425184109.46168-1-git@jeffhostetler.com>
        <xmqqd1bzst95.fsf@gitster.mtv.corp.google.com>
        <xmqq8tmnss66.fsf@gitster.mtv.corp.google.com>
        <5a97967d-5cf2-dc62-7f84-524556a9ca4c@jeffhostetler.com>
Date:   Wed, 26 Apr 2017 17:41:02 -0700
In-Reply-To: <5a97967d-5cf2-dc62-7f84-524556a9ca4c@jeffhostetler.com> (Jeff
        Hostetler's message of "Wed, 26 Apr 2017 09:06:37 -0400")
Message-ID: <xmqq60hqr8bl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> Either version is fine.  I'd say use my perl version as I have tested it and
> it is simple enough and already in the tree.  I don't think it's worth the
> bother to switch it to the dd version.

Thanks, I agree what you said is very sensible.
