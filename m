From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Itches with the current rev spec
Date: Mon, 29 Apr 2013 22:44:39 +0530
Message-ID: <CALkWK0k7w4xuewnJFNJLk730NSiZOA_1UF0_Dqcnw5Or3GYOcA@mail.gmail.com>
References: <CALkWK0n97VLtiR96VEy86645NVoDL2rS-g7LBuLb=JpncdH6VA@mail.gmail.com>
 <20130426101946.433f2d12@chalon.bertin.fr> <517A3E47.6010606@viscovery.net>
 <7v7gjpxjw0.fsf@alter.siamese.dyndns.org> <CAMP44s0-C_TRC_eD_ZbN3WFe4NKWVPQVhh+ME-F5yBBwKs2NdA@mail.gmail.com>
 <7v8v45vvuy.fsf@alter.siamese.dyndns.org> <CALkWK0=W_FxDwc3Tby=h90yc5i8UEuT7maERahFRDQU=hQ633g@mail.gmail.com>
 <7vobcxl3ui.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Yann Dirson <dirson@bertin.fr>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 19:15:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWrfi-0006JJ-8W
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 19:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757284Ab3D2RPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 13:15:22 -0400
Received: from mail-ia0-f169.google.com ([209.85.210.169]:60963 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757014Ab3D2RPV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 13:15:21 -0400
Received: by mail-ia0-f169.google.com with SMTP id l29so5894987iag.28
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 10:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=fcDr+qu5vdP5C+UGDbYUw341GJcwW83kWI/2Wv6aJFI=;
        b=h6DAizbBYyhTKnYuF3/R7+3MAAdprrDRIw1AOVPfo7FWuksYcoFEHfVjgt0ztLHwOD
         AvbEALq6e3tDshUc/G0NQvdNMev9W5P+6wtNRi/ephOz+p8udm+kWhuqojeLekxxhM3e
         ay2Ug6PHJelVEnl3LC3PXXJn4nwhVN/Zebgqf8tWcjacBeg6dfY02QoD1x0DW6J8i14x
         HqkB64B+xpEO6xCAhZ9TZqLFUJNCoQqQWesh0R/RYEMbdGXOvK/4uKDONnzRdiH/tkep
         0Zml/yFiOc3UIpZu3ZPg5rso/wYMq1nj6f7aYdwIE5fn0ChQY/OdHVlAKjh70JLsgss/
         nsCQ==
X-Received: by 10.50.72.65 with SMTP id b1mr7997611igv.63.1367255720612; Mon,
 29 Apr 2013 10:15:20 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Mon, 29 Apr 2013 10:14:39 -0700 (PDT)
In-Reply-To: <7vobcxl3ui.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222816>

Junio C Hamano wrote:
> That world view is broken, isn't it?  Perhaps you forgot to consider
> symmetric differences, where left positives and right positives have
> to be treated differently.

No, I did consider symmetric difference.  How is git log A B --not
$(git merge-base --all A B) different from git log B A --not $(git
merge-base --all A B)?

> "diff A B" and "diff B A" mean very
> different things, for that matter.

In fact, I would go so far as to claim that git diff A B is broken.
diff should be forbidden from taking two positives (since it has no
way to differentiate between them but for the ordering).  It should
diff a positive against a negative.

> A line of thought that begins
> with "there is no ordering" may be a "brave proposal", perhaps, but
> it is not "fundamental principles".

My claim is very simple.  If a command _depends_ on A..B being
resolved as ^A B, and not B ^A, we have have a big problem.  Why?
Because we've already established that git log A B is exactly the same
thing as git log B A.  To maintain consistency with this, ordering
should never matter.

> "rebase requires three: onto, list and a ref" (by the way, it is not
> refspec, which has a specific meaning)

Sorry about that thinko: yes, I meant ref.

After working on the implicit-push proposal for so long, I think I can
tell the difference between a ref and refspec ;)

> It is not far-fetched to allow rebase to handle a history with two
> branches A and B that share the common initial part (i.e. ^X A B)
> and replay that history on top of an unrelated point in history Y to
> transform:
>
>              o---o---Y
>             /
>     ---o---X---C---C---A---A---A (tip of branch A)
>                     \
>                      B---B---B (tip of branch B)
>
> into
>
>              o---o---Y---C'--C'--A'--A'--A' (updated tip of branch A)
>             /         \
>     ---o---X           B'--B'--B' (updated tip of branch B)

I wholeheartedly agree.

However, I think you've misunderstood what I said: my goal is to
define _everything_ in terms of how different commands interpret a
list of positive and negative commits.  It's not that some commands
take DAGs, other ranges, and yet others lists; all of them take rev
specs that resolve to a list of positive-negative commits.  What to do
with that information is up to the command (erroring out is a valid
response).  In my above proposal, I'd like to change "rebase can take
one negative commit and one positive commit" to "rebase can take one
negative commit and multiple positive commits" (in fact, this was my
original sentence, but I went back to "one positive commit" before
sending out the email because I thought I was being crazy).

> So what?  Why do you even _need_ to mix up all positive revisions,
> some of which mean different things from others, into a single bag,
> only to later differenciate some as special (i.e. used as the onto
> commit) from the others (i.e. the tips in the DAG)?  If something is
> special, you can say not just it is special and can say what it
> means by saying "this is where I want to replay the DAG on top".

Um, my point was again that "ordering does not matter"; therefore for
a third type of commit, you need a command-line parameter.

>     git show A..B C..D

This is seriously bad.  We'll have to think about fixing this along the way.
