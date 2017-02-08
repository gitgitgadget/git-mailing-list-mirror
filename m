Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 305701FCC7
	for <e@80x24.org>; Wed,  8 Feb 2017 08:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753856AbdBHIY6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 03:24:58 -0500
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:54504 "EHLO
        homiemail-a11.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753813AbdBHIY5 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 8 Feb 2017 03:24:57 -0500
Received: from homiemail-a11.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a11.g.dreamhost.com (Postfix) with ESMTP id 91691314C069;
        Wed,  8 Feb 2017 00:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:cc:date:in-reply-to:references:content-type
        :mime-version:content-transfer-encoding; s=novalis.org; bh=3UDCu
        TCE253BpKjEd4aq6N7zfeU=; b=YlKBngSjZulSYvfDyUj3qCr56z10YceMTjISc
        d1aNC43i7fEaHXWNQSb/wnwfl2PXN/zDG5qfmsnUUH2acpzVIb7UOPmecCmpKLEW
        rZp/1bYlJcQroqANz+9iY22s1wTj+V+nr9s91XxsozAbhAV9dl7Pd3daK4QAVj2S
        YoNRMQ=
Received: from [192.168.0.3] (207-38-252-131.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.252.131])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a11.g.dreamhost.com (Postfix) with ESMTPSA id F126A314C066;
        Wed,  8 Feb 2017 00:24:55 -0800 (PST)
Message-ID: <1486542299.1938.47.camel@novalis.org>
Subject: Re: "disabling bitmap writing, as some objects are not being
 packed"?
From:   David Turner <novalis@novalis.org>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Date:   Wed, 08 Feb 2017 03:24:59 -0500
In-Reply-To: <CACsJy8C81+D=UG4pZ4e+URQqKRCPG=5bLiCHbGCQamvE-2y2MQ@mail.gmail.com>
References: <1481922331.28176.11.camel@frank>
         <xmqqpokrr2cf.fsf@gitster.mtv.corp.google.com>
         <CACsJy8ACy+Hv1Z3FgG-WFBozwWqmMuN-JnMWF-+rdpF0knFjqg@mail.gmail.com>
         <1486515795.1938.45.camel@novalis.org>
         <CACsJy8C81+D=UG4pZ4e+URQqKRCPG=5bLiCHbGCQamvE-2y2MQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2017-02-08 at 13:45 +0700, Duy Nguyen wrote:
> On Wed, Feb 8, 2017 at 8:03 AM, David Turner <novalis@novalis.org> wrote:
> > On Sat, 2016-12-17 at 14:50 +0700, Duy Nguyen wrote:
> >> And we can't grep for fatal errors anyway. The problem that led to
> >> 329e6e8794 was this line
> >>
> >>     warning: There are too many unreachable loose objects; run 'git
> >> prune' to remove them.
> >>
> >> which is not fatal.
> >
> > So, speaking of that message, I noticed that our git servers were
> > getting slow again and found that message in gc.log.
> >
> > I propose to make auto gc not write that message either. Any objections?
> 
> Does that really help? auto gc would run more often, but unreachable
> loose objects are still present and potentially make your servers
> slow? Should these servers run periodic and explicit gc/prune?

At least pack files wouldn't accumulate.  This is the major cause of
slowdown, since each pack file must be checked for each object.

(And, also, maybe those unreachable loose objects are too new to get
gc'd, but if we retry next week, we'll gc them).


