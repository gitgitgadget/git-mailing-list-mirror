Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7989F1F62E
	for <e@80x24.org>; Mon, 14 Jan 2019 23:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfANXlP convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 14 Jan 2019 18:41:15 -0500
Received: from elephants.elehost.com ([216.66.27.132]:39175 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfANXlP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 18:41:15 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x0ENf9bZ037510
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 14 Jan 2019 18:41:09 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Duy Nguyen'" <pclouds@gmail.com>
Cc:     "'Git Mailing List'" <git@vger.kernel.org>,
        <jojo@schmitz-digital.de>, <mike_kilpatrick@nskopensource.com>
Subject: RE: [Not Git Bug] Commit generates GC repack failure
Date:   Mon, 14 Jan 2019 18:41:01 -0500
Message-ID: <000c01d4ac62$9f1c9510$dd55bf30$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdSsYomEO+XNr8HYS02n83nNOBpGnw==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 14, 2019 10:07, Duy Nguyen wrote:
> To: Randall S. Becker <rsbecker@nexbridge.com>
> Cc: Git Mailing List <git@vger.kernel.org>
> Subject: Re: [Possible Bug] Commit generates GC repack failure
> 
> On Mon, Jan 14, 2019 at 10:03 PM Duy Nguyen <pclouds@gmail.com>
> wrote:
> >
> > On Mon, Jan 14, 2019 at 9:51 PM Randall S. Becker
> > <rsbecker@nexbridge.com> wrote:
> > >
> > > Hi All,
> > >
> > > I'm trying to track down what happened this morning. We had a commit
> > > that caused a background gc to occur. What happened was:
> > >
> > > $ git commit -m "history commit ... "
> > > Auto packing the repository in background for optimum performance.
> > > See "git help gc" for manual housekeeping.
> > > warning: The last gc run reported the following. Please correct the
> > > root cause and remove .git/gc.log.
> > > Automatic cleanup will not be performed until the file is removed.
> > >
> > > fatal: open /dev/null failed: Invalid function argument
> >
> > sanitize_stdfds() in setup.c can attempt to open /dev/null then
> > redirect stdout and stderr to it. I think this is part of the
> > daemonization that is done in background gc.
> 
> However the message does not match. I think you will find this "open
> /dev/null failed" line in run-command.c

Mystery solved. The problem seems to occur with garbage collection on older versions of the operating system than the one we built 2.20.1 on. We sent out the advice to revert to 2.16.2, which was built on a prior revision that did not introduce incompatibilities. This was a specific situation with header files on a new version of the OS that introduced incompatibilities. The impact was not limited to the line in run-command.c, but was way more extensive.

Thanks for the help,

Randall

