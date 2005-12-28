From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/4] short circuit out of a few places where we would
 allocate zero bytes
Date: Wed, 28 Dec 2005 08:58:51 -0800
Message-ID: <43B2C44B.1070102@zytor.com>
References: <20051224121007.GA19136@mail.yhbt.net> <20051224121243.GA3963@mail.yhbt.net> <43B21312.50603@zytor.com> <Pine.LNX.4.64.0512272036380.14098@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>, git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 28 17:59:27 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eredx-0004PN-Js
	for gcvg-git@gmane.org; Wed, 28 Dec 2005 17:59:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbVL1Q7G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Dec 2005 11:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbVL1Q7G
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Dec 2005 11:59:06 -0500
Received: from terminus.zytor.com ([192.83.249.54]:20142 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932538AbVL1Q7F
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Dec 2005 11:59:05 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jBSGwpPT027219
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 28 Dec 2005 08:58:51 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512272036380.14098@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.7 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14103>

Linus Torvalds wrote:
> 
> On Tue, 27 Dec 2005, H. Peter Anvin wrote:
> 
>>Better yet, either always return NULL or allocate 1 byte in that case, to get
>>consistent behaviour.
> 
> Yes. However, if you do the "return NULL" case (which is nicest), you'll 
> have to wrap "free()" too. There are some libraries where passing "free()" 
> a NULL pointer causes a SIGSEGV.
> 
> That said, I think that would be preferable to changing the source code to 
> unnecessarily avoid zero-sized allocations. Having a "xfree()" to match 
> "xmalloc()" makes sense. 
> 

Yeah, although that might break GNU code which uses xmalloc that is 
included (GNU doesn't have xfree.)  The easiest is just to allocate 1 
byte when the user asks for 0.

Anyone knows what GNU xmalloc does?

	-hpa
