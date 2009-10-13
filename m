From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when
 appropriate to do so
Date: Tue, 13 Oct 2009 02:24:11 -0700
Message-ID: <7vy6nfwssk.fsf@alter.siamese.dyndns.org>
References: <0016e68fd0123a175304754694b4@google.com>
 <200910130836.57011.trast@student.ethz.ch>
 <7vljjf226t.fsf@alter.siamese.dyndns.org>
 <200910131051.47117.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	<Euguess@gmail.com>, Mikael Magnusson <mikachu@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	<git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Oct 13 11:33:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxdkm-000297-2q
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 11:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933625AbZJMJZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 05:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933617AbZJMJZl
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 05:25:41 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50490 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933581AbZJMJZk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 05:25:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 668F96F35B;
	Tue, 13 Oct 2009 05:24:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RZKo9hTa5gb9W5IlvUEvjITdq0c=; b=qAl8gL
	D8B7itplwSlnHUkUVDGIb7arEc88sdMyOHz+Nkx3B8KW9+WRtxqW+/yrOyiYN3cE
	nxxnfcmrxbxsOBKI8WBollQoM2N3oe6+/6urqIhOw2DB1Wb6Wcoyj9eqXFkCImWq
	AaaePkRXDB55Z300v2wA1/Zm7yfrGmzKwfuCw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hrIPsq0o/yVuuMFDkp8XRP/iopWIwwyL
	CSjQAWWkVvYm+oE8RYJZrICka3DHjP9QPHxkU7F6o53zGmS9MWPDcUhwamNGCiTQ
	qJ+dvqsqwfk+y3QYOCUc9dt5lPqDLoQAO/A8pj1OMQHPinfjApeOeDuW8WJKM3vI
	HpurccL1EIc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EFB866F358;
	Tue, 13 Oct 2009 05:24:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1D8436F351; Tue, 13 Oct 2009
 05:24:12 -0400 (EDT)
In-Reply-To: <200910131051.47117.trast@student.ethz.ch> (Thomas Rast's
 message of "Tue\, 13 Oct 2009 10\:51\:45 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 320DA7E2-B7DA-11DE-8030-A730BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130149>

Thomas Rast <trast@student.ethz.ch> writes:

>> #0. These will stay as is:
>> 
>>  $ git checkout mine               ;# switches to the branch
>>  $ git checkout $any_committish^0  ;# detaches
>> 
>> #1. These used to detach, but will create a local branch
>> 
>>  $ git checkout origin/next        ;# as if with -t
>>  $ git checkout xyzzy/frotz        ;# as if with -t (origin is not special)
>
> Agreed, though I'm still in favour of a cleaner syntax for explicit
> detaching.  (Cleaner in the sense that ^0 is documented as having a
> completely different purpose and only works by accident.)

Oh, ^0 was just one way to make sure a committish is not a refname.  If
you have an abbreviated hexadecimal commit object name, that would also
detach, which should fall into category #0.  Sorry for the omission.

>> #2. These are allowed only when unambiguous and there is no local branch yet.
>> 
>>  $ git checkout next               ;# ok
>>  $ git checkout frotz              ;# ok (origin is not special)
>>  $ git checkout nitfol             ;# not ok (ambiguous and origin is not special)
>
> I'm weakly leaning towards refusing all three, as the user should be
> required to explicitly say a remote branch should be involved.
>
> (Weakly because there's also a certain DWIM advantage to 'git checkout
> sometopic'...)

I thought this was the primary point of what Dscho has been advocating.

>> #3. These used to detach, but what should we do?
>> 
>>  $ git checkout v1.0.0             ;# detach, or refuse???
>
> Refuse, on the grounds that the main goal here is not detaching unless
> specifically told to.  (Having a branch called v1.0.0 is worse, as it
> would just cause a lot of confusion and/or a refusal at the next
> checkout.)
>
>>  $ git checkout origin/master      ;# detach, or refuse???
>
> This seems to be the trickiest of them.  Maybe check out 'master', to
> make the process repeatable.  Imagine, in your setting,
>
>   git checkout origin/next           ;# creates 'next' as with -t
>   git checkout -                     ;# back
>   git checkout origin/next           ;# should go to 'next' again
>
> Then again, that would trade the confusion of detaching for the
> confusion of not checking out the exact commit that the user
> specified.  Worse, 'next' could conceivably be tracking (as per
> branch.next.merge) some entirely different branch, making the "Your
> branch is behind..." message misleading.

As I said already in the thread, I think that is a misguided attempt to
half-hide the fact that there are origin/next (tracking branch) and next
(a fork of it), that are two separate entities.  It is misguided because
the user needs to understand and take advantage of the distinction to do
anything; in other words, it is not even an unnecessary complexity.

So I am very doubtful about the benefit of checking out 'master' when
the user explicitly tells us to check out 'origin/master', only because
the former forked from the latter.

> Some that come to mind:
>
> #3a. Other refs apart from tags that currently detach:
>
>   git fetch origin master            ;# or even sillier, 'git fetch . master'
>   git checkout FETCH_HEAD            ;# used to detach; refuse?

> #3b. Full specifiers that currently detach:
>
>   git checkout refs/heads/master     ;# could eventually attach
>   git checkout heads/master          ;# same

I'd throw both of these into category #3.

Anything that is valid "ref" (i.e. what dwim_ref() groks) that is not
a remote tracking branch (which creates a corresponding local branch)
can refuse to avoid unintended detachment by newbies.

> #0a. Should probably detach if the previous checkout was detached:
>
>   git checkout -                     ;# detach if previous was detached?
>   git checkout @{-1}                 ;# same

Perhaps.

So to recap, "git checkout $token" would:

 * If dwim_ref() groks $token, and

   - if it resolves to refs/heads/*, that is checking out a local branch;

   - if it resolves to refs/remotes/*, and if there is no corresponding
     local branch, create one forked from there, as if -t was given;

   - everything else we used to detach, but we refuse in 1.7.0, to make it
     harder for newbies to detach.

 * If check_ref_format() is happy with $token, get_sha1() does not grok
   $token, and there is only one ref of the form refs/remotes/$o/$token
   then we pretend as if -t $o/$token was given and create a local branch
   $token forked from it.

 * Otherwise, we always detach.

Note that "checkout -" and "checkout @{-4}" are part of dwim_ref() family.
