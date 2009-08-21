From: Johan 't Hart <johanthart@gmail.com>
Subject: Re: [msysGit] Re: [PATCH 01/14] Fix non-constant array creation
Date: Fri, 21 Aug 2009 22:06:01 +0200
Message-ID: <4A8EFE29.6010706@gmail.com>
References: <cover.1250860247.git.mstormo@gmail.com>	 <6283b3e1775f43c6fc07e5047f9c99acdc27bc8f.1250860247.git.mstormo@gmail.com>	 <40aa078e0908210641m660b003do6f637535293672ae@mail.gmail.com>	 <4A8EA53B.9080809@gmail.com> <9d6091530908210926p61aa5ea6ya6a7b71f940fdf5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <mstormo@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com
To: Janos Laube <janos.dev@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 22:06:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeaNN-00038l-Na
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 22:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbZHUUGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 16:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbZHUUGH
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 16:06:07 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:54279 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932371AbZHUUGF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 16:06:05 -0400
Received: by mail-ew0-f207.google.com with SMTP id 3so932028ewy.18
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 13:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=wucHyTMt4Y5Tw+Zg5cn4fea0ppvsxz1rsYVssbzl6ko=;
        b=cI1q5yeELTR6sB/xfMASyCq1KXgQYBEJrWzLmW4cq65cwbSbBYxMIP/62+cjg4jjto
         8TFfMhNP2itOdk0edWtdkyohzdd5Ho9zihGjgRcRDwLY5Ny4sY6SCG+iHrcMwWhn77SV
         RTxLOU2vUMBvebAmn9tGiWXPrk18HZldx+3VU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:newsgroups:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=YN/dFtxtQzXc9mB01h5KHxQgRkEJVZNLYfSsMmIM1Q+rX1Ig69AVN2dHJ4aav2xK0J
         B9G4Lv7wO3HTksbvvomaRdQOsE4B20GXS5b3b2WM1gXR3zpeteYn7O6lbnP/IL8M2LPj
         9fKcfFgJQGO5GAQiZthrZMIVJJmpGZxxNCELI=
Received: by 10.210.105.12 with SMTP id d12mr313636ebc.40.1250885166991;
        Fri, 21 Aug 2009 13:06:06 -0700 (PDT)
Received: from ?192.168.2.100? (dsl-083-247-086-199.solcon.nl [83.247.86.199])
        by mx.google.com with ESMTPS id 10sm2577072eyz.41.2009.08.21.13.06.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 21 Aug 2009 13:06:06 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
Newsgroups: gmane.comp.version-control.git,gmane.comp.version-control.msysgit
In-Reply-To: <9d6091530908210926p61aa5ea6ya6a7b71f940fdf5a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126745>

Janos Laube schreef:
>> MSVC compiles regex.c, so it must handle it. I'm fine with that.
> 
> msvc supports alloca, but regex.c doesn't make use of it per default
> (you must define HAVE_ALLOCA_H in order to use it). basically _alloca
> is fine for that task, but be aware that error handling on windows is
> a bit compilicated. when _alloca fails it throws a structured
> exception, you must reset the stack and use traditional memory
> allocation as fallback. see
> http://msdn.microsoft.com/en-us/library/wb1s57t5.aspx. :-)
> 

alloca() throws an exception when out of stack memory. But what would 
the dynamically alloced array do when it runs out of memory? (Supposing 
that those arrays are also created on the stack, which I don't know...) 
Is that realy more complicated?
