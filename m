From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] submodule: Fetch the direct sha1 first
Date: Fri, 19 Feb 2016 15:40:07 -0800
Message-ID: <CAGZ79kaL8T72Fcy1kzuRrYagX9biRTscA4q=xBc7JaUXv5msVg@mail.gmail.com>
References: <1455908253-1136-1-git-send-email-sbeller@google.com>
	<xmqqpovsbdyu.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaOQTGEY6akKgz695nPdG4cG4SsYKLcJkKr1im+RQjK5A@mail.gmail.com>
	<xmqqbn7cbahb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Dave Borowitz <dborowitz@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 00:40:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWuen-0008If-TD
	for gcvg-git-2@plane.gmane.org; Sat, 20 Feb 2016 00:40:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1428777AbcBSXkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 18:40:10 -0500
Received: from mail-ig0-f176.google.com ([209.85.213.176]:37862 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1427474AbcBSXkI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 18:40:08 -0500
Received: by mail-ig0-f176.google.com with SMTP id 5so47368506igt.0
        for <git@vger.kernel.org>; Fri, 19 Feb 2016 15:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3iTXIrufDJd2tWZ8lvQAxEU0RbLy/Mb4LxpqDryREnA=;
        b=FAa4hSmHgE0J+vxH7TAG5+lzGQw+j7It1Dt6BcbJKbsAw+iwHLApB0A1LXzhH7/3k5
         ZQWhID1tIIX5NGIwlRM4ftme1fDHc0L4f0J12kvYptGA4g2HK3EQ1+uq4XZrJp94xjvG
         4kNaA5SBjNel4e9364xocCCWT+GS0A3i+PArALQsryEIGaenaeyRh3iFLAUfK18hcMFU
         G91/yD7N5oVYUyDCWa+0JqxI3lcmOuCgVdpwEZk0jX2E9h0BxKLlQTT8JJ4aSV1Ws5cE
         1tN6sRdiIEZJ3HQP9ZMUn03sECtW/oe/9w+L/H1jX+nz8Noiztyv5GIrZp+bRVrzJC6W
         NnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=3iTXIrufDJd2tWZ8lvQAxEU0RbLy/Mb4LxpqDryREnA=;
        b=MS89vB5ViRLSvv5uobIfDVUSvwIAQ8hXTBG32ibE+P/9M2zSwvscQxy8hpIM5JL2Kc
         bhvGWJNH+040skeXg6zMjAW7zxUSMwxXTfkYWCf3F0I3E2V2nqKSHeqzRD3Qlp5OYzwd
         /zG3BTmIRx/HSlq5XCVoyb/C5khDS6oeNr291FEn20+9zqbDKWt799ht/RiPuAAOTNhk
         QjZCadfzGsVXWTGGL2aBUbB1YzO2stsAr57CUNEl2oZJwvKwvslhjEuPUmlXWUFc9iSz
         XNWXGStdTtoOOdD2l24eVQIjLVCgDhLImykOyETJj17cusY+dIdPTkAywgimHCSZ36r1
         rbDQ==
X-Gm-Message-State: AG10YOQ1LebOXfn0yeGBqoq2dIMFKNWc4zJm7CG6Edai+QfTGSIeDrJnkoiJ1pycg47mQuHe35a/RrlKuKq/0ZGK
X-Received: by 10.50.112.10 with SMTP id im10mr469650igb.93.1455925207898;
 Fri, 19 Feb 2016 15:40:07 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Fri, 19 Feb 2016 15:40:07 -0800 (PST)
In-Reply-To: <xmqqbn7cbahb.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286760>

On Fri, Feb 19, 2016 at 2:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Doing a 'git fetch' only and not the fetch for the specific sha1 would be
>> incorrect?
>
> I thought that was what you are attempting to address.

Yep. In an ideal world I would imagine it would look like

    if $sha1 doesn't exist:
        fetch $sha1
        if server did not support fetching direct sha1:
            fallback to fetch <no args>

and I thought this would be small enough to be expressed
using the || and &&.

It would be slightly more complicated for first doing the fetch
and then refetching if the sha1 is still missing as the condition
is more complicated to express.

>
>> ('git fetch' with no args finishes successfully, so no fallback is
>> triggered. But we are not sure if we obtained the sha1, so we need to
>> check if we have the sha1 by doing a local check and then try to get the sha1
>> again if we don't have it locally.
>
> Yes, that is what I meant in the "In the opposite fallback order"
> suggestion.
>>>>                               (clear_local_git_env; cd "$sm_path" &&
>>>> +                                     remote_name=$(get_default_remote)
>>>>                                       ( (rev=$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
>>>> -                                      test -z "$rev") || git-fetch)) ||
>>>> +                                      test -z "$rev") || git-fetch $remote_name $rev
>>>
>>> Regardless of the "fallback order" issue, I do not think $rev is a
>>> correct thing to fetch here.  The superproject binds $sha1 to its
>>> tree, and you would be checking that out, so shouldn't you be
>>> fetching that commit?
>>
>> Both $sha1 and $rev are in the submodule (because
>> 'git submodule--helper list' puts out the sha1 as the
>> submodule sha1). $rev is either empty or equal to $sha1
>> in my understanding of "rev-list $sha1 --not --all".
>
> Not quite.  The rev-list command expects [*1*] one of three outcomes
> in the original construct:
>
>  * The repository does not know anything about $sha1; the command
>    fails, rev is left empty, but thanks to &&, git-fetch runs.

ok. "git cat-file -e" would be able to replace this case.

>
>  * The repository has $sha1 but the history behind it is not
>    complete.  While digging from $sha1 following the parent chain,
>    it would hit a missing object and fails, rev may or may not be
>    empty, but thanks to &&, git-fetch runs.

which I read as a broken shallow clone or a half-way gc'ed repository.
(git fetch repairs that? ok.)

An intact shallow clone which has enough history to contain sha1 should
not be deepened in my understanding of "submodule update".

Rereading the man page for  "git cat-file -e", the output of
"cat-file -e" is the same as in the first case, and we want to also fetch.

>
>  * The repository has $sha1 and its history is all connected.  The
>    command succeeds.  If $sha1 is not connected to any of the refs,
>    however, that commit may be shown and stored in $rev.  In this
>    case, "$rev" happens to be the same as "$sha1".

So it would be possible to checkout $sha1 as a detached HEAD,
but it's not strongly protected against gc. (I assume gc will not
touch objects reachable from HEAD, but not referenced by any ref,
but HEAD can change in a heart beat, so it is not as strong of a protection
as having a branch include that $sha1).

>
> As this "fetch" is run in order to make sure that the history behind
> $sha1 is complete in the submodule repository, so that detaching the
> HEAD at that commit will give the user a useful repository and its
> working tree, the check the code is doing in the original is already
> flawed.  If $sha1 and its ancestry is complete in the repository,
> rev-list would succeed, and if $sha1 is ahead of any of the refs,
> the original code still runs "git fetch", which is not necessary for
> the purpose of detaching the head at $sha1.  On the other hand, by
> using "-n 1", it can cause rev-list stop before discovering a gap in
> history behind $sha1, allowing "git fetch" to be skipped when it
> should be run to fill the gap in the history.
>
> To be complete, the rev-list command line should also run with
> "--objects"; after all, a commit walker fetch may have downloaded
> commit chain completely but haven't fetched necessary trees and
> blobs when it was killed, and "rev-list $sha1 --not --all" would not
> catch such a breakage without "--objects".

So 'cat-file -e' doesn't sound like it would back-test the history at all,
so it doesn't sound like a sufficient replacement.

>
>> Oh! Looking at that I suspect the
>> "test -z $(git rev-list -n 1 $sha1 --not --all 2>/dev/null)"
>> and "git cat-file -e" are serving the same purpose here and should just
>> indicate if the given sha1 is present or not.
>
> That is the simplest explanation why the original "rev-list"
> invocation is already wrong.  It should do an equivalent of
> builtin/fetch.c::quickfetch() to ensure that $sha1 is something that
> is complete, i.e. could be anchored with a ref if we wanted to,
> before deciding to avoid running "git fetch".

Would it make sense in case of broken histories to not fetch
(specially if the user asked to not fetch) and rather repair by
making it a shallow repository?

>
