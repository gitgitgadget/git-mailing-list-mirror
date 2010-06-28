From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Patching bad commits
Date: Mon, 28 Jun 2010 18:23:44 -0400
Message-ID: <AANLkTimAAtO9p2rQW4pITKQehhYF6pppBUgPxoyrLOvA@mail.gmail.com>
References: <4c291e41.4f1ee30a.3484.fffff729@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 29 00:24:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTMkR-0002hE-AL
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 00:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753879Ab0F1WYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 18:24:10 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:50531 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471Ab0F1WYI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 18:24:08 -0400
Received: by gwaa18 with SMTP id a18so2226843gwa.19
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 15:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=YH46ZMT36YgyVkg88UPAf/AM0MIKp3jSEq/MPe/uWtA=;
        b=gGgZFEGmxuKcxG5VGXJCuLuqyczCbb06EdnupcJXLuSsdAc2bXfT728DzKRe2kZFsW
         L1iG9O03Fdlxz1/bAJ3i5Zz8qNHa4wBHMt6Dh/qThDuUXwMDIuBO0x0JZrKc7ecdQCwH
         HiWZH6X0POf19ptGyX8+ntFOgQ7qgDa+VlVOE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=KB1Bo27dTQwAfnUplF1KaGeH5TcvZPL6AEAANun8Adq8f5Fcnqt0CAU0Rlhpr3KW3x
         S5XR2V2B+trY2cceVpi8sJ/OIW43dkvNcGs3UTgj+T/fAMkagIEd0W8slLxNuXQvU6ZP
         pHMykTwBf6DiT1MXSz8wLaLOl/XMXSv/NYtC8=
Received: by 10.101.136.9 with SMTP id o9mr7166736ann.103.1277763845289; Mon, 
	28 Jun 2010 15:24:05 -0700 (PDT)
Received: by 10.151.45.9 with HTTP; Mon, 28 Jun 2010 15:23:44 -0700 (PDT)
In-Reply-To: <4c291e41.4f1ee30a.3484.fffff729@mx.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149866>

On Mon, Jun 28, 2010 at 6:03 PM, Michael Witten <mfwitten@gmail.com> wrote:
> Sometimes bisecting is less than useful because a number of commits
> fail to build.
>
> How about implementing something SIMILAR to "git notes" (perhaps
> even using "git notes") to store and apply patches for such bad
> commits?

You could probably use the (relatively new) 'git replace' feature for
this.  Just replace the broken tree object with a new one that doesn't
have the bug.  I've never tried it, but it does seem like it should
work.

That said, this idea would require you to manually patch every single
commit that ever had a problem.  I'm not sure there's much benefit to
that compared to the overwhelming cost.  I think it might be more
useful - and much easier -to just have a permanent "always skip these
commits when bisecting" list.  (I don't think such a feature exists
yet though.)

Btw, in recent versions of git, 'git bisect skip' is pretty smart and
seeks around in the tree in such a way that it doesn't hurt so much
when you have a batch of bad commits somewhere in the middle.  So you
may find that it's really not that bad to just use 'git bisect skip'
occasionally if your version of git is relatively new and your history
isn't absolutely littered with crap.

Speaking of littering your history with crap, the an ounce of
prevention is worth a pound of cure: make sure all your commits pass
unit tests before committing, and you'll rarely have this problem
anyway :)  That's obviously easier said than done however.

Have fun,

Avery
