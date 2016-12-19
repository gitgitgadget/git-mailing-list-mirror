Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AAD01FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 17:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932718AbcLSRp5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 12:45:57 -0500
Received: from mout.gmx.net ([212.227.17.20]:54819 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932659AbcLSRp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 12:45:56 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lskr7-1chjln1TUv-012LGC; Mon, 19
 Dec 2016 18:45:42 +0100
Date:   Mon, 19 Dec 2016 18:45:40 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     "Kyle J. McKay" <mackyle@gmail.com>
cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] mailinfo.c: move side-effects outside of assert
In-Reply-To: <900a55073f78a9f19daca67e468d334@3c843fe6ba8f3c586a21345a2783aa0>
Message-ID: <alpine.DEB.2.20.1612191844520.54750@virtualbox>
References: <900a55073f78a9f19daca67e468d334@3c843fe6ba8f3c586a21345a2783aa0>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:y+JsZ4iQ9rlooc9/odkqja43liORmilYnxSWVQyqcSMdvTOT0PW
 RlvfV3SXjXtQaEQk3O373v0m1w6N6Z+BZjZm0hoYUtYAkvoQFHrJlL1HO6ughcdJoVEsJt4
 hamgVumAlUbj295hZ78IJAHOMWhhgCdRWC8Cke9Dn/oCgS0yVQlI8kMOB7Z07mxYVn9DUkV
 i0vd2kL4uGs0pesEALvcw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3+Y3R/Py9FM=:/HhIKMbyTc878/zueFNP92
 YHImDMCyZRt/+7ZeyYXvIXuq0VVySP1eU5CaFkDFK1MewxaZZhbdNMAsUMZ9SkNTQw/QH/ebH
 3orPGWTUgiWfNzNCo/1Zhf6Ntr9GJvTCCPgSMFlsaqR1To3wMrWPmtqQq6W7iHDhxI5RI+dbF
 MSeGPDQ2M5ptjf80mFt+K2uAckqg58aEx2L3WZEE4aVY5LZaHwtEA8YCEo/awsiZVgjE3EIXj
 l9MOZ5JxmmJcrCejoF84Fv5jwwS+avwOC/rhhm2MSb3Hyry6WwHvN4FrnJ8bKlXAe1XltgOSy
 jTPVENsE5pSCG2l4dJSXEZi9roiSCMj0iBspKa77VevbBvS0JsFcVzNomN37lrelWpz08J5a6
 fR2TQ7lmB5tqBqdxsJn+d/Tjm9aX3vtcEjCmzevC8qaUhLNml8eodl9cpyyVLVqO5UIc3Vrh/
 vOLH/UtHJyUlmMdxvrt9E8F1pxYpi4ICG1exFzEJmsq/Oo9E9lVYwfe15dKM13q7bl96gPcV8
 HCGWlugqsNPZCyTEuRjOcw9PQL5j3FuFLERhUGLUvcg42MxgmfGia1JyplooV5EeWFUSTAKi0
 cm1/v7c24rDp4Sp8xy3Z0N34I+WW0156FRN6tdFLyrJoInt+ofNWnPlba8YNoEU19CInN+kGA
 wxRv4nHtCLS3OqPmaJ8rOm2gbWzuhlaXTKjzLufva9e5M6bw1byRnpIpxUeKiUWfVk96dRFSH
 7fgg3CWtEnIb9HKxehmjavuLrktYVVxHrU4cadXch/0M8IC1foAy8IiK0E2quYO4oaIKqxeIy
 Z2/N9Z1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 17 Dec 2016, Kyle J. McKay wrote:

> Since 6b4b013f18 (mailinfo: handle in-body header continuations,
> 2016-09-20, v2.11.0) mailinfo.c has contained new code with an
> assert of the form:
> 
> 	assert(call_a_function(...))
> 
> The function in question, check_header, has side effects.  This
> means that when NDEBUG is defined during a release build the
> function call is omitted entirely, the side effects do not
> take place and tests (fortunately) start failing.
> 
> Move the function call outside of the assert and assert on
> the result of the function call instead so that the code
> still works properly in a release build and passes the tests.
> 
> Signed-off-by: Kyle J. McKay <mackyle@gmail.com>

ACK. I noticed this problem (and fixed it independently as a part of a
huge patch series I did not get around to submit yet) while trying to get
Git to build correctly with Visual C.

Ciao,
Dscho
