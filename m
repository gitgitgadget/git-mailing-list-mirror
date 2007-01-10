From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Don't die in git-http-fetch when fetching packs.
Date: Tue, 09 Jan 2007 17:10:04 -0800
Message-ID: <7v1wm3hekz.fsf@assigned-by-dhcp.cox.net>
References: <20070110010452.GA30610@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 02:10:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Ryl-00039e-Be
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 02:10:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932606AbXAJBKH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 20:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbXAJBKH
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 20:10:07 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:60038 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932614AbXAJBKG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 20:10:06 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070110011004.XYRV29122.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Tue, 9 Jan 2007 20:10:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9D9E1W00J1kojtg0000000; Tue, 09 Jan 2007 20:09:14 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070110010452.GA30610@spearce.org> (Shawn O. Pearce's message
	of "Tue, 9 Jan 2007 20:04:52 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36459>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> My sp/mmap changes to pack-check.c modified the function such that
> it expects packed_git.pack_size to be populated with the total
> bytecount of the packfile by the caller.
>
> But that isn't the case for packs obtained by git-http-fetch as
> pack_size was not initialized before being accessed.  This caused
> verify_pack to think it had 2^32-21 bytes available when the
> downloaded pack perhaps was only 305 bytes in length.  The use_pack
> function then later dies with "offset beyond end of packfile"
> when computing the overall file checksum.
>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>
>  For the tip of my sp/mmap topic.  Without it HTTP fetch and push
>  support is severely broken as it cannot deal with packs.

Ah, thanks.  I've seen this today and a repeated fetch after
that fixed it and thought it was a mirroring lag.
