Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61F871F453
	for <e@80x24.org>; Mon, 11 Feb 2019 21:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfBKVs0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 16:48:26 -0500
Received: from elephants.elehost.com ([216.66.27.132]:60942 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbfBKVsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 16:48:25 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1BLmMw7002896
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 11 Feb 2019 16:48:23 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Duy Nguyen'" <pclouds@gmail.com>
Cc:     "'Git Mailing List'" <git@vger.kernel.org>
References: <000801d4c174$05b76860$11263920$@nexbridge.com>     <CACsJy8Bn+2zY6y_QqCjbB3qWM-F=3d0H5vgWj4az=md2FZ8RhA@mail.gmail.com> <xmqqftsughks.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqftsughks.fsf@gitster-ct.c.googlers.com>
Subject: RE: [Breakage] 2.20.0-rc0 t1404: test_i18ngrep reports 1 instead of 0 on NonStop in one case
Date:   Mon, 11 Feb 2019 16:48:16 -0500
Message-ID: <003601d4c253$8208dcc0$861a9640$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQNDD1TD3hXIgmvW3x+/7VSnrDKF3gHnalkaAbpdw+Gi4Xlh8A==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 11, 2019 16:07, Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
> 
> > On Mon, Feb 11, 2019 at 2:09 AM Randall S. Becker
> > <rsbecker@nexbridge.com> wrote:
> >>
> >> Hi All,
> >>
> >> I tracked down a breakage in t1404 subtest 52. The line
> >>
> >> test_i18ngrep "Unable to create $Q.*packed-refs.lock$Q: File exists"
> >> err
> >
> > The message does not match, does it? Here we grep for "File exists"
> > but the message you showed says "File already exists".
> 
> Hmph, this is from strerror(), right?

You can reasonably expect that NonStop error messages deviate occasionally.
Scaping from strerror() is not a good plan. A worse plan is to use errno
values, which I can guarantee do not match, but that's just an FYI.

> The question is if we should be using grep to match on strerror() result
in the
> C locale.  Do we really care that the reason of the failure is due to
EEXIST for
> this particular test?
> 
> >> The verbose output, with diagnostics, is:
> >>
> >> error: 'grep Unable to create '.*packed-refs.lock': File exists err'
> >> didn't find a match in:
> >> error: Unable to create '/home/git/git/t/trash
> >> directory.t1404-update-ref-errors/.git/packed-refs.lock': File
> >> already exists.
> 
> Otherwise, perhaps we should loosen the grep pattern, not as a part of
> "NonStop fix" topic, but as "tests should not depend on having a canonical
> spelling of strerror() result even in C locale" topic.

I'm happy not to have the fix I supplied used if there's a better way.


