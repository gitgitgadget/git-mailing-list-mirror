From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] Make clear_commit_marks() clean harder
Date: Mon, 03 Jul 2006 12:47:54 -0700
Message-ID: <7vzmfqqxlh.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org>
	<7vy7vedntn.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606302046230.12404@g5.osdl.org>
	<20060701150926.GA25800@lsrfire.ath.cx>
	<7vfyhldvd2.fsf@assigned-by-dhcp.cox.net>
	<44A6CD1D.2000600@lsrfire.ath.cx>
	<Pine.LNX.4.64.0607011301480.12404@g5.osdl.org>
	<7vveqhccnk.fsf@assigned-by-dhcp.cox.net>
	<7vpsgpccak.fsf@assigned-by-dhcp.cox.net>
	<20060701232958.GC2513@lsrfire.ath.cx>
	<7vejx3rq33.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0607031553570.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 03 21:48:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxUOk-0005YZ-OJ
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 21:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWGCTr4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 15:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWGCTr4
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 15:47:56 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:25341 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751261AbWGCTrz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jul 2006 15:47:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060703194755.PNZY22974.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 3 Jul 2006 15:47:55 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607031553570.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Mon, 3 Jul 2006 15:56:44 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23195>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > Don't care if objects have been parsed or not and don't stop when we
>> > reach a commit that is already clean -- its parents could be dirty.
>> 
>> There is something quite wrong with this patch.
>
> I always had the feeling that it was wrong to traverse not-yet-parsed 
> parents: How could a revision walk possibly come to a certain commit 
> without at least one continuous history of now-parsed objects?
>
> Also, AFAIK the revision walk sets flags for each commit it touched, and 
> we should not try to be smart-asses about the flags, but just unset these 
> flags.

The main points were made by Linus already.

Traversing is not needed -- not clearing not-yet-parsed is
obviously wrong.

> BTW some very quick tests showed that the clear_commit_marks() thing that 
> I sent to the list was much faster than traversing all objects (which was 
> in my original version).

I have a crude workaround pushed out last night but will be
replacing it with something less drastic.  I think the final
version should be what you had, perhaps minus not looking at the
parsed flag for unmarking purposes.
