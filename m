From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 00/14] New remote-hg helper
Date: Thu, 1 Nov 2012 07:05:21 +0100
Message-ID: <CAMP44s1-VOetN+e49UgJtpbpwYN2EBVYBzw5j_KoqXu6sbbaHA@mail.gmail.com>
References: <1351571736-4682-1-git-send-email-felipe.contreras@gmail.com>
	<20121030102526.GN4891@arachsys.com>
	<CAMP44s1g8rFGP7UOcvp9BEZ1oiSh3+-gYheciqO8Fmghipot8A@mail.gmail.com>
	<20121030180021.GX26850@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 07:05:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTnuK-0003ur-Kd
	for gcvg-git-2@plane.gmane.org; Thu, 01 Nov 2012 07:05:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437Ab2KAGFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2012 02:05:23 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:45479 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210Ab2KAGFW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2012 02:05:22 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so2248523oag.19
        for <git@vger.kernel.org>; Wed, 31 Oct 2012 23:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=iov8Y6ssXjWVGINyJkkBv3DRZlasnIFrxRSAUC2Ozqs=;
        b=C9rhJ3wMUTJdWsClh9Zbgwzm+/EHtdPGaJQ3YlxqhVLc9zjrTnkSlCYoXfnmxSEvDb
         oAi1eUUmHUTnu0M6mRDBAaKlMTHYxhEIUdqgXU0xqUMdsUE77UTnfU1s/9NrPPmEYM4Q
         kdyznB8kzkyUoYFHiP5d1Smlnh1c69amcHjX24OxDHuwHh1CBu4/DEpRo2e2gKlL6EHN
         okb2XPoeNWl5gRljRCY+1NyrLon7jSrrOJQfZpBgwNs6nSSA23bnLCPHnbKCJjsSI4Z5
         VjDIbLs3FhqRVWUzfANMSV2l64DUjrR+N3XzkOnTxhJo/xgS9q47bu6mzdEBLICV7ahq
         0M+A==
Received: by 10.182.116.6 with SMTP id js6mr32036241obb.82.1351749921627; Wed,
 31 Oct 2012 23:05:21 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Wed, 31 Oct 2012 23:05:21 -0700 (PDT)
In-Reply-To: <20121030180021.GX26850@arachsys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208865>

On Tue, Oct 30, 2012 at 7:00 PM, Chris Webb <chris@arachsys.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Yes, it seems this is an API issue; repo.branchtip doesn't exist in
>> python 2.2.
>
> Hi. Presumably this is a problem with old mercurial not a problem with old
> python as mentioned in the commit?

Yeah, mercurial.

>> Both issues should be fixed now :)
>
> They are indeed, and it now works nicely on all the repos I've tested it
> with, including http://selenic.com/hg: very impressive!
>
> I wonder whether it's worth ignoring heads with bookmarks pointing to them
> when it comes to considering heads of branches, or at least allowing the
> hg branch tracking to be easily disabled?
>
> A common idiom when working with hg bookmarks is to completely ignore the
> (not very useful) hg branches (i.e. all commits are on the default hg
> branch) and have a bookmark for each line of development used exactly as a
> git branch would be.
>
> On such a repository, at the moment you will always get a warning about
> multiple heads on branches/default, even though you actually don't care
> about branches/default (and would prefer it not to exist) and just want the
> branches coming from the bookmarks.
>
> I've also seen repositories with no hg branches, but with a single
> unbookmarked tip and bookmarks on some other heads to mark non-mainline
> development. It would be nice for branches/default to track the unbookmarked
> tip in this case, without warning about the other, bookmarked heads.

Implemented now. I'm not handling the 'tip' revision, but most likely
it's also the '.' revision. In this case a fake 'master' bookmark will
be created to track that revision.

> Finally, on a simple repo with no branches and where there's no clash with a
> bookmark called master, I'd love to be able to a get a more idiomatic
> origin/master rather than origin/branches/default.

Yeah, you can get that now. If there are no branches or bookmarks,
'master' will point to '.'.

As for your preference of not tracking branches, there's a new option:

% git config --global remote-hg.track-branches false

So you don't have to use hg-git-compat mode :)

Cheers.

-- 
Felipe Contreras
