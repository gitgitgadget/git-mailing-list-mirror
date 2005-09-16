From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH/RFC] Build a shared / renamed / "stable" version of the
 library?
Date: Fri, 16 Sep 2005 10:41:05 -0400
Message-ID: <432AD981.2080400@gmail.com>
References: <pan.2005.09.16.12.37.14.736570@smurf.noris.de>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Sep 16 16:44:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGHP9-0001Yc-5O
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 16:41:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161140AbVIPOlP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 10:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161110AbVIPOlP
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 10:41:15 -0400
Received: from xproxy.gmail.com ([66.249.82.205]:36989 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161140AbVIPOlO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 10:41:14 -0400
Received: by xproxy.gmail.com with SMTP id i27so157135wxd
        for <git@vger.kernel.org>; Fri, 16 Sep 2005 07:41:12 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=RbCUNHvAZy1ZAc6ApgmJDKeNIQ2KaI4gfANzZ/6GrxFgYePivv5zdlHa8OnmVhuT7v37adgLbUxdAIEJW/a9DiVWr4FemUiy6wt4fXsrf0exOx3IMV9dxglWp0mKE86inkr0aJa95Veq7BZYpzEkEFFq+JrK4uay6/zKv0YHOuE=
Received: by 10.70.37.9 with SMTP id k9mr174060wxk;
        Fri, 16 Sep 2005 07:41:12 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.89.97.97])
        by mx.gmail.com with ESMTP id h8sm675389wxd.2005.09.16.07.41.11;
        Fri, 16 Sep 2005 07:41:11 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <pan.2005.09.16.12.37.14.736570@smurf.noris.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8685>

Matthias Urlichs wrote:
> Build (and use) libgit.so instead of libgit.a.
> 
> --- 
> 
> I have written this nice Python extension that gives me fast access to
> git objects. Python extensions are built as shared libraries. Linking
> shared and non-shared objects into one library results in a couple of
> linker warnings on i386; other architectures are far less forgiving.
> 
> So the best choice I seem to have is to build a shared libgit.so.
> 
> Unfortunately, libgit doesn't have nice symbol names. I dunno how you
> all would feel about a big patch which renames absoutely every foo()
> function in libgit to be git_foo() instead (or one that #ifdef's them)...
> so I'm taking the easy way out, and use versioned symbols. That should
> prevent symbol name conflicts with other libraries.
> 
> I've had to redefine usage(), error() and die() to git_*(), because
> they're just too conflict-ish. "error" is even a weak symbol in libc. :-/
> 
> To summarize, the choices seem to be:
> - don't do anything => no script language extensions, need to fork off
>   a git program for absolutely everything. Bah.
> - build libgit.a with -fpic'd objects => doesn't work on all
>   architectures.
> - build libgit.shared.a and use that for building script language
>   extensions => works now, but may cause name conflicts down the road.
> - build a "normal" libgit.so => ditto on the name conflicts.
> - build a libgit.so with symbol versions => no name conflicts expected,
>   but works only with the GNU linker.
> - rename all library functions and globals => quite a bit of work,
>   and more typing down the road.
> - add "#define foo git_foo" to all library functions => ugly.
> 
> Opinions?

Renaming all the library functions and globals is the way to go if the 
long term view is that Git functionality will be desired in other 
projects. This is my view.

However, it's not clear (to me, anyway) that libgit is structured (other 
than naming) in a way that's usable for non core-git tools; git-daemon 
was discussed recently. Some research needs to be done to answer this 
question.
