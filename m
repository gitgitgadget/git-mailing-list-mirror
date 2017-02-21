Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04183201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 20:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751397AbdBUUeE (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 15:34:04 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35918 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751069AbdBUUeC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 15:34:02 -0500
Received: by mail-pg0-f66.google.com with SMTP id z128so1138190pgb.3
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 12:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HGMazA29BytCjbMs6s5l8+Rlxkt6U189fq2gtgq45q0=;
        b=MDYP9LhYw+Tb9oeOmSw2XSVO/oBvqbB+C0yXXa3+cKWPmXW59LN3NK0Jho8xZ+nII7
         ZrhwYZPCqxJbuee2jPHQVguJ8sPln/e+H28bZYCBbqhZ29rvYStpzFeA8+xL8M5d8SwV
         frUBEghn50J4NhoL/8J90IyVElIqqs0poCyCockmB8VnFxnKWYMDqAPBIAUwvXrOhqSt
         Sw7yhdDyn7sp6jLL3ySz/OrVvHkTw83BO0j0ppAmhfs1DSKGEq1ImFG7q/ZjOLksBvLB
         lPcLdwv+ySOD8lRPE+94Ib9ouZKC9u2jA1rpTPJTU7MqtjYEUutrw6hqrl2PwP2ImFoQ
         J40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HGMazA29BytCjbMs6s5l8+Rlxkt6U189fq2gtgq45q0=;
        b=tB/EgA+gKKw0/9NeVrTy0dhyRpFiZTrSxktAlag1ECumtrbK+sytgouKTYY9TaQ1jj
         tPt3tMDfwehGEC1xStQalHQbNqA8afqL/Rjpx4dVOJgorJqKWcyi9vYmX1P+SKDaIpid
         PlKwG6swDUC5DrJ0u4EW27X8cuEUEaXalvIUykA5+QSWXuo8lCocpFf/e1BN+Wjxk7JG
         MRHb4WnY8O6iosAPYnCwNGwniUEMOiwG/qdAl2rj+eg9mQeKpFuIz0RCy8Nz2No8klDH
         UwfNODndYg/D7tIp0GiHS8QlGIawygri04+IVC1hCQ1hLTgr65cLCTAeY/UnQY1hDmp4
         BJ3w==
X-Gm-Message-State: AMke39kNd/47HipsJyBNTa7NmaScm5kwLYrphLXk0I/ITTYfbXvFzJW23qu/1vOR87voRw==
X-Received: by 10.98.160.140 with SMTP id p12mr34827783pfl.97.1487709241611;
        Tue, 21 Feb 2017 12:34:01 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d997:8b5d:f579:2a90])
        by smtp.gmail.com with ESMTPSA id y67sm15651952pfa.96.2017.02.21.12.34.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 21 Feb 2017 12:34:00 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] config: reject invalid VAR in 'git -c VAR=VAL command'
References: <20170215111704.78320-1-larsxschneider@gmail.com>
        <xmqqzihn2smp.fsf@gitster.mtv.corp.google.com>
        <f238248f-0df2-19a5-581d-95c8a61b4632@google.com>
        <xmqqy3x712if.fsf@gitster.mtv.corp.google.com>
        <xmqqtw7v123n.fsf@gitster.mtv.corp.google.com>
        <xmqqa89n10df.fsf_-_@gitster.mtv.corp.google.com>
        <D0CDD1AC-05CA-47F3-8CB5-61EA1C6515A8@gmail.com>
        <20170216232730.xsx3xks5ppjws5rg@sigill.intra.peff.net>
        <xmqqwpcptxps.fsf@gitster.mtv.corp.google.com>
        <xmqqino5jia8.fsf@gitster.mtv.corp.google.com>
        <xmqq37f7gyuj.fsf_-_@gitster.mtv.corp.google.com>
        <CAGZ79kbR2QQyYO1dnQ0jW3-ztKEFj1MtJfDqEc0xoftMFeN=WA@mail.gmail.com>
Date:   Tue, 21 Feb 2017 12:33:59 -0800
In-Reply-To: <CAGZ79kbR2QQyYO1dnQ0jW3-ztKEFj1MtJfDqEc0xoftMFeN=WA@mail.gmail.com>
        (Stefan Beller's message of "Tue, 21 Feb 2017 11:15:52 -0800")
Message-ID: <xmqqlgszffm0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Combining this thought with another email[1] that flew by,
> do we also need to have this treatment for "git clone -c"

You tell me ;-) 

Do we share the same parser?  If not, should we make them share the
same code?

>> +for VAR in a .a a. a.0b a."b c". a."b c".0d
>> +do
>> +       test_expect_success "git -c $VAR=VAL rejects invalid '$VAR'" '
>> +               test_must_fail git -c $VAR=VAL config -l
>> +       '
>> +done
>> +
>>  test_expect_success 'git -c is not confused by empty environment' '
>>         GIT_CONFIG_PARAMETERS="" git -c x.one=1 config --list
>
> Do we also want to test obscure cases of expected success?
> e.g. I suspect we never use a."b c".d in the test suite elsewhere but it
> would be a valid key to be handed to git?

I wasn't aiming for anything obscure (and a."b c".d is not at all
obscure); as the new tests like "git -c V.a.R config --get V.A.R"
added in the previous step makes sure that the second level is not
molested and passed as is, so it is less urgent to see what can and
cannot come at the second level.

I didn't check if the existing coverage was sufficient, but we
certainly should test that three-level names with non-alpha and
non-keychar letters in the second are allowed in the overall "git
config" test, not limited to the case where the configuration comes
on a one-shot command line but from files.  I tend to think that is
a separate issue, though.
