Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A73B1F453
	for <e@80x24.org>; Tue, 19 Feb 2019 20:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfBSUyM (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 15:54:12 -0500
Received: from elephants.elehost.com ([216.66.27.132]:24717 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfBSUyM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 15:54:12 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x1JKs0p2063517
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 Feb 2019 15:54:01 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Max Kirillov'" <max@max630.net>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>,
        "=?iso-8859-1?Q?'SZEDER_G=E1bor'?=" <szeder.dev@gmail.com>,
        <git@vger.kernel.org>
References: <001201d4c617$de429540$9ac7bfc0$@nexbridge.com> <xmqqftsn4nik.fsf@gitster-ct.c.googlers.com> <000001d4c624$da8e05d0$8faa1170$@nexbridge.com> <xmqq5ztj4l3j.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1902182008270.45@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1902182249140.45@tvgsbejvaqbjf.bet> <20190219201536.GA2354@jessie.local>
In-Reply-To: <20190219201536.GA2354@jessie.local>
Subject: RE: [ANNOUNCE] Git v2.21.0-rc1 (NonStop Results) - Good News
Date:   Tue, 19 Feb 2019 15:53:53 -0500
Message-ID: <010e01d4c895$3c997800$b5cc6800$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFycQzmW9pNbu02MZcMspejNiBnQQDz28D8AaU7wHUB79R99QIiKXPzAibawYMCKTnR7KZUbdTg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 19, 2019 15:16, Max Kirillov <max@max630.net> wrote:
> On Mon, Feb 18, 2019 at 10:57:13PM +0100, Johannes Schindelin wrote:
> > I have to take that assessment back. So sad.
> >
> > After that build, I cherry-picked the commit on top of shears/pu
> > (which is Git for Windows' ever-green branch that continuously rebases
> > Git for Windows' `master` onto git.git's `pu`), and the build seems to
hang
> again:
> >
> > https://dev.azure.com/git-for-windows/git/_build/results?buildId=31291
> 
> Hi.
> 
> You seem to be talking about the hang like it's some old thing, I probably
> have missed some earlier discussion. I have not heard before that it hangs
on
> linux. The 60 seconds hang because of lost SIGCHILD is not it. Also the
hang
> observed at NonStop is not it as well since the no-reuse hack did not help
> (though numbered output files probably would be more sure to avoid
> duplications expecially at Windows where you cannot just unlink busy file
and
> reuse its place in directory)
> 
> >From the tasks you have posted there seem to be no details
> available. The test is not reported as completed, and the overall build
fails,
> and there seem to no additional data except the log available.
> 
> Have you or somebody else been investigating it or is there otherwise any
> information about those hangs?

The no-reuse hack made a big different
(https://public-inbox.org/git/20181124093719.10705-1-max@max630.net/) in
conjunction with replacing </dev/zero with </dev/null. It was the sleep
hack, and generate_zero_bytes that had no effect. I previously supplied a
multi-run result. Please refer to that fix/test for reference, which I paste
below:

On February 16, 2019 13:06, Junio C Hamano wrote:
> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> > On February 16, 2019 3:27, Max Kirillov wrote:
> >> What you could try is
> >> https://public-inbox.org/git/20181124093719.10705-1-
> max@max630.net/
> >> (I'm not sure it would not conflict by now), this would remove 
> >> dependency between tests. If it helps it would be very valuable
> information.
> >
> > Good news. This patch does seem to do the trick. I wonder whether 
> > this fixes the Azure build also.
> >
> > I have run the test under the following conditions:
> > Run 1 (system idle): Pass
> > Run 2 (system idle): Pass
> > Run 3 (system idle): Pass
> > Run 4 (system idle): Pass
> > Run 5 (system idle): Pass
> > Run 6 (system mild load, heavy file system): Pass Run 7 (system mild 
> > load, moderate file system load - git fetch): Pass Run 8 (heavy 
> > system load, heavy file system load): Pass Run 9 (--verbose, heavy 
> > system load, heavy file system load): Pass Run 10 (GIT_TRACE=true, 
> > --verbose, heavy system load, heavy file system
> > load): Pass
> > Run 11 (very heavy system load, very heavy file system load): Pass
> 
> That indeed is a good news.
> 
> > The current condition of the code is (the generate_zero_bytes delete 
> > was previously removed so can be ignored for the patch):
> 
> Just to make sure I do not misunderstand, this result is with Max's 
> patch but without the generate_zero_bytes stuff?

Correct.



