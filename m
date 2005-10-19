From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] git-daemon extra paranoia
Date: Tue, 18 Oct 2005 17:21:55 -0700
Message-ID: <435591A3.7030708@zytor.com>
References: <435560F7.4080006@zytor.com> <Pine.LNX.4.64.0510181517280.3369@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 19 02:22:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES1ij-0001CD-1X
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 02:22:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbVJSAWN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 20:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbVJSAWN
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 20:22:13 -0400
Received: from terminus.zytor.com ([192.83.249.54]:42428 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932203AbVJSAWM
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2005 20:22:12 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9J0M09J011832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Oct 2005 17:22:02 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510181517280.3369@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10242>

Linus Torvalds wrote:
> 
> Hmm. The "not ending in /" is a bad test. 
> 
> Especially in light of the fact that the git-pack protocol quite by design 
> tends to add a ".git" to the end as a fallback, so that a user that wants 
> to specify a particular directory _without_ that fallback needs to have 
> the slash at the end.
> 
> Now, git-daemon hasn't implemented that, but I think that was just a 
> mistake that grew out of it not getting a lot of testing, since it wasn't 
> used much. I personally use the "without the final .git" version quite 
> often, because it just looks so much nicer for the user.
> 
> In fact, here's a patch that makes git-daemon allow it, and thus match the 
> behaviour of the ssh transport.
> 
> The logic is simple: if the original "chdir()" fails, try another one with 
> ".git" appended. This is in _addition_ to doing the 'chdir(".git")' later, 
> so that if you have a checked-out git repository in /home/linux-2.6.git, 
> then doing a
> 

This is also exactly the kind of DWIM that tends to result in the kind 
of security holes I described earlier.

The DWIM aspect is fine, of course, but it has to be done up front: 
instead of doing just chdir(), each path should be validated through 
path_ok() before even being considered for chdir().  Perhaps the right 
thing to do is to combine the two functions.

	-hpa
