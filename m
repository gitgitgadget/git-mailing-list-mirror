From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [RFC PATCH 1/2] Replace memset(0) with static initialization
 where possible
Date: Thu, 09 Oct 2008 15:56:09 -0500
Message-ID: <CqZt8k7g-Uov2ItkgRw6K65RC0ee37ZAckIrbwPLNwDiaHtigtevnA@cipher.nrlssc.navy.mil>
References: <NveF6_7LIvvEmRZEvLeTO5lw7EzzmOQkz1WGEMYGSFKDWqSwAeLwBw@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0810091534430.26244@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Oct 09 22:57:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ko2ZZ-00045X-1V
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 22:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546AbYJIU4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 16:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754276AbYJIU4N
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 16:56:13 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:48141 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788AbYJIU4M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 16:56:12 -0400
Received: by mail.nrlssc.navy.mil id m99Ku9Yj008665; Thu, 9 Oct 2008 15:56:09 -0500
In-Reply-To: <alpine.LFD.2.00.0810091534430.26244@xanadu.home>
X-OriginalArrivalTime: 09 Oct 2008 20:56:09.0504 (UTC) FILETIME=[74ADE200:01C92A51]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97884>

Nicolas Pitre wrote:
> On Thu, 9 Oct 2008, Brandon Casey wrote:
> 
>> "Possible" benefits:
>>
>>   1) more concise, so it improves readability in most cases
>>   2) gives compiler more flexibility when optimizing
> 
> Beware beware.  At some point this wasn't a gain at all with some gcc 
> versions as it was stupid enough to construct a temporary object on the 
> stack corresponding to "{ 0, }" and afterward do the assignment by 
> *copying* this object to a different stack slot corresponding to the 
> actual variable instead of constructing the initial value in place.
> 
> Also note that, on the other hand, gcc is smart enough to optimize a 
> memset() using a constant size and value already by doing appropriate 
> code replacement inline.  I've also seen cases where gcc did the 
> opposite and replaced an explicit assignment like your patch does with 
> an actual call to memset() when optimizing for size.

I'd call that flexibility.

> So when claiming flexibility for the compiler to better optimize things, 
> please make sure this is really what is happening through assembly dump 
> inspection.

I didn't claim the compiler _would_ do a better job at optimizing if
memset wasn't used (though my expectation is that it would do no worse,
and I don't have assembly dumps to back that up). I suggested it could
give the compiler more flexibility. In some strange way you seem to
agree with me and have given 3 examples of ways that compilers may
optimize static initialization. :)

Anyway, this is a nothing patch. There is no functional change.
If readability is not improved, it is not worth applying. Of course, I
don't plan on scanning through and converting all of the existing assignments
which use { 0, } to use memset. I find a single step declaration/initialization
simpler. Not sure why that seems to be the case in the git source for simple
variables but not structures.

-brandon
