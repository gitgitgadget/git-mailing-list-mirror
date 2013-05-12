From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: [RFC/PATCH 0/2] merge-base: add --merge-child option
Date: Sun, 12 May 2013 18:44:30 +0300
Message-ID: <518FB8DE.7070004@bracey.fi>
References: <cover.1368274689.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun May 12 18:09:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbYqE-0001VZ-KQ
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 18:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754096Ab3ELQJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 12:09:38 -0400
Received: from 16.mo1.mail-out.ovh.net ([178.33.104.224]:48661 "EHLO
	mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753357Ab3ELQJi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 May 2013 12:09:38 -0400
Received: from mail615.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo1.mail-out.ovh.net (Postfix) with SMTP id 5A0FDFF8D8F
	for <git@vger.kernel.org>; Sun, 12 May 2013 17:44:34 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 12 May 2013 17:44:57 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 12 May 2013 17:44:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
X-Ovh-Mailout: 178.32.228.1 (mo1.mail-out.ovh.net)
In-Reply-To: <cover.1368274689.git.john@keeping.me.uk>
X-Ovh-Tracer-Id: 13327840149115736065
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrjeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrjeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224049>

On 11/05/2013 15:23, John Keeping wrote:
> This is helpful when examining branches with disjoint roots, for example
> because one is periodically merged into a subtree of the other.
>
>
>
>          $ git log --left-right F...E --not $(git merge-base --merge-child F E)
>          < F
>          > E
>

Wouldn't "--left-right --ancestry-path F...E" do the job? I can't 
immediately see how that differs.

Unfortunately, that syntax doesn't currently work - I just stumbled 
across this problem, and my "history traversal refinements" series in pu 
fixes it, somewhat incidentally to the main subject in there.

However, without that patch, the alternative way of expressing it:

"--left-right --ancestry path F E --not $(git merge-base --all F E)"

should still work. Unless --left-right is magic for "..."? If it is, 
then my patch is more significant than I thought.

My series will also be better at optimising away D too, through a 
combination of my and Junio's efforts. Try it out.

On this subject, is there any way to exclude a path from a log query? Is 
there a "not" operator for paths? Might be another way of doing this - 
disjoint histories probably have disjoint paths...

Kevin
