Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA53C4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 21:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A735360F46
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 21:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbhG2VBk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 17:01:40 -0400
Received: from elephants.elehost.com ([216.66.27.132]:54197 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhG2VBj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 17:01:39 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 16TL1Whi077765
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 29 Jul 2021 17:01:32 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Fabian Stelzer'" <fs@gigacodes.de>
Cc:     "'Jonathan Tan'" <jonathantanmy@google.com>,
        <gitgitgadget@gmail.com>, <git@vger.kernel.org>,
        <hanwen@google.com>, <sandals@crustytoothpaste.net>,
        <bagasdotme@gmail.com>, <hji@dyntopia.com>, <avarab@gmail.com>,
        <felipe.contreras@gmail.com>, <sunshine@sunshineco.com>,
        <gwymor@tilde.club>
References: <725764018ceb5bcecc748cc5169d4305ea9d7d23.1627501009.git.gitgitgadget@gmail.com>        <20210728230452.2719333-1-jonathantanmy@google.com>        <d4bda019-bbea-6645-e46a-18a702d3f0ad@gigacodes.de> <xmqq8s1o4zn8.fsf@gitster.g>
In-Reply-To: <xmqq8s1o4zn8.fsf@gitster.g>
Subject: RE: [PATCH v6 5/9] ssh signing: parse ssh-keygen output and verify signatures
Date:   Thu, 29 Jul 2021 17:01:26 -0400
Message-ID: <039a01d784bc$e92568a0$bb7039e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQKDCFfzyN3R5qbWeAOurSL0iTEETgJUwDMMAWiTjqoCKdmpr6nULtEQ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 29, 2021 4:46 PM, Junio wrote:
>Fabian Stelzer <fs@gigacodes.de> writes:
>
>> On 29.07.21 01:04, Jonathan Tan wrote:
>>
>>> Also, is this output documented to be stable even across locales?
>> Not really :/ (it currently is not locale specific)
>
>We probably want to defeat l10n of the message by spawning it in the C locale regardless.
>
>> The documentation states to only check the commands exit code. Do we
>> trust the exit code enough to rely on it for verification?
>
>Is the exit code sufficient to learn who signed it?  Without knowing that, we cannot see if the principal is in or not in our
keychain, no?

Have we not had issues in the past depending on exit code? I'm not sure this can be made entirely portable.

>> If so then i can move the main result and only parse the text for the
>> signer/fingerprint info thats used in log formats. This way only the
>> logs would break in case the output changes.
>>
>> I added the output check since the gpg code did so as well:
>> ret |= !strstr(gpg_stdout.buf, "\n[GNUPG:] GOODSIG ");
>
>Does ssh-keygen have a mode similar to gpg's --status-fd feature where its output is geared more towards being stable and marchine
>parseable than being human friendly, by the way?

I do not think this can be done in a platform independent way. Not every platform that has ssh-keygen conforms to the OpenSSH UI or
output - a particular annoyance I get daily.

