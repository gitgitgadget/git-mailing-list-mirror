From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Replacing the system call pread() with
 lseek()/xread()/lseek() sequence.
Date: Tue, 09 Jan 2007 14:48:12 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701091446150.4964@xanadu.home>
References: <11683687161816-git-send-email-@videotron.ca>
 <11683687162492-git-send-email-@videotron.ca>
 <11683687161239-git-send-email-@videotron.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 20:48:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4MxF-0000dk-Iv
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 20:48:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbXAITsP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 14:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbXAITsP
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 14:48:15 -0500
Received: from relais.videotron.ca ([24.201.245.36]:20035 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932251AbXAITsO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 14:48:14 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JBM001AJ9OCK920@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 09 Jan 2007 14:48:12 -0500 (EST)
In-reply-to: <11683687161239-git-send-email-@videotron.ca>
X-X-Sender: nico@xanadu.home
To: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36390>

On Tue, 9 Jan 2007, Stefan-W. Hahn wrote:

> --- /dev/null
> +++ b/compat/pread.c
> @@ -0,0 +1,15 @@
> +#include "../git-compat-util.h"
> +
> +ssize_t git_pread(int fd,void *buf,size_t count,off_t offset)
> +{
> +        off_t current_offset = lseek(fd, 0, SEEK_CUR);
> +
> +        if (lseek(fd, offset, SEEK_SET) < 0)
> +                return EINVAL;

You certainly wanted to return -1 here.

> +
> +        ssize_t rc=xread(fd, buf, count);
> +
> +        if (current_offset != lseek(fd, current_offset, SEEK_SET))
> +                return EINVAL;

Ditto here.

> +        return rc;
> +}


Nicolas
