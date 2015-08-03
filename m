From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/6] clone: fix hostname parsing when guessing dir
Date: Mon, 03 Aug 2015 12:43:14 -0700
Message-ID: <xmqqsi8088fh.fsf@gitster.dls.corp.google.com>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
	<1438185076-28870-1-git-send-email-ps@pks.im>
	<1438185076-28870-6-git-send-email-ps@pks.im>
	<xmqq7fpiamiq.fsf@gitster.dls.corp.google.com>
	<20150730121811.GA24635@pks-pc.localdomain>
	<xmqqk2th7gmq.fsf@gitster.dls.corp.google.com>
	<xmqqfv457fkc.fsf@gitster.dls.corp.google.com>
	<20150803083414.GA23997@pks-xps.Speedport_W_723V_1_37_000>
	<20150803163727.GA2602@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	pclouds@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 03 21:43:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMLdq-0006fI-6B
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 21:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754426AbbHCTnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 15:43:17 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36604 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882AbbHCTnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 15:43:16 -0400
Received: by pacgq8 with SMTP id gq8so31805836pac.3
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 12:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=+v6QcRjMnI6weHQ/mQhTLAWZKfxqLzjFNy3J5SGtqlA=;
        b=U6CTbLZb4NCT+/DpyEszhCN40XUQwD9Fyf6r+YSjaZQHRPj757pmEiLvsTuC58HWY+
         gyO4z5srctgWORht0WqleGYARwYIWxbRnReUq+57/CfeY8FBUwLwMxYZ0InNA7VW7fQp
         LCi3iqICk0Og6gKnBnARQDKK3XrQdJqg0pvvWXsiUFH943QFo5OE7xzPr3jNTTUZWaIt
         tfr5CGr207HxwFBlM5NZF+uYkJ+G24QaUKRWpYP0oIlUjaoJ+aCiIrCSyd8Xjlb1Kf2C
         2I1/J58Nso9LutxCjDuu8qd/H0n0xjMUx93338496N7f05FTdPOZ1cQ+00B3ksbVdLVN
         +pWg==
X-Received: by 10.66.63.9 with SMTP id c9mr38818024pas.40.1438630995966;
        Mon, 03 Aug 2015 12:43:15 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:38a2:7ad5:137e:6e11])
        by smtp.gmail.com with ESMTPSA id pp8sm8776297pbb.10.2015.08.03.12.43.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 03 Aug 2015 12:43:15 -0700 (PDT)
In-Reply-To: <20150803163727.GA2602@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 3 Aug 2015 12:37:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275189>

Jeff King <peff@peff.net> writes:

> On Mon, Aug 03, 2015 at 10:34:14AM +0200, Patrick Steinhardt wrote:
>
>> One more question for backwards compatibility remains then.
>> Currently when we clone something like 'http://example.com:2222/'
>> we'd create a git repository '2222' as we'd split on the first
>> occurrence of ':'. Should we remain backwards compatible here, as
>> well, or change the behavior to use 'example.com' as repository
>> name?
>
> I don't think naming the repo "2222" makes much sense; I'd consider it a
> bug. The only sensible names are "example.com" or "example.com:2222"
> (the latter is more specific if you are going to clone the root off of
> several different ports, but that seems rather unlikely; the former is
> probably what I'd expect).

Yeah, I tend to agree.
