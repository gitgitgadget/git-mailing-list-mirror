From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Client-side mirroring patches (v0)
Date: Wed, 25 Nov 2009 16:58:37 -0800
Message-ID: <20091126005837.GN11919@spearce.org>
References: <1259143617-26580-1-git-send-email-sam@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Nov 26 01:58:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDSh4-0005sT-IG
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 01:58:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759870AbZKZA6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 19:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759552AbZKZA6c
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 19:58:32 -0500
Received: from george.spearce.org ([209.20.77.23]:37349 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759349AbZKZA6b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 19:58:31 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id E0ACD3842F; Thu, 26 Nov 2009 00:58:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1259143617-26580-1-git-send-email-sam@vilain.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133745>

Sam Vilain <sam@vilain.net> wrote:
> Hey folks, this is the first stage of git mirroring 
...
> Also there is the matter of falling over to the next mirror should one
> not be reachable, but then we're getting into C weaknesses really.
> Should I plan to do exception recovery using 'longjmp' ? 

Please don't use longjmp.

You'll have to change the code to not die() upon connection failure,
but instead return an error code to the higher level which can
locate another mirror and retry.

> Also the
> process should be interruptible and provide a user menu.  Again this
> seems like it would be very tedious and clumsy in C.  How do people
> manage?

With great pain.  :-)

To do a user menu you can do a simple interface like `git add -i`
does, which just dumps the choices to stdout and a prompt for the
user to enter their selection.  If you want something more complex
you need to link to curses or ncurses, which IIRC opens some issues
with portablity, but lets you do a bit nicer interface on the tty.

-- 
Shawn.
