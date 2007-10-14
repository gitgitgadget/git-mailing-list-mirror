From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 14/14] Use the asyncronous function infrastructure to
 run the content filter.
Date: Sun, 14 Oct 2007 04:07:18 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710140404480.25221@racer.site>
References: <1192305984-22594-1-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-2-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-3-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-4-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-5-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-6-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-7-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-8-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-9-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-10-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-11-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-12-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-13-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-14-git-send-email-johannes.sixt@telecom.at>
 <1192305984-22594-15-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Oct 14 05:07:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgtpI-0002nS-Vl
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 05:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345AbXJNDHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 23:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752992AbXJNDHW
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 23:07:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:36170 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753030AbXJNDHV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 23:07:21 -0400
Received: (qmail invoked by alias); 14 Oct 2007 03:07:20 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 14 Oct 2007 05:07:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19/evp0555/InaakFp7qt879kwV/TJULxn8Ragxfb
	668eGU65fTBVmq
X-X-Sender: gene099@racer.site
In-Reply-To: <1192305984-22594-15-git-send-email-johannes.sixt@telecom.at>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60795>

Hi,

On Sat, 13 Oct 2007, Johannes Sixt wrote:

>  	status = finish_command(&child_process);
>  	if (status)
> -		error("external filter %s failed %d", cmd, -status);
> +		error("external filter %s failed", params->cmd);

Did you mean to remove the status from the output (it should probably read 
"(exit status %d)" instead of just "%d", but an exit status can help 
identify problems, right?


> -	child_process.pid = fork();
> -	if (child_process.pid < 0) {
> -		error("cannot fork to run external filter %s", cmd);
> -		close(pipe_feed[0]);
> -		close(pipe_feed[1]);
> -		return NULL;
> -	}
> -	if (!child_process.pid) {
> -		close(pipe_feed[0]);
> -		exit(filter_buffer(pipe_feed[1], src, *sizep, cmd));
> -	}
> -	close(pipe_feed[1]);
> +	if (start_async(&async))
> +		return 0;	/* error was already reported */

Please write "return NULL;"

Thanks,
Dscho
