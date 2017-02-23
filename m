Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 697B72022D
	for <e@80x24.org>; Fri, 24 Feb 2017 00:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751599AbdBXAa5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 19:30:57 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35883 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751342AbdBXAa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 19:30:56 -0500
Received: by mail-pf0-f196.google.com with SMTP id c193so204494pfb.3
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 16:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TqCk5V50pvybnKi/F8wtdLVquqdxdqpZwl1NOMhjbSE=;
        b=ULboWxdNGHLZaH3CbxclcEPKURLqx2S7ah5Re90JHOLOXHUtx1z80SjXdes6c9DZgC
         anNSugsLuif+WLA+5y+m0UenGrsDlpeEx7txDUrDgE5d6QqWe7RjEhUdHx9xnvsbPXIG
         6Xxdn8d4S5DgVhQdizek5EAFYCvCUmLG7qv9yeE8OAdVmLG/kpTQsBUqQpsblFNBt23s
         iUQ9TfQGlXpxCdHKwQBOlarZ9BRk5tfoXttwR5DfMjd6dscZHnxAbbgTjrjp/kQzlX7Q
         JuL6mTuyTapbBpWTVKXsh6vNiMaAo0F0GuYyaAtNs1+a9sdo/6fgfc76RGELVzPC8Lhm
         O6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=TqCk5V50pvybnKi/F8wtdLVquqdxdqpZwl1NOMhjbSE=;
        b=SVK0XDsviFDNO+SuuVnJwfvdtV8YawYuOUktGiTzDamxYPsvUDz4RWzX+fcnY03xhj
         WDruedvbo1yv5a63bNZyedNuspr6+/sX5JQgOygSeFMPQ2RVRLae0ROEaABMMRC9M9Ub
         +HRCDUiWLapKJSUX1AXcxaLb8S4tVioy+lXYDnTWIHujByyZf0jjr82mUYP7FmdZhmTw
         LSQPtniWiyP7xZ2fy/PXeXHy3FhxPZ4GlzfA0sIOZtqNzOre3M36ht2Mry/Qg/NQSjFv
         MChmuJJlqi3gXQsCH3/xuAyWFNd5tJiCd4bLtX/dMkCkz0wn/lZm2vB0X4xxg1z4emz6
         CkJw==
X-Gm-Message-State: AMke39kUrYOj6pLinmIuWki30k7yhhUZwSXYjNKSYK9zZLAaIij8R6l29yAISaMDY0JRAA==
X-Received: by 10.99.127.89 with SMTP id p25mr31562882pgn.101.1487894358040;
        Thu, 23 Feb 2017 15:59:18 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8829:f260:c132:141f])
        by smtp.gmail.com with ESMTPSA id m3sm11706943pfc.66.2017.02.23.15.59.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 15:59:17 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, peartben@gmail.com,
        benpeart@microsoft.com
Subject: Re: [BUG] allowtipsha1inwant serves unreachable blobs if you know its hash
References: <20170223230358.30050-1-jonathantanmy@google.com>
        <xmqqtw7k5uxj.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 23 Feb 2017 15:59:16 -0800
In-Reply-To: <xmqqtw7k5uxj.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 23 Feb 2017 15:50:00 -0800")
Message-ID: <xmqqpoi85ui3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> Adding "--objects" works, and all existing tests pass, except for the
>> potential performance issue and the side effect that even fetching a
>> reachable blob no longer works. This is due to a possible bug where a
>> call like "git rev-list --objects $tree ^master" (where $tree is the
>> tree object corresponding to master) prints out objects ...
>
> The "reachable from this, excluding what is reachable from that"
> notation was originally designed to work only on commits, and I
> wouldn't be surprised if "$tree ^master" did not work as you expect
> in the current implementation.
>
> I agree that ideally it shouldn't show anything, but I suspect that
> it would make it very expensive if done naively---we'd end up having
> to call mark_tree_uninteresting() for all uninteresting commits, not
> just for the commits at the edge of the DAG as we do right now.

BTW, by "it would be expensive" I didn't mean "hence it shouldn't be
done."  Even though I do not know by how much expensive it would
become, I think this approach is a lot better way going forward than
punting and say "no, you cannot specify anything lower than commit."

Thanks for looking into this.

