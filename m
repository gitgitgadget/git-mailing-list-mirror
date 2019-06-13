Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C6281F462
	for <e@80x24.org>; Thu, 13 Jun 2019 22:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbfFMWq1 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 13 Jun 2019 18:46:27 -0400
Received: from elephants.elehost.com ([216.66.27.132]:62294 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFMWq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 18:46:27 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x5DMkHal081039
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 13 Jun 2019 18:46:18 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>, <randall.s.becker@rogers.com>
Cc:     <git@vger.kernel.org>
References: <20190613185313.16120-1-randall.s.becker@rogers.com> <20190613190644.GC27217@sigill.intra.peff.net> <000101d5221e$88aa67d0$99ff3770$@nexbridge.com>
In-Reply-To: <000101d5221e$88aa67d0$99ff3770$@nexbridge.com>
Subject: RE: [Patch 0/5] Add exclusions for tests requiring cvs where cvs is not installed
Date:   Thu, 13 Jun 2019 18:46:10 -0400
Message-ID: <001b01d52239$cefaa270$6cefe750$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMHvzyDluE9P4st0JpJQ4fnzjC8uAE6c9KmAsZ1DLCkFO1HIA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 13, 2019 3:31 PM, I wrote:
> On June 13, 2019 3:07 PM, Peff wrote:
> > On Thu, Jun 13, 2019 at 02:53:08PM -0400, randall.s.becker@rogers.com
> > wrote:
> >
> > > From: "Randall S. Becker" <rsbecker@nexbridge.com>
> > >
> > > t9600 to t9604 currently depend on cvs to function correctly,
> > > otherwise all of those tests fail. This patch follows an existing
> > > pattern of from the t9400 series by attempting to run cvs without
> > > arguments, which succeeds if installed, and skipping the test if the
> > > command fails.
> >
> > Hrm. I don't have cvs installed, and those tests are properly skipped for me.
> > That's because they include lib-cvs.sh, which has:
> >
> >   if ! type cvs >/dev/null 2>&1
> >   then
> >           skip_all='skipping cvsimport tests, cvs not found'
> >           test_done
> >   fi
> >
> > Why doesn't that work for you? Does the "type" check not work (e.g.,
> > you have something called "cvs" but it does not behave as we expect)?
> > If so, then it sounds like we just need to harmonize that with the other
> checks.
> >
> > It also sounds like the t9400 tests could be using lib-cvs to avoid
> > duplicating logic, though it might need some refactoring (they don't
> > need cvsps, for example).
> 
> The t9400 tests use the same technique as I used - and I mistakenly trusted it.
> The type check does not fail.
> 
> if ! type cvs >/dev/null 2>&1
> then
> 	echo "oops"
> fi
> 
> does not print "oops". type is reporting $?=0 and a legitimate file in
> /usr/local/bin/cvs. Confusingly, t9400 skips, but type reports a valid path. I
> think the test done in the t9400 series is not correct.
> 
> cvs >/dev/null 2>&1 on the platform causes $?=255, while a blah >/dev/null
> 2>&1 reports $?=127.
> 
> There is something else going on causing the cvs-related tests to fail that this
> patch might be hiding. We do have cvsps so I'm now much more confused by
> the whole thing.
> 
> Let's drop this patch for now. I was premature on this patch and need to dig
> deeper as to what is going on.

We do not need the patch. The situation was caused by an old version of CVS (pre 1.11)  that was causing t9600... to fail. The message was buried under --verbose. I ported CVS 1.11.23 and CVS tests are now working. My bad.

Cheers,
Randall


