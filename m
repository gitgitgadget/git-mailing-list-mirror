From: David Lang <david@lang.hm>
Subject: Re: Multi-threaded 'git clone'
Date: Mon, 16 Feb 2015 05:31:13 -0800 (PST)
Message-ID: <alpine.DEB.2.02.1502160521030.23770@nftneq.ynat.uz>
References: <CACSCj9yoso1oLHzySx1F3O+DFAPiz-XEz1YNCEUMu1pj7KmX7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git <git@vger.kernel.org>
To: Koosha Khajehmoogahi <koosha.khajeh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 14:41:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNLvC-00024x-LS
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 14:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755695AbbBPNlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 08:41:05 -0500
Received: from mail.lang.hm ([64.81.33.126]:39158 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254AbbBPNlE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 08:41:04 -0500
X-Greylist: delayed 588 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Feb 2015 08:41:04 EST
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id t1GDVDgM004625;
	Mon, 16 Feb 2015 05:31:13 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <CACSCj9yoso1oLHzySx1F3O+DFAPiz-XEz1YNCEUMu1pj7KmX7w@mail.gmail.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263900>

On Mon, 16 Feb 2015, Koosha Khajehmoogahi wrote:

> Cloning huge repositories like Linux kernel takes considerable amount
> of time. Is it possible to incorporate a multi-threaded simultaneous
> connections functionality for cloning? To what extent do we need to
> change the architecture of the current code and how large would be the
> scope of the work? That just seems an interesting idea to me and would
> liked to share it with the community.

They key question is what is it that takes the time in clonding and can that be 
multi-threaded.

If it's the netwrok traffic that takes the most time, where is the bottleneck?

Is it in the server software assembling what will be sent? Is it in the 
receiving software processing it? If so, multiple threads could help.

Is it in network bandwidth? If so doing multiple connections won't help much. 
TCP connections favour a few connections passing a lot of data rather than many 
connections passing a little. The one place where multiple connections can help 
is when you have non-congestion induced packet loss as a lost packet on a 
connection will cause the throughput of that connection to drop (if the drop is 
due to congestion, this is TCP working as designed, throttling back to match the 
available bandwidth). This can be a significant effect if you have a very high 
bandwidth, high latency connection (think multiple Gb on international 
connections), but for lower bandwidth connections it's much less of a factor. 
You can look at projects like bbcp

I think it's an interesting question to look at, but before you start looking at 
changing the architecture of the current code, I would suggest doing a bit more 
analisys of the problem to see if the bottleneck is really where you think it 
is.

First measure, then optimize :-)

David Lang
