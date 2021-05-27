Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25958C4707F
	for <git@archiver.kernel.org>; Thu, 27 May 2021 12:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03F86613ED
	for <git@archiver.kernel.org>; Thu, 27 May 2021 12:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbhE0MGy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 08:06:54 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:49768 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234798AbhE0MGr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 08:06:47 -0400
Received: from host-92-14-216-189.as13285.net ([92.14.216.189] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1lmElE-000Aj1-6W; Thu, 27 May 2021 13:05:12 +0100
Subject: Re: fast forward merge overwriting my code
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Andre Ulrich <andre.ulrich@smail.fh-koeln.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
References: <20210522154815.Horde.rqiNSyIc3CGJECACotWLO1T@webmail.th-koeln.de>
 <4c1c3dbc-7a89-02db-3883-b7eea644cd83@kdbg.org>
 <YKrsC9CaG/KDvDBi@camp.crustytoothpaste.net>
 <20210524061355.Horde.I7EpK9A1l-KtI_TwFo97eNd@webmail.th-koeln.de>
 <60adb824bac10_2c7f620844@natae.notmuch>
 <da77d0a0-7fdb-e4c8-6510-87ea0294dac4@iee.email>
 <60ae947797deb_25ba2089c@natae.notmuch>
 <6dcc8557-9df4-9ea2-c348-f4ebf76ff446@iee.email>
 <60aedb22c075e_4bd420896@natae.notmuch>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <02bbe080-cd8a-cc7d-5dbc-9231b51c4baf@iee.email>
Date:   Thu, 27 May 2021 13:05:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <60aedb22c075e_4bd420896@natae.notmuch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/05/2021 00:34, Felipe Contreras wrote:
> Philip Oakley wrote:
>> On 26/05/2021 19:33, Felipe Contreras wrote:
>>> Philip Oakley wrote:
>>>> On 26/05/2021 03:53, Felipe Contreras wrote:
>>>>> Andre Ulrich wrote:
>>>>>> So the last point is where we still want to do some fine tuning. Right  
>>>>>> now this looks about: my prof fetches my edits and locally checks out  
>>>>>> a branch to compare the changes with git diff.
>>>>>> But in this diff view you can't edit the files. So you have to  
>>>>>> separately open up another window to edit the changes (lets say my  
>>>>>> prof only wants to keep some of my changes, but not all).
>>>>> So for example after fetching your changes your professor sees this:
>>>> Part of Andre's problem was that this diff wasn't stable because the
>>>> underlying file format is said to be json so items can move around
>>>> without issue (e.g. key value pairs swapping position) and that they
>>>> aren't really working on the json file (it may as well be binary..) but
>>>> on the jupytper notebook display view, so one step removed from the 'diff'.
>>> Andre said they use the diff view, and he wants to be able to edit it.
>>> Not sure how else would you interpret "But in this diff view you can't
>>> edit the files".
>>>
>> In
>> https://lore.kernel.org/git/20210524061355.Horde.I7EpK9A1l-KtI_TwFo97eNd@webmail.th-koeln.de/
>> Abdre did say they used the special jupyter notebook diff viewer.
> Yes, but that is a separate issue.
>
> Right now they are able to resolve conflicts with a jupyter mergetool.

I don't believe that ("resolve") is true in the sense they would like. I
don't think they are really 'merging' in an all-in-one `git merge`
sense, rather they are [trying to] splitting and patching and commenting
the changes.

Aside: In my previous employment it just wasn't possible to diff a
tool's save output (MathCAD, a graphic maths whiteboard) because the
structure of their XML file was not conventionally 'linear' -
rearranging object position on the canvas did not move them in the file,
you had to 'guess' (try and visualise) the objects movement and effect
on computational order. It just wasn't worth the effort as the supplier
didn't have useful diff tool. I Feel that Jupyter is better than that,
but still awkward.

> The tool gets rid of all the extra noise so the user is able to focus
> only on the actual important changes. When they exit the tool, their
> changes are properly staged.
>
> The problem Andre described in [1] appears when mergetool does *not*
> run. 

Here they are (in my mind) highlighting the GitLab server side merge
process, which only (IIUC) showing the git diff, and not the jupyter
diff, meaning they have to fetch and then work in the jupyter tool, not Git.

> In that case the user is forced to run `git diff` (jupyter difftool
> will be used), edit the file manually with some viewer, `git add
> --update`, and then run `git diff --cached` to verify the changes.

I'd misremembered the --update option, and it possibly doesn't do what
the user expects if they expect just the staged files (rather than all
the tracked index files) updated to take on-board their tweaks (i.e. mid
review)
>
> In case an unwanted change sneaks by, the user would have to edit the
> file again, or do `git checkout --patch` to selectively remove chunks
> (and since this tools presents the diffs in reverse, it's
> counterintuitive and error-prone).
I'd agree that the whole process for such tools (because they break
linear code conventions) is, as you say, "counter-intuitive and error-prone"
>
> This is far from ideal.
>
>
> The problem is that there is no `git stage edit`, in order to launch the
> mergetool.

I see it the other way around (I think). I see it as Git getting out of
the way for a period and supporting that other tool's review process,
rather than assuming that the git-way is the-right-way.

> I just wrote an example `git stage-edit` [2] that does launch the
> mergetool even if there are no merge conflicts, allowing the user to
> modify the stage directly and with no hassle.
>
> Cheers.
>
> [1] https://lore.kernel.org/git/20210522154815.Horde.rqiNSyIc3CGJECACotWLO1T@webmail.th-koeln.de/
> [2] https://dpaste.com/62XS8TTXP
>
Hopefully, Andre can put a little information about just how the mid
'merge/review' process actually happens, and the pain points, to avoid
the discussion talking in thin air...

There may be terminology confusion because of the way that *server based
cooperation* goes via _Pull/Merge Requests_, when really they are
*Review Requests*, and no one (in that situation) actually expects them
to be accepted as-is anyway, rather they are 'returned with comments for
rework' or 'reworked before merge'.

Philip
