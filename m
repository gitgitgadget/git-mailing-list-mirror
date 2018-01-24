Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69F1B1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 23:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932547AbeAXXjT (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 18:39:19 -0500
Received: from avasout02.plus.net ([212.159.14.17]:41427 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932072AbeAXXjS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 18:39:18 -0500
Received: from [10.0.2.15] ([80.189.70.206])
        by smtp with ESMTPA
        id eUdPe8N8QC9PeeUdReWSRV; Wed, 24 Jan 2018 23:39:17 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=P+MUeBIu c=1 sm=1 tr=0
 a=BecK+r/lr4XRfISlKBaA+g==:117 a=BecK+r/lr4XRfISlKBaA+g==:17
 a=IkcTkHD0fZMA:10 a=onhi19IbAAAA:8 a=Dx4yW56zAAAA:8 a=73kysmNu9xkLk0fDuFkA:9
 a=QEXdDO2ut3YA:10 a=Jn1WFg6fsOMA:10 a=JvkiTdytZRqVYIXWt-wT:22
 a=X_u8qhY6y2Nm79co_leF:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v4 1/4] Add tar extract install options override in
 installation processing.
To:     Junio C Hamano <gitster@pobox.com>, randall.s.becker@rogers.com
Cc:     git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
References: <20180121234203.13764-1-randall.s.becker@rogers.com>
 <20180121234203.13764-2-randall.s.becker@rogers.com>
 <xmqq607rdmka.fsf@gitster.mtv.corp.google.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <12878143-3529-4802-f0a3-52a6a99b5ce5@ramsayjones.plus.com>
Date:   Wed, 24 Jan 2018 23:39:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <xmqq607rdmka.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJkJEgGt4kytQDiaEb2wKdk4kabI6a2IHwdXEoTudi3MmK8obTSKBhi89JrCFfSLdEYX6nxd30X4SJaZ3J9N1ZJZKzAV9qhE9+juT9ZRxn44etXGbh9v
 /5Xd+sek3xxp11Tonq/eFm3O2ukFfc1DyyV6r15dahCy8aHjyRuIqkIgN5SXx/mu9INWFweb6NLMyQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 24/01/18 20:33, Junio C Hamano wrote:
> randall.s.becker@rogers.com writes:
> 
>> From: "Randall S. Becker" <rsbecker@nexbridge.com>
>> Subject: Re: [PATCH v4 1/4] Add tar extract install options override in installation processing.
> 
> We typically start the subject with some short token to help readers
> of "git shortlog --no-merges" identify what area is being touched,
> e.g. something like
> 
> Subject: [PATCH 1/4] Makefile: allow customizing tar extract options for installation
> 
>> Introduced TAR_EXTRACT_OPTIONS as a configuration option to change
>> the options of tar processing during extract. The default value is "o"
>> which synthesizes xof, by default.
> 
> And then we order the codebase "to be like so" (or, give an order to
> a patch monkey "to make the resulting code like so").
> i.e. something like:
> 
>     Introduce TAR_EXTRACT_OPTIONS to allow customizing the tar
>     options used when installing.  The default value is "o", which ...
> 
> What is missing from the log message is the most important thing,
> though.  Everything you wrote (i.e. what build-time knob is being
> added, what is tweaked and what the default is) we can read from the
> patch text itself, but readers will be left wondering why anybody
> would want to change "o" and change it to what else under what
> circumstances to achieve what.  I am guessing something like this
> might be the reason behind this change
> 
>     This allows an implementations of "tar" that lacks the 'o'
>     (--no-same-owner) extract option to be used (even though the
>     resulting installed versions will keep ownership of whoever
>     happened to have built them, instead of being owned by 'root')
> 
> but please do not make readers guess.

Hmm, I'm a bit puzzled by this patch. I may be wrong, but it
looks like it has nothing to do with the lack of the 'o' option
of tar, and more to do with adding the 'v' option to only a
single invocation of tar. There are three instances of this
kind of pattern in the Makefile, but only one has been modified.
Why?

> Having said all that, I wonder if this "go to po/build/locale, tar
> everything up and then extract it elsewhere" is truly necessary.
> IOW, why isn't it sufficient to do this instead, for example?
> 
>     umask 022 && cp -r po/build/locale/. '$(DESTDIR_SQ)$(localedir_SQ)'

Given the above, I suspect that (for some unknown reason), a verbose
'listing' of the locale files is required ... :-D

ATB,
Ramsay Jones

