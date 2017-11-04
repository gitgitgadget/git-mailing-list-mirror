Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDE8420281
	for <e@80x24.org>; Sat,  4 Nov 2017 09:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756557AbdKDJGA (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Nov 2017 05:06:00 -0400
Received: from mout.web.de ([212.227.15.3]:56657 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756555AbdKDJF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Nov 2017 05:05:58 -0400
Received: from [192.168.178.36] ([91.20.50.17]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MKIti-1eAMQu1SJ4-001gNn; Sat, 04
 Nov 2017 10:05:46 +0100
Subject: Re: [PATCH 1/2] sequencer: factor out rewrite_file()
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Simon Ruderich <simon@ruderich.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        Ralf Thielow <ralf.thielow@gmail.com>
References: <6150c80b-cb0e-06d4-63a7-a4f4a9107ab2@web.de>
 <20171101194732.fn4n46wppl35e2z2@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1711012240500.6482@virtualbox>
 <20171101221618.4ioog7jlp7n2nd53@sigill.intra.peff.net>
 <20171103103248.4p45r4klojk5cf2g@ruderich.org>
 <xmqqpo8zpjdj.fsf@gitster.mtv.corp.google.com>
 <20171103191309.sth4zjokgcupvk2e@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b074d6fa-8778-ea0d-d53b-7cc35bc4264a@web.de>
Date:   Sat, 4 Nov 2017 10:05:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171103191309.sth4zjokgcupvk2e@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:fXFzRFvBRMoG2a1fh5jK3pt9NfLombS6kwL/BOl89Rwhmmgl7TU
 9M6M2z7LwdHceCEEvS3MwoyKKC3SlgaK4BQV+EKRwcxkUZvCMDnwZtMlhhROMZo5TDZ2vTm
 puzffCt/grWd8sLIh6+UdVK9Eue84CLVweXJzOKhstwr5JTan6ibD0iKl4b/8LILBlEUuVB
 zhGAc9zaWsqt+EYIeV60g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+B5lcXdPavw=:pFTYtZV84sF4YevBqkysyZ
 HN6BM2pFgB8RYpczGfvi0ojJYM/i00iL2KC0OZNTJ80pH8PkH+yNfl7XM0KzwNh8H1OIK/gQz
 T5IqQhz9yjDaihmnSwBnf3EGmN7Mp5dBtY2mEtBjhWgooMI4WmEh9dhJGko1CqoY3Q/Q9jwpH
 FOfgFHL0cqTWJcHYgsWbXD+Op8haiwHdEpCDeJMPcQEL15EqcT2MVnf9ChlvdnM5Gxs3VL7lB
 JtKhWG4ZFzoOkxtzuECuuONaXnqW31XfrXKBxVGvvVczsGfhE8AJpfcHIAFmAsntEvwCgFZNo
 r+PNGz95YlY5tLQZgBRGaFJOiEr/CuBv3lANk5+qQPVZOk7KOmvEBK4waqUC1T945L6AKt/qq
 0wbaoVuWVpBEWSLUgQs4lOZnXu0HORiywx/mfOhbLbNLPQdbC0mcABS6vR2jceLIGyttEqD+B
 BQrLwoUkRf6cE7i2t6oFdF3g897rSelfvFVB0q4Dgk4469AaXCXAtD4Nfp9lZd/z/KLZSv8RM
 dEQiaym8LmyU3yh3hjEQdMPz3XRtK3duAM/UAEvGW9S+HePI3FL/EZgmpMi4axzfAGIiIeYXB
 RHIMu8WwWg5CFF8fBHvPOq44vfHJuFt6GwVO69M/a2JJUmlCpZPxUDFFZksCPL7xi9YgM5hoM
 Gy+gTU0chRnUzJGP4PhZSWsTPlFx0Ti9GPJuiJSzbdo46F6hqCPBTpglO5uyw4dla0/ui+xiY
 l1gmPEP+WCJA7haLueBghVb+xY3QoIaArZipat02iZ/SVwzZt4jNY/aXsmc7YoEI7ABfXBuwE
 Kk7eThGI9Zpr0caWPYch+2lfSnbEpYuNfvar/ZOpe4T280eaAo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.11.2017 um 20:13 schrieb Jeff King:
> On Fri, Nov 03, 2017 at 10:44:08PM +0900, Junio C Hamano wrote:
> 
>> Simon Ruderich <simon@ruderich.org> writes:
>>
>>> I tried looking into this by adding a new write_file_buf_gently()
>>> (or maybe renaming write_file_buf to write_file_buf_or_die) and
>>> using it from write_file_buf() but I don't know the proper way to
>>> handle the error-case in write_file_buf(). Just calling
>>> die("write_file_buf") feels ugly, as the real error was already
>>> printed on screen by error_errno() and I didn't find any function
>>> to just exit without writing a message (which still respects
>>> die_routine). Suggestions welcome.
>>
>> How about *not* printing the error at the place where you notice the
>> error, and instead return an error code to the caller to be noticed
>> which dies with an error message?
> 
> That ends up giving less-specific errors.

Not necessarily.  Function could return different codes for different
errors, e.g. -1 for an open(2) error and -2 for a write(2) error, and
the caller could use that to select the message to show.

Basically all of the messages in wrapper.c consist of some text mixed
with the affected path path and a strerror(3) string, so they're
compatible in that way.  A single function (get_path_error_format()?)
could thus be used and callers would be able to combine its result with
die(), error(), or warning().

René
