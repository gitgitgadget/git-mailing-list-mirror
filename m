From: Remi LESPINET <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH 1/3] t4150-am: refactor and clean common setup
Date: Fri, 29 May 2015 13:50:43 +0200
Message-ID: <871thz4n70.fsf@ensimag.grenoble-inp.fr>
References: <1432675975-11020-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<CACRoPnQEJHPfoz0LjSs2X1CrW-TdVGb54XSrg6VWXP2tdyu5Uw@mail.gmail.com>
	<CAPig+cRm6MRaR=Qgjxo2fGGcs522DstVedmq4j_fAQeBwG4ZUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>, Git List <git@vger.kernel.org>,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri May 29 13:51:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyIoV-0007e5-1n
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 13:50:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755233AbbE2Luu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 07:50:50 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:54279 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752833AbbE2Lus (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 May 2015 07:50:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 64BF248864;
	Fri, 29 May 2015 13:50:45 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BlPmA-u-GKhK; Fri, 29 May 2015 13:50:45 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr (zm-smtpauth-1.grenet.fr [130.190.244.122])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 4B44D48861;
	Fri, 29 May 2015 13:50:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTP id 4218A20D6;
	Fri, 29 May 2015 13:50:45 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nqb6kyLPFGyg; Fri, 29 May 2015 13:50:45 +0200 (CEST)
Received: from Groseille (cor91-7-83-156-199-91.fbx.proxad.net [83.156.199.91])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTPSA id 5D2FD20D4;
	Fri, 29 May 2015 13:50:44 +0200 (CEST)
In-Reply-To: <CAPig+cRm6MRaR=Qgjxo2fGGcs522DstVedmq4j_fAQeBwG4ZUg@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 28 May 2015 14:15:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270237>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Paul Tan <pyokagan@gmail.com> writes:
>
> >> Remi LESPINET <remi.lespinet@ensimag.grenoble-inp.fr> writes:
> >> +       tmp_name=${2-"temporary"}
> >
> > I don't think the quotes are required. Also, I don't feel good about
> > swapping the order of the arguments to git-checkout. (or making $2 an
> > optional argument). As the patch stands, if I see
> >
> > setup_temporary_branch lorem
> >
> > I will think: so we are creating a temporary branch "lorem". But nope,
> > we are creating a temporary branch "temporary" that branches from
> > "lorem". I don't think writing setup_temporary_branch "temporary"
> > "lorem" explicitly is that bad.
> 
> In fact, the second argument is never used in any of the three
> patches, so it seems to be wasted functionality (at this time). If so,
> then an even more appropriate name might be new_temp_branch_from().
> Clearly, then:
> 
>     new_temp_branch_from lorem

Considering your two comments about the name of the function I think
removing the possibility of using the second argument and renaming the
function new_temp_branch_from gets everyone to agree since it has not
the possible confusion with git-checkout problem.

> This is confusing. The commit message seems to advertise this patch as
> primarily a refactoring change (pulling boilerplate out of tests and
> into a new function), but the operation of that new function is
> surprisingly different from the boilerplate it's replacing: The old
> code did not create a branch, the new function does.
> 
> If your intention really is to create new branches in tests which
> previously did not need throwaway branches, then the commit message
> should state that as its primary purpose and explain why doing so is
> desirable, since it is not clear from this patch what you gain from
> doing so.
> 
> Moreover, typically, you should only either refactor or change
> behavior in a single patch, not both. For instance, patch 1 would add
> the new function and update tests to call it in place of the
> boilerplate; and patch 2 would change behavior (such as creating a
> temporary branch).
> 
> On the other hand, if these tests really don't benefit from having a
> throw-away branch, then this change seems suspect and obscures the
> intent of the test rather than clarifying or simplifying.

The purpose of this patch was originally to eliminate some test
dependancies introduced by the checkouts relative to HEAD (which
caused "cascade failure") and avoid creating branches, whose name
can't be reused, but you're right, that may not benefit as much as I
expected...  Perhaps I should have make tags from branches used as
start points, which would have done the same effect as these temporary
branches.

> >         sed -n -e "3,\$p" msg >file &&
> >         head -n 9 msg >>file &&
> >         git add file &&
> > @@ -303,10 +297,8 @@ test_expect_success 'am -3 -p0 can read --no-prefix patch' '
> >  '
> >
> >  test_expect_success 'am can rename a file' '
> > +       setup_temporary_branch lorem &&
> >         grep "^rename from" rename.patch &&
> > -       rm -fr .git/rebase-apply &&
> > -       git reset --hard &&
> > -       git checkout lorem^0 &&
> 
> In other cases, you insert the setup_temporary_branch() invocation
> where the old code resided. Why the difference in this test (and
> others following)?

This doesn't affect the result of the test (assuming
setup_temporary_branch doesn't fail). I preferred to add the setup
before anything else in the test.  It affects efficiency in case the
rename patch has not the correct syntax. So it may be better to put the
grep as the first instruction to avoid evaluating all the test in case
the syntax of the patch is not correct.

Thanks a lot for your comments, I'll correct the patch asap !
