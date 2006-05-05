From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] binary patch.
Date: Fri, 05 May 2006 10:38:46 -0700
Message-ID: <7vejz8z80p.fsf@assigned-by-dhcp.cox.net>
References: <7vodyd2vqn.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605042241240.28543@localhost.localdomain>
	<7vwtd10xyd.fsf@assigned-by-dhcp.cox.net>
	<7vy7xgzsiu.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605051128100.28543@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 05 19:39:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fc4H1-00027R-5O
	for gcvg-git@gmane.org; Fri, 05 May 2006 19:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbWEERiv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 13:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbWEERiu
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 13:38:50 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:27079 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751697AbWEERis (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 May 2006 13:38:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060505173847.YXRL25692.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 5 May 2006 13:38:47 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0605051128100.28543@localhost.localdomain>
	(Nicolas Pitre's message of "Fri, 05 May 2006 11:41:32 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19619>

Nicolas Pitre <nico@cam.org> writes:

>> +	delta = NULL;
>> +	deflated = deflate_it(two->ptr, two->size, &deflate_size);
>> +	if (one->size && two->size) {
>> +		delta = diff_delta(one->ptr, one->size,
>> +				   two->ptr, two->size,
>> +				   &delta_size, deflate_size);
>
> Here you probably want to use deflate_size-1 (deflate_size can't be 0).

I am not sure if -1 is worth here.

The delta is going to be deflated and hopefully gets a bit
smaller, so if we really care that level of detail, it might be
worth to do (deflate_size*3/2) or something like that here, use
delta with or without deflate whichever is smaller, and mark the
uncompressed delta with a different tag ("uncompressed delta"?).
And for symmetry, to deal with uncompressible data, we may want
to have "uncompressed literal" as well.

>> +		orig_size = delta_size;
>> +		if (delta)
>> +			delta = deflate_it(delta, delta_size, &delta_size);
>
> Here you're leaking the original delta buffer memory.

Indeed.  Thanks.
