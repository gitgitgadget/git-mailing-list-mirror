Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5163F1F97E
	for <e@80x24.org>; Sat,  6 Oct 2018 09:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbeJFQVk (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Oct 2018 12:21:40 -0400
Received: from mail.ao2.it ([92.243.12.208]:46017 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727703AbeJFQVk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Oct 2018 12:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ao2.it; s=20180927;
        h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:From:Date; bh=KNZUA/tH7CylR6yPsWDSqYF4ZGJ5vkFuJIhtjGCME5w=;
        b=cQh7rVnSHAjgyPTv3LUThCPBpK2m8W/33rdxyP/yhtxbosGp403LurW/7FXbJQJEst6cUz1dAkRQ5DsrnWAbLjF9dVRNAL2PuyHnYYfVFmMzSdf5gb8hYNiLTSzi0vuvGuZa9HA0DQ29jjs/aZIcw7wcQp0AFFcoah/vcSeFWO4j9ZB58OHbqDear1sTMFJDS+jYEeGHaLarl8IaYOaWNJBorpQptHKtZ8joEcVMYqG5lbUJzSZx4cKOLD5p5aF7WwHxQkH8X0pu75fF2CqWf6eq9ni3Kn4aT5oO4IFwo59XjipgZVb6JH0gUlwyP64rc1ojpEelmmijstQG/2k06A==;
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1g8ihK-0007Lk-16; Sat, 06 Oct 2018 11:16:30 +0200
Date:   Sat, 6 Oct 2018 11:19:04 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?ISO-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v6 08/10] submodule: add a helper to check if it is safe
 to write to .gitmodules
Message-Id: <20181006111904.cb45cb24e097ad86f7525fcd@ao2.it>
In-Reply-To: <CAGZ79kbaeRVBLhYiqzisADHs+Af+c2giXcsCySAEe4jue_rWwA@mail.gmail.com>
References: <20181005130601.15879-1-ao2@ao2.it>
        <20181005130601.15879-9-ao2@ao2.it>
        <CAGZ79kbaeRVBLhYiqzisADHs+Af+c2giXcsCySAEe4jue_rWwA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 5 Oct 2018 16:50:10 -0700
Stefan Beller <sbeller@google.com> wrote:

> >  static int module_config(int argc, const char **argv, const char *prefix)
> >  {
> > +       enum {
> > +               CHECK_WRITEABLE = 1
> > +       } command = 0;
> 
> Can we have the default named? Then we would only use states
> from within the enum?

The default would mean:

  "no command passed as a CLI *option*"

I copied this style from builtin/bisect--helper.c::cmd_bisect__helper()
and it's also used in builtin/rebase--helper.c

I can add a name for the default enum value but I am not sure what it
should be: NO_COMMAND_OPTION, COMMAND_DEFAULT, MODE_DEFAULT?

Ciao,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
