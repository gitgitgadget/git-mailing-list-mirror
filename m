From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Fw: git-core: SIGSEGV during {peek,ls}-remote on HTTP remotes.
Date: Mon, 2 Nov 2009 20:21:46 +0100
Message-ID: <20091102192145.GA12718@localhost>
References: <20091101.010702.527849118592864646._deepfire@feelingofgreen.ru> <7v8weq50pm.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.00.0911011348190.14365@iabervon.org> <7vljiqxapw.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.00.0911011518590.14365@iabervon.org> <20091101230442.GA20264@coredump.intra.peff.net> <alpine.LNX.2.00.0911011829130.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Samium Gromoff <_deepfire@feelingofgreen.ru>,
	git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>,
	Mike Hommey <mh@glandium.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Nov 02 20:23:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N52U8-000171-1c
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 20:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756657AbZKBTWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2009 14:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756625AbZKBTWK
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 14:22:10 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:62028 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756616AbZKBTWI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2009 14:22:08 -0500
Received: by bwz27 with SMTP id 27so6677682bwz.21
        for <git@vger.kernel.org>; Mon, 02 Nov 2009 11:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=7mEjdXw47fvILP/rqqDy3LZbs/43UwdgBq9KvNqvZ7Y=;
        b=uZypzS+ADsaYIZ2ir8pz12y8yFZh1yCYT38TpWFLZc81yZFp4Vm+1qx4FGdITwlVKv
         +DrLKCEEGrCGDtYiLiCYipFsRiq1JBq47EUZ5k6sq6wSrwltyxFc2+o4UN7Hnh91boI0
         60/1ej0PaoA0GD3W/Cxe1XurhmHGnb7Zpl04g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=ZVrRJaAAu+Zneg/UFVxfNo5QZYqUp3o94yE4xWHuXCVEFiIWWEdpVBVgmDafZS2a2n
         CE/rzBP86Vloz8MreZo80+lN5mRNkZIc0kIE9egZSHEeJc6WtERvX81PYhSx72b9x3XZ
         mclbXSz7nw7aG5L+JzTO4uqYxtpaDTcfqwAYM=
Received: by 10.204.155.69 with SMTP id r5mr4202754bkw.136.1257189731906;
        Mon, 02 Nov 2009 11:22:11 -0800 (PST)
Received: from darc.lan (p549A358C.dip.t-dialin.net [84.154.53.140])
        by mx.google.com with ESMTPS id 13sm685803bwz.14.2009.11.02.11.22.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Nov 2009 11:22:10 -0800 (PST)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1N52TK-0003lV-13; Mon, 02 Nov 2009 20:21:46 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0911011829130.14365@iabervon.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131932>

On Sun, Nov 01, 2009 at 07:59:45PM -0500, Daniel Barkalow wrote:

> I've been looking at it, just now, and I might try to clean stuff up. The 
> problem I'm running into is that, in some cases, you have to call 
> setup_git_directory_gently(), and it might determine that there is no git 
> repo, but then the various environment functions don't distinguish between 
> the situation where you haven't called it at all and the situation where 
> you called it and determined there to be no answer. Furthermore, a lot of 
> functions seem to be getting git_path(something), ignoring the fact that 
> there is no repo, and acting like there is a repo that has simply not got 
> the file it is looking for.

Indeed. In particular, you can cause most git commands which take a path
argument to segfault in GIT_DIR:

$ git grep -- /
Segmentation fault

$ git ls-files /
Segmentation fault

$ git show HEAD /
Segmentation fault

$ git diff HEAD /
Segmentation fault

You get the idea. It looks like at some point each of these calls
get_git_work_tree(), which returns NULL. I was trying to fix it this weekend
but got confused by the setup api (to be documented in
Documentation/technical/api-setup.txt). I don't think fixing all the callers
of get_git_work_tree() is the right thing to do. Instead, we should die() if
there is no work tree and a different function should be used to check
whether or not a work tree exists.

I will try to understand this convoluted codepath when I have gathered the
patience to do it. But while you're looking at it, maybe you can also take
this issue into consideration.

Thanks,
Clemens
