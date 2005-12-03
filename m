From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git pull aborts in 50% of cases
Date: Fri, 02 Dec 2005 20:22:54 -0800
Message-ID: <43911D9E.5030803@zytor.com>
References: <20051202190412.GA10757@mipter.zuzino.mipt.ru>	<43909963.60901@zytor.com>	<20051202211250.GA11384@mipter.zuzino.mipt.ru>	<4390B64E.20601@zytor.com>	<Pine.LNX.4.63.0512030316520.19086@wbgn013.biozentrum.uni-wuerzburg.de> <7vu0dq29wg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 03 05:23:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiOvh-0003cE-Is
	for gcvg-git@gmane.org; Sat, 03 Dec 2005 05:23:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbVLCEXH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 23:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbVLCEXH
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 23:23:07 -0500
Received: from terminus.zytor.com ([192.83.249.54]:64730 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751123AbVLCEXG
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 2 Dec 2005 23:23:06 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jB34Ms6Z030143
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 2 Dec 2005 20:22:55 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0dq29wg.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.7 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13145>

Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> 
>>>0.99.9k is clearly bad.
>>
>>Huh? It could be slower, and it could therefore hit the maximum client 
>>count faster, but it should not be bad.
>>
>>All changes to pull were done in a manner so as to be backward compatible. 
>>In both ways.
> 
> 
> I do not think the fetch-pack common computation changes is
> involved in this problem at all.
> 
> What is suspect is the repository validity check code,
> specifically (quoting from diff between 0.99.9j and 0.99.9k
> daemon.c::path_ok() function):
> 
> +               /* The validation is done on the paths after enter_repo
> +                * canonicalization, so whitelist should be written in
> +                * terms of real pathnames (i.e. after ~user is expanded
> +                * and symlinks resolved).
> +                */
> 
> I suspect (but have not heard back from HPA to confirm) that
> kernel.org runs git-daemon with /pub/scm as the whitelist, but
> there is a symbolic link (or bind mount?) involved, and the real
> path checked based on getcwd() return value is somewhere else.

/pub is a symbolic link.  We shouldn't rely on getcwd() for this kind of 
stuff; it's bad for a whole bunch of reasons.

	-hpa
