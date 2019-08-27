Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C355A1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 18:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfH0SIJ convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 27 Aug 2019 14:08:09 -0400
Received: from elephants.elehost.com ([216.66.27.132]:53639 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfH0SIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 14:08:09 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id x7RI833B089776
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 27 Aug 2019 14:08:03 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Matheus Tavares Bernardino'" <matheus.bernardino@usp.br>,
        "'Giuseppe Crino''" <giuscri@gmail.com>
Cc:     "'git'" <git@vger.kernel.org>
References: <20190827162725.GA29263@instance-template-2.europe-west6-a.c.vaulted-journal-250706.internal> <CAHd-oW6MtoYAwv36_Jsx5qQzvLguXdvrA6NRA+D3ayHGmfVSqw@mail.gmail.com>
In-Reply-To: <CAHd-oW6MtoYAwv36_Jsx5qQzvLguXdvrA6NRA+D3ayHGmfVSqw@mail.gmail.com>
Subject: RE: How to build to debug with gdb?
Date:   Tue, 27 Aug 2019 14:07:57 -0400
Message-ID: <018f01d55d02$5e89e1f0$1b9da5d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQKGl7gichNm/SI1hdluiFjdgqZSsQHOC4wopZ5i3hA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 27, 2019 1:56 PM, Matheus Tavares Bernardino wrote:
> On Tue, Aug 27, 2019 at 1:27 PM Giuseppe Crino' <giuscri@gmail.com>
> wrote:
> > Hello, to debug some issues I built and installed git via
> >
> > $ make prefix=/usr/local DEVELOPER=1 CFLAGS="-O0 -g"
> > $ sudo make install
> > $ git --version # git version 2.23.0.40.g4d8aada92f
> 
> Hmm, could it be perhaps that CFLAGS is being overwritten? To debug Git
> with GDB I always add this to my config.mak file:
> 
> CFLAGS += -g3 -O0
> LDFLAGS += -g3 -O0
> 
> And then just compile with `make`. Maybe give it a try?
> 
> > But it seems there's still some optimization going on that prevents gdb
> from working correctly.
> >
> > For example
> >
> > (gdb) b builtin/config.c:752
> > Breakpoint 1 at 0x43942: file builtin/config.c, line 752.
> > (gdb) r config --global --edit
> > Starting program: /usr/local/bin/git config --global --edit [Thread
> > debugging using libthread_db enabled] Using host libthread_db library
> > "/lib/x86_64-linux-gnu/libth read_db.so.1".
> >
> > Breakpoint 1, cmd_config (argc=0, argv=<optimized out>,
> >     prefix=<optimized out>) at builtin/config.c:753
> >     753                             if (fd >= 0) {
> >     (gdb) p fd
> >     $1 = <optimized out>
> >
> >  What am I missing?

Given that you are 40 commits in from 2.23.0, is it possible that you have compiled a few objects, like main, using the old CFLAGS? Gdb is notorious for not showing symbols if main does not have it. Have you done a git clean -dxf before building with the new CFLAGS?

Just a thought.

Randall

