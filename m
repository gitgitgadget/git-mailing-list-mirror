From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH] remote-bzr: reuse bzrlib transports when possible
Date: Sat, 07 Sep 2013 20:02:15 -0400
Message-ID: <522BBE87.10206@bbn.com>
References: <1378598300-22737-1-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, felipe.contreras@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 08 02:02:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VISSN-00059w-7l
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 02:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846Ab3IHACT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 20:02:19 -0400
Received: from smtp.bbn.com ([128.33.0.80]:30356 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770Ab3IHACS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 20:02:18 -0400
Received: from socket.bbn.com ([192.1.120.102]:55592)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VISSH-000PNj-39; Sat, 07 Sep 2013 20:02:17 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 7E79A3FF4D
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <1378598300-22737-1-git-send-email-rhansen@bbn.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234149>

On 2013-09-07 19:58, Richard Hansen wrote:
> Pass a list of open bzrlib.transport.Transport objects to each bzrlib
> function that might create a transport.  This enables bzrlib to reuse
> existing transports when possible, avoiding multiple concurrent
> connections to the same remote server.
> 
> If the remote server is accessed via ssh, this fixes a couple of
> problems:
>   * If the user does not have keys loaded into an ssh agent, the user
>     may be prompted for a password multiple times.
>   * If the user is using OpenSSH and the ControlMaster setting is set
>     to auto, git-remote-bzr might hang.  This is because bzrlib closes
>     the multiple ssh sessions in an undefined order and might try to
>     close the master ssh session before the other sessions.  The
>     master ssh process will not exit until the other sessions have
>     exited, causing a deadlock.  (The ssh sessions are closed in an
>     undefined order because bzrlib relies on the Python garbage
>     collector to trigger ssh session termination.)

I forgot to mention:  I didn't add a Signed-off-by line because there is
no mention of a copyright license at the top of git-remote-bzr.

-Richard
