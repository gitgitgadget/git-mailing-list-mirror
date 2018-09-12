Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09CBA1F404
	for <e@80x24.org>; Wed, 12 Sep 2018 22:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbeIMD0o convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 12 Sep 2018 23:26:44 -0400
Received: from elephants.elehost.com ([216.66.27.132]:46887 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbeIMD0o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 23:26:44 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w8CMK87n015984
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 12 Sep 2018 18:20:08 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Johannes Sixt'" <j6t@kdbg.org>
Cc:     <git@vger.kernel.org>
References: <003901d44acd$12c2bb90$384832b0$@nexbridge.com> <4102803b-d5de-5812-4cef-569c9869fed1@kdbg.org> <004e01d44ada$b4a11ad0$1de35070$@nexbridge.com>
In-Reply-To: <004e01d44ada$b4a11ad0$1de35070$@nexbridge.com>
Subject: RE: [Question] Signature calculation ignoring parts of binary files
Date:   Wed, 12 Sep 2018 18:20:00 -0400
Message-ID: <000001d44ae6$c2a20ac0$47e62040$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQL1dHr/8n7yCB9UeIXEGLjm31C4owFRfwXbAhcuk1Gij501AA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On September 12, 2018 4:54 PM, I wrote:
> On September 12, 2018 4:48 PM, Johannes Sixt wrote:
> > Am 12.09.18 um 21:16 schrieb Randall S. Becker:
> > > I feel really bad asking this, and I should know the answer, and yet.
> > >
> > > I have a binary file that needs to go into a repo intact (unchanged).
> > > I also have a program that interprets the contents, like a textconv,
> > > that can output the relevant portions of the file in whatever format
> > > I like - used for diff typically, dumps in 1K chunks by file section.
> > > What I'm looking for is to have the SHA1 signature calculated with
> > > just the relevant portions of the file so that two actually
> > > different files will be considered the same by git during a commit
> > > or status. In real terms, I'm trying to ignore the Creator metadata
> > > of a JPG because it is mutable and irrelevant to my repo contents.
> > >
> > > I'm sorry to ask, but I thought this was in .gitattributes but I
> > > can't confirm the SHA1 behaviour.
> >
> > You are looking for a clean filter. See the 'filter' attribute in gitattributes(5).
> > Your clean filter program or script should strip the unwanted metadata
> > or set it to a constant known-good value.
> >
> > (You shouldn't need a smudge filter.)
> >
> > -- Hannes
> 
> Thanks Hannes. I thought about the clean filter, but I don't actually want to
> modify the file when going into git, just for SHA calculation. I need to be able
> to keep some origin metadata that might change with subsequent copies, so
> just cleaning the origin is not going to work - actually knowing the original
> author is important to our process. My objective is to keep the original file
> 100% exact as supplied and then ignore any changes to the metadata that I
> don't care about (like Creator) if the remainder of the file is the same.

I had a thought that might be workable, opinions are welcome on this.

The commit of my rather weird project is done by a script so I have flexibility in my approach. What I could do is set up a diff textconv configuration so that the text diff of the two JPG files will show no differences if the immutable fields and the image are the same. I can then trigger a git add and git commit for only those files where git diff reports no differences. That way the actual original file is stored in git with 100% fidelity (no cleaning). It's not as elegant as I'd like, but it does solve what I'm trying to do. Does this sound reasonable and/or is there a better way?

Cheers,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



