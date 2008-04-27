From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: git doesn't finds the parent of a commit
Date: Sun, 27 Apr 2008 23:46:21 +0200
Message-ID: <20080427214621.GA30793@cuci.nl>
References: <slrng019fg.nd8.joerg@alea.gnuu.de> <20080413094131.GA9437@xp.machine.xx> <slrng0v8h8.ujv.joerg@alea.gnuu.de> <200804240801.13674.chriscool@tuxfamily.org> <20080424060857.GX29771@spearce.org> <20080427104704.GA11784@alea.gnuu.de> <20080427173731.GA9523@cuci.nl> <7vtzhnf3w5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 27 23:47:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqEiT-0004Ib-B2
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 23:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbYD0VqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 17:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbYD0VqX
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 17:46:23 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:37078 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbYD0VqX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 17:46:23 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 00835545E; Sun, 27 Apr 2008 23:46:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vtzhnf3w5.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80488>

Junio C Hamano wrote:
>"Stephen R. van den Berg" <srb@cuci.nl> writes:
>> I've had similar symptoms when I had circular references in the
>> repository.  They're not reported by any of the existing checks, I've
>> submitted a patch (resent it just now) which causes git to check for
>> (and report) circular references when using --topo-order on e.g.
>> git-rev-list.

>Assuming that we never have SHA-1 hash collisions, the graft mechansim is
>practically the only way to get yourself into the circular reference
>situation.

True, I think.

>Perhaps we should check this circularity when we install grafts instead of
>special casing the topo-order codepath?  How expensive would that
>alternative approach be?

Not practical in its current form.
Checking for circular references is O(n) in CPU and memory use relative
to the number of commits in the entire repository.

Consider:
- The proposed check in the topo-order path is very low-cost, it costs a
  single decrement/increment per commit (and will detect other circular
  references not caused by the grafts mechanism, if they ever should occur).
- If it is being done during the grafts install, then there should be a
  flag-file (at least), which indicates when the grafts file has changed
  since the last check.
- It could/should be added to git-fsck.
-- 
Sincerely,                                                          srb@cuci.nl
           Stephen R. van den Berg.
