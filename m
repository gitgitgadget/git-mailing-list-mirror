From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] binary patch.
Date: Fri, 05 May 2006 11:41:32 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0605051128100.28543@localhost.localdomain>
References: <7vodyd2vqn.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0605042241240.28543@localhost.localdomain>
 <7vwtd10xyd.fsf@assigned-by-dhcp.cox.net>
 <7vy7xgzsiu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 05 17:42:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fc2Qz-00054B-5d
	for gcvg-git@gmane.org; Fri, 05 May 2006 17:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbWEEPle (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 11:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbWEEPle
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 11:41:34 -0400
Received: from relais.videotron.ca ([24.201.245.36]:48300 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751140AbWEEPld (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 May 2006 11:41:33 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IYS00ER6U984U30@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 05 May 2006 11:41:33 -0400 (EDT)
In-reply-to: <7vy7xgzsiu.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19614>

On Fri, 5 May 2006, Junio C Hamano wrote:

> > Yeah, things still to be done are deflating both delta and
> > optionally perhaps use just deflate without delta for "new file"
> > codepath.

> +	/* We could do deflated delta, or we could do just deflated two,
> +	 * whichever is smaller.
> +	 */
> +	delta = NULL;
> +	deflated = deflate_it(two->ptr, two->size, &deflate_size);
> +	if (one->size && two->size) {
> +		delta = diff_delta(one->ptr, one->size,
> +				   two->ptr, two->size,
> +				   &delta_size, deflate_size);

Here you probably want to use deflate_size-1 (deflate_size can't be 0).

> +		orig_size = delta_size;
> +		if (delta)
> +			delta = deflate_it(delta, delta_size, &delta_size);

Here you're leaking the original delta buffer memory.


Nicolas
