From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git tag: pre-receive hook issue
Date: Sat, 18 Jul 2015 14:19:14 -0700
Message-ID: <xmqqtwt1yxil.fsf@gitster.dls.corp.google.com>
References: <1437159533304-7635764.post@n2.nabble.com>
	<CA+P7+xoXgSHPVhMTm_GZbq+6Pps5yttK2rBZpMycTUFGfqOCvw@mail.gmail.com>
	<CAGDgvc2F7UMWTVrRFt5eK2xmbfz-kyWh6Vp-eQNEj7tixzRPYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Gaurav Chhabra <varuag.chhabra@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 18 23:19:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGZVz-00018L-J5
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 23:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277AbbGRVTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 17:19:19 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33100 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbbGRVTS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2015 17:19:18 -0400
Received: by padck2 with SMTP id ck2so79438739pad.0
        for <git@vger.kernel.org>; Sat, 18 Jul 2015 14:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=c9k/6Lf5Lf+KkqgmTLYkxbL+2FRr03A8cYRJUdeQM94=;
        b=tMyPltgwZt5nnZjmJOViywgjFh7+7xDchhzAvDM6cMXJpoh2oGfBA4rynSuHPeXYQJ
         GUUIrYpyztmsXJBzFREkJpKr0+i46Y9h0MkB4ZTUF1ybWTNb+fSrkDPooN7Z6b4UrRFs
         93NkbPTMBvfMxO5RHXxGu8u0/DC/H/SBUi9pSj5aWTHgypy1fLLn9RrZZriRQzcIWSC0
         9F509w8xbzbgZfOzIeJ6bRaPggEsh76EEqAvP3umAOxqhw08q33zRjUolzEkTLVr+FQP
         J1gBt7KBOyEBSqgZFDT4CU56cg5oiR3S8YITQEacqPwVI1ix1iyKnjX5XQJ4Lvcnh3Ki
         COXw==
X-Received: by 10.69.27.39 with SMTP id jd7mr42831474pbd.49.1437254357985;
        Sat, 18 Jul 2015 14:19:17 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c060:7851:3fd2:bcfb])
        by smtp.gmail.com with ESMTPSA id w3sm15220366pdl.45.2015.07.18.14.19.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 18 Jul 2015 14:19:15 -0700 (PDT)
In-Reply-To: <CAGDgvc2F7UMWTVrRFt5eK2xmbfz-kyWh6Vp-eQNEj7tixzRPYQ@mail.gmail.com>
	(Gaurav Chhabra's message of "Sun, 19 Jul 2015 01:38:28 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274178>

Gaurav Chhabra <varuag.chhabra@gmail.com> writes:

> @Junio: From the example you gave, i could conclude the following:
>
> 1) : gitster garbage/master; git commit --allow-empty -m third
>   [master d1f1360] third
>   : gitster garbage/master; git describe --exact-match HEAD ;# third
>   fatal: no tag exactly matches 'd1f1360b46dfde8c6f341e48ce45d761ed37e357'
>
>> Since after # third commit, no tag was applied to HEAD, so
>> --exact-match resulted in fatal error
>
> 2)  : gitster garbage/master; git commit --allow-empty -m second
> [master d1de78e] second
> : gitster garbage/master; git tag -a -m 'v0.1' v0.1
> : gitster garbage/master; git describe --exact-match HEAD^ ;# second
>     v0.1
>> Since annotated tag was applied after # second commit, so
>> --exact-match did referenced the commit as expected.
>
> 3) : gitster garbage/master; git commit --allow-empty -m initial
>   [master (root-commit) b18cac2] initial
>   : gitster garbage/master; git tag v0.0 ;# lightweight
>   : gitster garbage/master; git describe --exact-match HEAD^^ ;# first
>   fatal: no tag exactly matches 'b18cac237055d9518f9f92bb4c0a4dac825dce17'
>
>> In this case, it's a lightweight tag and i read today that by
>> default, git describe only shows annotated tags (without --all or
>> --tags). I think it's because of the missing option (--all or
>> --tags) that it resulted in fatal error in this case.
>
> Please correct me if i misunderstood any/all of the above cases.

All correct.  The part that I find questionable is that by checking
with "is this commit a tagged one?" and doing different things.
What makes the initial and the third special to deserve checking
(because they are not annotated with a tag) while skipping the
validation for the second (merely because it has an annotated tag
added to it)?

> My queries:
> A) When you mentioned: "I am feeding three _commits_, not tags.", i
> didn't really get what you're trying to highlight.

I was skipping one round-trip, expecting for you to say "the part
that sets 'commit=$new' for a newly created branch was a mistake,
and it should do 'commit=$(git rev-list $new)'".  And even when $new
is a tag, what comes out of `git rev-list $new` is a sequence of
commit object names, never the tag object.

> You've also mentioned that "And you check everything on that list.  Why?"
>> Was this comment for the portion where the code is validating
>> commits (git rev-list $old_sha1..$new_sha1) for existing branch? If
>> yes, then i didn't really get your concern. Can you kindly elaborate
>> a bit?

I do not question the validity of checking everything between $old..$new;
my question was more about "even though you correctly check everything,
why do you check _only_ the tip by doing 'commit=$new' (instead of
doing 'commit=`git rev-list $new`') when somebody pushes to a new branch?".

>>> git describe --exact-match ac28ca721e67adc04078786164939989a5112d98 2>&1 |
>>> grep -o fatal | wc -w
>>>
>>> So i'm wondering why it's not entering the IF block (as confirmed in the
>>> output link)

When you push a branch 'master' and a tag 'v1.0', these things
happen in order:

 (1) all objects that are necessary to ensure that the receiving
     repository has everything reachable from 'master' and 'v1.0'
     are sent to it and stored.  If the receiving end fails to store
     this correctly, everything below is skipped and the operation
     fails.

 (2) pre-receive is run.  Notice that at this point, no refs have
     been updated yet, so "describe" will not know v1.0 tag (if it
     is a new one) exists.  But this step can assume that all new
     objects are already accessible using their object name, so

	case "$old" in
        0000000000000000000000000000000000000000) range=$new ;;
        *) bottom=$old..$new ;;
	esac &&
     	git rev-list $range |
        while read commit
        do
        	check $commit object, e.g.
                git cat-file commit $commit | grep FooBarId
	done

     is expected to work.

 (3) for each ref being updated (in this case, refs/heads/master and
     refs/tags/v1.0), the following happens:

     (3-1) built-in sanity checks may reject the push to the ref,
           e.g. refusing to update a checked out branch, refusing to
           accept a non-fast-forward push that is not forced, etc.

     (3-2) update-hook is run, which may reject the push to this
           ref.

     (3-3) the ref is updated (unless the push is atomic).

 (4) if the push is atomic, the refs are updated.

 (5) post-receive hook is run.  This is for logging and cannot
     affect the outcome of the push.

 (6) for each ref that was updated (in this case, refs/heads/master
     and refs/tags/v1.0), post-update hook is run.  This is for
     logging and cannot affect the outcome of the push.


As your requirement seems to be to validate any and all new commits,
I think it is totally unnecessary to check if any of them happens to
have a tag pointing at it in the first place.
