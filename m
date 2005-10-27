From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] multi_ack protocol v2
Date: Thu, 27 Oct 2005 12:47:24 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510271227490.2724@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0510270149590.12163@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzmov4elu.fsf@assigned-by-dhcp.cox.net> <20051027141619.0e8029f2.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 27 12:48:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EV5IV-0003F4-Ip
	for gcvg-git@gmane.org; Thu, 27 Oct 2005 12:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932641AbVJ0Kr1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 06:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932644AbVJ0Kr1
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 06:47:27 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:49282 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932641AbVJ0Kr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 06:47:26 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D19C913F43C; Thu, 27 Oct 2005 12:47:25 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B65AB9EFB6; Thu, 27 Oct 2005 12:47:25 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8EEEE9AAB0; Thu, 27 Oct 2005 12:47:25 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 333BD13F43C; Thu, 27 Oct 2005 12:47:25 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Sergey Vlasov <vsu@altlinux.ru>
In-Reply-To: <20051027141619.0e8029f2.vsu@altlinux.ru>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10712>

Hi,

On Thu, 27 Oct 2005, Sergey Vlasov wrote:

> Actually, there is another way to pass some data from the server
> which would be ignored by older clients - at the first stage,
> when upload-pack sends the list of refs to the client:
> 
> 	packet_write(1, "%s %s%c%s\n", sha1_to_hex(sha1), refname, '\0',
> 		     server_capabilities);

That exploits that packet_write() uses vnsprintf() to find out the length,
not strlen(). Sweet.

get_remote_heads() would need to store the server_capabilities, maybe with 
a function "server_supports(const char *extension_string)" 

Actually, I like that even more than Junio's proposal. I was thinking hard 
about how to enhance get_ack() to understand -- and most importantly to 
return -- the capabilities. I could not think of an elegant way.

So, unless people complain, I'll go with that approach.

> This looks cleaner (no NUL bytes in the protocol), but does not
> allow to replace the "want" stage with something entirely
> different (if we ever want to do that).

Also it feels wrong that a client should ask for capabilities, where it 
does not yet know if the server supports them.

Ciao,
Dscho
