From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] daemon whitelist handling (Re: git pull aborts in 50% of
 cases)
Date: Sat, 03 Dec 2005 11:41:17 -0800
Message-ID: <4391F4DD.2060002@zytor.com>
References: <20051202190412.GA10757@mipter.zuzino.mipt.ru>	<43909963.60901@zytor.com>	<20051202211250.GA11384@mipter.zuzino.mipt.ru>	<4390B64E.20601@zytor.com>	<Pine.LNX.4.63.0512030316520.19086@wbgn013.biozentrum.uni-wuerzburg.de>	<7vu0dq29wg.fsf@assigned-by-dhcp.cox.net> <43911D9E.5030803@zytor.com>	<7vpsoezf6y.fsf@assigned-by-dhcp.cox.net> <7vzmnivuz8.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 03 20:42:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EidGM-0002Mh-3q
	for gcvg-git@gmane.org; Sat, 03 Dec 2005 20:41:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbVLCTlf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Dec 2005 14:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbVLCTlf
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Dec 2005 14:41:35 -0500
Received: from terminus.zytor.com ([192.83.249.54]:51102 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750725AbVLCTle
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 3 Dec 2005 14:41:34 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jB3JfHjg013835
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 3 Dec 2005 11:41:18 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmnivuz8.fsf_-_@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13164>

Junio C Hamano wrote:
> 
> For example, I can by mistake create a symbolic link:
> 
> 	ln -s /home /pub/scm/git/git.git/oops
> 
> now accesses /pub/scm/git/oops/hpa/secret.git/ is not
> restricted.  We could hand-resolve the each level from the
> request to see if no "funny" symbolic links are involved, but
> what is the definition of "funny"?  When we see /pub pointing at
> somewhere in /mnt/disk47/slice31, we should not complain.  When
> we see "oops" under git in the above example, we would want to
> complain.  These things are hard to get right.
> 

Actually, it's a policy decision whether or not symlinks should be 
allowed to exit space like that; in Apache, for example, it's a 
configurable.

> I tend to say that the 0.99.9k (and the current master) rule to
> make validation always work on what getcwd() gives back is
> easier to understand (which generally means safer).  Can I talk
> you into adjusting your whitelist on kernel.org machines?

I'm not happy about it, but it's not a huge deal on kernel.org. 
However, I think it's the wrong thing, especially in the light of 
allowing user-relative paths.

At the very least, if you insist on using getcwd() names, you should 
pre-canonicalize the whitelist, too.

	-hpa
