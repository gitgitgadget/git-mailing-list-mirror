From: sf <sf@b-i-t.de>
Subject: Re: [PATCH] git-http-fetch: Allow caching of retrieved objects byproxy
 servers
Date: Tue, 20 Sep 2005 13:34:22 +0200
Message-ID: <432FF3BE.8060501@b-i-t.de>
References: <20050913153858.GB24405@master.mivlgu.local> <43285B24.7050907@b-i-t.de> <Pine.LNX.4.62.0509181720290.14003@qynat.qvtvafvgr.pbz> <432E91ED.7050605@b-i-t.de> <20050919133508.GA2903@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 20 13:40:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHgSJ-0004Ab-M6
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 13:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbVITLi2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 07:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbVITLi2
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 07:38:28 -0400
Received: from main.gmane.org ([80.91.229.2]:22952 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964976AbVITLi1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2005 07:38:27 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EHgQI-0003Zo-8e
	for git@vger.kernel.org; Tue, 20 Sep 2005 13:36:30 +0200
Received: from ip-213157000067.dialin.heagmedianet.de ([213.157.0.67])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Sep 2005 13:36:30 +0200
Received: from sf by ip-213157000067.dialin.heagmedianet.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 20 Sep 2005 13:36:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ip-213157000067.dialin.heagmedianet.de
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050725)
X-Accept-Language: en-us, en
In-Reply-To: <20050919133508.GA2903@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8991>

Petr Baudis wrote:
> Dear diary, on Mon, Sep 19, 2005 at 12:24:45PM CEST, I got a letter
> where sf <sf@b-i-t.de> told me that...
...
>> The OP assumed that "files in a GIT repository are immutable" which is 
>> not true. If you consider the sequence
>> 
>> pack -> prune -> update zlib or git -> unpack
>> 
>> you can end up with different files if the new zlib implementation 
>> changes imcompatibly (with respect to byte-by-byte compression results) 
>> or if git suddenly does not use the default compression level any more.
> 
> Yes, but why should this matter? It shouldn't matter if you get the old
> "version" or the new version of the file over HTTP, the actual object's
> contents is still the same, and GIT shouldn't care.
> 

This is correct as long as you take care to always get each file in one go.

Recently there was talk about how git handles objects larger than 4GB. 
But you do not have to go this far. Think about fetching 1MB (or 10MB or 
100MB) compressed objects over a slow link. If the transfer gets 
interrupted some people or some clever piece of software - perhaps even 
in git-core - might try to continue the interrupted download. Now if the 
file representation has changed in the meantime the downloaded file is 
going to be corrupt.

The git tools will of course take note of the corruption but then the 
head scratching begins: "What went wrong?"

The more I think about this I realize that my worries have nothing to do 
with caching but with HTTP fetching in general.

Regards

	Stephan
