From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git-upload-pack: the timeout gets corrupted?!
Date: Sun, 11 Mar 2007 01:23:59 -0800
Message-ID: <45F3CAAF.7030909@zytor.com>
References: <45F35F38.1080206@zytor.com> <7vy7m4wcfb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 11 10:24:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQKHm-0001Sq-80
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 10:24:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbXCKJYL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 05:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbXCKJYL
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 05:24:11 -0400
Received: from terminus.zytor.com ([192.83.249.54]:35391 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbXCKJYK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 05:24:10 -0400
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id l2B9O0CY023061
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 11 Mar 2007 01:24:00 -0800
User-Agent: Thunderbird 1.5.0.9 (X11/20070212)
In-Reply-To: <7vy7m4wcfb.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV 0.88.7/2806/Sun Mar 11 00:36:34 2007 on terminus.zytor.com
X-Virus-Status: Clean
X-Spam-Status: No, score=2.3 required=5.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_96_XX,PLING_QUERY,RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL
	autolearn=no version=3.1.8
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.1.8 (2007-02-13) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41917>

Junio C Hamano wrote:
> 
>> The process spends effectively forever waiting in on the fflush() in
>> show_commit() (in upload-pack.c); /proc/*/fd shows it is trying to
>> write to a pipe, but I'm not sure what is at the other end of that
>> same pipe.
> 
> The process forks and the one that runs show_commit() is running
> rev-list internally while the other end is a pack-objects that
> reads from it and sends its output back to the client.
> 

Now, given that the fact that the git-pack-object process has already 
died, normally one would expect the write() to get SIGPIPE which would 
kill the process.  Does git-upload-pack not close the read end of the 
pipe in the writer?  From the looks of the fd directory, I would say it 
does not.

	-hpa
