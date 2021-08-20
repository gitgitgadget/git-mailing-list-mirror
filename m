Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B73C19F34
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 18:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C92A61209
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 18:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237387AbhHTSXY convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 20 Aug 2021 14:23:24 -0400
Received: from elephants.elehost.com ([216.66.27.132]:13711 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235964AbhHTSW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 14:22:29 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 17KILY08072765
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 20 Aug 2021 14:21:34 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Xia XiaoWen'" <haoyurenzhuxia@gmail.com>, <git@vger.kernel.org>,
        <worldhello.net@gmail.com>,
        "'Xia XiaoWen'" <chenan.xxw@alibaba-inc.com>
References: <20210819091433.348-1-chenan.xxw@alibaba-inc.com> <xmqq4kbl2sre.fsf@gitster.g> <YR/wbWhei0PPLSgX@coredump.intra.peff.net>
In-Reply-To: <YR/wbWhei0PPLSgX@coredump.intra.peff.net>
Subject: RE: [PATCH] add http.maxReceiveSpeed to limit git-receive-pack receiving speed
Date:   Fri, 20 Aug 2021 14:21:28 -0400
Message-ID: <018c01d795f0$350a5c00$9f1f1400$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQF+2dPKibqJr6eaFu8OyVKSc9ncSwJhZKNgAV5MwnOsEC7UYA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 20, 2021 2:12 PM, Jeff King wrote:
>On Thu, Aug 19, 2021 at 11:28:53AM -0700, Junio C Hamano wrote:
>
>> > https protocol, and only supports libcurl 7.15.5 and above.
>>
>> We are likely be raising the floor versions of libcURL to 7.16.0 or
>> even 7.19.4 soonish.  It probably would make it easier to allow it
>> unconditionally (otherwise you'd probably need to implement error or
>> warning messages when configuration is given but the libcURL version
>> used is too old, etc.).
>
>Yeah, I agree that if we can drop the conditional totally, we should.
>
>If we do need to make it conditional, I think there was a preference for shifting to checking the actual option constants, like:
>
>  #ifdef CURLOPT_MAX_RECV_SPEED_LARGE
>  ...ok, we have it...
>  #endif
>
>The rest of your comments all seemed quite reasonable to me.
>
>As a general feature, IMHO speed-limiting is best done outside of application-level tools like Git (and instead done via proxies or kernel
>network config). But since we are not building the feature ourselves, but rather just plugging our config to curl's feature, I don't have any
>problem with it here.

I second that. This should be in the realm of QoS at a managed switch/router in the consumer's network (or the upstream repo in some cases).
-Randall

