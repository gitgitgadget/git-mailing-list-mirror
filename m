From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/4] Move remove_path() into libgit.a
Date: Wed, 24 Jan 2007 16:07:16 -0800
Message-ID: <7v7ivcdl57.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0701240213020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 25 01:07:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9s9C-00087O-It
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 01:07:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932879AbXAYAHT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 19:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752099AbXAYAHS
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 19:07:18 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:41080 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098AbXAYAHR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 19:07:17 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070125000716.DQUL2628.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Wed, 24 Jan 2007 19:07:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id FC7b1W0021kojtg0000000; Wed, 24 Jan 2007 19:07:35 -0500
In-Reply-To: <Pine.LNX.4.63.0701240213020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 24 Jan 2007 02:13:31 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37693>

We seem to have variants of the seme theme in many places.

 * builtin-apply.c::remove_file()
 * builtin-rm.c::remove_file() -- this one leaks the strdup result
 * refs.c::remove_empty_dir_recursive()
 * unpack-trees.c::unlink_entry() 
 * mrege-recursive.c::remove_path()

It would be nicer to consolidate their "remove the now
potentially empty directories recursively" part in a single
function and have them call it.

Some of them try to be more efficient by not allocating an extra
string (because they know the string supplied by the caller is a
fair game), so the clean-up might be slightly involved, but I
think it is worth it.

 
	
