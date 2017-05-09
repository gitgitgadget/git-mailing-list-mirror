Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F6F02018D
	for <e@80x24.org>; Tue,  9 May 2017 23:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750984AbdEIXmp (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 19:42:45 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34855 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbdEIXmg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 19:42:36 -0400
Received: by mail-pg0-f52.google.com with SMTP id o3so7245833pgn.2
        for <git@vger.kernel.org>; Tue, 09 May 2017 16:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8iZLZ1aFGx6dQA094Ryt2VeG+2ptJqcgdcuT9jQbxM4=;
        b=RPLSO9znuTl8FogVkMszFxy4u6RUy7mUOgFwegxvvM5uTU87xtYPUYrkBo6KTjb7ph
         j20yg8BnnBBwZdziHw5dcm6U561W7bzR5JXFVYdSgTwTLRf96/I27BRzZybpkye23m8j
         Rurxb3YAX+RDo3cjJyCt0+xc/DgFtS8UZsW5JDnikiIhb7/4hepemOfg2+6vxh/IdoVy
         rMhhoPh+fY7fCRAHqX/dn3WWHHyGIhUD9WEWBWVeFh3rN/meJEnfi+UC8fGd2maseVCr
         XwtoktUi6Z0yJOr0RNIJUHQzr84QB4jDLtugJrQzAi6B5gcIEE0lPbSIeuw8WIs/+Gse
         DTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8iZLZ1aFGx6dQA094Ryt2VeG+2ptJqcgdcuT9jQbxM4=;
        b=qmgK/znsM7h/nXRbGeLDQiPbK9rWUuOluQyd06cXFCT/JwfldLyWG3yL41uiapnDsE
         tw5jsCix2BdsErTKpVBDJvbvsX3kutA6xIK0NWebaycb3koweBmuHcaE0AXC73Bwl9ov
         eBz7EMBu//ye2ZszIbDP5CFM2qMHacDFaRByeIFC9uYMHPBz/nG1uNEO7Z2VFzPpShfg
         FeIZD6gG2nXKm8J/nxIZH/5DeeSuGw+bbl223Ykp6FcMv+HTsqnZa6DsSh+oTOs4N05I
         +hJR8PwVP+lf1QS/3PVMKeH5ASwVXag5CdxPCLmDqRbF9ZOAI/nrNU1/Sv/qh/Jw5DWx
         whyA==
X-Gm-Message-State: AODbwcBljMx3aFekJlILFDcjjJxiib6SFzLr38k63DlYGKQ7mwUSAdpZ
        iiMgWDbpAfC3OQ==
X-Received: by 10.99.122.21 with SMTP id v21mr3123809pgc.98.1494373355885;
        Tue, 09 May 2017 16:42:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9133:cf19:b689:27d6])
        by smtp.gmail.com with ESMTPSA id x5sm1704938pfd.94.2017.05.09.16.42.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 May 2017 16:42:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH v2] archive-tar: fix a sparse 'constant too large' warning
References: <4bf9be3c-5d19-09e3-b8b3-dd58e00e623d@ramsayjones.plus.com>
        <alpine.DEB.2.21.1.1705091223190.146734@virtualbox>
        <5068a9b6-c77a-737d-9d80-40108c5f22c3@ramsayjones.plus.com>
Date:   Wed, 10 May 2017 08:42:34 +0900
In-Reply-To: <5068a9b6-c77a-737d-9d80-40108c5f22c3@ramsayjones.plus.com>
        (Ramsay Jones's message of "Tue, 9 May 2017 21:13:01 +0100")
Message-ID: <xmqqr2zxzjf9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Yeah, I had a similar comment in the commit message (but much more
> verbose than your concise addition above), but I edited it several
> times, without finding a wording that I liked. I eventually removed
> it, because it didn't really add any value. :(

I tend to agree that the proposed additional comment does not add
much value.  It assures the readers that we (at the time of applying
this patch) know that the earlier use of ULL was not done with a
good reason but was merely an accident, and strengthens the claim
that this is a good change, but the correctness of the change is
already obvious, and the readers would understand without being
explained where the incorrectness we have to fix with this patch
came from, I would think.
.
