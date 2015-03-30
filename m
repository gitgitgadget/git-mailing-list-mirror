From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] docs: Clarify what git-rebase's "--preserve-merges" does
Date: Mon, 30 Mar 2015 21:42:15 +0200
Message-ID: <CAHGBnuP0mRYWyJiLvWHuqsVxMRPPtvu-QuWmcD8xXeVOXhwSDA@mail.gmail.com>
References: <CAHGBnuO5Y=ejJLxktk0GsnXx8h2LwPW1i7TqDePhfZ_zLR_X9A@mail.gmail.com>
	<xmqqd23vzkon.fsf@gitster.dls.corp.google.com>
	<5519178A.6080408@gmail.com>
	<xmqqfv8mxuuv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>, sorganov@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 21:42:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcfZm-0002k2-4J
	for gcvg-git-2@plane.gmane.org; Mon, 30 Mar 2015 21:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880AbbC3TmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 15:42:18 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33713 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864AbbC3TmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 15:42:16 -0400
Received: by iecvj10 with SMTP id vj10so126929573iec.0
        for <git@vger.kernel.org>; Mon, 30 Mar 2015 12:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Qq2KZ+5QABBj49KsG+NocI244ig2EnyX0Mre9DSHaT4=;
        b=qSpyTLp5EmoeXJM2HWeCrpcyY2/RhsRIB9A7lBon2j2wnTH/6/lHa8uzcEN4cBLJRf
         l6NRl3xnCg+64YK5Nnb0290Pd0wuFQZ+9B56PTABmscilQ5PSPI2jLi7ZL7e8PQKl949
         rIBsv4+bkNHsixIL7Ct0azVfwRViT3CRDKjtooWbb98PEK7FyqiV3u8zd2sSr5Da5pA9
         sjuNMI11ek9ee9HtEVSw6o3JNlqh/HNu28hNj1y9Q/UiUPMH5Zao8FKCw2BSYvCD+O1y
         EcuuphpgKcUKZKmNHgAGGmX1ubV7q8RNGD/V17DOHlEhFYdCUfe6eRi4dMqVjtXm8hZQ
         Nrjw==
X-Received: by 10.107.163.65 with SMTP id m62mr51859192ioe.40.1427744535391;
 Mon, 30 Mar 2015 12:42:15 -0700 (PDT)
Received: by 10.107.132.144 with HTTP; Mon, 30 Mar 2015 12:42:15 -0700 (PDT)
In-Reply-To: <xmqqfv8mxuuv.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266469>

On Mon, Mar 30, 2015 at 7:23 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> Ignoring a merge sounds like ignoring the changes a merge commit
>> introduces altogether, as if the merge commit was skipped or dropped from
>> history. But that is not what happens if "-p" is not specified.
>
> Every time I read the above (which is essentially the same from your
> first edition I think) I find the "ignoring the changes a merge
> commit introduces altogether" and "as if the merge commit was
> skipped" somehow contradicting with each other.  If the latter were
> "as if the side branch that was merged was skipped or dropped", I do
> not see the room for such a misinterpretation.
>
> That is, at least to me,
>
>          D---E---F
>         /         \
>     ---A---B---C---G---H
>
> the former, i.e. "the changes the merge G introdues", is "diff C G",

To me, too. In other words, this is the combined diff of all commits
reachable from all parents of the merge (other than the first parent).
In your example, that would be the combined diff of D, E and F, which
equals "git diff C G".

However, I'm used to thinking that a non-conflicting merge itself has
no diff, but introduces commits that have diffs. This way of seeing it
probably comes from my intensive use of gitk which does not display a
diff when selecting a merge commit unless it has conflicts resolved.

> while "merge commit was skipped" would mean a history like this:
>
>     ---A---B---C---D'--E'--F'--H'
>

This is where your interpretation differs. If a merge commit was
skipped, it is non-existent. If it is non-existent, it also has no
parents. If it has no parents, there are no commits that D, E, F could
be replayed on to of C. Thus for me, skipping merge commit G in your
example would result in:

    ---A---B---C---H'

> And I think with "as if the side branch that was merged was
> dropped", this misinterpretation will become impossible.  It can
> only mean this history:
>
>     ---A---B---C---.---H'

I think we need to generalize the wording a bit for merges with more
than two parents. How about making the the first paragraph of the
commit message simply read:

Ignoring a merge sounds like dropping the merge commit and all side
branches it merges from history. But that is not what happens if "-p" is
not specified.

-- 
Sebastian Schuberth
