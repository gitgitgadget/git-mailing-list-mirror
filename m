From: Marius Storm-Olsen <marius@storm-olsen.com>
Subject: Re: [msysGit] Re: [PATCH 01/14] Fix non-constant array creation
Date: Fri, 21 Aug 2009 21:49:42 +0200
Message-ID: <4A8EFA56.6050001@gmail.com>
References: <cover.1250860247.git.mstormo@gmail.com>	 <6283b3e1775f43c6fc07e5047f9c99acdc27bc8f.1250860247.git.mstormo@gmail.com>	 <40aa078e0908210641m660b003do6f637535293672ae@mail.gmail.com>	 <4A8EA53B.9080809@gmail.com> <9d6091530908210926p61aa5ea6ya6a7b71f940fdf5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Erik Faye-Lund <kusmabite@googlemail.com>,
	Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com
To: Janos Laube <janos.dev@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 21:48:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mea6T-0004db-Mc
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 21:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754430AbZHUTsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 15:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751682AbZHUTsj
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 15:48:39 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:64348 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422AbZHUTsj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 15:48:39 -0400
Received: by ewy3 with SMTP id 3so920278ewy.18
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 12:48:40 -0700 (PDT)
Received: by 10.210.91.17 with SMTP id o17mr1597070ebb.91.1250884120100;
        Fri, 21 Aug 2009 12:48:40 -0700 (PDT)
Received: from ?192.168.0.196? (cm-84.215.55.206.getinternet.no [84.215.55.206])
        by mx.google.com with ESMTPS id 5sm3053848eyh.56.2009.08.21.12.48.38
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 21 Aug 2009 12:48:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <9d6091530908210926p61aa5ea6ya6a7b71f940fdf5a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126744>

Janos Laube said the following on 21.08.2009 18:26:
>> MSVC compiles regex.c, so it must handle it. I'm fine with that.
> 
> msvc supports alloca, but regex.c doesn't make use of it per default 
> (you must define HAVE_ALLOCA_H in order to use it). basically _alloca
>  is fine for that task, but be aware that error handling on windows
> is a bit compilicated. when _alloca fails it throws a structured 
> exception, you must reset the stack and use traditional memory 
> allocation as fallback. see 
> http://msdn.microsoft.com/en-us/library/wb1s57t5.aspx. :-)

I must admit that I didn't look much at the surrounding code to know how 
large preimage->nr can get. But assuming variable-length array is 
handled the same way by the compiler as alloca(), and this code seems to 
be performing fine, I guess it's safe to say that this code won't be 
triggering any SEH, and thus we won't need to handle it?

So, given my assumptions I think we can just replace that one line with 
alloca(), nuke the free(), and everything is ok.

--
.marius
