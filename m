From: Junio C Hamano <gitster@pobox.com>
Subject: Re: The fetch command should "always" honor remote.<name>.fetch
Date: Tue, 08 Apr 2014 18:45:13 -0700
Message-ID: <7v61mjnumu.fsf@alter.siamese.dyndns.org>
References: <5340871D.8070503@lewisdiamond.com>
	<xmqqioqlm21y.fsf@gitster.dls.corp.google.com>
	<CAHwd=G=zV97H7eEK5dJ0XrfbF0bpZD6-YOvk0O8nVuqMGSz=jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lewis Diamond <git@lewisdiamond.com>, git@vger.kernel.org
To: Lewis Diamond <me@lewisdiamond.com>
X-From: git-owner@vger.kernel.org Wed Apr 09 03:43:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXhYQ-0006Fb-MP
	for gcvg-git-2@plane.gmane.org; Wed, 09 Apr 2014 03:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757388AbaDIBnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 21:43:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57592 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756639AbaDIBnp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 21:43:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BCFB7BC12;
	Tue,  8 Apr 2014 21:43:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+V3fXlxwkqTBybnbXZVH4xQhjRA=; b=nY45tn
	bzb3ePbC5oTtVXmKilQBqJN3EgHofb4QDGJy0aDKMDneHbTnsnPnL5/n2oCiSAyG
	VvQXzo8vkdZqZHglQtj63o1Mg1tIovXb0ocmxS700dcQrOruZ+IV8g/eetOlB+uL
	VB5kkFaCKL3lw7Zd/Sy1pH19uIAa4VOUh1Omc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sl701hCmf8otrie2WuFANdyDw2zVepsM
	TW16WVramYkkrrs/HQbZR1dGeRdKdCxqwwp88DH7R6ML5s3/dzQnz+ORJwvf5lV7
	jk3ATOUnCsibfw34x4DSt4DszT5JzWaqLPHxqk//+teiKYr8q2j14NyX21C0zZL1
	v53SW3QGM2s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 278A67BC11;
	Tue,  8 Apr 2014 21:43:44 -0400 (EDT)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB6507BC0D;
	Tue,  8 Apr 2014 21:43:42 -0400 (EDT)
In-Reply-To: <CAHwd=G=zV97H7eEK5dJ0XrfbF0bpZD6-YOvk0O8nVuqMGSz=jw@mail.gmail.com>
	(Lewis Diamond's message of "Mon, 7 Apr 2014 14:46:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: 61CBA4F6-BF88-11E3-9DEE-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245971>

Lewis Diamond <me@lewisdiamond.com> writes:

>>> 'git fetch foo master' would result in (FETCH_HEAD omitted):
>>> [new ref] refs/heads/master -> foo/master //OK, but missing another
>>> ref! (case 2)
>>> //It should also fetch refs/users/bob/heads/master -> foo/bob/master
>>
>> This is an incorrect expectation.
>
> Indeed this is the "correct" behaviour since it works as designed.
> However, this behaviour is inconsistent with the push command. An
> expectation is never "incorrect" as we are talking about intuitive vs
> non-intuitive.
>
>>
>> The user who gave the command line said only "master", and did not
>> want to grab "users/bob/heads/master".  If the user wanted to get it
>> as well, the command line would have said so, e.g.
>>
>>         git fetch there master users/bob/heads/master
>>
>
> Actually, the user specifically configured the remote to fetch
> refs/users/bob/heads/*, meaning "those are the branches I'm interested
> in".
>
>>> If you remove this configuration line: fetch =
>>> +refs/heads/*:refs/remotes/foo/*
>>> Then you run 'git fetch foo master', this would result in:
>>>  * branch master -> FETCH_HEAD //Debatable whether this is OK or not,
>>> but it's definitely missing bob's master! (case 3)
>>
>> Likewise.
>>
>> The 'master' short-hand is designed not to match refs/users/any/thing.
>
> Sure, this shorthand is designed to match refs listed in the rev parse
> rules list. However, a quick survey showed me that most people would
> expect their configuration to be honoured when using the shorthand for
> fetching (like it is for push). This thread is about improving the
> fetch command so that the short-hand works in such cases (and make it
> consistent with what push does).

Now, I am puzzled, as I do not think push behaves in such an insane
way.  You got me worried enough that I had to make sure (see below).

Perhaps there is some misunderstanding.

With two repositories src and dst, I prepared these in src:

    $ git ls-remote ../src
    cae2fe07f0954772ec9d871391313cb91a030cba	HEAD
    cae2fe07f0954772ec9d871391313cb91a030cba	refs/heads/master
    cae2fe07f0954772ec9d871391313cb91a030cba	refs/users/bob/master

and then this config in dst/.git/config:

    [remote "origin"]
            url = ../src
            fetch = +refs/heads/*:refs/remotes/origin/*
            fetch = +refs/users/bob/*:refs/remotes/bob/*
            push = refs/heads/*:refs/users/alice/*

Now, from such an empty dst repository:

    $ cd dst
    $ git fetch -v origin
    From ../src
     * [new branch]      master     -> origin/master
     * [new ref]         refs/users/bob/master -> bob/master
    $ git reset --hard origin/master
    $ git ls-remote .
    cae2fe07f0954772ec9d871391313cb91a030cba	HEAD
    cae2fe07f0954772ec9d871391313cb91a030cba	refs/heads/master
    cae2fe07f0954772ec9d871391313cb91a030cba	refs/remotes/bob/master
    cae2fe07f0954772ec9d871391313cb91a030cba	refs/remotes/origin/master

    $ git commit --allow-empty -m another
    $ git push -v origin master
    Pushing to ../src
    Counting objects: 1, done.
    Writing objects: 100% (1/1), 185 bytes | 0 bytes/s, done.
    Total 1 (delta 0), reused 0 (delta 0)
    To ../src
       cae2fe0..faae8fb  master -> refs/users/alice/master

Redoing the same experiment with this config with an extra item in
dst/.git/config:

    [remote "origin"]
            url = ../src
            fetch = +refs/heads/*:refs/remotes/origin/*
            fetch = +refs/users/bob/*:refs/remotes/bob/*
            push = refs/heads/*:refs/users/alice/*
	    push = refs/remotes/bob/*:refs/users/bob/*

gives the same.

    ... the same procedure to prepare 'master' that is one commit
    ... ahead with "allow-empty"
    $ git update-ref refs/remotes/bob/master HEAD
    $ git push -v origin master
    Pushing to ../src
    Counting objects: 1, done.
    Writing objects: 100% (1/1), 185 bytes | 0 bytes/s, done.
    Total 1 (delta 0), reused 0 (delta 0)
    To ../src
       cae2fe0..faae8fb  master -> refs/users/alice/master

We do not look at remotes/bob/master we have, and we do not touch
users/bob/master at the remote site, either.

When you explicitly say what you want to push on the command line,
that is what you are telling Git to push.  'master' which is an
abbreviation of refs/heads/master.  Where it goes may be determined
by using remote.origin.push as a mapping, but the left hand side of
the mapping is still what you gave from the commad line (after
dwimming the abbreviated refname exactly the same way other commands
like "git log master" interpret them).

This is very much deliberately so and unlikely to change.  And that
goes the same for fetching as well.

The command line interface is optimized for the two most common use
cases.  Either you want to fetch everything you are interested in
(in which case you do not say what you want to fetch on the command
line and let the configured refspecs kick in), or you want to
explicitly want to state what you want.  Allowing random set of refs
that happens to match left hand side of wildcard patterns of refspec
will break the expectation big time, when somebody asks "git push
origin master" meaning "I want to push my 'master' branch out" (or
"git pull origin master" meaning "I want to merge the master branch
from the origin") and you instead push out "remotes/bob/master" (or
even worse, create an octopus merge with origin's master and bob's
master).

Hope this clarifies the confusion.
