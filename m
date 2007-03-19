From: Junio C Hamano <junkio@cox.net>
Subject: Re: git push to a non-bare repository
Date: Sun, 18 Mar 2007 23:44:51 -0700
Message-ID: <7vzm69ivfg.fsf@assigned-by-dhcp.cox.net>
References: <vpq648ye9w6.fsf@olympe.imag.fr>
	<20070319020053.GA11371@thunk.org>
	<7vr6rmm1y9.fsf@assigned-by-dhcp.cox.net>
	<20070319022143.GF20658@spearce.org>
	<20070319024744.GD11371@thunk.org>
	<20070319025603.GG20658@spearce.org>
	<20070319032130.GF11371@thunk.org>
	<20070319035351.GI20658@spearce.org>
	<alpine.LFD.0.83.0703182355570.18328@xanadu.home>
	<20070319062525.GH11371@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 19 07:44:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTBby-0000m9-T7
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 07:44:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965724AbXCSGoy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 02:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965726AbXCSGox
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 02:44:53 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:34193 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965724AbXCSGow (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 02:44:52 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070319064452.VQOY18070.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Mon, 19 Mar 2007 02:44:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cWkr1W0081kojtg0000000; Mon, 19 Mar 2007 02:44:52 -0400
In-Reply-To: <20070319062525.GH11371@thunk.org> (Theodore Tso's message of
	"Mon, 19 Mar 2007 02:25:25 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42596>

Theodore Tso <tytso@mit.edu> writes:

> Right, but if the branch being pointed to is pointed to by HEAD I
> would argue that the reflog for HEAD should be updated, since
> operations that reference HEAD will see a new commit, and and it will
> be confusing when "git reflog" shows no hint of the change.
>
> Of couse, if the branch being pushed to isn't one which is pointed by
> HEAD, of course HEAD's reflog shouldn't be updated.

If we were to do this properly, we probably would need to
restructure the reflog update code for the HEAD in a major way.
"git-update-ref refs/heads/foo $newvalue" when HEAD points at
branch 'foo' currently does not update HEAD reflog because the
current definition of HEAD reflog is (as Nico mentioned) log of
changes made through HEAD symref.  Instead, we would need a
reverse lookup every time any ref is updated to see if that ref
is pointed by any symbolics ref and update the reflogs of those
symbolic refs.  This is expensive to do in general, though,
because there is no backpointer to list of symbolic refs that
point at a non-symbolic ref.
