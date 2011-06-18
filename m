From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: [PATCH] rebase -i -p: doesn't pick certain merge commits that
 are children of "upstream"
Date: Sat, 18 Jun 2011 10:17:18 -0500
Organization: Exigence
Message-ID: <20110618101718.6ff03688@sh9>
References: <4DEB495F.9080900@kdbg.org>
	<1307419725-4470-1-git-send-email-andrew.kw.w@gmail.com>
	<1307419725-4470-2-git-send-email-andrew.kw.w@gmail.com>
	<7vmxhlpvob.fsf@alter.siamese.dyndns.org>
	<4DF64932.1090607@sohovfx.com>
	<20110616172454.13ff1a18@sh9>
	<4DFC4863.2090803@sohovfx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Andrew Wong <andrew.kw.w@gmail.com>, git@vger.kernel.org
To: Andrew Wong <andrew.w@sohovfx.com>
X-From: git-owner@vger.kernel.org Sat Jun 18 17:17:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXxH9-0003AP-Jv
	for gcvg-git-2@lo.gmane.org; Sat, 18 Jun 2011 17:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754770Ab1FRPR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jun 2011 11:17:26 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47313 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908Ab1FRPRY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2011 11:17:24 -0400
Received: by gyh3 with SMTP id 3so957504gyh.19
        for <git@vger.kernel.org>; Sat, 18 Jun 2011 08:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exigencecorp.com; s=google;
        h=domainkey-signature:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=ojeyPdV+SzEmRDVsIoSt8oklhhk/rMXJMDkunve5O8Q=;
        b=VZlf7dOVzFy9jieUn4kJl3YtuHfVujHDvS6c+i2Lykqp94RZVWGCYM6IDCIRODTL0/
         wIMyJEVuJUNlUjgvB7u4SEZvR+jM1H5IugbvbU5qR9pk5f/3gSW1qWY/B4dVpLz+9L/Q
         mzXFZ6Wj1KCeWEu1yQV2xasYGGl4xySR106To=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=exigencecorp.com; s=google;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        b=CqfLF4tV5lA7/rFYkmHZk0MMu1q8hgho9aqDrCLEIX4UaTpUwpKPR7vsaXKZH0KMA1
         B1686724MRhjpL7W48gJFq0uUGZItdFl04Qo6ACTW6/xQAaPkUU6qIya10AyZNT3Oovs
         XPFNSvJd5kct2PHwKD8l8bJ6+47v40cPiRRS4=
Received: by 10.236.66.80 with SMTP id g56mr5054847yhd.367.1308410243699;
        Sat, 18 Jun 2011 08:17:23 -0700 (PDT)
Received: from sh9 (wsip-184-187-11-226.om.om.cox.net [184.187.11.226])
        by mx.google.com with ESMTPS id e24sm2444947yhk.65.2011.06.18.08.17.20
        (version=SSLv3 cipher=OTHER);
        Sat, 18 Jun 2011 08:17:22 -0700 (PDT)
In-Reply-To: <4DFC4863.2090803@sohovfx.com>
X-Mailer: Claws Mail 3.7.8 (GTK+ 2.24.4; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175973>


> In commit a4f25e3, we could already rebase B1 and squash F1 onto D1, 
> while reusing C1 and recreating the merge. That means we could
> already pass t3411.2if we adjusted the todo-list to account for the
> extra "pick C1" line.

You're right. I was wrong about that.

> Slightly off-topic, but I believe the branches will remain intact as
> long as the branch commits remain in the same topo-order relative to
> each other in the todo-list.

If in topo-order, yeah, I guess that is right.

> i.e. git will be confused if we try to move a commit from one branch
> into the other.

Right. If I do `rebase -i -p B1` and in the todo put C1 after F1, I get
a fatal message that E1 cannot be cherry picked.

Given rebase-i-p's limited ability to reorder graphs, e.g. the error
above, my understanding was that, when -p is used, only first-parent
changes should be in the todo. This straight line, non-graph list does
limit what the user can do, but, AFAIK, the benefit is that rebase-i-p
can then actually handle any given reordering of the todo.

Letting C1 into the todo would mean having to explain to the user why
some of their reorderings worked and others didn't. Or else making
rebase-i-p smart enough to handle all cases. Which, IIRC, was something
considered unlikely just given the fact that todo is flat and there
isn't a way for the user to express topo reorderings. At the time,
there was talk of another rewriting tool that would use marks and
other hints to handle graphs and it was considered what, if anything,
would eventually handle complex rewrites like this.

I think that Jeff's use case of rebase-i-p'ing C1, which is not on the
first-parent list of commits, should be an error as it delves into
territory (topo reordering) that rebase-i-p can't fully handle.

(If -p isn't used, just regular rebase, everything is being flattened,
so there is no concern of topo reordering, so things are a lot simpler
and C1 can/should be in the list.)

- Stephen
