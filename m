From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] git-fetch: Don't trigger a bus error when given the refspec "tag"
Date: Sat, 5 Apr 2008 14:46:44 -0400
Message-ID: <9FD2C650-C9DD-41E1-AE27-684A82E1D700@sb.org>
References: <1207420133-23631-1-git-send-email-kevin@sb.org> <alpine.DEB.1.00.0804051931480.12583@eeepc-johanness>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 05 20:47:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiDQI-0005S0-Vx
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 20:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753113AbYDESqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2008 14:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753132AbYDESqr
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 14:46:47 -0400
Received: from sd-green-bigip-202.dreamhost.com ([208.97.132.202]:49503 "EHLO
	randymail-a3.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752975AbYDESqr (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Apr 2008 14:46:47 -0400
Received: from kballard.res.wpi.net (kballard.res.wpi.net [130.215.239.91])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a3.g.dreamhost.com (Postfix) with ESMTP id 42EEE185D13;
	Sat,  5 Apr 2008 11:46:46 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0804051931480.12583@eeepc-johanness>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78859>

On Apr 5, 2008, at 2:33 PM, Johannes Schindelin wrote:
> Hi,
>
> On Sat, 5 Apr 2008, Kevin Ballard wrote:
>
>> diff --git a/builtin-fetch.c b/builtin-fetch.c
>> index a11548c..5841b3e 100644
>> --- a/builtin-fetch.c
>> +++ b/builtin-fetch.c
>> @@ -637,6 +637,8 @@ int cmd_fetch(int argc, const char **argv,  
>> const char *prefix)
>> 			if (!strcmp(argv[i], "tag")) {
>> 				char *ref;
>> 				i++;
>> +				if (i >= argc)
>> +					die("You need to specify a tag name.");
>
> Would it not be better to check in the if() above?  IOW
>
> 			if (i + 1 < argc && !strcmp(argv[i], "tag")) {
>
> Hmm?

So that `git fetch origin tag` will try and fetch the branch named  
tag? Given that we treat "tag foo" as shorthand for refs/tags/foo:refs/ 
tags/foo it seems like it would be unexpected to treat "tag" as just a  
plain ref. I much prefer to die in this situation, let the user fix  
the refspec to mean exactly what they want (either by adding a tag  
name, or by using tag: if they really want a branch named tag).

-Kevin

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
