From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 3/3] Make clear_commit_marks() clean harder
Date: Mon, 3 Jul 2006 15:55:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607031552410.12404@g5.osdl.org>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org>
 <7vy7vedntn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606302046230.12404@g5.osdl.org>
 <20060701150926.GA25800@lsrfire.ath.cx> <7vfyhldvd2.fsf@assigned-by-dhcp.cox.net>
 <44A6CD1D.2000600@lsrfire.ath.cx> <Pine.LNX.4.64.0607011301480.12404@g5.osdl.org>
 <7vveqhccnk.fsf@assigned-by-dhcp.cox.net> <7vpsgpccak.fsf@assigned-by-dhcp.cox.net>
 <20060701232958.GC2513@lsrfire.ath.cx> <7vejx3rq33.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0607031553570.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzmfqqxlh.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0607032309190.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 00:55:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxXJy-0004ha-Tl
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 00:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWGCWzL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 18:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWGCWzK
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 18:55:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36540 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751178AbWGCWzJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 18:55:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k63Mt1nW000650
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 3 Jul 2006 15:55:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k63Mt0q5005132;
	Mon, 3 Jul 2006 15:55:00 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607032309190.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23221>



On Mon, 3 Jul 2006, Johannes Schindelin wrote:
> 
> Traversing is actually wrong. Clearing the marks does not mean to clear 
> them on commits we did not even mark!

If we didn't mark them, then clearing them would be a no-op, so nobody 
really cares.

> But clearing on commits we _have_ -- but not parsed -- is important, 
> obviously.

Right. The point is, some logic can choose to mark commits UNINTERESTING 
without even parsing that commit, and it would be a good thing. You only 
need to parse the commit once you decide that you need its parents (or 
it's tree, of course), but you may be able to mark it uninteresting before 
that.

This is why it is _wrong_ to care about the "parsed" bit when clearing the 
flags.

		Linus
