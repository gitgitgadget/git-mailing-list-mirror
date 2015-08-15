From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v7 1/4] notes: document cat_sort_uniq rewriteMode
Date: Sat, 15 Aug 2015 12:06:14 +0200
Message-ID: <CALKQrgd=qVBPMKu_bZxVHgqsdYGtJcOvnrQaB2aH9z67ymv=Uw@mail.gmail.com>
References: <1439586835-15712-1-git-send-email-jacob.e.keller@intel.com>
	<1439586835-15712-2-git-send-email-jacob.e.keller@intel.com>
	<xmqq4mk1h66i.fsf@gitster.dls.corp.google.com>
	<CA+P7+xoSB0um3FkhRAXGF1t0ZoYk0zaxAvAOvFcwn+CWQ-gyfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 12:06:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQYMI-0004Ws-F1
	for gcvg-git-2@plane.gmane.org; Sat, 15 Aug 2015 12:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844AbbHOKGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2015 06:06:23 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:52621 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbbHOKGW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2015 06:06:22 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1ZQYM0-000NVY-3T
	for git@vger.kernel.org; Sat, 15 Aug 2015 12:06:20 +0200
Received: by ykll84 with SMTP id l84so25168851ykl.0
        for <git@vger.kernel.org>; Sat, 15 Aug 2015 03:06:14 -0700 (PDT)
X-Received: by 10.129.138.129 with SMTP id a123mr49370028ywg.139.1439633174100;
 Sat, 15 Aug 2015 03:06:14 -0700 (PDT)
Received: by 10.37.201.134 with HTTP; Sat, 15 Aug 2015 03:06:14 -0700 (PDT)
In-Reply-To: <CA+P7+xoSB0um3FkhRAXGF1t0ZoYk0zaxAvAOvFcwn+CWQ-gyfg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275990>

On Sat, Aug 15, 2015 at 12:53 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Fri, Aug 14, 2015 at 3:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jacob Keller <jacob.e.keller@intel.com> writes:
>>
>>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>>> index 75ec02e8e90a..de67ad1fdedf 100644
>>> --- a/Documentation/config.txt
>>> +++ b/Documentation/config.txt
>>> @@ -1947,8 +1947,8 @@ notes.rewriteMode::
>>>       When copying notes during a rewrite (see the
>>>       "notes.rewrite.<command>" option), determines what to do if
>>>       the target commit already has a note.  Must be one of
>>> -     `overwrite`, `concatenate`, or `ignore`.  Defaults to
>>> -     `concatenate`.
>>> +     `overwrite`, `concatenate`, `cat_sort_uniq`, or `ignore`.
>>> +     Defaults to `concatenate`.
>>>  +
>>>  This setting can be overridden with the `GIT_NOTES_REWRITE_MODE`
>>>  environment variable.
>>> diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
>>> index 851518d531b5..674682b34b83 100644
>>> --- a/Documentation/git-notes.txt
>>> +++ b/Documentation/git-notes.txt
>>> @@ -331,7 +331,8 @@ environment variable.
>>>  notes.rewriteMode::
>>>       When copying notes during a rewrite, what to do if the target
>>>       commit already has a note.  Must be one of `overwrite`,
>>> -     `concatenate`, and `ignore`.  Defaults to `concatenate`.
>>> +     `concatenate`, `cat_sort_uniq`, or `ignore`.  Defaults to
>>> +     `concatenate`.
>>>  +
>>>  This setting can be overridden with the `GIT_NOTES_REWRITE_MODE`
>>>  environment variable.
>>
>> This obviously is not a problem introduced by this patch, but I
>> wonder why we have two similar but different set of modes for
>> rewrtie and merge.

We do. Rewrite builds directly on top of the combine_notes_* functions
that are part of the core/low-level notes code, added in 73f464b5
(2010-02-13, Refactor notes concatenation into a flexible interface for
combining notes). Notes merge (and its various strategies) were added
later, and also build on top of these combine_notes_* functions (see
merge_one_change() in notes-merge.c). In addition, notes-merge adds the
'manual' strategy, which depends on surrounding machinery that
notes-merge provides, but that the low-level combine_notes_* functions
cannot depend on.


>>  Isn't 'overwrite' like 'ours', 'ignore' like
>> 'theirs', and 'concat' like 'union', and if these are similar
>> enough, perhaps it would be helpful to the end user if we unified
>> the terms (or accepted both as synonyms for backward compatibility)?

The mapping (which is contained in merge_one_change() in notes-merge.c)
is:

  'manual'        -> [custom handling in notes-merge]
  'ours'          -> combine_notes_ignore [or simply a no-op]
  'theirs'        -> combine_notes_overwrite
  'union'         -> combine_notes_concatenate
  'cat_sort_uniq' -> combine_notes_cat_sort_uniq

>>
>> Also I notice that you cannot manually reconcile while rewriting;
>> don't we want to have 'manual' there, too, I wonder?

No, as stated above, 'manual' requires some external mechanism for
creating a "worktree" where the notes conflicts can be checked out
and manipulated by the user. The guts of notes.c is not the correct
place to do that. I don't know if it's easy to rewrite "rewrite" to
do a (partial) notes merge instead of using the combine_notes_*
functions directly, but I imagine that would be the best way forward.

>>
>> [jc: Cc'ed Thomas who invented rewrite back when merge was not even
>> there, and Johan who added merge]
>>
>
> I was not sure. I believe that re-write doesn't do the same thing as
> merge? I think we could make all of them handle the "overwrite", which
> is basically a synonym of, I think "theirs" depending on the direction
> of the "merge".

Correct.

> I don't know if re-write actually supports manual mode at all!

It doesn't.

> Maybe we could make merge support the other names as synonyms, and
> then code re-write in terms of merging?

Adding the synonyms is fine, but I wouldn't publicize it heavily, as
the meaning of words like "overwrite" and "ignore" can become quite
confusing in the context of a merge.

Reimplementing re-write in terms of merge is probably a good idea,
though.

> I wasn't sure so I chose only to document the mode that was missing.

IMHO, that's good for now.


...Johan


-- 
Johan Herland, <johan@herland.net>
www.herland.net
