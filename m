Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 490D8202AC
	for <e@80x24.org>; Wed,  5 Jul 2017 01:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752337AbdGEBth (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jul 2017 21:49:37 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36566 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752279AbdGEBtg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jul 2017 21:49:36 -0400
Received: by mail-pf0-f196.google.com with SMTP id z6so32610851pfk.3
        for <git@vger.kernel.org>; Tue, 04 Jul 2017 18:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=03wriHQ6SWMukc8Tkalym6FuDFc4z26BQVwScqTdr3Q=;
        b=iQUgexL+eqvuc9OLopzGyWhySXbEpWBHHTNIVY4geNidijnsV78itzwguORb5WKxF7
         2GIbWUPsofpNmWL1SeaANjFlhwoeaLjjUtGTic8Tdg8yWm5SNRf56ILHtGj4hLncpuw6
         1PNCTyabS+Ug1SY1LlsgM/ESwZec1mqV2zW+dO0E/flwqUGarfysBrkZg4n5vjB8qQw8
         MqJMfuUrJMEgkP9sf4OOWt3GKwXQK3KpRS9zSYCuMHdRuxS+v1Xgk2uPwjRkcFMlU2rc
         LPRP0p5TVhEz1Th+G2tG7pnYJ8vcAIAygMrWjaA/zRCzdcW8/GX1upn4Fv1EWcTT1tvO
         1PMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=03wriHQ6SWMukc8Tkalym6FuDFc4z26BQVwScqTdr3Q=;
        b=Mg7iPxvnF/p0Rz1CToN5dJmiaGKBRFcVp46oB9aSXEd0usZHzwCXo2HoSUYPl06vD/
         G+QXIG83c9DB7hjVvgSDX+LERssp4s4I8eUDFJYii7oK2kYHMuQ6ABwLDJrz4xpj0Ag4
         GHnlnckXEVI1iVz738NwJ6fq5R165ry1TDSWY6BxdxgbOcjOM8Fc2bQeVJRS22aP1dWt
         czmEh4vkTk9XYFhCcfjnVJFz9zifeTXQkS9uZp/2arVu/iima4Jyi9aGCfmnlfjHSXFJ
         55V9Xobttj0n0igE1g8mB3TJx8DblyCL5svLuCJDc1vyxlyjDzR7KtIFyiui8uswkjgU
         cDMg==
X-Gm-Message-State: AIVw113v3gl7YI5L4OvMto8wOwBb5Xloy/hTiFunsX9rqR0tGaNEp/TE
        NWg2V7bcc11duA==
X-Received: by 10.98.147.19 with SMTP id b19mr17907781pfe.145.1499219375567;
        Tue, 04 Jul 2017 18:49:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:58ac:d78a:789c:c809])
        by smtp.gmail.com with ESMTPSA id m11sm45490083pfg.85.2017.07.04.18.49.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 04 Jul 2017 18:49:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org,
        Sahil Dua <sahildua2305@gmail.com>
Subject: Re: Truncating HEAD reflog on branch move
References: <20170622151603.rrh2j7zsotyt2jxe@sigill.intra.peff.net>
        <xmqqziczkh4k.fsf@gitster.mtv.corp.google.com>
        <20170622184516.kq3y7nxwohm3coq4@sigill.intra.peff.net>
        <xmqqvannkfp8.fsf@gitster.mtv.corp.google.com>
        <20170622202146.cxrkjca636xl4dgk@sigill.intra.peff.net>
        <xmqqd19vix03.fsf@gitster.mtv.corp.google.com>
        <20170622215235.to6yleo3adt5klv2@sigill.intra.peff.net>
        <20170622222545.yewnynklle24ebtf@sigill.intra.peff.net>
        <20170623031315.7aw5qd7c4wdqlyf6@sigill.intra.peff.net>
        <20170704195806.ndbykl776t3vigya@genre.crustytoothpaste.net>
        <20170704212408.xy6jciggoueq6qsu@sigill.intra.peff.net>
Date:   Tue, 04 Jul 2017 18:49:33 -0700
In-Reply-To: <20170704212408.xy6jciggoueq6qsu@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 4 Jul 2017 17:24:08 -0400")
Message-ID: <xmqqmv8jk5zm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Jul 04, 2017 at 07:58:06PM +0000, brian m. carlson wrote:
>
>> > And here's one more patch on top of those that's necessary to get the
>> > tests to pass (I don't expect anybody to necessarily be applying this
>> > slow string of patches; it's just to show the direction I'm looking in).
>> 
>> I've looked at your original patch, which modified reflog-walk.c, and it
>> does fix the issue.  I'm happy to send in a patch with that and a test
>> (provided you're okay with me adding your sign-off), or if you wanted to
>> send in something a bit more complete, like the series of patches here,
>> that's fine, too.
>
> I've been on vacation for the past week, but wrapping this up is on my
> todo. I'll try to get to it tonight.

;-)  Welcome back.  

Hopefully I haven't advanced topics to 'next' that are sub-par
during your absence.


