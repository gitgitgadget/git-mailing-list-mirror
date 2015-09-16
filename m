From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 15/67] convert trivial sprintf / strcpy calls to xsnprintf
Date: Wed, 16 Sep 2015 11:24:27 -0700
Message-ID: <xmqqh9muql2c.fsf@gitster.mtv.corp.google.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915153637.GO29753@sigill.intra.peff.net>
	<CAPig+cR9n=hT3F-0uDbJT_Z9REe83-kFKR5XB6pVrHRe0Z14eA@mail.gmail.com>
	<20150916094814.GB13966@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 16 20:24:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcHNi-0006xj-2M
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 20:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498AbbIPSY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 14:24:29 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36344 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921AbbIPSY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 14:24:29 -0400
Received: by padhk3 with SMTP id hk3so215833892pad.3
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 11:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=rYEthuuazH/G48gYszQvd5/cRdbMsuAFQ6zODLXNQD0=;
        b=0S2cwk3mIeTpcDagOjBLxgCwnurBYIQKMKW6bk+pjQKe9mO4lFeCJq2bnwZpwEdlPZ
         WsV8yk8fDaLf0KSaaGMtFD8km1Rhc65WjO/cELU8YFmcLOoW6t22VdwzzorH+w3B/9is
         RaB4DD5rg8hFxDbrydHgN77m2y6vQnPMA+trdqnmeRz0fa/9yD555bU+96u6cxr0mKUA
         gOwGy0N+8ahN1gTuCM/FxJvwcbZXwW6ErZdvVRwXhRL+bAfdpDJjxohwl/J040hsMBsw
         5cH1lDFCl4meXQRalIbcUwiezqtgqj48TsGlTi1v4c6aVqR9ip640r2YJoh127j+Lpjs
         Njrw==
X-Received: by 10.68.171.37 with SMTP id ar5mr63959982pbc.39.1442427868672;
        Wed, 16 Sep 2015 11:24:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:150c:7d53:9693:493e])
        by smtp.gmail.com with ESMTPSA id d13sm29147756pbu.17.2015.09.16.11.24.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 11:24:28 -0700 (PDT)
In-Reply-To: <20150916094814.GB13966@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 16 Sep 2015 05:48:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278045>

Jeff King <peff@peff.net> writes:

> On Tue, Sep 15, 2015 at 11:19:21PM -0400, Eric Sunshine wrote:
>
>> >                 strcpy(hexbuf[stage], sha1_to_hex(ce->sha1));
>> > -               sprintf(ownbuf[stage], "%o", ce->ce_mode);
>> > +               xsnprintf(ownbuf[stage], sizeof(ownbuf[stage]), "%o", ce->ce_mode);
>> 
>> Interesting. I wonder if there are any (old/broken) compilers which
>> would barf on this. If we care, perhaps sizeof(ownbuf[0]) instead?
>
> Good point. I've changed it to sizeof(ownbuf[0]).

Panda brain is lost here.  What's the difference, other than that we
will now appear to be measuring the size of the thing at index 0
while using that size to stuff data into a different location?  All
elements of the array are of the same size so there wouldn't be any
difference either way, no?
