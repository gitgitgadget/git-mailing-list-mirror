From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [FYI] very large text files and their problems.
Date: Wed, 22 Feb 2012 23:18:19 +0700
Message-ID: <CACsJy8Bdbegs7QdztvsFnKPcpAX5UL7s7uc37wF3_nF4kJQjrQ@mail.gmail.com>
References: <20120222154926.GC11202@pomac.netswarm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Ian Kumlien <pomac@vapor.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 17:18:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0Eu8-0004CQ-9W
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 17:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753734Ab2BVQSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 11:18:51 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:53178 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255Ab2BVQSu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 11:18:50 -0500
Received: by wics10 with SMTP id s10so139131wic.19
        for <git@vger.kernel.org>; Wed, 22 Feb 2012 08:18:49 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.180.74.177 as permitted sender) client-ip=10.180.74.177;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.180.74.177 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.180.74.177])
        by 10.180.74.177 with SMTP id u17mr37184565wiv.13.1329927529333 (num_hops = 1);
        Wed, 22 Feb 2012 08:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7VIhD3FzE/Kbp+fS1ajy8bkOmNVHflJlAKhRk7hfc6Q=;
        b=GaaDYrWKGEsiyHlvo8J2sSsTnOXMrerMsocfc968rmmfQAizToRnm65xzNO9qU9L9h
         5SXt1Nr5Ui3n6gZhAiXWhEx8XzzE6Bew+rQNrYWMa290DQCJxDbQHMsfbaZB/+i1o0gR
         rMOj9C6mmOMb+VVxA/nnuntp6pOWo5MAzOras=
Received: by 10.180.74.177 with SMTP id u17mr30746822wiv.13.1329927529264;
 Wed, 22 Feb 2012 08:18:49 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Wed, 22 Feb 2012 08:18:19 -0800 (PST)
In-Reply-To: <20120222154926.GC11202@pomac.netswarm.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191263>

On Wed, Feb 22, 2012 at 10:49 PM, Ian Kumlien <pomac@vapor.com> wrote:
> Hi,
>
> We just saw a interesting issue, git compressed a ~3.4 gb project to ~57 mb.

How big are those files? How many of them? How often do they change?

> But when we tried to clone it on a big machine we got:
>
> fatal: Out of memory, malloc failed (tried to allocate
> 18446744072724798634 bytes)
>
> This is already fixed in the 1.7.10 mainline - but it also seems like

Does 1.7.9 have this problem?

> git needs to have atleast the same ammount of memory as the largest
> file free... Couldn't this be worked around?
>
> On a (32 bit) machine with 4GB memory - results in:
> fatal: Out of memory, malloc failed (tried to allocate 3310214313 bytes)
>
> (and i see how this could be a problem, but couldn't it be mitigated? or
> is it bydesign and intended behaviour?)

I think that it's delta resolving that hogs all your memory. If your
files are smaller than 512M, try lower core.bigFileThreshold. The
topic jc/split-blob, which stores a big file are several smaller
pieces, might solve your problem. Unfortunately the topic is not
complete yet.
-- 
Duy
