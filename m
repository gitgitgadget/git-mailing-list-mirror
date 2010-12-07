From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] logging branch deletion to help recovering from
 mistakes
Date: Tue, 7 Dec 2010 10:37:39 -0800
Message-ID: <20101207183739.GB3725@spearce.org>
References: <7vlj42siu5.fsf@alter.siamese.dyndns.org>
 <AANLkTikbsyFUzZeu8R6yAND6spV6OnvYL08gYZ+ZgJCh@mail.gmail.com>
 <7vmxoiqeoq.fsf@alter.siamese.dyndns.org>
 <20101207170623.GB21749@sigill.intra.peff.net>
 <AANLkTimnp3xCHp_3E7ry-5OQL3PFnYh=H8PhfzMN307C@mail.gmail.com>
 <20101207182040.GA26770@sigill.intra.peff.net>
 <20101207182342.GA3725@spearce.org>
 <20101207183507.GA27277@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 07 19:44:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ2Wc-0007xO-G1
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 19:44:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915Ab0LGSoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 13:44:25 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33766 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753685Ab0LGSoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 13:44:25 -0500
Received: by pwj3 with SMTP id 3so85783pwj.19
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 10:44:24 -0800 (PST)
Received: by 10.142.242.19 with SMTP id p19mr1268778wfh.176.1291747061318;
        Tue, 07 Dec 2010 10:37:41 -0800 (PST)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.74.25])
        by mx.google.com with ESMTPS id v19sm9283892wfh.12.2010.12.07.10.37.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Dec 2010 10:37:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101207183507.GA27277@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163112>

Jeff King <peff@peff.net> wrote:
> On Tue, Dec 07, 2010 at 10:23:42AM -0800, Shawn O. Pearce wrote:
> 
> > Yea, I'm leaning more towards the foo..deleted-n idea too, for the
> > same reasons.  It also makes it easier to GC a deleted branch's
> > reflog, we can examine the last record's timestamp in a reasonable
> > time bound and unlink the log if its really freaking old.
> 
> Do we need to actually do that? Shouldn't the entries in the reflog get
> expired as part of the regular reflog gc? In that case, we would just
> delete the file when it had zero entries.

Yes, you are right.  We should instead let the normal reflog expire
action do its work here, and delete the empty log file when it is
finally empty.

I guess we also need repack and prune to enumerate these deleted
reflogs and retain the objects their records point to.

-- 
Shawn.
