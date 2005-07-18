From: Bryan Larsen <bryan.larsen@gmail.com>
Subject: git, porcelain, darcs, and version 1.0
Date: Mon, 18 Jul 2005 00:46:21 -0400
Message-ID: <42DB341D.6050506@gmail.com>
References: <7islyev5s4.fsf@lanthane.pps.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: darcs-devel@darcs.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 06:46:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DuNWQ-0007BB-BV
	for gcvg-git@gmane.org; Mon, 18 Jul 2005 06:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbVGREqX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jul 2005 00:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVGREqX
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jul 2005 00:46:23 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:46861 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261511AbVGREqW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jul 2005 00:46:22 -0400
Received: by zproxy.gmail.com with SMTP id l8so801352nzf
        for <git@vger.kernel.org>; Sun, 17 Jul 2005 21:46:22 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=WvCq9kGvF+UkwOf3lG+vxCe3O2MEbDYPgOaUtQIoftZcmvPjWqp0Nzq9dqQ48TA/BS5WjIZBOPIN0o1+jPxuTazHi+PB/zxoA1r0Pewtcs1YCTnZ/+Pdnp4COJauI1lbEsf0Lm8ZUPXYWiO9hQMb0lPw2XINIsX0RjJrkCI9wwU=
Received: by 10.36.129.3 with SMTP id b3mr298421nzd;
        Sun, 17 Jul 2005 21:46:21 -0700 (PDT)
Received: from ?192.168.1.100? ([70.26.43.137])
        by mx.gmail.com with ESMTP id 19sm5877536nzp.2005.07.17.21.46.21;
        Sun, 17 Jul 2005 21:46:21 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: en-us, en
To: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
In-Reply-To: <7islyev5s4.fsf@lanthane.pps.jussieu.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Juliusz Chroboczek wrote:
> There are three ways to do that:
> 
>   (1) require that the users put a suitable libgit.a in /usr/local/lib
>       before building Darcs, and distribute a tarball of Git from
>       darcs.net;

I was under the impression that the stablest interface to git was the 
command line; we use spawnvp in stacked git.  I've been using it with 
repositories that make the Linux kernel look small.

I certainly don't think the lib interface is anywhere near stable: 
Linus accepted my change to index_fd far too easily.

 >
 >   (2) include just the sources needed for libgit.a in Darcs, and have
 >       the Darcs build build a local libgit
 >
 >   (3) as (2), but include all of Git, including their
 >       ``user-friendly'' scripts.

Ugh.  That's what they do in the commercial world.  We have it so much 
better here in Linux & BSD land: you just add a "depends libgit1" line 
to your package, and the right thing happens: minor updates happen 
automatically and changes that break the interface don't.  Of course, 
keeping it that easy for the user requires active effort from us, the 
developers, and sometimes the pain spills over, but the benefits are nice.

I see too major long-term alternatives:

1) talk the darcs guys into using spawnvp
2) talk the git people into exporting a stable lib interface

It's my opinion that #1 is a non-starter.  We want others to interact 
with us.  I'm going to use spawnvp for my porcelain, but we should be 
inclusive.

The current 'libgit' probably contains more than Linus and Junio are 
comfortable locking down as a stable interface, but I'm sure that 
there's a subset that they'd be comfortable with once a relative amount 
of stability is achieved, or it may be achievable via some other method.

I propose that Darcs includes all of git for now.  (I prefer this over 
partial inclusion; anybody should be able to take the darcs sources and 
easily drop in a later git).  However, the long term goal is for a 
library.  Darcs and git work together to determine the minimal amount 
that needs to go into libgit1.so.  It gets blessed by being documented, 
and doesn't change until libgit2.so.

I'd like to see this added to Junio's list of "1.0" goals.

A similar 1.0 goal would be to document porcelain's use of the .git 
directory.  For instance, stacked git uses .git/patches, 
.git/patchdescr.tmpl and .git/patchexport.tmpl.  If Linus does not 
accept a patch documenting this usage, stacked git should use .stgit 
instead.

Bryan
