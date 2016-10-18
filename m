Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F86120988
	for <e@80x24.org>; Tue, 18 Oct 2016 16:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965089AbcJRQFi (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 12:05:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60637 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S964914AbcJRQFf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 12:05:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 22CB647990;
        Tue, 18 Oct 2016 12:05:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lHz0Nq8DcAUf9tNrN/J5/87Klcc=; b=Y9uyQc
        RYytBWEIIuRUJhT6YGunkUlIglyH4FT7rfvglihIYgi9ZUpb3x590d0bEk+YD4Aj
        /kVEfJDVSfQDBVJJy+yYKoGR13Ybr5zJ19rEOcCVJcu/beFLrOcT9++lmuT/B8dC
        PbwOpqPh8pDuA/yLLEc1zaYB4fizwNDDG4yVw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QPGLUPgIbVuF6p8fpGaw967p012pGFTy
        pLyZzX7lE0qQnKZ4+cIhKzDCaOqUjv63tXzDBQ4bmVnH8XSxikSpkWmHDaftjcHN
        Lu4PQEo/6y0WoHxPZ4F06OfKzhlTO2w82J/Kc6VJxLyHV70ev1QN11tU8edl6LO/
        o60VPteePpA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A0ED4798F;
        Tue, 18 Oct 2016 12:05:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 818484798E;
        Tue, 18 Oct 2016 12:05:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 4/6] trailer: make args have their own struct
References: <cover.1476232683.git.jonathantanmy@google.com>
        <cover.1476466609.git.jonathantanmy@google.com>
        <2357e9e6418fc5b30a60efe16dd8f72bf7544fef.1476466609.git.jonathantanmy@google.com>
        <CAGZ79kYuaHvO-aXeCocDseTLe13g=PesKxQgOrcOREtM1CsWcg@mail.gmail.com>
Date:   Tue, 18 Oct 2016 09:05:31 -0700
In-Reply-To: <CAGZ79kYuaHvO-aXeCocDseTLe13g=PesKxQgOrcOREtM1CsWcg@mail.gmail.com>
        (Stefan Beller's message of "Mon, 17 Oct 2016 16:20:05 -0700")
Message-ID: <xmqqh989r6b8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B30E4BF6-954C-11E6-868B-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> @@ -29,6 +29,12 @@ struct trailer_item {
>>         struct list_head list;
>>         char *token;
>>         char *value;
>> +};
>> +
>> +struct arg_item {
>> +       struct list_head list;
>> +       char *token;
>> +       char *value;
>>         struct conf_info conf;
>>  };
>
> (Unrelated side note:) When first seeing this diff, I assumed the diff
> heuristic is going wild, because it doesn't add a full struct.
> But on a second closer look, I realize this is the only correct diff,
> because we do not account for moved lines from one struct to the
> other.

It probably is not "the only" correct diff, as you actually could
shift it the other way by one to three lines.  I am not sure which
one among four possible diff is the easiest to grok, though.  Both
the above (picking the highest possible position) and the below (the
other extreme) are probably easier to read than anything in between.

 struct trailer_item {
+	struct list_head list;
+	char *token;
+	char *value;
+};
+
+struct arg_item {
 	struct list_head list;
 	char *token;
 	char *value;
 	struct conf_info conf;
 };
 
