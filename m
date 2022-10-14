Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A1AC4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 20:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiJNUDn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 16:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJNUDl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 16:03:41 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021AF1D0D4D
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 13:03:40 -0700 (PDT)
Received: (qmail 15157 invoked by uid 109); 14 Oct 2022 20:03:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Oct 2022 20:03:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2115 invoked by uid 111); 14 Oct 2022 20:03:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Oct 2022 16:03:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Oct 2022 16:03:39 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 03/10] run-command API: add and use a run_command_l_opt()
Message-ID: <Y0nAm4+KL71vyYB8@coredump.intra.peff.net>
References: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com>
 <patch-03.10-fd81d44f221-20221014T153426Z-avarab@gmail.com>
 <xmqqtu468d0k.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtu468d0k.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 14, 2022 at 11:40:27AM -0700, Junio C Hamano wrote:

> > @@ -862,11 +858,11 @@ static void write_refspec_config(const char *src_ref_prefix,
> >  
> >  static void dissociate_from_references(void)
> >  {
> > -	static const char* argv[] = { "repack", "-a", "-d", NULL };
> 
> Good to see that this one in a wrong scope can now go away.

It definitely is broader scope than is necessary. I wonder if it makes
things easier to read, though, the way we would sometimes hoist things
out of a function into a static-global to make them more obvious. I
dunno.

> >  	char *alternates = git_pathdup("objects/info/alternates");
> >  
> >  	if (!access(alternates, F_OK)) {
> > -		if (run_command_v_opt(argv, RUN_GIT_CMD|RUN_COMMAND_NO_STDIN))
> > +		if (run_command_l_opt(RUN_GIT_CMD|RUN_COMMAND_NO_STDIN,
> > +				      "repack",  "-a", "-d", NULL))
> >  			die(_("cannot repack to clean up"));

I just happened to notice in this one there is a weird extra space
before "-a".

-Peff
