Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB16F20281
	for <e@80x24.org>; Wed, 27 Sep 2017 01:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030329AbdI0BHb (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 21:07:31 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:44937 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966668AbdI0BHa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 21:07:30 -0400
Received: by mail-pf0-f174.google.com with SMTP id e1so6413129pfk.1
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 18:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=m0vjlJ/RIEryWZblJx6Jq5MCYCutjTuityGWKaxvSFg=;
        b=gXhyOgzi2lqA2pfwmkKoRxs6nXmZW87B7J0TOCwTNTDdPeUEqmxfunyeuZVz6c31Y4
         mlLCZfgtPyzKEdlK+AgjvDDHTwta3bvCNGYm+DYsHswo4Ei2fRxa6uhEBOT4nQ9wVa4G
         OOImca46updZ260csE9hM9hmPGtV0T2xAaHSuNXKWUJlqzgeIvTuD4Dv7bztwFkEhBfA
         u4e8u1e8oRWGvaLGkNdBxHhu5bPl6/mwUUd9B//ZZO3RCQLZe6XqvAFvCyAuAWA8p7oj
         P+SCMD2NSgrrdf4o7RxLzdzkzqeLY5C2Rbj5SViA7TGM4YNTDZOlsiWek5ZJbcB87AHP
         1Jig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=m0vjlJ/RIEryWZblJx6Jq5MCYCutjTuityGWKaxvSFg=;
        b=H/oegXTPeVjhRLMeWKiejFdGKK4JFkpGp5ZdgU3lYN/PRC7I1Tk7pLMnowU9fkBw8v
         jqfk1eeshq2KY4hISUn56N/FaT1lRDQz62T80owIYyvxacTyUMTdjiWbgRZpub3oPbSJ
         m0OKiOpjzqiDNHvTxQOExXVWwHKs1ZMAV5ok8WcnMrYYUmEv5c7u8tsmiJbj/kbd2bfd
         Pv6C4By8a4gHXURjwJzfjs2kIjVLOwhaVEEAPf+J1C5decvolDwWhuPoVh9t9bliRSld
         17xyisMOd2CI7y5wFLV90kGjvVBTQt2wR//GoRkXtR8pQQzEJpZC0V8AwW+78eneERRi
         JBmQ==
X-Gm-Message-State: AHPjjUhBgPgaZs2Szu0Saor3IDUDKuyLXamALpohrI+KkRpg+7kiSvt2
        gIrweaP81mO+dUslAAA9obE=
X-Google-Smtp-Source: AOwi7QCyvnhFmDDzcal6vXQJn99MlsP6kJKQGkd3sVqglZ5CBpkf+Fcdy07VapleRyatpvKrUA30fA==
X-Received: by 10.99.170.69 with SMTP id x5mr12971113pgo.117.1506474449459;
        Tue, 26 Sep 2017 18:07:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:a541:226f:6d4c:7f7a])
        by smtp.gmail.com with ESMTPSA id p88sm19169269pfi.174.2017.09.26.18.07.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 18:07:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, bturner@atlassian.com, git@jeffhostetler.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [PATCH v2 6/9] connect: teach client to recognize v1 server response
References: <20170913215448.84674-1-bmwill@google.com>
        <20170926235627.79606-1-bmwill@google.com>
        <20170926235627.79606-7-bmwill@google.com>
Date:   Wed, 27 Sep 2017 10:07:27 +0900
In-Reply-To: <20170926235627.79606-7-bmwill@google.com> (Brandon Williams's
        message of "Tue, 26 Sep 2017 16:56:24 -0700")
Message-ID: <xmqqh8vp7xv4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> +/* Returns 1 if packet_buffer is a protocol version pkt-line, 0 otherwise. */
> +static int process_protocol_version(void)
> +{
> +	switch (determine_protocol_version_client(packet_buffer)) {
> +		case protocol_v1:
> +			return 1;
> +		case protocol_v0:
> +			return 0;
> +		default:
> +			die("server is speaking an unknown protocol");
> +	}
> +}

checkpatch.pl yells at me:

    ERROR: switch and case should be at the same indent

and we would probably want to teach "make style" the same, if we
already don't.
