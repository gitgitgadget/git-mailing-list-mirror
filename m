From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Today's 'master' leaves .idx/.pack in 0400
Date: Sun, 22 Apr 2007 12:29:55 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704221225300.9964@woody.linux-foundation.org>
References: <7vhcrml4wx.fsf@assigned-by-dhcp.cox.net> <7v1widrl0o.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0704221019100.9964@woody.linux-foundation.org>
 <7vvefonvdz.fsf@assigned-by-dhcp.cox.net> <7vmz10nv1h.fsf_-_@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0704221422250.28339@xanadu.home> <7vejmcnu28.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0704221431430.28339@xanadu.home>
 <alpine.LFD.0.98.0704221144250.9964@woody.linux-foundation.org>
 <7vy7kkmdtg.fsf@assigned-by-dhcp.cox.net>
 <7vd51wmd1a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 22 21:30:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hfhll-0006XY-Rt
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 21:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030767AbXDVTal (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 15:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030727AbXDVTal
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 15:30:41 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:35861 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030524AbXDVTak (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Apr 2007 15:30:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3MJTu8P026370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 22 Apr 2007 12:29:57 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3MJTt3n032569;
	Sun, 22 Apr 2007 12:29:55 -0700
In-Reply-To: <7vd51wmd1a.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3.04 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45270>



On Sun, 22 Apr 2007, Junio C Hamano wrote:
> 
> How about this as a replacement (hot off the press -- still
> running the tests).

Looks good, but..

> +		mode_t mode = umask(0);
> +
> +		umask(mode);
> +		mode = 0666 & ~mode;

I would really suggest just defaulting to

	mode = 0444 & ~mode;

since there simply is never any reason to allow a writable pack-file.

The fact that we have some tests that try to corrupt a pack-file is not 
really a reason. Just make them do "chmod +w" before corrupting it.

But your patch is an obvious improvement regardless, so I certainly don't 
think this is a *big* issue.

		Linus
