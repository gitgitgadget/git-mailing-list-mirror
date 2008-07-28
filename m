From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: git submodules
Date: Mon, 28 Jul 2008 17:40:22 -0400
Message-ID: <32541b130807281440v64f3cb9ci50cf6d16be4f2f82@mail.gmail.com>
References: <20080728162003.GA4584@artemis.madism.org>
	 <320075ff0807281323l51bb6478j30e3e4c490974a70@mail.gmail.com>
	 <20080728205545.GB10409@artemis.madism.org>
	 <20080728205923.GC10409@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Pierre Habouzit" <madcoder@debian.org>,
	"Nigel Magnay" <nigel.magnay@gmail.com>,
	"Git ML" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 23:41:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNaT7-0005Yp-AF
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 23:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755993AbYG1VkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 17:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754676AbYG1VkY
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 17:40:24 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:14033 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755993AbYG1VkX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 17:40:23 -0400
Received: by qw-out-2122.google.com with SMTP id 3so329063qwe.37
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 14:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=3boT7OeRTHhVx6NcdxrggmhoAqi/YDBW16Bndfr52c8=;
        b=rSk19ycuJeazDsjkH3j4vC0xjgf/MEiTgppAnBdTUGsyGOomJjJrGC/VjGIquSwDoZ
         2M461On1Lwy731rdyWIyjyZsyvRBYW1YQbEToyTtkAhW2yAKnl1j60eAtRxAsFJYe9kF
         IMK6hgho4MwKagSOuNhPHywj7ALIJxQEHWoxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=xsyRR4VivnzVdR6rBN2m70CEnYhtw31R1HcCUdX0bI9dtUC9MNl7/2WQRnIKY0Onkd
         obgg521wtkbL3DDa9c792MbELjkj4iMS/DK7eurLRey2n13fkLzlizr4RUr+NHL7x4uS
         z2RZtec0/iy3L1ogvMkQmMz1PSaxbr1vV2chY=
Received: by 10.214.114.16 with SMTP id m16mr523583qac.75.1217281222193;
        Mon, 28 Jul 2008 14:40:22 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Mon, 28 Jul 2008 14:40:21 -0700 (PDT)
In-Reply-To: <20080728205923.GC10409@artemis.madism.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90510>

On 7/28/08, Pierre Habouzit <madcoder@debian.org> wrote:
> On Mon, Jul 28, 2008 at 08:55:45PM +0000, Pierre Habouzit wrote:
> >   That too indeed (the "easier to clone" bit). OTOH, I don't like the
>  > .git/submodules idea a lot, if you mean to put a usual $GIT_DIR layout
>  > inside of it. With what I propose, you find objects for all your
>  > super/sub-modules in the usual store, which eases many things.
>  > Especially, I believe that when you replace a subdirectory of a project
>  > with a submodule, git-blame could benefit quite a lot from this to be
>  > able to glue history back through the submodule limits, without having
>  > to refactor a _lot_ of code: it would merely have to dereference so
>  > called "gitlinks" to the commit then tree, hence twice, and just do its
>  > usual work, with your proposal, we still rely on having to recurse in
>  > subdirectories which requires more boilerplate code.
>
>   And of _course_ this is also true for git-log, which is like 10x as
>  important for me (like I don't remember if I used git-blame this year,
>  whereas I used git-log in the last 10 minutes ;p)

I don't think you're going to get away with *not* having a separate
.git directory for each submodule.  You'll just plain lose almost all
the features of submodules if you try to do that.

Most importantly in my case, my submodules (libraries shared between
apps) have a very different branching structure than my supermodules.
It wouldn't be particularly meaningful to force them to use the same
branch names.

Further, if you don't have a separate .git directory for each
submodule, you can't *switch* branches on the submodule independently
of the supermodule in any obvious way.  This is also useful; I might
want to test updating to the latest master of my submodule, see if it
still works with my supermodule, and if so, commit the new gitlink in
the supermodule.  This is a very common workflow for me.

On the other hand, your thought about combining the "git log" messages
is quite interesting.  That *is* something I'd benefit from, along
with being able to git-bisect across submodules.  If I'm in the
supermodule, I want to see *all* the commits that might have changed
in my application, not just the ones in the supermodule itself.  I
suspect this isn't simple at all to implement, however, as you'd have
to look inside the file tree of a given commit in order to find
whether any submodule links have changed in that commit.  It's
unfortunate that submodules involve a commit->tree->commit link
structure.

> One irritating problem with submodules, is
> that when someone else commited, and that you git submodule update,
> you're on a detached head. Absolutely horrible.

I think that roughly everyone agrees with the above statement by now.
It would also be trivial to fix it, if only we knew what "fix" means.
So far, I haven't seen any good suggestions for what branch name to
use automatically in a submodule, and believe me, I've been looking
for one :)

Have fun,

Avery
