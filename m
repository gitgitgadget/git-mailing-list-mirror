From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] sha1_file.c (write_sha1_from_fd): Detect close failure.
Date: Mon, 26 Mar 2007 16:42:59 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703261636410.3041@xanadu.home>
References: <874po8umyk.fsf@rho.meyering.net>
 <7v8xdjwxr4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Jim Meyering <jim@meyering.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 26 22:43:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVw1x-0002BY-A3
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 22:43:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbXCZUnB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 16:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752988AbXCZUnB
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 16:43:01 -0400
Received: from relais.videotron.ca ([24.201.245.36]:64598 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbXCZUnA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 16:43:00 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JFJ0010B2VN5940@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 26 Mar 2007 16:42:59 -0400 (EDT)
In-reply-to: <7v8xdjwxr4.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43184>

On Mon, 26 Mar 2007, Junio C Hamano wrote:

> Hmph.  Not catching error from close() is wrong, so this is an
> improvement, but it still leaves tmpfile on the filesystem,
> doesn't it?
> 
> Looking at write_sha1_file(), which is in a sense more important
> than this function, it is worse.  We should also detect error
> from close(), nuke the temporary file and return an error there.

Actually, the temp file is always left there whenever there is an error 
or die() is called or CTRL_C is issued.

I don't think it is worth bothering with the removal of temp files given 
all the cases that would have to be considered, and most probably not 
exercised that often (increasing their likelihood of bing buggy).

Instead, teaching git-purge about those tmp files might be a better 
idea.


Nicolas
