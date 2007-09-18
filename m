From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] git-merge: add option --no-ff
Date: Tue, 18 Sep 2007 10:02:44 +0200
Message-ID: <8c5c35580709180102l10e89094tab801cd5742c6415@mail.gmail.com>
References: <8c5c35580709170817s467fa7dv375952f872bba0e3@mail.gmail.com>
	 <11900461843997-git-send-email-hjemli@gmail.com>
	 <20070918005013.GA6368@muzzle>
	 <8c5c35580709172312w55613a1bw8cc58b200c526fab@mail.gmail.com>
	 <7v4phsxy55.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Eric Wong" <normalperson@yhbt.net>,
	"Andreas Ericsson" <ae@op5.se>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Chris Shoemaker" <c.shoemaker@cox.net>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 10:02:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXY2n-0002RQ-E6
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 10:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448AbXIRICr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 04:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753248AbXIRICq
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 04:02:46 -0400
Received: from rv-out-0910.google.com ([209.85.198.191]:2818 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753222AbXIRICp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 04:02:45 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1531630rvb
        for <git@vger.kernel.org>; Tue, 18 Sep 2007 01:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=OF3HHBAO1Iwc7DVKP1Pb/JKfFOdGlLGx3oCN/G/+SaY=;
        b=VVuOJVP0H8JWLqOCkXhu7nSOm8ngONnntU/kA3n3oYUI+XeI6ETqusVJasu1UdqtaA/YllbJ3DfHBExTBKaAs1fljKDGvv9msSeQp4UAUStgti1ye80uLKWZlTq+ZPSF3HgXnLoKHfPhaXJ3PT6l9ixY8iiziWFndy/xvgJGyhU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y/bvkeGRYpnzIyMuFTMQyDXYpGPNZ7EAvVg7YHRbJdooWPyQckqbVA3jdo3npzG3MWZsozpUNTC1YHjzqRHID6BDCUu++dCX3ozVuQdm3glUL3KLAgEbFC6olgobDMGcwJXjQpatr0n73rPvuz4LzjrmZGd+6y/7nTqv360KgrI=
Received: by 10.115.33.1 with SMTP id l1mr4035401waj.1190102564305;
        Tue, 18 Sep 2007 01:02:44 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Tue, 18 Sep 2007 01:02:44 -0700 (PDT)
In-Reply-To: <7v4phsxy55.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58541>

On 9/18/07, Junio C Hamano <gitster@pobox.com> wrote:
> "Lars Hjemli" <hjemli@gmail.com> writes:
>
> > On 9/18/07, Eric Wong <normalperson@yhbt.net> wrote:
> >> Would automatically enabling --no-ff when it detects merging of two (or
> >> more) SVN branches be a good thing?
> >
> > I'd say 'git-svn merge' as a wrapper for 'git merge --no-ff' would be cleaner.
>
> That unfortunately does not solve the problem.
>

The problem we're trying to solve is to somehow avoid fast-forward
merges between git-svn branches, right?

I don't think it's a big issue in itself. If a fast-forward occurs,
what will happen is basically that git-svn will guess the wrong
upstream branch and then proceed to do nothing [1]. The user can
always recover from this state with 'git-reset' and 'git-merge
--no-ff'. So I think the result of a fast-forward merge between
git-svn branches is annoying, but not fatal [2].

But a closely related issue is that git-svn shouldn't dcommit to the
wrong upstream (even in the case of a fast-forward merge). We need a
way to explicitly show the link between the local and remote svn
branch (something like .git/config perhaps).

-- 
larsh

[1] If the merged-in branch had local commits they will be 'dcommited'
to the correct upstream of the merged-in branch, which isn't to bad

[2] if git-svn could be fixed to handle even the ff case, someone
could actually prefer to get the 'cherry-picked' history in
subversion. I don't, hence my --no-ff patch, but I'm not at all
certain this should be _forced_ on git-svn branches.
