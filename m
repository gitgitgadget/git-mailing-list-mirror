From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve contrib/diff-highlight to highlight unevenly-sized hunks
Date: Thu, 18 Jun 2015 14:39:36 -0700
Message-ID: <xmqqh9q4d7c7.fsf@gitster.dls.corp.google.com>
References: <1434388853-23915-1-git-send-email-patrick@parcs.ath.cx>
	<xmqqwpz1f22b.fsf@gitster.dls.corp.google.com>
	<CA+C-WL-CC9o13Rxrr+mKw+vbx=aEJmguLnwMwO=fE-JPJ2DqEg@mail.gmail.com>
	<xmqq1th8ga9b.fsf@gitster.dls.corp.google.com>
	<20150618190417.GA12769@peff.net>
	<alpine.DEB.2.20.8.1506181536070.4322@idea>
	<20150618204505.GD14550@peff.net> <20150618212356.GA20271@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Patrick Palka <patrick@parcs.ath.cx>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 18 23:39:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5hXN-0001Ph-Gz
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 23:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945AbbFRVjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 17:39:48 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:33444 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154AbbFRVjj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 17:39:39 -0400
Received: by iebgx4 with SMTP id gx4so63463196ieb.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 14:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=MBEDkzYlEtsb4RrPIdKd6Ev9QpRvWSNbnmjXLmnuPcs=;
        b=o8nP2Km8XGXFYzbK1ypgkJ5rmA68wgQQxUFC7cV2YNdTA8Un2gEkqZi0L0bDWkk4TL
         qUERpzsStcRuKvC8uBQwt3Ge+rL/sxj6u7hxBmBin4PjhnRjv5SutvgmH9tyy2E7pr/V
         cAAPoWqoo7Cf4Pg11MGEjeO8C7CtLidoo6UsGHaK8dshTXosQNGQmCcawPrZni/pzgn8
         E+CIjXO2bVc+X5cCEP8U/kRuFS+QXkLBV82WjREJMa8JHsz90qG158klSbW5KkVaDQdH
         J8NxLaicFPbl9SvMm+uMHU2yaZ+vyrAh7pi6U8OJIwK7oFi/AcdKufXsg4OjGif+9vAF
         LG8Q==
X-Received: by 10.50.7.68 with SMTP id h4mr242040iga.40.1434663578623;
        Thu, 18 Jun 2015 14:39:38 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e04a:861:67b3:9e25])
        by mx.google.com with ESMTPSA id o19sm341958igs.18.2015.06.18.14.39.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jun 2015 14:39:38 -0700 (PDT)
In-Reply-To: <20150618212356.GA20271@peff.net> (Jeff King's message of "Thu,
	18 Jun 2015 17:23:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272082>

Jeff King <peff@peff.net> writes:

> On Thu, Jun 18, 2015 at 04:45:05PM -0400, Jeff King wrote:
>
>> Still, I think this is probably a minority case, and it may be
>> outweighed by the improvements. The "real" solution is to consider the
>> hunk as a whole and do an LCS diff on it, which would show that yes,
>> it's worth highlighting both of those spots, as they are a small
>> percentage of the total hunk.
>
> I've been meaning to play with this for years, so I took the opportunity
> to spend a little time on it. :)

I envy you ;-)  It certainly looks like a fun side project.

> Below is a (slightly hacky) patch I came up with. It seems to work, and
> produces really great output in some cases. For instance, in 99a2cfb, it
> produces (I put highlighted bits in angle brackets):
>
>   -               <hash>cpy(peeled, <sha1>);
>   +               <oid>cpy(<&>peeled, <oid>);
>
> It also produces nonsense like:
>
>   -       <un>s<ign>ed <char >peeled<[20]>;
>   +       s<truct obj>e<ct_i>d peeled;

ROTFL ;-)

And the change does not look bad at all.
