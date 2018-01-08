Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD23C1FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 17:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753041AbeAHRo7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 12:44:59 -0500
Received: from elephants.elehost.com ([216.66.27.132]:13848 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752769AbeAHRo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 12:44:58 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w08Hinj1074540
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 8 Jan 2018 12:44:49 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'brian m. carlson'" <sandals@crustytoothpaste.net>
Cc:     "'git mailing list'" <git@vger.kernel.org>
References: <000d01d387fa$36a65300$a3f2f900$@nexbridge.com> <20180107211829.GA5946@genre.crustytoothpaste.net>
In-Reply-To: <20180107211829.GA5946@genre.crustytoothpaste.net>
Subject: RE: Request for Assist on Limits for Tests
Date:   Mon, 8 Jan 2018 12:44:43 -0500
Message-ID: <005401d388a8$60f81270$22e83750$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIsqlOQw1sRkxQ946AH+2ZXuTJILgFHBPsGoq2/n4A=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 7, 2018 4:18 PM, brian m. Carlson wrote:
> On Sun, Jan 07, 2018 at 03:57:59PM -0500, Randall S. Becker wrote:
> > I'm looking for a proper (i.e. not sneaky) way to detect the platform
> > I am on during testing so that some tests can be modified/skipped
> > other than using the standard set of dependencies. In particular, the
> > maximum path on current NonStop platforms is 8-bit 2048 bytes. It
> > appears that there are some tests - at least from my preliminary
> > "guessing" - that are beyond that limit once all of the path segments
> > are put together. I would rather have something in git that specifies
> > a path size limit so nothing exceeds it, but that may be wishing.
> 
> The way we usually skip tests automatically is with a test prerequisite.
> You might look at t/test-lib.sh for the test_set_prereq and
test_lazy_prereq
> calls and synthesize one (maybe LONG_PATHS) that meets your needs.  You
> can then annotate those tests with the appropriate prerequisite.
> 
> I expect that for long paths, you will hit a lot of the same issues as
occur on
> Windows, where PATH_MAX may be very small.  It might be valuable to
> expose this information as a build option and then set an appropriate
> variable in t/test-lib.sh.

Where I am, at this point: I have PATH_MAX defined in Makefile as optional
and which can be specified as a number in config.mak.uname. If provided, it
adds -DPATH_MAX to BASIC_CFLAGS, which will ensure consistency with limits.h
(if the values are different, at least c99 warns about it). I've also got it
into GIT-BUILD-OPTIONS, if defined. From there it seems straight-forward to
use it in test scripts using standard shell scripting, however, I can't find
a good model/function for what would be a prerequisite check consistent with
existing git test methods - you know, clarity. One approach I have been
pursuing is to use test_set_prereq if PATH_MAX is defined, and add a new
method like test_missing_prereq_eval that would take PATH_MAX and an
expression, like -le 2048, to cause a test to be skipped if the variable is
defined but the evaluation fails. I'm still having noodling through trying
to make that work, and if anyone has a better idea (please have a better
idea!!), please please suggest it.

Cheers,
Randall

-- Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)/NonStop(211288444200000000)
-- In my real life, I talk too much.



