From: Edgar Toernig <froese@gmx.de>
Subject: Re: [RFC] sending errors to stdout under $PAGER
Date: Sun, 17 Feb 2008 14:48:54 +0100
Message-ID: <20080217144854.56fcb98d.froese@gmx.de>
References: <7vbq6g90gy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 14:49:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQjtd-0004Pb-HA
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 14:49:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754690AbYBQNs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 08:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754634AbYBQNs7
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 08:48:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:60717 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752563AbYBQNs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 08:48:58 -0500
Received: (qmail invoked by alias); 17 Feb 2008 13:48:56 -0000
Received: from p5B010569.dip0.t-ipconnect.de (EHLO dialup) [91.1.5.105]
  by mail.gmx.net (mp055) with SMTP; 17 Feb 2008 14:48:56 +0100
X-Authenticated: #271361
X-Provags-ID: V01U2FsdGVkX1/2lRZTx/H2mbkT+StLbGALsrrfi2BaZvI2rQATgu
	fBbpeH45AhVUa8
In-Reply-To: <7vbq6g90gy.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74131>

Junio C Hamano wrote:
>
> +	FILE *outto = (pager_in_use() ? stdout : stderr);
> +
>  	vsnprintf(msg, sizeof(msg), err, params);
> -	fprintf(stderr, "%s%s\n", prefix, msg);
> +	fprintf(outto, "%s%s\n", prefix, msg);
>
> What do people think?  Have I overlooked any downsides?

Wouldn't it be better/safer to redirect stderr to the pager
in the first place?

So, instead of the current

	foo | less
use
	foo 2>&1 | less

or, in pager.c:

         /* return in the child */
        if (!pid) {
                dup2(fd[1], 1);
+               dup2(fd[1], 2);
                close(fd[0]);
                close(fd[1]);
                return;
        }

Ciao, ET.
