From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: "git-send-pack"
Date: Thu, 30 Jun 2005 18:24:05 -0700
Message-ID: <42C49B35.3050204@zytor.com>
References: <Pine.LNX.4.21.0506301651250.30848-100000@iabervon.org> <Pine.LNX.4.58.0506301412470.14331@ppc970.osdl.org> <42C46A3C.1070104@zytor.com> <Pine.LNX.4.58.0506301514240.14331@ppc970.osdl.org> <42C482ED.1010306@zytor.com> <Pine.LNX.4.58.0506301656570.14331@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 01 03:17:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoA9S-0007WA-Ec
	for gcvg-git@gmane.org; Fri, 01 Jul 2005 03:17:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263162AbVGABYg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 21:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263165AbVGABYg
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 21:24:36 -0400
Received: from terminus.zytor.com ([209.128.68.124]:40833 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S263162AbVGABYd
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2005 21:24:33 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j611OArG024864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 30 Jun 2005 18:24:11 -0700
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506301656570.14331@ppc970.osdl.org>
X-Virus-Scanned: ClamAV version 0.85.1, clamav-milter version 0.85 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.7 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 30 Jun 2005, H. Peter Anvin wrote:
> 
>>In your linux-2.6 tree, there are currently 54,204 objects, and that is 
>>after less than one full 2.6.x kernel release cycle.  That's a megabyte 
>>of SHA1s.
> 
> 
> But that's _all_ objects. There are "only" 4040 commit objects (which are
> always the starting point for a search). 
> 

Well, there are objects that reference commit objects (e.g. tag 
objects), not the other way around, but your point is well taken.

> So streaming out the commit objects a few hundred at a time is actually 
> a very simple strategy. 
> 
> Also, note that the server is usually _more_ ahead than the client is, and 
> the server is the one that potentially has lots of commits that the 
> client doesn't have. Not the other way around. So if the client makes a 
> list of it's top commits, it almost certainly won't have to make a very 
> long list until the server can tell it "ok, stop, I've seen it".

Well, what I proposed was pretty much that except to have the client 
(receiver) start first.

I prefer calling it sender and receiver, because in the case of upload 
and download you have different sides being the "server".

> Yeah, maybe we want to limit the "burst" to 70 sha1's, since that will fit 
> in a regular-sized ethernet packet, but whatever - you'd burst out your 
> commits "latest first", so you'd never even get to the current 4040 unless 
> you've literally done the kind of work we've done in the git tree for the 
> last 3 months _and_you've_not_pulled_from_that_server_in_the_whole_time_.

Well, in the common case (sender has a superset of receiver), what I 
proposed would converge on the first iteration.  I'm not even convinced 
that the algorithm *ever* needs to iterate.

	-hpa
