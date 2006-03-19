From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cloning from sites with 404 overridden
Date: Sun, 19 Mar 2006 11:37:01 -0800
Message-ID: <7vk6aqql9e.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550603190252n7e3e1cbbp94e3f15c92f12d07@mail.gmail.com>
	<4d8e3fd30603190525o5a01fba8w5bcdedd064c213ec@mail.gmail.com>
	<e5bfff550603190604ne4364f3o6a862d25267a2dce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Mar 19 20:37:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FL3i9-0002XZ-Ir
	for gcvg-git@gmane.org; Sun, 19 Mar 2006 20:37:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWCSThG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Mar 2006 14:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWCSThG
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Mar 2006 14:37:06 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:21475 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750744AbWCSThE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Mar 2006 14:37:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060319193542.GCNX3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 19 Mar 2006 14:35:42 -0500
To: "Marco Costalba" <mcostalba@gmail.com>
In-Reply-To: <e5bfff550603190604ne4364f3o6a862d25267a2dce@mail.gmail.com>
	(Marco Costalba's message of "Sun, 19 Mar 2006 15:04:43 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17719>

"Marco Costalba" <mcostalba@gmail.com> writes:

> http://digilander.libero.it /mcostalba/scm/qgit.git/objects/8d/ea03519e75f47d
>
> Git does not understand object is missing and thinks what site sends
> _is_ the requested
> object and then founds that is (of course) corrupted.

To be fair, the site is _not_ missing anything from HTTP
protocol perspective, because when git asks 8d/ea0351... file,
the server responds with a regular "HTTP/1.0 200 OK" response.
So it is _your_ repository that is corrupt -- instead of
correctly _lacking_ the file you should have removed with
prune-packed, it has a garbage file.

Having said that, I agree that it would be nicer if we support
such a site, in the same spirit that we already bend backwards
to support really dumb hosted http servers that do not give
directory index by using objects/info/packs and info/refs.

I think it wouldn't be too much a hassle to add logic to
http-fetch.c (perhaps with an additional "--no-404" option or
somesuch) to fall back on pack transfer upon seeing a corrupt
loose object.  We do the falling back when getting 404 error to
a request for a loose object, so the new code would essentially
do the same and you might be OK.
