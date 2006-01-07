From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [ANNOUNCE] GIT 1.0.7
Date: Sat, 07 Jan 2006 12:47:06 -0800
Message-ID: <43C028CA.8090702@zytor.com>
References: <7vhd8go71t.fsf@assigned-by-dhcp.cox.net>	<20060107.021614.94523887.yoshfuji@linux-ipv6.org>	<7vsls0mns8.fsf@assigned-by-dhcp.cox.net> <7vmzi8mkdi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?WU9TSElGVUpJIEhpZGVha2kgLyDlkInol6Toi7HmmI4=?= 
	<yoshfuji@linux-ipv6.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 07 21:48:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvKzD-0005of-La
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 21:48:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161085AbWAGUry (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 15:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161088AbWAGUry
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 15:47:54 -0500
Received: from terminus.zytor.com ([192.83.249.54]:59083 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1161085AbWAGUry
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 7 Jan 2006 15:47:54 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k07Kl6NR008973
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 7 Jan 2006 12:47:06 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzi8mkdi.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.7 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14273>

Junio C Hamano wrote:
> 
> Here is what I am planning to merge into the master/maint.  The
> patch is for maint which does not ship with describe, but the
> problematic path[] can be updated to path[FLEX_ARRAY] as others
> when merging it to the master branch.
> 
> -- >8 --
> Subject: [PATCH] Compilation: zero-length array declaration.
> 
> ISO C99 (and GCC 3.x or later) lets you write a flexible array
> at the end of a structure, like this:
> 
> 	struct frotz {
> 		int xyzzy;
> 		char nitfol[]; /* more */
> 	};
> 
> GCC 2.95 lets you to do this with "char nitfol[0]";
> unfortunately this is not allowed by ISO C90.
> 
> This declares such construct like this:
> 
> 	struct frotz {
> 		int xyzzy;
> 		char nitfol[FLEX_ARRAY]; /* more */
> 	};
> 
> and git-compat-util.h defines FLEX_ARRAY to 0 for gcc 2.95 and
> empty for others.
> 
> Although I have not tried this myself, if you are using a C90 C
> compiler, you should be able to override this with
> CFLAGS=-DFLEX_ARRAY=1 from the command line of "make".
> 

Any reason to not just do:

  	struct frotz {
  		int xyzzy;
  		char nitfol[1]; /* more */
  	};

... which should work on all compilers?

	-hpa
