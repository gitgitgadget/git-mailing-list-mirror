From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/9] fetch: fetch submodules in parallel
Date: Fri, 28 Aug 2015 11:41:03 -0700
Message-ID: <xmqqlhcv1cjk.fsf@gitster.mtv.corp.google.com>
References: <1440724495-708-1-git-send-email-sbeller@google.com>
	<1440724495-708-8-git-send-email-sbeller@google.com>
	<CAGZ79kbTAVDVmw+MrXvky6tJWZcG97tT_KAxV7S-pKCiNqRp3g@mail.gmail.com>
	<20150828170141.GB8165@google.com>
	<xmqqfv332v84.fsf@gitster.mtv.corp.google.com>
	<20150828182008.GC8165@google.com>
	<xmqqpp271d6v.fsf@gitster.mtv.corp.google.com>
	<20150828183501.GA17222@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 28 20:41:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVOaN-0005SM-L7
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 20:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051AbbH1SlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 14:41:07 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36365 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbbH1SlG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 14:41:06 -0400
Received: by padhm10 with SMTP id hm10so14917658pad.3
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 11:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=23tCVPt1N+8Hs6FpBuIZsYU2dNUr9Inpvcr9tJtBNt8=;
        b=ZuEXq78zEDCR9FMotSHhqAfF4KUC2dpi95DLUadSSQejFA/hNOrqyrNl9n2HUZjEP0
         ixT9EhJKGB3OXLJT6TCCZKKaOAQ1UuWKBI7Zt4QGWseVKPt3D3NNqSnNyDYHyD9qwRNz
         HGcLhp5XATtCchI1k3CbBgvcx+C6wvc0bH7ozXAhUN+yTTHHNQk8xb92CBqSTmr5YehB
         PTKLqNGl/6prY3eZKNJp8ebr9z0f3S7HvAHOx7liq9TbDy/lmjXfadILHjbuF8IVk+o3
         MibcHmAgX1PZ78JjWhRLZLSO4gR323ukT/nSf698HqGlyHNrEokil9dVdowHB9+d3stj
         3Cxg==
X-Received: by 10.68.96.197 with SMTP id du5mr17976892pbb.32.1440787264770;
        Fri, 28 Aug 2015 11:41:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c919:3f20:8560:5a06])
        by smtp.gmail.com with ESMTPSA id qv3sm6470593pbb.78.2015.08.28.11.41.03
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 28 Aug 2015 11:41:04 -0700 (PDT)
In-Reply-To: <20150828183501.GA17222@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 28 Aug 2015 14:35:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276749>

Jeff King <peff@peff.net> writes:

> I think Jonathan's point is that you could pick _one_ active child to
> show without buffering, while simultaneously buffering everybody else's
> output. When that finishes, pick a new active child, show its buffer,
> and then start showing its output in realtime. And so on.
>
> So to an observer, it would look like a serial operation, but subsequent
> operations after the first would magically go much faster (because
> they'd been working and buffering in the background).

OK, I can buy that explanation.

> And that doesn't require any additional IPC magic (though I am not sure
> how we get progress in the first place if the child stderr is a
> pipe...).

That is a good point ;-)
