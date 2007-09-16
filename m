From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: metastore
Date: Sun, 16 Sep 2007 11:51:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0709161054380.5298@iabervon.org>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151507310.28586@racer.site> <20070915145437.GA12875@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151430040.5298@iabervon.org> <Pine.LNX.4.64.0709152310380.28586@racer.site>
 <Pine.LNX.4.64.0709151737400.24221@asgard.lang.hm> <7vwsur590q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: david@lang.hm, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?utf-8?Q?H=C3=A4rdeman?= <david@hardeman.nu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 17:51:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWwP2-0008LR-K7
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 17:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbXIPPvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 11:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbXIPPvQ
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 11:51:16 -0400
Received: from iabervon.org ([66.92.72.58]:40656 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750816AbXIPPvP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 11:51:15 -0400
Received: (qmail 32728 invoked by uid 1000); 16 Sep 2007 15:51:06 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Sep 2007 15:51:06 -0000
In-Reply-To: <7vwsur590q.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58320>

On Sun, 16 Sep 2007, Junio C Hamano wrote:

> I however think your idea to have extra "permission information
> file" is very interesting.  What would be more palatable, than
> mucking with the core level git, would be to have an external
> command that takes two tree object names that tells it what the
> old and new trees our work tree is switching between, and have
> that command to:
> 
>  - inspect the diff-tree output to find out what were checked
>    out and might need their permission information tweaked;
> 
>  - inspect the differences between the "permission information
>    file" in these trees to find out what were _not_ checked out,
>    but still need their permission information tweaked.
> 
>  - tweak whatever external information you are interested in
>    expressing in your "permission information file" in the work
>    tree for the paths it discovered in the above two steps.
>    This step may involve actions specific to projects and call
>    hook scripts with <path, info from "permission information
>    file" for that path> tuples to carry out the actual tweaking.

Why not have the command also responsible for creating the files that need 
to be created (calling back into git to read their contents)? That way, 
there's no window where they've been created without their metadata, and 
there's more that the core git doesn't have to worry about.

I could see the program getting the index, the target tree, and the 
directory to put files in, and being told to do the whole 2-way merge 
(except, perhaps, updating the index to match the tree, which git could do 
afterwards). As far as git would be concerned, it would mostly be like a 
bare repository.

	-Daniel
*This .sig left intentionally blank*
