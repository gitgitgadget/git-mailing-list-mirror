From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: bug? in checkout with ambiguous refnames
Date: Sat, 8 Jan 2011 15:40:33 -0500 (EST)
Message-ID: <alpine.DEB.1.10.1101081449220.12031@debian>
References: <20110107104650.GA5399@pengutronix.de> <20110107194909.GB6175@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 08 21:41:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbfbI-00072Y-Gr
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 21:41:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671Ab1AHUkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jan 2011 15:40:41 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64026 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086Ab1AHUkk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jan 2011 15:40:40 -0500
Received: by vws16 with SMTP id 16so7601224vws.19
        for <git@vger.kernel.org>; Sat, 08 Jan 2011 12:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type;
        bh=ZEifKl2CMdus6cjZusK7O+azIJ/LIexZm5RDKE1Wof0=;
        b=ctXu1c/vd7UXm2e37Xn7gIdDdSeXU8H+trqOBNTga3hBI47+CBpNwkbJ8LCOXcrGfA
         tObtCN3GNDa0ZYSFczGDVGXL1EdjgxnkJFldLl+4xnG4jbNE3whQHsTyIygjKYBllLcN
         hdBTEsP2CR0CY1E0RPurjBlx9tz7HVuF4Tx3c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=tuDYugmw+ejo4KSf/B9qC2s+Aog/HtuDvmA5HFqohyZ1E4lhAl6cVq7NJFcLErKZSM
         TnAnd/T5sGkOV4AzelboQcrEYmMhs3SqcEB7hWJK9BjW2gXs8XF90sU0Kr7Z9hlH+/SV
         mTFLgkueJvoN+zshbHarxsFxnWwlUIhZgx7vA=
Received: by 10.220.198.196 with SMTP id ep4mr7887103vcb.110.1294519239496;
        Sat, 08 Jan 2011 12:40:39 -0800 (PST)
Received: from [192.168.1.101] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id b26sm10351797vby.13.2011.01.08.12.40.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 Jan 2011 12:40:38 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <20110107194909.GB6175@sigill.intra.peff.net>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164840>

On Fri, 7 Jan 2011, Jeff King wrote:

> On Fri, Jan 07, 2011 at 11:46:50AM +0100, Uwe Kleine-K?nig wrote:
> 
> > 	ukl@octopus:~/gsrc/linux-2.6$ git diff; git diff --cached
> > 
> > 	ukl@octopus:~/gsrc/linux-2.6$ git checkout sgu/mxs-amba-uart
> > 	warning: refname 'sgu/mxs-amba-uart' is ambiguous.
> > 	Previous HEAD position was c13fb17... Merge commit '65e29a85a419f9a161ab0f09f9d69924e36d940e' into HEAD
> > 	Switched to branch 'sgu/mxs-amba-uart'
> > 
> > OK, it might be a bad idea to have this ambiguity, still ...
> > [...]
> > So working copy and cache are at refs/tags/sgu/mxs-amba-uart, HEAD
> > points to refs/heads/sgu/mxs-amba-uart
> 
> Yeah, we generally resolve ambiguities in favor of the tag (and that
> warning comes from deep within get_sha1_basic). So the real bug here is
> that it still said "Switched to branch", which is totally wrong.
> 
> That being said, it probably would make more sense for "git checkout" to
> prefer branches to tags.

What was the rationale for generally favoring tags? Why does that
reasoning not apply to 'git checkout' too? At least without knowing
the answer to that question, I think I would prefer to have checkout
behave the same as the other commands do. Maybe a bit academic, but it
seems like it would be nice if e.g. 'git checkout $anything && git
show $anything' would show the HEAD commit and if 'git checkout
$anything && git diff HEAD $anything' was always empty.

Btw, what exactly does "generally" mean, i.e. which other commands
don't favor tags? I know rebase is one example of a command that does
not favor tags.

Slightly off topic, but why does 'git rev-parse --symbolic-full-name'
not output anything when the input is ambiguous? 'git rev-parse'
without any flags favors tags, so I would have expected to get
something like refs/tags/$name back.

The reason I'm asking is because I just happened to see in the rebase
code the other day that it will rebase a detached head if the <branch>
parameter is not "completely unqualified". For example 'git rebase
master heads/topic' or 'git rebase master refs/heads/topic' will not
update refs/heads/topic. I was trying to fix that by using 'git
rev-parse --symbolic-full-name' to parse <branch>. That seemed to work
fine until I saw this thread :-).
