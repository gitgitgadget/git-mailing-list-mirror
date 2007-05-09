From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH v2] Custom compression levels for objects and packs
Date: Wed, 09 May 2007 09:26:25 -0700
Message-ID: <7vlkfyt13i.fsf@assigned-by-dhcp.cox.net>
References: <4640FBDE.1000609@gmail.com>
	<7vk5vi27ko.fsf@assigned-by-dhcp.cox.net>
	<56b7f5510705081725v655d2ce1j28712507cfa7fa55@mail.gmail.com>
	<alpine.LFD.0.99.0705082106590.24220@xanadu.home>
	<56b7f5510705090221g38ab0973x8631dacc601abb16@mail.gmail.com>
	<alpine.LFD.0.99.0705091048120.24220@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dana How <danahow@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed May 09 18:26:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlozv-0001Z1-HM
	for gcvg-git@gmane.org; Wed, 09 May 2007 18:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755718AbXEIQ02 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 12:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755892AbXEIQ02
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 12:26:28 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:56402 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755718AbXEIQ01 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 12:26:27 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070509162627.PVRO22040.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 9 May 2007 12:26:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id x4SS1W00Q1kojtg0000000; Wed, 09 May 2007 12:26:27 -0400
In-Reply-To: <alpine.LFD.0.99.0705091048120.24220@xanadu.home> (Nicolas
	Pitre's message of "Wed, 09 May 2007 11:27:28 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46741>

Nicolas Pitre <nico@cam.org> writes:

> So I suggest that we get rid of core.legacyheaders, preserve the legacy 
> format as the only writable loose object format and deprecate the other 
> one to keep things simpler.  Thoughts?

I agree with your analysis, especially when deeper delta chains
are allowed, straight copy of loose object becomes less and less
likely.

> What we need instead is a --no-reuse-object that would force 
> recompression of everything when you really want to enforce a specific 
> compression level across the whole pack(s).

Yeah.  Or maybe --no-reuse to mean both and make '-f' a
short-hand synonym for that.

I do not see much reason to want to tweak them independently;
recomputing delta is much more expensive than recompressing
anyway, and when the user says 'repack -f', it is a sign that
the user is willing to spend CPU cycles.
