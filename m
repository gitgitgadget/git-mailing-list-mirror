From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Fix git-init-db creating crap directories (zeroth try)
Date: Mon, 19 Sep 2005 17:42:47 -0700
Message-ID: <432F5B07.2060803@zytor.com>
References: <200509172141.31591.dtor_core@ameritech.net> <432F0D1B.60303@zytor.com> <20050919194445.GD18320@pasky.or.cz> <432F46BE.5000406@zytor.com> <20050919234030.GI18320@pasky.or.cz> <432F50BC.5000304@zytor.com> <20050920000731.GJ18320@pasky.or.cz> <432F5345.3020303@zytor.com> <20050920001949.GL18320@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Dmitry Torokhov <dtor_core@ameritech.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 02:44:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHWE7-00052t-F4
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 02:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbVITAnH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 20:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbVITAnH
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 20:43:07 -0400
Received: from terminus.zytor.com ([209.128.68.124]:61650 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964805AbVITAnG
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 20:43:06 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j8K0gq3t017791
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 19 Sep 2005 17:42:53 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050920001949.GL18320@pasky.or.cz>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8938>

Petr Baudis wrote:
>>>
>>>-	memcpy(path, git_dir, len);
>>>+	memcpy(path, git_dir, len-1);
>>>+	path[len] = 0;
>>>	copy_templates_1(path, len,
>>
>>Wrong!  You're not initializing path[len-1]!
> 
> 
> Oops, sorry. That's what you get when you want to make things marginally
> better. ;-) We indeed want to pass copy_templates_1() the trailing slash
> as well.
> 
> Let's just settle with the original patch then.
> 

But if len is the index of the '/', then you're not.

Think about it: the memcpy(path, git_dir, len) copies bytes 0..len-1. 
Thus you need to use path[len] = 0 to terminate.

If you want to copy len-1 characters, then you need to use path[len-1] = 0.

	-hpa
