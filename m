From: david@lang.hm
Subject: Re: [PATCH] Prevent megablobs from gunking up git packs
Date: Thu, 24 May 2007 10:23:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0705241020450.21766@asgard.lang.hm>
References: <46528A48.9050903@gmail.com> <7v7iqz19d2.fsf@assigned-by-dhcp.cox.net>
 <56b7f5510705231655o589de801w88adc1aa6c18162b@mail.gmail.com>
 <7vps4ryp02.fsf@assigned-by-dhcp.cox.net> <20070524071235.GL28023@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <junkio@cox.net>, Dana How <danahow@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 24 19:23:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrH2Y-00089Q-GB
	for gcvg-git@gmane.org; Thu, 24 May 2007 19:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbXEXRXv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 13:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbXEXRXv
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 13:23:51 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:50535
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbXEXRXv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 13:23:51 -0400
Received: from asgard (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l4OHNf3Q021187;
	Thu, 24 May 2007 10:23:41 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20070524071235.GL28023@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48277>

On Thu, 24 May 2007, Shawn O. Pearce wrote:

> Now #3 is actually really important here.  Don't forget that we
> *just* disabled the fancy "new loose object format".  It doesn't
> exist.  We can read the packfile-like loose objects, but we cannot
> write them anymore.  So lets say we explode a megablob into a loose
> object, and its 800 MiB by itself.  Now we have to send that object
> to a client.  Yes, that's right, we must *RECOMPRESS* 800 MiB for
> no reason.  Not the best choice.  Maybe we shouldn't have deleted
> that packfile formatted loose object writer...

when did the object store get changed so that loose objects aren't 
compressed?

if the problem is that the codepath for fetching does an uncompress 
followed by a compress then it would seem that this is a fairly easy 
problem to fix (how hard would it be to add the headers around the 
compressed object to make it look to the receiver like it's a pack with 
only one thing in it)

David Lang
