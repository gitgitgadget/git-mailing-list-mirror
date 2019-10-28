Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAA301F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 14:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389993AbfJ1OPm (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 10:15:42 -0400
Received: from elephants.elehost.com ([216.66.27.132]:55513 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730033AbfJ1OPl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 10:15:41 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x9SEFb6T085218
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 28 Oct 2019 10:15:38 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>
Cc:     <git@vger.kernel.org>
References: <011f01d58ab6$91fee620$b5fcb260$@nexbridge.com> <nycvar.QRO.7.76.6.1910281405000.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1910281405000.46@tvgsbejvaqbjf.bet>
Subject: RE: [BUG] git 2.24.0-rc1 t0500 on NonStop in Jenkins
Date:   Mon, 28 Oct 2019 10:15:31 -0400
Message-ID: <026401d58d9a$2bbe7600$833b6200$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHPNYlvTp8HvTWaccQRmuAfB7Lx7gHWySK8p24SIKA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On October 28, 2019 9:07 AM, Johannes Schindelin wrote:
> On Thu, 24 Oct 2019, Randall S. Becker wrote:
> > We are running the regression suite (as we always have) in Jenkins and
> > are finding that t0500 is basically a complete failure. I cannot
> > recreate it using bash where we have a real terminal, but without one,
> > the t0500 consistently fails. I wonder whether any other platform is
> > experiencing the same situation.
> 
> This says that a test failed, but it lacks the verbose log, so there is
little else
> left to the willing reader than wild guesses that are almost certainly
> completely missing the culprit.
> 
> In other words: verbose log, please. That is, the output of the test
script
> when run with `-i -v -x` (or `-i -V -x` in which case you will want to
analyze the
> contents of `t/test-results/t0500-progress-display.out` and if that does
not
> help, paste it into a reply).

Here is the verbose output from subtest 2 that failed. Sorry it took so
long, we had to arrange a different Jenkins job to test this in isolation.
Format issue?

Cheers,
Randall

expecting success of 0500.2 'progress display with total': 
	cat >expect <<-\EOF &&
	Working hard:  33% (1/3)<CR>
	Working hard:  66% (2/3)<CR>
	Working hard: 100% (3/3)<CR>
	Working hard: 100% (3/3), done.
	EOF

	cat >in <<-\EOF &&
	progress 1
	progress 2
	progress 3
	EOF
	test-tool progress --total=3 "Working hard" <in 2>stderr &&

	show_cr <stderr >out &&
	test_i18ncmp expect out

+ cat
+ 1> expect 0< /tmp/sh1811939370.4
+ cat
+ 1> in 0< /tmp/sh1811939370.5
+ test-tool progress --total=3 Working hard
+ 0< in 2> stderr
+ show_cr
+ 0< stderr 1> out
+ test_i18ncmp expect out
--- expect	2019-10-28 14:11:40 +0000
+++ out	2019-10-28 14:11:41 +0000
@@ -1,4 +1,2 @@
-Working hard:  33% (1/3)<CR>
-Working hard:  66% (2/3)<CR>
-Working hard: 100% (3/3)<CR>
-Working hard: 100% (3/3), done.
+Working hard:   0% (1/12884901888)<CR>
+Working hard:   0% (3/12884901888), done.
error: last command exited with $?=1
not ok 2 - progress display with total
#	
#		cat >expect <<-\EOF &&
#		Working hard:  33% (1/3)<CR>
#		Working hard:  66% (2/3)<CR>
#		Working hard: 100% (3/3)<CR>
#		Working hard: 100% (3/3), done.
#		EOF
#	
#		cat >in <<-\EOF &&
#		progress 1
#		progress 2
#		progress 3
#		EOF
#		test-tool progress --total=3 "Working hard" <in 2>stderr &&
#	
#		show_cr <stderr >out &&
#		test_i18ncmp expect out
#	

