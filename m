From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC PATCH v2] fetch-pack: log(n)-transmission find_common()
Date: Fri, 24 Oct 2008 11:49:56 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810241144260.3061@xanadu.home>
References: <1222217303-29792-1-git-send-email-trast@student.ethz.ch>
 <1224790716-20551-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Oct 24 17:52:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtOx5-0007rk-Fj
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 17:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753536AbYJXPuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 11:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753470AbYJXPuE
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 11:50:04 -0400
Received: from relais.videotron.ca ([24.201.245.36]:30207 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838AbYJXPuD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 11:50:03 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K99000MX2N8F6XJ@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 24 Oct 2008 11:49:57 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <1224790716-20551-1-git-send-email-trast@student.ethz.ch>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99043>

On Thu, 23 Oct 2008, Thomas Rast wrote:

> Replaces the existing simple history search with a more sophisticated
> algorithm:
> 
> 1) Walk history with exponentially increasing stride lengths; i.e.,
>    send the 1st commit, then the 2nd after that, then the 4th after
>    that, and so on.
> 
> 2) Bisect the resulting intervals.
> 
> Combined with tracking the "outstanding haves" so that we can detect
> which sha1s were never ACKed by upload-pack (and hence not common),
> this gives O(log(n)) required "have" lines.
> 
> Unfortunately this cannot work if the server sends fake ACKs, so we
> introduce a capability 'exp-stride' which instructs upload-pack to
> disable ok_to_give_up().  (Which incidentally saves the server a lot
> of work.)
> 
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> 
> ---
> 
> This is a simple resend of v2, in the hope of attracting some
> discussion or at least encouraging words this time around.

OK, I gave this a quick try, and fetch operations appear to make their 
mind about what to do quicker.  Some fetch requests which used to take 
up to 5 seconds are somewhat faster.  I have no formal measurements 
though.


Nicolas
