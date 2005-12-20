From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] xread/xwrite: do not worry about EINTR at calling sites.
Date: Tue, 20 Dec 2005 11:40:05 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512201136430.29711@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vhd95h02o.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0512191142410.4827@g5.osdl.org> <43A732C9.2060509@zytor.com>
 <7vvexkpoxf.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 20 11:42:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eoeux-0005H9-QW
	for gcvg-git@gmane.org; Tue, 20 Dec 2005 11:40:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbVLTKkK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Dec 2005 05:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbVLTKkK
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Dec 2005 05:40:10 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:59836 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750934AbVLTKkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2005 05:40:09 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E71EB13FB0F; Tue, 20 Dec 2005 11:40:05 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C4B0C9E08F; Tue, 20 Dec 2005 11:40:05 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id AA7989DD63; Tue, 20 Dec 2005 11:40:05 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 37B7213F3DB; Tue, 20 Dec 2005 11:40:05 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvexkpoxf.fsf_-_@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13847>

Hi,

On Mon, 19 Dec 2005, Junio C Hamano wrote:

> +static inline ssize_t xwrite(int fd, const void *buf, size_t len)
> +{
> +	ssize_t nr;
> +	while (1) {
> +		nr = write(fd, buf, len);
> +		if ((nr < 0) && (errno == EAGAIN || errno == EINTR))
> +			continue;
> +		return nr;
> +	}
> +}

In another project I'm working on, a user insisted that on Solaris 2.7, 
write(2) sometimes returns ENOENT when it really means "try again". I 
cannot verify, since I don't have Solaris 2.7.

Ciao,
Dscho
