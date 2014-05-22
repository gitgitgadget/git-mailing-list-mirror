From: David Turner <dturner@twopensource.com>
Subject: Re: git reset for index restoration?
Date: Thu, 22 May 2014 17:53:06 -0400
Organization: Twitter
Message-ID: <1400795586.18134.40.camel@stross>
References: <1400775763.1933.5.camel@stross>
	 <CABPp-BHtYnput7SiAbnqUjpDibTi5o_2MAXfSj17fCdKSC7Hjg@mail.gmail.com>
	 <1400782642.18134.8.camel@stross>
	 <20140522183930.GB1167@sigill.intra.peff.net>
	 <1400785669.18134.21.camel@stross>
	 <20140522190959.GA18785@sigill.intra.peff.net>
	 <20140522193030.GA22383@sigill.intra.peff.net>
	 <xmqqha4hmr9d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 22 23:53:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnavK-0002wm-K3
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 23:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500AbaEVVxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 17:53:10 -0400
Received: from mail-qc0-f169.google.com ([209.85.216.169]:65534 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbaEVVxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 17:53:09 -0400
Received: by mail-qc0-f169.google.com with SMTP id e16so6823651qcx.14
        for <git@vger.kernel.org>; Thu, 22 May 2014 14:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=xgzidQk4r6XuoyEpsjQu0lnX4688oPP3N1AQTWyH4bo=;
        b=F1CgPCL1rhk4cD7Y+5AX/JFIBKRnqbroVgrR83ASlk/QnOeji9b0oMhN0YphBWOtET
         gmDEwuFx+ILEY4ftmjqKTt7aKj5vJ9vka21dlj39hSGdc+C+PqSA38xfsl8E7/kOBkbM
         QgL/y/5miObm6Ym9xmzUapWOHnoBZRYNAFNf6iwcTvRnOkGkDS3P4GjJeZ7fotSREyVv
         a1+u2phuDDAczihbdKR9rB6Xy1wA1IgKG+ybGNEC8LPJuzq30bdQUzn5yBDfvTDUUohl
         /Ll/Cu0GV/DL7SN1r5kRwnBLRO4UAE+hwV1CEzbIZqIvrl2ig7Bgq0fsenUv2TF+Q4Fn
         UCiA==
X-Gm-Message-State: ALoCoQmJnGrlnn73recM35HlL0xZ+NQyd7S6cKl59+It01VnCfzYPo6VJmxKXC7Oa+yhZPfRA/wr
X-Received: by 10.140.23.7 with SMTP id 7mr996725qgo.0.1400795588231;
        Thu, 22 May 2014 14:53:08 -0700 (PDT)
Received: from [172.17.3.46] ([38.104.173.198])
        by mx.google.com with ESMTPSA id s13sm1622583qay.39.2014.05.22.14.53.06
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 22 May 2014 14:53:07 -0700 (PDT)
In-Reply-To: <xmqqha4hmr9d.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249947>

On Thu, 2014-05-22 at 14:34 -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > [+cc Junio for cache-tree expertise]
> > ...
> > We never call reset_index now, because we handle it via diff.  We could
> > call prime_cache_tree in this case, but I'm not sure if that is a good
> > idea, because it primes it from scratch (and so it opens up all those
> > trees that we are trying to avoid touching). I'm not sure if there's an
> > easy way to update it incrementally; I don't know the cache-tree code
> > very well.
> 
> The cache-tree is designed to start in a well-populated state,
> allowing you to efficiently smudge the part you touched by
> invalidating while keeping the parts you haven't touched intact.

As far as I can tell, the cache-tree does not in fact ever get into a
well-populated state (that is, it does not exist at all) under ordinary
git operation except by git reset --hard.  Perhaps this was already
clear from the previous traffic on the thread, but I wanted to make sure
Junio was also aware of this.
