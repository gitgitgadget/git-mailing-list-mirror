Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFC5B1F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 13:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbfACNT6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 08:19:58 -0500
Received: from fed1rmfepo102.cox.net ([68.230.241.144]:36880 "EHLO
        fed1rmfepo102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbfACNT6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 08:19:58 -0500
Received: from fed1rmimpo306.cox.net ([68.230.241.174])
          by fed1rmfepo102.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20190103131957.VKRO12708.fed1rmfepo102.cox.net@fed1rmimpo306.cox.net>
          for <git@vger.kernel.org>; Thu, 3 Jan 2019 08:19:57 -0500
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id D608AB82571;
        Thu,  3 Jan 2019 06:19:56 -0700 (MST)
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090207.5C2E0BFD.003C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=e8qytph/ c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=kj9zAlcOel0A:10 a=3JhidrIBZZsA:10 a=aXbRJEjTf9OWfr_QpdoA:9 a=CjuIK1q_8ugA:10
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
From:   "Stephen P. Smith" <ischis2@cox.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/3] Add 'human' date format
Date:   Thu, 03 Jan 2019 06:19:56 -0700
Message-ID: <2637944.PqRbksyA0G@thunderbird>
Organization: Personal
In-Reply-To: <20190103073735.GB24925@sigill.intra.peff.net>
References: <20181231003150.8031-1-ischis2@cox.net> <20181231003150.8031-2-ischis2@cox.net> <20190103073735.GB24925@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday, January 3, 2019 12:37:35 AM MST Jeff King wrote:
> I like the idea of "human", and I like the idea of "auto", but it seems
> to me that these are really two orthogonal things. E.g., might some
> people not want to do something like:
> 
>   git config log.date auto:relative
I didn't see anything in the code which would prohibit setting something like 
that.  

> 
> I don't personally care about using this myself, but we already had to
> deal with retrofitting "local" as a modifier. I'd prefer to avoid making
> the same mistake again.
Since I wasn't involved could you summarize the you are referring to?

> 
> (I'd actually argue that "log.date" should basically _always_ have the
> "auto" behavior, since it tends to get treated as plumbing anyway, and I
> suspect that anybody who sets log.date now would see subtle breakage
> from scripts. But maybe it's too late at this point?).
If auto isn't added to the "log.date" file, then the date behaviour is not 
changed from is currently in the code base.   Therefore, there shouldn't be 
any breakage.
> 
> > diff --git a/builtin/blame.c b/builtin/blame.c
> > index 6d798f9939..f684e31d82 100644
> > --- a/builtin/blame.c
> > +++ b/builtin/blame.c
> > @@ -925,6 +925,10 @@ int cmd_blame(int argc, const char **argv, const char
> > *prefix)> 
> >  		 */
> >  		
> >  		blame_date_width = utf8_strwidth(_("4 years, 11 months ago")) + 1; /*
> >  		add the null */ break;
> > 
> > +	case DATE_HUMAN:
> > +		/* If the year is shown, no time is shown */
> > +		blame_date_width = sizeof("Thu Oct 19 16:00");
> > +		break;
> 
> OK, and we expect the year to be less than 5 characters. I briefly
> wondered what would happen at Y100K (or somebody maliciously using a
> bogus year), but it is not a buffer overflow. It is simply a mis-aligned
> blame line (and actually, the same goes for the existing entries, which
> use a 4-digit year).
> 
> -Peff




