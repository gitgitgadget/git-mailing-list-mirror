From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Using git to track my PhD thesis, couple of questions
Date: Thu, 27 Aug 2009 14:38:11 -0700
Message-ID: <7v1vmxq6nw.fsf@alter.siamese.dyndns.org>
References: <20090827203402.GC7168@kisimul>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: seanh <seanh.nospam@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 23:39:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgmgf-0003US-3S
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 23:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263AbZH0ViX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 17:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753232AbZH0ViX
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 17:38:23 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60088 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243AbZH0ViS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 17:38:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5CF6B39AEB;
	Thu, 27 Aug 2009 17:38:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MysspQ4c1MrThopOwBrRosoOIkA=; b=c9RfWX
	eESciwgt21Vf+WP1AtNtZ2fxMFoIbWjwjkCX9ic6rG5/u0bgRXXLmQiJJT4dpzzX
	kmVuadB8PsQqMROuHqeyQBNkEqFwWxiB3GF62Q3zTvPEic2ff22mBREG1Pr7e9RY
	Ap74S5D4myK3psWCoIYp+0Jeq8mtrfw7J+yVc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WJnj7w8u+NRTrB9d2b9ZCAfWZFZaR2mF
	s7Q+PFl8zPAkHrIHJ7nfSGBkWUPtE2243aOWHN8J2RiXoXdoC1wagZpmAww+iPNi
	2XRlSt/1c4kBHJnNV5Ms86ArLJary2x5g2HSMNcqQIc51jYB336vmFnDYUX2EoeV
	x+k59K6laMQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3AE7D39AE8;
	Thu, 27 Aug 2009 17:38:17 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D3C4739AE6; Thu, 27 Aug 2009
 17:38:13 -0400 (EDT)
In-Reply-To: <20090827203402.GC7168@kisimul> (seanh's message of "Thu\, 27
 Aug 2009 21\:34\:02 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EE92BCAC-9351-11DE-97F6-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127216>

seanh <seanh.nospam@gmail.com> writes:

> I'm planning to use git to track my PhD thesis as I work on it and to 
> let my supervisors track it. I've setup a git repository and a gitweb 
> instance showing it. There are a couple of specific requirements.
>
> 1. My supervisors don't want to see all the little commits that I make 
> day by day. So I'll commit to a dev branch, then whenever I've made 
> significant progress will merge it into a trunk branch. I want the trunk 
> branch to get all the changes but as one big commit, not inherit all the 
> little commits like a normal merge would do. I think this is a `git 
> merge --squash`. Btw the help for that command ends quite brilliantly: 
> "(or more in case of an octopus)".
>
> 2. They don't want to look at the latex source but the PDFs built from 
> it, which they're going to annotate with their comments. So I need an 
> easy way for them to get the PDF of each commit from gitweb without 
> having to checkout the repo and build it themselves. Normally I 
> wouldn't commit the PDF files into the repo because they're compiled 
> files not source files, but it seems that just building a PDF and 
> committing it along with each commit to trunk would be by far the 
> easiest way to achieve this. But will git store the PDFs efficiently, or 
> will the repo start to get really big?

What I would do if I were you (and I did something similar recently while
working on my book) is something like this:

 * Keep your source in git.  Do not worry about the commit granularity.
   Commit as often as you think makes sense.

 * Have a Makefile to build pdf if you have not done so.

 * Dedicate a separate directory, for review pupose.  Have a separate git
   repository there.  If you choose to use an untracked subdirectory
   'publish' of your source work tree (you do not have to), you would do
   something like this:

	$ mkdir publish
        $ (cd publish && git init)

   Arrange things so that "git push" in that repository will propagate its
   contents to the public repository your advisors will look at.

 * Have a 'publish' target in your Makefile, which would roughly do:

	#!/bin/sh

	make pdf &&
        cp paper.pdf publish/. &&

        this=$(git rev-parse HEAD) &&
        prev=$(cd publish &&
               git show -s | sed -ne 's/^ *Changes up to: \(.*\)$/\1/p'
	) &&
	{
		echo "Changes up to: $this"
                echo
                case "$prev" in
                '') # initial round
                        git shortlog ;;
                ?*)
                        git shortlog $prev.. ;;
                esac
	} >publish/log &&
        cd publish &&
        git add paper.pdf &&
        git commit -F log &&
        git push

 * Then when you want to submit the current status for review (perhaps you
   would want this to happen at the end of each day, or every other day,
   or whatever), type

    $ make publish

The idea is:

 (1) If your source material is not interesting to your advisors at all,
     there is no point showing, let alone the commit granularity of your
     work; and

 (2) If your advisors want to see PDF and PDF only, then give them that,
     but as you correctly said, that is a cruft from your source's point
     of view, so do not mix them together.
