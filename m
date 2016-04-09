From: Elijah Newren <newren@gmail.com>
Subject: Re: [RFC/PATCH 00/18] Add --index-only option to git merge
Date: Fri, 8 Apr 2016 19:35:07 -0700
Message-ID: <CABPp-BGpBDsn_ZZh8iot7qbgpWn0cUcdWTypRqKOKFMm9Y-E4w@mail.gmail.com>
References: <1460098726-5958-1-git-send-email-newren@gmail.com>
	<xmqqlh4ovuqv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 04:35:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoik2-000291-P1
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 04:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754724AbcDICfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 22:35:09 -0400
Received: from mail-ig0-f193.google.com ([209.85.213.193]:36688 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754279AbcDICfI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 22:35:08 -0400
Received: by mail-ig0-f193.google.com with SMTP id kb1so4571488igb.3
        for <git@vger.kernel.org>; Fri, 08 Apr 2016 19:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=/SC8uRMYvOmmSlYjgWKs1vAJ5Gvc9JOC5PmrSuTeatQ=;
        b=q73wVy368cwOERtfEKmMqOtg2vNRJP/hfbqVCGK8/Pes/EOsI1riWIrZJg9R/4B56V
         oXNAyf0Z0bod0VC/D/sIHrSaEVbXieWXCU9Lw3XD3ajp2r3v4zLTR3iiXG8MZg9XBNEH
         UDnFjPjc/ANW3aM0jkuFRqmiQAynlC4eduQ0T4kIqCUgseUj8ZXYN5iKqI8uWw+8IXY3
         Q45X16hUObz2RiKqTPrxTLpP72Eo2iEPwgBZsItLwaHXlPy1oCm0YT14ccTK7Bw/OvEl
         m/2HPx3tpcDl3a6j2d8cyFqT0jnN00op2eEWkCe/JG/TZqKnMn4Zd5ODqnNvgmzcpVyJ
         Ly2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=/SC8uRMYvOmmSlYjgWKs1vAJ5Gvc9JOC5PmrSuTeatQ=;
        b=amJ0AGtjS3L2ZkhkTdWp0pmN7M7Na3EIFn/GBFNcAkv8VjcDdC7SiIdV3WWncvgg58
         EVJ+KAnkAx0d+lD7RvwZ6g9Xu7ewAv7NC/BlVp+6PGmk1zMtkYoXR9VJ4im6ozelJ3B1
         GvSbYWQ3/L1jUVF87pmg6LlwaPwhllpMOAhzPJlP6Re5KBcIFJJC3hqiCIJ3oGVP2aIL
         3RNQGAgOWnbDkTMkQjAAtsXLrEZ4K9De1/wPVkoMhXv72xTosTWn2bHq/O0ElfOBNPL9
         AkKmX7Hs78Yv/NG2E7Hw9LpaT36kznHkGBH7vTYKsZa1PO9+FbRqpE7xj/6ZATDL52nq
         hwKg==
X-Gm-Message-State: AD7BkJJF41YmTWVSYB0ziSB+EwqMUI6taTe8QAt2LCvJYIdiOLaQeK2/9DQt7deda6M0YgBgh2LFtG8TBzPnwg==
X-Received: by 10.50.50.74 with SMTP id a10mr7300404igo.87.1460169307270; Fri,
 08 Apr 2016 19:35:07 -0700 (PDT)
Received: by 10.64.0.173 with HTTP; Fri, 8 Apr 2016 19:35:07 -0700 (PDT)
In-Reply-To: <xmqqlh4ovuqv.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291077>

Hi,

On Fri, Apr 8, 2016 at 11:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
> The goal is stated rather vaguely--when you have a working tree and
> perform this "in index" merge, you would obviously update the index
> with the merge result and ...

Yes, I think you hit the nail on the head with your suggestions
elsewhere to (1) limit this to bare repository only, and/or (2) do the
"git merge --into master en/topic"

I'll fix this.

>> The core fix, to merge-recursive, was actually quite easy.  The
>> recursive merge logic already had the ability to ignore the working
>> directory and operate entirely on the index -- it needed to do this
>> when creating a virtual merge base, i.e. when o->call_depth > 0.
>
> You need to be careful here, though.  The creation of a virtual
> parent accepts (actually it wants to have) conflicted blobs as if
> that is a valid merge result--"git merge but only in index" probably
> does not want that behaviour.

Yes, precisely.  :-)

A close look at the merge-recursive code showed that the code to
handle the index-only behavior was already nicely separated from the
other things triggered by o->call_depth (e.g. the conflicted blobs
case you mention above, among others), making it really easy to modify
it so we could get the index-only behavior without the other stuff.

> I'd prefer these as a separate series if they are truly unrelated
> cleanups, so that we can quickly review and have them graduated
> without waiting for the remainder.  You can still submit the main
> series with a comment that says it applies on that separate clean-up
> series and the right things should happen ;-)

Will do.

> When you say "index only", I'd say people would understand that to
> be saying "as opposed to using and updating both the index and the
> working tree", so I do not think there is no confusion.
>
> An established convention to spell "index only" found in "apply" and
> "grep" is to say "--cached", though (cf. "git help cli").

I'm assuming your double negative was unintentional, i.e. that you do
not think there is any confusion.  Let me know if I misread.

The pointer is helpful, but I struggle a bit with the name '--cached'.
The past tense in that word suggests to me that it should be a
read-only operation on the cache (which works for grep), rather than a
write operation (such as for merge or apply).  It could also be
misconstrued in merge's case to think that the index is one of the
things being merged (rather than erroring out if the index doesn't
match HEAD).  I know apply already uses --cached, but if others don't
mind, I personally would rather not use it here.  Is this something
you feel strongly about, or are you okay with --index-only?

> If you have to assume, assume that there are people who use these
> programs in their scripts and workflows, because it is a relatively
> new development to make "git merge" directly calling into the
> recursive machinery bypassing these commands.

So, my question wasn't so much about whether the git-merge-* programs
are used, as to whether they should support all the same options that
e.g. "git merge -s recursive" does.  I'm not sure if having the old
merge-* programs support fewer options is considered good ("we want to
toss them eventually", or "they are less tested these days so we want
to take less risk with modifying them") or bad ("we don't want there
to be any difference in ability or behavior").

It should be easy to add the --index-only option to each of these, I'm
just unsure whether it matters or if it's wanted.

> I have a suspicion that this would become moot, as the conclusion
> may become that "git merge" that works only in index does not make
> sense unless you are in a bare repository---in which case, these
> external merge drivers has to be given a temporary working tree
> anyway, and they can keep writing their result out to what they
> consider is the working tree (i.e. via GIT_WORK_TREE or something).
> You read the result of them from that temporary working tree into
> the index before cleaning the temporary working tree.  That way,
> you do not have to touch them at all, no?  In fact, the temporary
> working tree trick may be applicable even when you are working in a
> repository with a tree working tree.

I'm a little confused; you seem to be suggesting git-merge-one-file
will always need to have a working tree of some sort, though I don't
see why.

git-merge-one-file doesn't currently read from the working tree,
except to check for untracked files in the way; it instead gets file
contents from git unpack-file, which pulls it from the object store.
git-merge-one-file currently records the merge resolution, if clean,
in both the index and the working copy, so my modifications are about
making it able to write to only the index. That's the only
modification I think it needs to avoid requiring a working tree at
all.

(git-merge-one-file does create some temporary files in the current
working directory via git unpack-file, but it doesn't need a full
working tree for that.  I should also make it a little cleaner by
having it not check for the presence of untracked-and-in-the-way files
in the --index-only case.)
