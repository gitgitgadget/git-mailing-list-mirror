From: David Turner <dturner@twopensource.com>
Subject: Re: git reset for index restoration?
Date: Thu, 22 May 2014 18:01:17 -0400
Organization: Twitter
Message-ID: <1400796077.18134.41.camel@stross>
References: <1400775763.1933.5.camel@stross>
	 <CABPp-BHtYnput7SiAbnqUjpDibTi5o_2MAXfSj17fCdKSC7Hjg@mail.gmail.com>
	 <1400782642.18134.8.camel@stross>
	 <20140522183930.GB1167@sigill.intra.peff.net>
	 <1400785669.18134.21.camel@stross>
	 <20140522190959.GA18785@sigill.intra.peff.net>
	 <20140522193030.GA22383@sigill.intra.peff.net>
	 <xmqqha4hmr9d.fsf@gitster.dls.corp.google.com>
	 <1400795586.18134.40.camel@stross>
	 <xmqqd2f5mq5h.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 23 00:01:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wnb3E-0005LN-KU
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 00:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbaEVWBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 18:01:20 -0400
Received: from mail-qc0-f171.google.com ([209.85.216.171]:54739 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbaEVWBU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 18:01:20 -0400
Received: by mail-qc0-f171.google.com with SMTP id x13so6814178qcv.2
        for <git@vger.kernel.org>; Thu, 22 May 2014 15:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=AcV59qxR+cmfLCo/u6KKQQfh2GjpLT47Yj0ok0zE5Ho=;
        b=F/NQi8cUTsuYRrUQW6UF9FTsWk0QDKT8KN5ruiGGO/4lyu/S1FDl/txahP73m1dgsk
         +Ul15xCI/kzw8CQQ9hlm7gwxvNndGJ4VbzRTFA+b+JeJUW6ut2m9PmQLSqRJj0f199w1
         GabxosvluMWVn14m2O5HrtJxUuR8mivHGGc2FmfwPLVCZ875evukXWKWIpLxcfxAAxcA
         rF7NdJ8NyzNC3LdPQJTmAaLB5baBmHLxir9Jc/FuoIqmkfVgrlRKAUDdJC6qponGkwv7
         4DAjFo+EBQ/DNyNNN8O2Qn468LwTxZh38Bb0LRCj1mAbyZ9zzO/nOclLV9pAafEmBA12
         L5vw==
X-Gm-Message-State: ALoCoQk9VR/aVOinPAyhiVPifbEWRLbbxroYfq+csuqZbMuWF8fNe8h6AELgDP6CnyNvvRPbRV0H
X-Received: by 10.140.96.68 with SMTP id j62mr748761qge.5.1400796079428;
        Thu, 22 May 2014 15:01:19 -0700 (PDT)
Received: from [172.17.3.46] ([38.104.173.198])
        by mx.google.com with ESMTPSA id j110sm681225qga.40.2014.05.22.15.01.18
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 22 May 2014 15:01:18 -0700 (PDT)
In-Reply-To: <xmqqd2f5mq5h.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249949>

On Thu, 2014-05-22 at 14:58 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > On Thu, 2014-05-22 at 14:34 -0700, Junio C Hamano wrote:
> >> Jeff King <peff@peff.net> writes:
> >> 
> >> > [+cc Junio for cache-tree expertise]
> >> > ...
> >> > We never call reset_index now, because we handle it via diff.  We could
> >> > call prime_cache_tree in this case, but I'm not sure if that is a good
> >> > idea, because it primes it from scratch (and so it opens up all those
> >> > trees that we are trying to avoid touching). I'm not sure if there's an
> >> > easy way to update it incrementally; I don't know the cache-tree code
> >> > very well.
> >> 
> >> The cache-tree is designed to start in a well-populated state,
> >> allowing you to efficiently smudge the part you touched by
> >> invalidating while keeping the parts you haven't touched intact.
> >
> > As far as I can tell, the cache-tree does not in fact ever get into a
> > well-populated state (that is, it does not exist at all) under ordinary
> > git operation except by git reset --hard.  Perhaps this was already
> > clear from the previous traffic on the thread, but I wanted to make sure
> > Junio was also aware of this.
> 
> Yes.  As I said, that should not usually be a problem for those who
> do the real work (read: commit), at which time write-tree will fully
> populate the cache-tree.

Git commit does not in fact populate the cache-tree.
