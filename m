From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [RFC][RESEND][PATCH] Allow fetching from multiple repositories
 at once
Date: Sat, 23 Sep 2006 09:57:36 -0700
Message-ID: <45156780.6070801@gmail.com>
References: <20060923164308.16334.49252.stgit@machine.or.cz>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 18:58:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRAp9-00043R-LK
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 18:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWIWQ5o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 12:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWIWQ5o
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 12:57:44 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:64380 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751322AbWIWQ5n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Sep 2006 12:57:43 -0400
Received: by py-out-1112.google.com with SMTP id n25so1750409pyg
        for <git@vger.kernel.org>; Sat, 23 Sep 2006 09:57:42 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=U+36r9k/OgSTebdcksW9Hfk4OBKhTeRkklPCHFOfCx4l+UkKxDXxwOa0Kcz7FGqyFnAxSMrlviR3ERF3SAhq0M42Y7zsyC0eyiWIH4xTJPGOwqTQaRJ5yq6626cu9h0DpAsipf5JJTnhA/2y4OMeyiZ6eX0vN8tLFqT0YIz/L7M=
Received: by 10.64.27.13 with SMTP id a13mr2153061qba;
        Sat, 23 Sep 2006 09:57:42 -0700 (PDT)
Received: from ?10.0.0.6? ( [68.70.66.154])
        by mx.gmail.com with ESMTP id f16sm454723qba.2006.09.23.09.57.41;
        Sat, 23 Sep 2006 09:57:42 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060923164308.16334.49252.stgit@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27600>

Petr Baudis wrote:
> This patch enables fetching multiple repositories at once over the Git
> protocol (and SSH, and locally if git-fetch-pack is your cup of coffee
> there). This is done especially for the xorg people who have tons of
> repositories and dislike pulls much slower than they were used to with CVS.
> I'm eager to hear how this affects the situation.
> 
> It's kind of "superproject" thing, basically, taking reverse approach than
> the subproject ideas. However, in practice I think it can be used for
> subprojects quite well and perhaps if I find some spare time during the day
> I will add the lightweight subproject support to Cogito, using this.
> 
> So, you need some kind of porcelain for this. The idea is that instead of
> telling git-fetch-pack a single repository, you pass multiple --repo=
> parameters and refs always "belong" to the latest mentioned repository;
> when outputting the new ref values, the appropriate repo is mentioned near
> each ref. In order for this to be useful, on your local side you should
> share the objects database in some way - either using alternates (then
> you must fetch to an object database reachable from everywhere) or symlinked
> object databases.
> 
> You still need to pass git-fetch-pack some URL in addition to the
> repositories - it is used only for git_connect(), the purpose is that
> repositories must be local directories so if you want to talk remote, you
> need to do something like
> 
> 	git-fetch-pack git://kernel.org/pub/scm/git/git.git --repo=/pub/scm/git/git.git master next --repo=/pub/scm/cogito/cogito.git master
> 

Can't this be done with a simple wrapper around git-fetch* ?
