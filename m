From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: clone breaks replace
Date: Fri, 07 Jan 2011 19:43:40 -0500
Message-ID: <4D27B33C.2020907@cfl.rr.com>
References: <4D262D68.2050804@cfl.rr.com> <20110106213338.GA15325@burratino> <4D276CD2.60607@cfl.rr.com> <20110107205103.GC4629@burratino> <4D278930.7010100@cfl.rr.com> <20110107214907.GA9194@burratino> <20110107220942.GB10343@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Stephen Bash <bash@genarts.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 08 01:43:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbMuL-0001X4-Bk
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 01:43:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731Ab1AHAnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 19:43:43 -0500
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.121]:54337 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573Ab1AHAnm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 19:43:42 -0500
X-Authority-Analysis: v=1.1 cv=Inhw+Jdt7z1D3BivGPfn2aw54OvUEJw5lAn/booRZkE= c=1 sm=0 a=IkcTkHD0fZMA:10 a=JmtI77n5PKyEllQSDapvNg==:17 a=BwIhM0POwfTtjgtMt1wA:9 a=Vdgao4lGtDvGkfilP2IA:7 a=Wl0zXEsO93AO8LZoPWK_aNgAz_4A:4 a=QEXdDO2ut3YA:10 a=JmtI77n5PKyEllQSDapvNg==:117
X-Cloudmark-Score: 0
X-Originating-IP: 184.91.189.177
Received: from [184.91.189.177] ([184.91.189.177:55960] helo=[192.168.1.3])
	by cdptpa-oedge04.mail.rr.com (envelope-from <psusi@cfl.rr.com>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id CD/FB-13137-C33B72D4; Sat, 08 Jan 2011 00:43:41 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <20110107220942.GB10343@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164796>

On 01/07/2011 05:09 PM, Jeff King wrote:
> I think there are two separate issues here:
>
>    1. Should transport protocols respect replacements (i.e., if you
>       truncate history with a replacement object and I fetch from you,
>       should you get the full history or the truncated one)?
>
>    2. Should clone fetch refs from refs/replace (either by default, or
>       with an option)?
>
> Based on previous discussions, I think the answer to the first is no.
> The resulting repo violates a fundamental assumption of git. Yes,
> because of the replacement object, many things will still work. But many
> parts of git intentionally do not respect replacement, and they will be
> broken.

What parts do not respect replacement?  More importantly, what parts 
will be broken?  The man page seems to indicate that about the only 
thing that does not by default is reachability testing, which to me 
means fsck and prune.  It seems to be the purpose of replace to 
/prevent/ breakage and be respected by default, unless doing so would 
cause harm, which is why fsck and prune do not.

> Instead, I think of replacements as a specific view into history, not a
> fundamental history-changing operation itself. Which means you can never
> save bandwidth or space by truncating history with replacements. You can
> only give somebody the full history, and share with them your view. If
> you want to truncate, you must rewrite history[1].

Right, but if you only care about that view, then there is no need to 
waste bandwidth fetching the original one.  It goes without saying that 
people pulling from the repository mainly care about the view upstream 
chooses to publish.  Upstream can choose to rewrite, which will cause 
breakage and is a sort of sneaky way to hide the original history, or 
they can use replace, which avoids the breakage and gives the client the 
choice of which view to use.
