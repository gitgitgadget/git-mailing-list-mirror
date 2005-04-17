From: Brad Roberts <braddr@puremagic.com>
Subject: Re: Re: Merge with git-pasky II.
Date: Sun, 17 Apr 2005 08:08:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.44.0504170804130.2625-100000@bellevue.puremagic.com>
References: <20050417145232.GA5289@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>,
	Simon Fowler <simon@himi.org>,
	David Lang <david.lang@digitalinsight.com>,
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 17 17:06:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNBLA-00021F-62
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 17:05:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVDQPJP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 11:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVDQPJP
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 11:09:15 -0400
Received: from bellevue.puremagic.com ([209.189.198.108]:31875 "EHLO
	bellevue.puremagic.com") by vger.kernel.org with ESMTP
	id S261323AbVDQPJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 11:09:09 -0400
Received: from bellevue.puremagic.com (localhost [127.0.0.1])
	by bellevue.puremagic.com (8.13.3/8.13.3/Debian-6) with ESMTP id j3HF8ZGK012074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 17 Apr 2005 08:08:35 -0700
Received: from localhost (braddr@localhost)
	by bellevue.puremagic.com (8.13.3/8.13.3/Submit) with ESMTP id j3HF8ZeV012070;
	Sun, 17 Apr 2005 08:08:35 -0700
X-Authentication-Warning: bellevue.puremagic.com: braddr owned process doing -bs
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20050417145232.GA5289@elte.hu>
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 17 Apr 2005, Ingo Molnar wrote:

> Date: Sun, 17 Apr 2005 16:52:32 +0200
> From: Ingo Molnar <mingo@elte.hu>
> To: Linus Torvalds <torvalds@osdl.org>
> Cc: Petr Baudis <pasky@ucw.cz>, Simon Fowler <simon@himi.org>,
>      David Lang <david.lang@digitalinsight.com>, git@vger.kernel.org
> Subject: Re: Re: Merge with git-pasky II.
>
>
> * Linus Torvalds <torvalds@osdl.org> wrote:
>
> > Almost all attacks on sha1 will depend on _replacing_ a file with a
> > bogus new one. So guys, instead of using sha256 or going overboard,
> > just make sure that when you synchronize, you NEVER import a file you
> > already have.
>
> With tens of thousands (or hundreds of thousands) of objects expected in
> the repository sooner or later, there's quite a selection to pick from.
> Once you apply the patch, instead of the expected new file that you
> reviewed and found safe, the attacker has the other object included in
> the official kernel.
>
> A dangerous object can be anything: e.g. a debugging hack that allows
> arbitrary kernel-space writes. Or a known-insecure module (which since
> then got fixed, but the buggy code still exists in the DB). The module
> is in a single file and is self-installing (e.g. it has __init code to
> register itself as some driver.)

While I agree that a hash collision is bad and certainly worth preventing
during new object creation, for it to actually implant a trojan in a build
successfully it'd have to meet even more criteria than you've layed out.
It'd have to...

  - be shadowing an object that's part of an active tree
  - provide all the public symbols the shadowed object provided so that it
    would still build and link successfully

Shadowing an object that's not part of the working tree means something on
another branch or obsoleted some time in the past is still db corruption,
but not nearly as big an issue from a trojan standpoint.

Later,
Brad


