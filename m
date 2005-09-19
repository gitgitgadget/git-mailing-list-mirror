From: sf <sf@b-i-t.de>
Subject: Re: [PATCH] git-http-fetch: Allow caching of retrieved objects  
 byproxy servers
Date: Mon, 19 Sep 2005 12:24:45 +0200
Message-ID: <432E91ED.7050605@b-i-t.de>
References: <20050913153858.GB24405@master.mivlgu.local> <43285B24.7050907@b-i-t.de> <Pine.LNX.4.62.0509181720290.14003@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Sep 19 13:04:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHJPs-0006L3-3n
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 13:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbVISLCS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 07:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbVISLCS
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 07:02:18 -0400
Received: from main.gmane.org ([80.91.229.2]:63447 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750729AbVISLCR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 07:02:17 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1EHJO9-0005yg-Jh
	for git@vger.kernel.org; Mon, 19 Sep 2005 13:00:45 +0200
Received: from ip-213157000067.dialin.heagmedianet.de ([213.157.0.67])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Sep 2005 13:00:45 +0200
Received: from sf by ip-213157000067.dialin.heagmedianet.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Sep 2005 13:00:45 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ip-213157000067.dialin.heagmedianet.de
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050725)
X-Accept-Language: en-us, en
In-Reply-To: <Pine.LNX.4.62.0509181720290.14003@qynat.qvtvafvgr.pbz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8854>

David Lang wrote:
> On Wed, 14 Sep 2005, sf wrote:
> 
>> Sergey Vlasov wrote:
>>
>>> By default the curl library adds "Pragma: no-cache" header to all
>>> requests, which disables caching by proxy servers.  However, most
>>> files in a GIT repository are immutable, and caching them is safe and
>>> could be useful.
>>
>>
>> Is caching really safe? Because of compression one git object can have 
>> many file representations.
> 
> 
> only if you use different compression algorithums.

Even different implementations and different compression levels can lead 
to different file representations.

> remember that git objects are identified by their sha1, if the sha1 is 
> what you want (and the file matches the sha1 after you decompress it) 
> then it really doesn't matter what it's on-disk representation is.

You are arguing on the git tool level but we are talking about HTTP 
which knows nothing about the uncompressed sha1.

The OP assumed that "files in a GIT repository are immutable" which is 
not true. If you consider the sequence

pack -> prune -> update zlib or git -> unpack

you can end up with different files if the new zlib implementation 
changes imcompatibly (with respect to byte-by-byte compression results) 
or if git suddenly does not use the default compression level any more.

And surely in the future there will be other git implementations than 
this one which may not even use zlib.

I do not say that caching is not possible at all but HTTP caching has 
its pitfalls so just be careful.

Regards

	Stephan
