From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 4/8] git-repack --max-pack-size: add fixup_header_footer()
Date: Mon, 09 Apr 2007 15:33:50 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704091525260.28181@xanadu.home>
References: <46197950.3080804@gmail.com>
 <7vwt0m76rv.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0704082012220.28181@xanadu.home>
 <20070409173858.GT5436@spearce.org>
 <alpine.LFD.0.98.0704091404530.28181@xanadu.home>
 <20070409184039.GZ5436@spearce.org>
 <56b7f5510704091211i3d101cafq371fbb96ca27238b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 02:14:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hazcg-0006ur-OU
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 21:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906AbXDITdv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 15:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752921AbXDITdv
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 15:33:51 -0400
Received: from relais.videotron.ca ([24.201.245.36]:44023 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752906AbXDITdu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 15:33:50 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG8006YNX0EGSI0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 09 Apr 2007 15:33:50 -0400 (EDT)
In-reply-to: <56b7f5510704091211i3d101cafq371fbb96ca27238b@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44089>

On Mon, 9 Apr 2007, Dana How wrote:

> Wouldn't the following address the "object count unknown
> at the start of sequential pack writing" problem:
>  Write 0 for object count in the header. This is a flag to look for
>  another header of same format just before the final SHA-1 which
>  has the correct count. The SHA-1 is still a checksum of everything
>  before it and no seeking/rewriting is needed on generation.

No.  You really wants to know up front how many objects a pack contains 
when streaming it.  And this is not only for packs written to stdout.

> Finally, when I generate several 2GB split packfiles,  I do notice
> the slight delay for fixup_header_footer(), and I do think it's a bit
> ugly, but in quantitative terms it's an insignificant part of a long
> operation that's infrequently performed.  Does this need to be
> optimized at all?

Maybe, maybe not.  That depends how much data we think GIT could be used 
to manage in the future.  With a 1TB pack file you definitely want to 
optimize that case.

OTOH this could wait for the real pack v4 too.


Nicolas
