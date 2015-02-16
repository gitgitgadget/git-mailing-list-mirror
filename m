From: David Lang <david@lang.hm>
Subject: Re: Multi-threaded 'git clone'
Date: Mon, 16 Feb 2015 07:31:33 -0800 (PST)
Message-ID: <alpine.DEB.2.02.1502160727480.23770@nftneq.ynat.uz>
References: <CACSCj9yoso1oLHzySx1F3O+DFAPiz-XEz1YNCEUMu1pj7KmX7w@mail.gmail.com> <alpine.DEB.2.02.1502160521030.23770@nftneq.ynat.uz> <20150216150305.GA8279@peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Koosha Khajehmoogahi <koosha.khajeh@gmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 16 16:31:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNNe9-00017m-3K
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 16:31:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755483AbbBPPbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 10:31:37 -0500
Received: from mail.lang.hm ([64.81.33.126]:45204 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752955AbbBPPbg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 10:31:36 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id t1GFVYuB005184;
	Mon, 16 Feb 2015 07:31:34 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20150216150305.GA8279@peff.net>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263903>

On Mon, 16 Feb 2015, Jeff King wrote:

> On Mon, Feb 16, 2015 at 05:31:13AM -0800, David Lang wrote:
>
>> I think it's an interesting question to look at, but before you start
>> looking at changing the architecture of the current code, I would suggest
>> doing a bit more analisys of the problem to see if the bottleneck is really
>> where you think it is.
>>
>> First measure, then optimize :-)
>
> Yes, very much so. Fortunately some people have already done some of
> this work. :)

nice summary

> Then the server streams the data to the client. It might do some light
> work transforming the data as it comes off the disk, but most of it is
> just blitted straight from disk, and the network is the bottleneck.

Depending on how close to full the WAN link is, it may be possible to improve 
this with multiple connections (again, referencing bbcp), but there's also the 
question of if it's worth trying to use the entire WAN for a single user. The 
vast majority of the time the server is doing more than one thing and would 
rather let any individual user wait a bit and service the other users.

David Lang
