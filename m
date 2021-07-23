Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5F8C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 16:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C40E460E73
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 16:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhGWQJE convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 23 Jul 2021 12:09:04 -0400
Received: from elephants.elehost.com ([216.66.27.132]:11876 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhGWQJD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 12:09:03 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 16NGnX6l098871
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 23 Jul 2021 12:49:33 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Jeff King'" <peff@peff.net>
Cc:     "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, <git@vger.kernel.org>,
        "'Nicolas Morey-Chaisemartin'" <NMoreyChaisemartin@suse.de>,
        "'Tom G . Christensen'" <tgc@jupiterrise.com>,
        "'Mischa POSLAWSKY'" <git@shiar.nl>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>        <cover-0.5-00000000000-20210721T220402Z-avarab@gmail.com>        <YPqW8lAcwno3j7Fq@coredump.intra.peff.net> <xmqqo8atovbc.fsf@gitster.g>
In-Reply-To: <xmqqo8atovbc.fsf@gitster.g>
Subject: RE: [PATCH v2 0/5] drop support for ancient curl
Date:   Fri, 23 Jul 2021 12:49:27 -0400
Message-ID: <016801d77fe2$b7310ae0$259320a0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQE0vbRnJUMvLfkMQVvxJmHGPWW9BwHenvwDAmPc0/0CIMzKH6xjLd9A
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 23, 2021 12:21 PM, Junio C Hamano wrote:
>Jeff King <peff@peff.net> writes:
>
>> On Thu, Jul 22, 2021 at 12:22:11AM +0200, Ævar Arnfjörð Bjarmason wrote:
>>
>>> This series is a re-roll of patches found in Peff's GitHub repo at
>>> jk/no-ancient-curl, which were already-rebased versions of those
>>> patches. His original on-list version had his Signed-off-by, but the
>>> range-diff is against that branch, hence the addition of
>>> Signed-off-by in the range-diff.
>>
>> Heh, OK. It's a little surprising to see random junk pulled out of my
>> GitHub repo, but in this case I was holding onto them with the intent
>> of eventually resending after more time passed.
>>
>> So I'm happy to see these cleaned up and posted. I think what's on
>> that branch should be good-ish, in the sense that I've been rebasing
>> it forward as part of my daily routine, and it's part of the build
>> that I use day-to-day. Though apparently I never applied the
>> CURLOPT_POST301 fix. :-/
>
>Thanks.
>
>> I know my S-o-b was on the originals to the list, but just to make
>> clear: I am fine with using them on the rebased versions you grabbed.
>
>Good.  S-o-b is merely "I can let the project use it" and does not say "I agree this is (still) relevant in the context of the code this is being
>submitted to", so the above note is very much appreciated.
>
>> So modulo the commit message tweaks that Junio suggested, this all
>> looks fine. I actually think my original "#error on too-old curl" is
>> still reasonable. Yes, people whose distro has backported all of these
>> features could possibly still use it. But in that case they likely
>> know what's going on and can rip out the #error. It seems much more
>> likely to me that it _won't_ work, and they'll get confused by obscure
>> errors when they try to use an old curl.
>>
>> But I don't feel too stronlgy about it either way.
>
>Me neither.  Those who are vanilla would not be helped by having it, as their build would fail if their cURL is too old anyway even without
>it.  Those who backported would have a build that may or may not work, but diagnosing it is part of the job of backporting their cURL
>anyway.  So in practice, I think "#error if you are older than X" primarily would serve documentation purposes (which may be worth doing,
>but requirements listed in INSTALL would probably be a better alternative anyway).

This is probably a red-herring, but from what I am observing, the curl 7.70 version is required for OpenSSL 3.0.0. Once we move there, which my team is working on, the near recent older version of curl could also be problematic and incompatible. This is rather unpleasant because the current standard libcurl on our platform is 7.65, which is too old to be compatible anyway, so we're going to have to put out a separate libcurl build. Curl seems to need to be closer to the bleeding edge to retain imminent compatibility.

-Randall

