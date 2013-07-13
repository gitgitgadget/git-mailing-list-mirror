From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 7/7] push: document --lockref
Date: Sat, 13 Jul 2013 23:11:23 +0200
Message-ID: <51E1C27B.7070705@kdbg.org>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org> <1373399610-8588-1-git-send-email-gitster@pobox.com> <1373399610-8588-8-git-send-email-gitster@pobox.com> <51DC7199.2050302@kdbg.org> <7vhag3v59o.fsf@alter.siamese.dyndns.org> <51DC78C0.9030202@kdbg.org> <7v38rnv0zt.fsf@alter.siamese.dyndns.org> <7vvc4jtjqa.fsf@alter.siamese.dyndns.org> <51DF1F56.9000705@kdbg.org> <7vzjtspwvo.fsf@alter.siamese.dyndns.org> <51E03B18.5040502@kdbg.org> <7vli5bllsd.fsf@alter.siamese.dyndns.org> <51E0605E.9020902@kdbg.org> <7vy59biih4.fsf@alter.siamese.dyndns.org> <51E0F93A.8050201@kdbg.org> <7vwqougwec.fsf@alter.siamese.dyndns.org> <7vr4f2gr4m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 13 23:11:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uy76I-0007Nr-I8
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jul 2013 23:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227Ab3GMVL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jul 2013 17:11:26 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:25900 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751065Ab3GMVLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jul 2013 17:11:25 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 4212413004A;
	Sat, 13 Jul 2013 23:11:24 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id AD56A19F61C;
	Sat, 13 Jul 2013 23:11:23 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7vr4f2gr4m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230293>

Am 13.07.2013 22:08, schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> If "--lockref" automatically implies "--allow-no-ff" (the design in
>> the reposted patch), you cannot express that combination.  But once
>> you use "--lockref" in such a situation , for the push to succeed,
>> you know that the push replaces not just _any_ ancestor of what you
>> are pushing, but replaces the exact current value.  So I do not think
>> your implicit introduction of --allow-no-ff via redefining the
>> semantics of the plus prefix is not adding much value (if any),
>> while making the common case less easy to use.
>>
>>> No; --lockref only adds the check that the destination is at the
>>> expected revision, but does *NOT* override the no-ff check.
>>
>> You _could_ do it in that way, but that is less useful.
> 
> Another issue I have with the proposal is that we close the door to
> "force only this one" convenience we have with "+ref" vs "--force
> ref".  Assuming that it is useful to require lockref while still
> making sure that the usual "must fast-forward" rule is followed (if
> that is not the case, I do not see a reason why your proposal is any
> useful---am I missing something?),

The ability to express "require both fast-forward and --lockref" is just
an artefact of the independence of fast-forward-ness and --lockref in my
proposal. It is not something that I think is absolutely necessary.

> I would prefer to allow users a
> way to decorate this basic syntax to say:
> 
>     git push --lockref master jch pu
> 
> things like
> 
>  (1) pu may not fast-forward and please override that "must
>      fast-forward" check from it, while still keeping the lockref
>      safety (e.g. "+pu" that does not --force, which is your
>      proposal);

That must be a misunderstanding. In my proposal

    git push --lockref +pu

would do what you need here. I don't know where you get the idea that
these two

    git push --lockref +pu
    git push +pu

would be different with regard to non-fast-forward-ness. The table
entries were correct.

[Please do not use the option name "--force" in the discussion unless
you mean "all kinds of safety off".]

>  (2) any of them may not fast-forward and please override that "must
>      fast-forward" check from it, while still keeping the lockref
>      safety (without adding "--allow-no-ff", I do not see how it is
>      possible with your proposal, short of forcing user to add "+"
>      everywhere);

The point of my proposal is to force users to add + when they want to
allow non-fast-forward. Usually, this is shorter to type anyway than to
insert --force or --allow-no-ff in the command.

> 
>  (3) I know jch does not fast-forward so please override the "must
>      fast-forward", but still apply the lockref safety, pu may not
>      even satisfy lockref safety so please force it (as the "only
>      force this one" semantics is removed from "+", I do not see how
>      it is possible with your proposal).

I think

   git push --lockref=jch +jch +pu

would do.

> The semantics the posted patch (rerolled to allow "--force" push
> anything) implements lets "--lockref" to imply "--allow-no-ff" and
> that makes it much simpler; we do not have to deal with any of the
> above complexity.

But see my other post, where this hurts users who have a fast-forward
push refspec configured.

> [Footnote]
> 
>  *1* The assurance --lockref gives is a lot stronger than "must
>      fast-forward".
...
>      If your change were not a rebase but to build one of you own:
> 
>      o---o----o----o----o----X---Y
> 
>      your "git push --lockref=topic:X Y:X" still requires the tip is
>      at X.  If somebody rewound the tip to X~2 in the meantime
>      (because they decided the tip 2 commits were not good), your
>      "git push Y:X" without the "--lockref" will lose their rewind,
>      because Y will still be a fast-forward update of X~2.
>      "--lockref=topic:X" will protect you in this case as well.

Good point.

>      So I think "--lockref" that automatically disables "must
>      fast-forward" check is the right thing to do, as we are
>      replacing the weaker "must fast-forward" with something
>      stronger.

But I do not share this conclusion. My conclusion is that your proposal
replaces one kind of check with a very different kind of check.

>      I do not think we are getting anything from forcing
>      the user to say "--allow-no-ff" with "+ref" syntax when the
>      user says "--lockref".

Is this the same misunderstanding? My proposal does not require
--allow-no-ff with +ref syntax when --lockref is used.

-- Hannes
