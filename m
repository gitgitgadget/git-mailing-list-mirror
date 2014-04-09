From: Lewis Diamond <git@lewisdiamond.com>
Subject: Re: The fetch command should "always" honor remote.<name>.fetch
Date: Wed, 9 Apr 2014 11:57:19 -0400
Message-ID: <CAHwd=GnRHM9Nk7SzCL46cLTrxgGYH+F9O7KBOxnJmAQQRvKhSA@mail.gmail.com>
References: <5340871D.8070503@lewisdiamond.com>
	<xmqqioqlm21y.fsf@gitster.dls.corp.google.com>
	<CAHwd=G=zV97H7eEK5dJ0XrfbF0bpZD6-YOvk0O8nVuqMGSz=jw@mail.gmail.com>
	<7v61mjnumu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 09 17:57:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXusc-0003uX-Fy
	for gcvg-git-2@plane.gmane.org; Wed, 09 Apr 2014 17:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934101AbaDIP5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2014 11:57:30 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:51346 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934068AbaDIP5V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2014 11:57:21 -0400
Received: by mail-qa0-f53.google.com with SMTP id w8so2578651qac.40
        for <git@vger.kernel.org>; Wed, 09 Apr 2014 08:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=SiE3iHbdK0fMlnTiR1/tzzzzYPDi0TRKj1hInWg+HjQ=;
        b=ZyN+UJwHRolTSn7fGLO0iz1tGCJPq0YTlHwlKLS57gkump1KVFsuRZBxb+Di+ZTRsP
         S4dEDFLjRJvoysWcABqEbjKpRSzsHux8M/bDBhWZk+08/8/l5gAermJtA2zchmrhUO1m
         qYIC5NEGDOlzxD4jaOw4Y1cC2rdZT1eAlcPmGlK5yOT8oio9FVPK/e7wAEJITmx2nt4W
         d6/S5JX56Ig5BK4ALR+VxG7192q37SwAlM2uFp0LgX6dEL/nLXpkXEi9YX31NOkpzKyv
         aHCyG2+IPnTv8P1QW3JZqoF4ii5toVFCI82aX1zuSb4+CYNJe1X5VPzYvSK9vB7ZdCfx
         A5nQ==
X-Gm-Message-State: ALoCoQkLUiH2qjG/VZuZc3WGHOIN4z+QaEXCsxF6grNdGeCGAjdMNTXMgrg8rv2HI2xyDHtGaXxE
X-Received: by 10.140.85.116 with SMTP id m107mr12736506qgd.78.1397059040558;
        Wed, 09 Apr 2014 08:57:20 -0700 (PDT)
Received: from mail-qg0-f46.google.com (mail-qg0-f46.google.com [209.85.192.46])
        by mx.google.com with ESMTPSA id j7sm2368943qab.27.2014.04.09.08.57.19
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 09 Apr 2014 08:57:19 -0700 (PDT)
Received: by mail-qg0-f46.google.com with SMTP id 63so2358533qgz.5
        for <git@vger.kernel.org>; Wed, 09 Apr 2014 08:57:19 -0700 (PDT)
X-Received: by 10.140.44.2 with SMTP id f2mr12866278qga.73.1397059039831; Wed,
 09 Apr 2014 08:57:19 -0700 (PDT)
Received: by 10.140.38.166 with HTTP; Wed, 9 Apr 2014 08:57:19 -0700 (PDT)
X-Originating-IP: [216.251.112.134]
In-Reply-To: <7v61mjnumu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245976>

Hi Junio,

What I mean by "behave like push" is the following:

[remote "foo"]
    url = ...
    fetch = refs/users/bob/heads/*:refs/heads/*  #Note that the fetch
and push configuration match.
    push = refs/heads/*:refs/users/bob/heads/*

git ls-remote foo
refs/heads/master

git push foo master
refs/heads/master -> refs/users/bob/heads/master

git fetch foo master
refs/heads/master -> FETCH_HEAD

In this case, the fetch commit isn't the same as the one we just
pushed! Yes, I agree that the abbreviation expansion works as designed
(using the rev_parse_rules), but the point of that email is that those
rules become counter-intuitive when you configure a fetch refspec. You
specifically tell git that you don't care about refs/heads/* and all
you care about is refs/users/bob/heads/*, why would it go and fetch
refs/heads/master? Of course, you should still be able to fetch it
when you explicitly asks for it but the configured refspec should take
precedence over the default rev_parse_rules.

Maybe more people could give their opinion as to whether this would be
more intuitive or not. I (and other people I've asked) find the
current behaviour counter-intuitive. Our opinion seem to differ
because you consider the 'master' abbreviation as being explicit. In
my opinion, explicit means 'refs/heads/master' and an abbreviation is
absolutely not explicit.

If a patch wouldn't be welcome I'll fix it with aliases or a plugin.

-Lewis

On Tue, Apr 8, 2014 at 9:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Lewis Diamond <me@lewisdiamond.com> writes:
>
>>>> 'git fetch foo master' would result in (FETCH_HEAD omitted):
>>>> [new ref] refs/heads/master -> foo/master //OK, but missing another
>>>> ref! (case 2)
>>>> //It should also fetch refs/users/bob/heads/master -> foo/bob/master
>>>
>>> This is an incorrect expectation.
>>
>> Indeed this is the "correct" behaviour since it works as designed.
>> However, this behaviour is inconsistent with the push command. An
>> expectation is never "incorrect" as we are talking about intuitive vs
>> non-intuitive.
>>
>>>
>>> The user who gave the command line said only "master", and did not
>>> want to grab "users/bob/heads/master".  If the user wanted to get it
>>> as well, the command line would have said so, e.g.
>>>
>>>         git fetch there master users/bob/heads/master
>>>
>>
>> Actually, the user specifically configured the remote to fetch
>> refs/users/bob/heads/*, meaning "those are the branches I'm interested
>> in".
>>
>>>> If you remove this configuration line: fetch =
>>>> +refs/heads/*:refs/remotes/foo/*
>>>> Then you run 'git fetch foo master', this would result in:
>>>>  * branch master -> FETCH_HEAD //Debatable whether this is OK or not,
>>>> but it's definitely missing bob's master! (case 3)
>>>
>>> Likewise.
>>>
>>> The 'master' short-hand is designed not to match refs/users/any/thing.
>>
>> Sure, this shorthand is designed to match refs listed in the rev parse
>> rules list. However, a quick survey showed me that most people would
>> expect their configuration to be honoured when using the shorthand for
>> fetching (like it is for push). This thread is about improving the
>> fetch command so that the short-hand works in such cases (and make it
>> consistent with what push does).
>
> Now, I am puzzled, as I do not think push behaves in such an insane
> way.  You got me worried enough that I had to make sure (see below).
>
> Perhaps there is some misunderstanding.
>
> With two repositories src and dst, I prepared these in src:
>
>     $ git ls-remote ../src
>     cae2fe07f0954772ec9d871391313cb91a030cba    HEAD
>     cae2fe07f0954772ec9d871391313cb91a030cba    refs/heads/master
>     cae2fe07f0954772ec9d871391313cb91a030cba    refs/users/bob/master
>
> and then this config in dst/.git/config:
>
>     [remote "origin"]
>             url = ../src
>             fetch = +refs/heads/*:refs/remotes/origin/*
>             fetch = +refs/users/bob/*:refs/remotes/bob/*
>             push = refs/heads/*:refs/users/alice/*
>
> Now, from such an empty dst repository:
>
>     $ cd dst
>     $ git fetch -v origin
>     From ../src
>      * [new branch]      master     -> origin/master
>      * [new ref]         refs/users/bob/master -> bob/master
>     $ git reset --hard origin/master
>     $ git ls-remote .
>     cae2fe07f0954772ec9d871391313cb91a030cba    HEAD
>     cae2fe07f0954772ec9d871391313cb91a030cba    refs/heads/master
>     cae2fe07f0954772ec9d871391313cb91a030cba    refs/remotes/bob/master
>     cae2fe07f0954772ec9d871391313cb91a030cba    refs/remotes/origin/master
>
>     $ git commit --allow-empty -m another
>     $ git push -v origin master
>     Pushing to ../src
>     Counting objects: 1, done.
>     Writing objects: 100% (1/1), 185 bytes | 0 bytes/s, done.
>     Total 1 (delta 0), reused 0 (delta 0)
>     To ../src
>        cae2fe0..faae8fb  master -> refs/users/alice/master
>
> Redoing the same experiment with this config with an extra item in
> dst/.git/config:
>
>     [remote "origin"]
>             url = ../src
>             fetch = +refs/heads/*:refs/remotes/origin/*
>             fetch = +refs/users/bob/*:refs/remotes/bob/*
>             push = refs/heads/*:refs/users/alice/*
>             push = refs/remotes/bob/*:refs/users/bob/*
>
> gives the same.
>
>     ... the same procedure to prepare 'master' that is one commit
>     ... ahead with "allow-empty"
>     $ git update-ref refs/remotes/bob/master HEAD
>     $ git push -v origin master
>     Pushing to ../src
>     Counting objects: 1, done.
>     Writing objects: 100% (1/1), 185 bytes | 0 bytes/s, done.
>     Total 1 (delta 0), reused 0 (delta 0)
>     To ../src
>        cae2fe0..faae8fb  master -> refs/users/alice/master
>
> We do not look at remotes/bob/master we have, and we do not touch
> users/bob/master at the remote site, either.
>
> When you explicitly say what you want to push on the command line,
> that is what you are telling Git to push.  'master' which is an
> abbreviation of refs/heads/master.  Where it goes may be determined
> by using remote.origin.push as a mapping, but the left hand side of
> the mapping is still what you gave from the commad line (after
> dwimming the abbreviated refname exactly the same way other commands
> like "git log master" interpret them).
>
> This is very much deliberately so and unlikely to change.  And that
> goes the same for fetching as well.
>
> The command line interface is optimized for the two most common use
> cases.  Either you want to fetch everything you are interested in
> (in which case you do not say what you want to fetch on the command
> line and let the configured refspecs kick in), or you want to
> explicitly want to state what you want.  Allowing random set of refs
> that happens to match left hand side of wildcard patterns of refspec
> will break the expectation big time, when somebody asks "git push
> origin master" meaning "I want to push my 'master' branch out" (or
> "git pull origin master" meaning "I want to merge the master branch
> from the origin") and you instead push out "remotes/bob/master" (or
> even worse, create an octopus merge with origin's master and bob's
> master).
>
> Hope this clarifies the confusion.
