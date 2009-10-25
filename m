From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 4/7] t5540-http-push: expect success when pushing
	without arguments
Date: Sun, 25 Oct 2009 17:16:31 +0100
Message-ID: <20091025161630.GB8532@localhost>
References: <20091025232044.06d7ce5c.rctay89@gmail.com> <20091025231932.be9a6dfa.rctay89@gmail.com> <20091025231809.15b470fa.rctay89@gmail.com> <20091025231651.18c75559.rctay89@gmail.com> <20091025232142.6558d9e4.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 17:20:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N25pj-0007S8-Di
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 17:20:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753696AbZJYQQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 12:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753221AbZJYQQV
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 12:16:21 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:34604 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552AbZJYQQU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2009 12:16:20 -0400
Received: by fxm18 with SMTP id 18so11492392fxm.37
        for <git@vger.kernel.org>; Sun, 25 Oct 2009 09:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=B3qZd5KXf8erh/qGgmqwdXMnqf6/sLGBqAQVmGN7Lkg=;
        b=Ougzo/qS5cH/j3w0KDL4xVw06/kxkRTg5kGEbqqMLl/RVMq70MCEEd6bGwVOswuEqE
         E9J7tKrbNY57BvjnQujuuA3km8uZky1VoiVUjkMrajYqRzkuxi6S30TagFurm/Wrfo52
         Xehrgyotj2/YgsrRWPO3Radrx0eAr/lzPvzIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=Ml9m1ZtloJwuIuSIigcsf2ojNVhNwDOXdtmsoYbrlqS4aS+8jIOIucGzQNLYPTlVFc
         LspFUPj4yndEe4AtUGpWsKf1+6zeceWEJrN4P3JGrfetQVDhBGz4pfelccchHiTPUJ52
         EihyLJbPK7/FhZClsvChcbnVquj7tUjcDUDAg=
Received: by 10.204.7.195 with SMTP id e3mr9271244bke.118.1256487384971;
        Sun, 25 Oct 2009 09:16:24 -0700 (PDT)
Received: from darc.lan (p549A3880.dip.t-dialin.net [84.154.56.128])
        by mx.google.com with ESMTPS id 26sm7444981fxm.95.2009.10.25.09.16.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 09:16:24 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1N25lf-00031X-29; Sun, 25 Oct 2009 17:16:31 +0100
Content-Disposition: inline
In-Reply-To: <20091025232142.6558d9e4.rctay89@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131221>

On Sun, Oct 25, 2009 at 11:21:42PM +0800, Tay Ray Chuan wrote:

> But after c6aa27e (Move WebDAV HTTP push under remote-curl, Wed Oct
> 14), the dumb http mechanism additionally learns about the refs through
> /info/refs (via remote-curl.c::get_refs), so it is aware of packed
> refs, even though it still doesn't read /packed-refs (assuming /info/
> refs is up-to-date). Thus the push now succeeds.

If left as is, it should actually fail, and for two reasons.

1. push aborts immediately because info/refs is not updated by "git
update-ref" so that it thinks everything is up-to-date from the previous
test. The old http-push code did not check for up-to-date refs which is why
this problem did not trigger so far. This is fixed in "update http tests
according to remote-curl capabilities".

2. Even if info/refs is updated, a bug in the new remote-helper causes push
to exit with error status 128. This is fixed in "remote-helpers: return
successfully if everything up-to-date".

This is unrelated to the original intention of the test, but I think it
doesn't hurt to keep it around, at least for the time being.

It's unfortunate that we both worked on t5540 at the same time. But except
for this point I think our changes are compatible.

Clemens
