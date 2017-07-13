Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78E46202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 19:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752848AbdGMTjX (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 15:39:23 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34897 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752611AbdGMTjW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 15:39:22 -0400
Received: by mail-pg0-f44.google.com with SMTP id j186so34284193pge.2
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 12:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Fn/K1LV/n6laAz0XrzSwAKSjak4/APZBsGaoNu8Fo40=;
        b=HNfTEg8muD/RXx0CYSUfkQ7Nw44Pt/cWAmj+5EiIRujpFZby43wokd0QH/+gcpCUWG
         efD2hcIAREBFUSlGZcQeTs+TgmrmYkzAoePZucVyvLu7lk5gU15lGklXy1OqHTcSSCtE
         6mf/pgauZr51e2gziZRVCTqWTcVHfhi7gI3QMPDTGmUIMLDi8m7Y1ed6EKK0QklPqpjN
         IAJVt82gnqVVA34N31Jy2Boh4JDriVoHFfAHngpJJ0uEgPc2c9H2cPmMq3G+zt5IvmvL
         Urwzaw7r0kmpWr1J+dto+FClZX1EzG7L/pggWlJfOeBXA6gZlORkhwkejkcw9i7lplBG
         dEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Fn/K1LV/n6laAz0XrzSwAKSjak4/APZBsGaoNu8Fo40=;
        b=ECz7e6EPq0VL7gMFRQK5UlWXhU8QEHfo6bg+Qj3G+1H7tpA2Z0TtHzCvCrOb1kz8bJ
         I6G1YIpC2I6e73XlHiTTG73eqPCcbK/oYEM5yzSJ53ChevdVYwKazWUA88T+MaSaI7l6
         JtALOWpneyowQINvXIDefQ8OOHkxupp79345lhpazPZppoqIWBkkXXG6rJ714RFQTLYu
         LxRRWoXKYBdaHhDzO+5FjVGF4Fjq6o6iukZxvG2OK0+yamofM2ImPN0V5066ISrO0T1R
         S2gsj6qz/yzOSG4U10EozyLJB24JAlBr43A4bxhTx2OyBxDF8NE7EUtl+AU0zaCFfCrc
         7sjg==
X-Gm-Message-State: AIVw113WqRNXXwygDDRfYg2wU0eBQ9+i4OzfmFUOUoC1G1US/JKD2moU
        gpMrqcb8TvwIIpMQFjQvfhjTvNSWdRaJVnRdQA==
X-Received: by 10.98.147.142 with SMTP id r14mr1271594pfk.150.1499974761416;
 Thu, 13 Jul 2017 12:39:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Thu, 13 Jul 2017 12:39:20 -0700 (PDT)
In-Reply-To: <xmqqa848xjxr.fsf@gitster.mtv.corp.google.com>
References: <20170712234504.15811-1-sbeller@google.com> <20170713000117.GJ93855@aiede.mtv.corp.google.com>
 <xmqq60exyx5k.fsf@gitster.mtv.corp.google.com> <CAGZ79kaHX-YCMv01T-QE=mYeymjTnwrpg9-bsOrCjg3NWEunDA@mail.gmail.com>
 <xmqqa848xjxr.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 13 Jul 2017 12:39:20 -0700
Message-ID: <CAGZ79kYtRbHvfC6d=+eEXCceJam4wwo9XqvY752c_pg6kq90DA@mail.gmail.com>
Subject: Re: [PATCH] submodule: use cheaper check for submodule pushes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2017 at 11:37 AM, Junio C Hamano <gitster@pobox.com> wrote:

>
> I think Jonathan's question (which I concurred) is if we also ended
> up relying on the side effect of calling that function (i.e. being
> able to now find objects that are not in our repository but in the
> submodule's object store).  By looking at the eb21c732d6, we can
> tell that the original didn't mean to and didn't add any code that
> relies on the ability to be able to read from the submodule object
> store.  I am not sure if that is still true after 5 years (i.e. is
> there any new code added in the meantime that made us depend on the
> ability to read from submodule object store?).

Yes we are safe, because the function itself only spawns a child process
(not using any of the objects).

It's only caller push_unpushed_submodules also doesn't rely on objects
loaded after calling push_submodule.

The caller of push_unpushed_submodules (transport.c, transport_push)
also doesn't need submodule objects loaded.

> My hunch (and hope) is that we are probably safe, but that is a lot
> weaker than "yes this is a good change we want to apply".

Given the above (I went through the code), all I can do is repeating
"yes this is a good change we want to apply".

Thanks,
Stefan
