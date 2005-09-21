From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Make object creation in http fetch a bit safer.
Date: Wed, 21 Sep 2005 11:55:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509211140230.23242@iabervon.org>
References: <7vd5n2ycbe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 17:53:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EI6s0-0006Aa-Iy
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 17:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbVIUPuu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 11:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbVIUPuu
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 11:50:50 -0400
Received: from iabervon.org ([66.92.72.58]:35338 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751101AbVIUPut (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 11:50:49 -0400
Received: (qmail 8808 invoked by uid 1000); 21 Sep 2005 11:55:09 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Sep 2005 11:55:09 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5n2ycbe.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9052>

On Wed, 21 Sep 2005, Junio C Hamano wrote:

> Unlike write_sha1_file() that tries to create the object file in a
> temporary location and then move it to the final location, fetch_object
> could have been interrupted in the middle, leaving a corrupt file.

Looks fine to me, although it should possibly share the code somehow with 
write_sha1_file().

>  I think the packfile side is safer -- the index is verified
>  with the call to parse_pack_index() which eventually calls
>  check_packed_git_idx() to validate it, and the pack file is
>  checked when it is first used, just like any pack file we
>  originally had.  Ideally, we should validate the pair after
>  downloading with git-verify-pack, though.

Well, with verify_pack(), anyway. No need to prepare a command line, fork, 
exec, and parse it, just to call a library function.

I think we want to have the partial file in the destination location, and 
maybe teach http-fetch about resuming the download, since it takes 
significant time to download a single pack, and it would be nice to be 
able to use the part we've got if we get interrupted.

	-Daniel
*This .sig left intentionally blank*
