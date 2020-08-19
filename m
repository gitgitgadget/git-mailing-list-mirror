Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF46EC433DF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 21:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD5A4207FF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 21:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgHSV4g convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 19 Aug 2020 17:56:36 -0400
Received: from elephants.elehost.com ([216.66.27.132]:54300 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgHSV4g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 17:56:36 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [173.32.57.223])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 07JLuNcl036941
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 19 Aug 2020 17:56:24 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Lukas Straub'" <lukasstraub2@web.de>,
        "'git'" <git@vger.kernel.org>,
        "'Elijah Newren'" <newren@gmail.com>,
        "'Brandon Williams'" <bwilliams.eng@gmail.com>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>
References: <cover.1597853634.git.lukasstraub2@web.de> <xmqqr1s2tswd.fsf@gitster.c.googlers.com> <04aa01d67659$2dc217b0$89464710$@nexbridge.com> <xmqqimdetpuw.fsf@gitster.c.googlers.com> <20200819201736.GA2511157@coredump.intra.peff.net> <xmqqa6yqtm03.fsf@gitster.c.googlers.com> <20200819203825.GA2511902@coredump.intra.peff.net>
In-Reply-To: <20200819203825.GA2511902@coredump.intra.peff.net>
Subject: RE: [RFC PATCH 0/2] Allow adding .git files and directories
Date:   Wed, 19 Aug 2020 17:56:18 -0400
Message-ID: <04e401d67673$94c47d30$be4d7790$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJUwsi1t0kYcCu+MG1WzKjrMbhjgQKo5EueAejmVwAB/vjPsAIQdRDrAko2jCYCkm7cHKfXcgiw
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On August 19, 2020 4:38 PM, Jeff King wrote:
> On Wed, Aug 19, 2020 at 01:32:28PM -0700, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> >
> > > It _could_ still be useful in a more isolated environment (e.g.,
> > > your company server that is serving only internal repos to
> > > employees). But I have misgivings about a feature that lets people
> > > intentionally create repositories whose history cannot ever interact
> > > with other users who haven't set a special config flag. It's one
> > > thing to say "to take advantage of this feature, we must all agree
> > > to have version X, or set flag Y". But it's another to bake that
> > > restriction into the repository history for all time.
> >
> > If people want a pre-prepared repository propagated to CI environment
> > and keep trakc of the state of such repository over time, for example,
> > they can use (versioned) tarballs.  Such a tarball won't automatically
> > get extracted after "git pull" (which is a feature), but those who
> > want such a pre-prepared repository for CI can make the extraction
> > step as a part of their CI build procedure.
> 
> Yeah, I almost went into more detail there. There are lots of solutions that
> make accessing an embedded sub-repository only one command away for
> the person who clones. :)  Some others are:
> 
>   - just call it "foo.git", and "mv foo.git .git" solves it (you'd
>     probably want to "git checkout -f" after that, but even if it were
>     embedded it seems silly to hold the data in two separate formats
>     anyway
> 
>   - just hold a bare repository ("foo.git") and then clone it

That is a reasonable approach that will not get you ping'd on the CVE database for someone who wants to do this, which is a key concern of mine.

> etc. I think this is really a solution in search of a problem.


