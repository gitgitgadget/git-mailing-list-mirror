Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F0DB211B4
	for <e@80x24.org>; Mon, 14 Jan 2019 16:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfANQJw convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 14 Jan 2019 11:09:52 -0500
Received: from elephants.elehost.com ([216.66.27.132]:11266 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfANQJv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 11:09:51 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x0EG9mHo078335
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 14 Jan 2019 11:09:49 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "=?UTF-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>
Cc:     <git@vger.kernel.org>
References: <002601d4ac18$83d4a210$8b7de630$@nexbridge.com> <87tvib46kr.fsf@evledraar.gmail.com>
In-Reply-To: <87tvib46kr.fsf@evledraar.gmail.com>
Subject: RE: [Possible Bug] Commit generates GC repack failure
Date:   Mon, 14 Jan 2019 11:09:41 -0500
Message-ID: <003601d4ac23$91ff2f80$b5fd8e80$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKQVlHavKXbVXaOWziyBXTnRfoDkQFjLzszpCx8oHA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 14, 2019 10:12, Ævar Arnfjörð Bjarmason wrote:
> On Mon, Jan 14 2019, Randall S. Becker wrote:
> 
> > Hi All,
> >
> > I'm trying to track down what happened this morning. We had a commit
> > that caused a background gc to occur. What happened was:
> >
> > $ git commit -m "history commit ... "
> > Auto packing the repository in background for optimum performance.
> > See "git help gc" for manual housekeeping.
> > warning: The last gc run reported the following. Please correct the
> > root cause and remove .git/gc.log.
> > Automatic cleanup will not be performed until the file is removed.
> >
> > fatal: open /dev/null failed: Invalid function argument
> > fatal: failed to run repack
> >
> > Obviously the /dev/null open was not right, but I don't know where
> > this is in the git code to investigate further. Any pointers on where
> > to look would be appreciated. This started happening at  2.20.1 on the
> NonStop platform.
> 
> We use start_command() when gc does run_command_v_opt() of e.g. git-
> repack. See in that file:
> 
>     null_fd = open("/dev/null", O_RDWR | O_CLOEXEC)
> 
> Maybe that sort of code just fails on NonStop?

That line of code works fine on the platform. I tested it in isolation at various OS levels. Let me go back and say that I'm not 100% sure this is new, but may have been there since just before 2.16. Still perplexed recognizing that that is the only point in git code where that can happen.

Cheers,
Randall

