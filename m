From: John Keeping <john@keeping.me.uk>
Subject: Re: Question about "git log --cherry"
Date: Fri, 27 Sep 2013 09:11:13 +0100
Message-ID: <20130927081113.GE27238@serenity.lan>
References: <CAC9WiBjLqdqSKgLv_M6FPx3a2J-+ZKAQnk9OGn3h5SfqSpiT3g@mail.gmail.com>
 <20130926202153.GC27238@serenity.lan>
 <CAC9WiBjykt5qj2sRtTK=VHp0B5x===7oqVP7VRC6BOdCMTn9yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 27 10:11:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPT9A-0004AI-E1
	for gcvg-git-2@plane.gmane.org; Fri, 27 Sep 2013 10:11:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837Ab3I0IL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Sep 2013 04:11:28 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:60757 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345Ab3I0ILV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Sep 2013 04:11:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 6A537CDA67A;
	Fri, 27 Sep 2013 09:11:20 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eCNIBJpjdGg2; Fri, 27 Sep 2013 09:11:18 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id B84D5CDA68A;
	Fri, 27 Sep 2013 09:11:15 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAC9WiBjykt5qj2sRtTK=VHp0B5x===7oqVP7VRC6BOdCMTn9yg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235443>

On Fri, Sep 27, 2013 at 07:09:03AM +0200, Francis Moreau wrote:
> Hi,
> 
> On Thu, Sep 26, 2013 at 10:21 PM, John Keeping <john@keeping.me.uk> wrote:
> > On Thu, Sep 26, 2013 at 06:35:57PM +0200, Francis Moreau wrote:
> >> I'm trying to use "git log --cherry ..." in order to display new, kept
> >> and removed commits between two branches A and B.
> >>
> >> So commits which are only in B are considered new and should be marked
> >> with '+'. Commits which are in both branches are marked with '=' but
> >> only commit in branch B are shown. Eventually commits which are in A
> >> but not in B anymore should be marked with '-'.
> >>
> >> So far I found this solution:
> >>
> >>   $ git log --cherry-mark --right-only A...B
> >>   $ git log --cherry-pick  --left-only   A...B
> >>
> >> but I have to call twice git-log. This can be annoying since depending
> >> on A and B, calling git-log can take time.
> >>
> >> Is there another option that I'm missing which would do the job but
> >> with only one call to git-log ?
> >
> > Does this do what you want?
> >
> >     git log --cherry-mark --left-right A...B |
> >     sed -e '/^commit / {
> >         y/<>/-+/
> >     }'
> 
> Nope because --left-right shows common commits (with '=' mark) that
> belong to A *and* B, and I'd like to have only the ones in B.

I think the only way you can address this is to post-process the result,
I don't know any way to remove a left side commit only if it is
patch-identical to a right side commit.

It should be relatively easy to filter out any '=' commits that are in
the output of "git rev-list --left-only A...B".
