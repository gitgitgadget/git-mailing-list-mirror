From: Kacper Kornet <draenog@pld-linux.org>
Subject: Re: [PATCH v2] Fix revision walk for commits with the same dates
Date: Fri, 22 Mar 2013 22:07:41 +0100
Message-ID: <20130322210741.GC18210@camk.edu.pl>
References: <20130307180321.GA26756@camk.edu.pl>
 <20130322183819.GA18210@camk.edu.pl>
 <7va9pv6u4k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 22 22:08:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ9CO-0002ZK-LU
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 22:08:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423038Ab3CVVIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 17:08:00 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:57520 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422967Ab3CVVH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 17:07:59 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 914D75F0003;
	Fri, 22 Mar 2013 22:08:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 1pyHw3azioJc; Fri, 22 Mar 2013 22:07:53 +0100 (CET)
Received: from gatekeeper.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 54CB35F0001;
	Fri, 22 Mar 2013 22:07:53 +0100 (CET)
Received: by gatekeeper.camk.edu.pl (Postfix, from userid 1293)
	id 6B6C94838A; Fri, 22 Mar 2013 22:07:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7va9pv6u4k.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218845>

On Fri, Mar 22, 2013 at 01:45:47PM -0700, Junio C Hamano wrote:
> Kacper Kornet <draenog@pld-linux.org> writes:

> > Logic in still_interesting function allows to stop the commits
> > traversing if the oldest processed commit is not older then the
> > youngest commit on the list to process and the list contains only
> > commits marked as not interesting ones. It can be premature when dealing
> > with a set of coequal commits. For example git rev-list A^! --not B
> > provides wrong answer if all commits in the range A..B had the same
> > commit time and there are more then 7 of them.

> > To fix this problem the relevant part of the logic in still_interesting
> > is changed to: the walk can be stopped if the oldest processed commit is
> > younger then the youngest commit on the list to processed.

> Is the made-up test case to freeze the clock even interesting?  The
> slop logic is merely a heuristic to compensate for effects caused by
> skewed or non-monototic clocks, so in a different repository you may
> even need to fuzz the timestamp comparison further

> 	if (date - 10 < src->item->date)

> or something silly like that.

I don't think it is a made-up test case. For example it is easy to get a
number of coequal commits by using git rebase -i. So I argue that git
should treat correctly ranges of such commits.

-- 
  Kacper Kornet
