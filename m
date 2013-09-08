From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/4] Re: [PATCH 3/4] t: rev-parse-parents: avoid yoda conditions
Date: Sat, 7 Sep 2013 22:11:49 -0500
Message-ID: <CAMP44s3O=cHAtHOj41MccBDOausukb49MV-E6jib6n6czs+p3Q@mail.gmail.com>
References: <20130903075107.GA25540@goldbirke>
	<20130903080358.GA30158@sigill.intra.peff.net>
	<CAMP44s112mwgs=8n0XCnTtPM2V-O5RYE2ns+fjCvgkxj+kEY8Q@mail.gmail.com>
	<20130903111006.GJ29840@goldbirke>
	<CAMP44s349-v6xtCvbDzycVj1wBwTdAgLmuGxB0pYn6CmHYkM1Q@mail.gmail.com>
	<20130903150855.GK29840@goldbirke>
	<20130903170419.GA29921@google.com>
	<xmqqli3co7ov.fsf@gitster.dls.corp.google.com>
	<20130904171356.GD2582@serenity.lan>
	<xmqq1u54o5c4.fsf@gitster.dls.corp.google.com>
	<20130904183559.GA3465@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 08 05:12:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIVPn-0003d4-Od
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 05:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079Ab3IHDLw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 23:11:52 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:62561 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753933Ab3IHDLv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 23:11:51 -0400
Received: by mail-lb0-f182.google.com with SMTP id c11so4029263lbj.13
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 20:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=K3tltAGfzjM5JMZkfLFrGzGywKMtp2c29b9pJmwWwVA=;
        b=xA4l1dRSZSj9gyuJUrkWHu+fpxwFKQJA5YtHMSWaXB7qV2GPM9oXn32fT+aQqDR35G
         5j47e8zYz4KBme/m60we/8JBRStN4Chx5Iq9pGbk75zT7PntHJs52FeAZsArPdg65dTG
         3onrKVej8xJYOVH9hDALRCOxyAeZM8Ij2cCA4Xuy8sWiRuFW6jQ/+33QHQG4a8jUAPiI
         YPaXtW6PktKECUSDDl28mlKsm9lGEy3nOtXXXVh7FU0RrdRTF82z/G1q8wwRlO6Hmnrx
         /9BR9EIOo4c3D+1QS5jA6a3w2L3e9/6npNsCE1XZHUQKlFsasM1O8LKh3u8P44wMSouj
         gY+g==
X-Received: by 10.112.64.36 with SMTP id l4mr9844131lbs.15.1378609909928; Sat,
 07 Sep 2013 20:11:49 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sat, 7 Sep 2013 20:11:49 -0700 (PDT)
In-Reply-To: <20130904183559.GA3465@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234168>

On Wed, Sep 4, 2013 at 1:36 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Sep 04, 2013 at 10:38:03AM -0700, Junio C Hamano wrote:
>
>> >> This is way off tangent, but I am somewhat sympathetic to Felipe's
>> >> "compare actual with expect", with reservations.
>> >
>> > This isn't an argument either way, but note that JUnit (and NUnit and
>> > PHPUnit) all have assertEquals methods that take the arguments in the
>> > order "expect, actual".  I've always assumed that Git's test framework
>> > was imitating that,...
>>
>> No.  See 82ebb0b6 (add test_cmp function for test scripts,
>> 2008-03-12).  The "test_cmp" was a replacement for "diff -u", and
>> the same order we fed "diff -u", i.e. expect then actual, was
>> carried over.
>
> I don't think it was intentional at the time. But over the intervening 5
> years, I have noticed that I certainly think of "test_cmp A B" as
> "differences from A to B", and the order makes sense. IOW, the "test_cmp
> is diff" abstraction is leaky, and that is fine (if it were not leaky,
> then order would not matter at all, but it clearly does).
>
> But let's take a step back. This seems like an endian-ness issue to me.
> I.e., some people prefer one order for test assertions, and other people
> prefer the other. Is anyone actually right, or is this simply a matter
> of preference? And if it is simply a matter of preference, then why
> bother going through the pain of changing the current project standard?
>
> Though I prefer the current, I can certainly live and adapt to a changed
> standard, and I do not mind doing so if there is a good reason. But I've
> yet to see any argument beyond "it is not what I like". Which to me
> argues for the status quo as the path of least resistance.

Didn't Junio already provided reasoning?

Here's more; human semantics:

Computer, compare A with B
cmp(A, B)

Why would I write?

cmp(B, A)

Could you even construct an English sentence that starts with B, and then A?

-- 
Felipe Contreras
