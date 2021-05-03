Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21335C433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 21:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9DF161077
	for <git@archiver.kernel.org>; Mon,  3 May 2021 21:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhECVCm convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 3 May 2021 17:02:42 -0400
Received: from elephants.elehost.com ([216.66.27.132]:28186 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhECVCm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 17:02:42 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 143L1d1V020211
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 3 May 2021 17:01:40 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>,
        "'Daniel Carpenter'" <dc@ammonit.com>
Cc:     "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, <git@vger.kernel.org>
References: <8f664b07d1df45bcb6b3f787f42bd046@ammonit.com> <87pmy7x6le.fsf@evledraar.gmail.com> <YJAEVMeY9v/j6PeS@coredump.intra.peff.net> <ed63aa37ef0547bd97a5d965fb5e123f@ammonit.com> <YJBhH0eLKRSpPFy3@coredump.intra.peff.net>
In-Reply-To: <YJBhH0eLKRSpPFy3@coredump.intra.peff.net>
Subject: RE: http.sslVersion only specifies minimum TLS version, later versions are allowed
Date:   Mon, 3 May 2021 17:01:32 -0400
Message-ID: <000c01d7405f$823fd090$86bf71b0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQKPGlYstJZ8C8cfxIQEUsjO/sA2RwDtbvgMAogttL0B5xbjXgDjS/DiqTCJZmA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 3, 2021 4:46 PM, Jeff King wrote:
>On Mon, May 03, 2021 at 03:02:10PM +0000, Daniel Carpenter wrote:
>
>> > Just looking at how the curl binary does it, "--tlsv1.2" means "1.2
>> > or greater" (which is not at all surprising; the library interface
>> > tends to mirror their command-line and vice versa, and our behavior
>> > is influenced by the library interface here).  But that implies to
>> > me that curl folks considered this and though the "or greater"
>> > behavior was useful (which makes sense -- the main goal is probably
>> > to avoid insecurities in older versions of the protocol).
>> >
>> > Anyway, the binary also has --tls-max for capping the maximum version.
>> > That seems more flexible in general than "use this version exactly"
>> > (if you only care that 1.3 is broken, then setting "max=1.2" lets
>> > you talk to servers that support 1.1 or 1.2).
>> >
>> > -Peff
>>
>> I agree that the current behaviour is better for most users, and that
>> some kind of separate "max" config option would work for anyone in my
>> situation.
>>
>> Another idea would be to keep the current behaviour for
>> `http.sslVersion`, but use an exact match with the environment
>> variable only. That already takes priority, and I imagine its main
>> appeal over the config option is for users that want to try something
>> with a specific TLS version.
>
>I think you're right that it may work for many people, but I'd shy away from it
>simply because it's subtle and hard to explain.
>
>Adding config and environment variables for "max" is pretty straight-forward to
>explain. I think it would also make sense to improve the documentation for
>http.sslVersion to make it clear that this is a minimum (the current wording is
>quite misleading).

What if http.sslVersion=v1[,v2]... were supported, so there would be an enumeration of allowed versions. The benefit of an enumeration is that you could force something like 3.0-fips if your environment requires a FIPS-certified version for communication. Admittedly this is a different use case than discussed above.

Just a thought.

Randall

