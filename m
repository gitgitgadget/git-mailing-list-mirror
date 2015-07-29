From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/6] notes: replace pseudorefs with real refs
Date: Tue, 28 Jul 2015 19:25:54 -0700
Message-ID: <xmqq8u9zbsy5.fsf@gitster.dls.corp.google.com>
References: <1438107144-24293-1-git-send-email-dturner@twopensource.com>
	<1438107144-24293-3-git-send-email-dturner@twopensource.com>
	<xmqqpp3cds44.fsf@gitster.dls.corp.google.com>
	<xmqqegjsdq3n.fsf@gitster.dls.corp.google.com>
	<CALKQrgdLC_sLkM3jyH6pnDoY+RTHr9wJR_VH6iirBWmvyHYcVA@mail.gmail.com>
	<xmqqpp3bc2u6.fsf@gitster.dls.corp.google.com>
	<CALKQrgfxc83-yjrCWZqC+pyPhbQDgYbrpCDSaBk78YypO=BXOg@mail.gmail.com>
	<xmqqlhdzby5o.fsf@gitster.dls.corp.google.com>
	<55B824BD.8000003@alum.mit.edu>
	<CALKQrgeevWUE6tdPLWRKzRQLj5v5_9NyFqJCBraRArrZB-QNyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	David Turner <dturner@twopensource.com>,
	Git mailing list <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Philip Oakley <philipoakley@iee.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jul 29 04:26:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKH4D-00036K-EA
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 04:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294AbbG2CZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 22:25:57 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:36203 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527AbbG2CZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 22:25:56 -0400
Received: by pdjr16 with SMTP id r16so81913955pdj.3
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 19:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=M4z1Mg1om+22yhAQVvNJ3cOW10eCyoJ3UaIgG64bxco=;
        b=1IVoggVscPwwN1Rg6COHoDUpJJggfofUz0YYWLd8fys6Rp+WXjfPya836SElgK+1gj
         BdtEyF1dTtlirMF+JMK+BjOkH4GOAKuS41VcUYNJSV1m/aISIijxnFAKlRhzXfq1t9mS
         xUTd4vdeSw5ovsw0MMyEIgLUbXVyLHazSU6phMHR48fU3+I0760QeAsWsiJmmNVq3ueg
         TPlaF+HjFJeVLlZRjJ8e6nnw5FQhGXlxAJ5aLejlZ8w9LbYAGo8ZO04IdttXrQ9fQ/Xr
         BoSTXQZpG3vJfx89/bMi+LIdJVrx1v5eYmlVIDdq/3/6KralbZlSVmJd1EGwUx3v1wDD
         57Zg==
X-Received: by 10.70.109.199 with SMTP id hu7mr88774377pdb.71.1438136756123;
        Tue, 28 Jul 2015 19:25:56 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e592:68fd:3f1d:35f9])
        by smtp.gmail.com with ESMTPSA id cz1sm37505067pdb.44.2015.07.28.19.25.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 Jul 2015 19:25:54 -0700 (PDT)
In-Reply-To: <CALKQrgeevWUE6tdPLWRKzRQLj5v5_9NyFqJCBraRArrZB-QNyw@mail.gmail.com>
	(Johan Herland's message of "Wed, 29 Jul 2015 03:24:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274875>

Johan Herland <johan@herland.net> writes:

> Yes, almost. There are some complications with the concept of
> "checking out" a notes tree:
>
>  - The notes tree fanout must be flattened (so that when merging two
> note trees with different fanout, conflicting notes (e.g. deadbeef...
> and de/adbeef....) are turned into a file-level conflict in the notes
> merge worktree (i.e. contents with conflict markers in
> .git/NOTES_MERGE_WORKTREE/deadbeef...).

True.  I however think Michael was envisioning further into the
future, where the tree-level merges would take care of that detail
and populate the index to express conflicts using "canonicalised"
paths, removing these fan-out slashes, before externalising the
conflicted paths that need user's attention on the filesystem.

>  - Notes trees may be very large (e.g. one note per commit for the
> entire project history), so we want to avoid checking out as many
> notes as possible. Currently we only checkout the notes that actually
> do conflict, and keep the rest referenced from NOTES_MERGE_PARTIAL.

This is a valid point, but nobody forces us to do a full checkout to
perform a merge.  From day one, our merge machinery is prepared to
merge in an empty working tree, only checking out paths that need to
be modified by the merge.

>> * This would allow multiple notes merges to take place at the same time
>> provided they target different merge references.
>>
>> * This would prevent multiple notes merges to the same notes reference
>> at the same time by the same mechanism that prevents the same branch
>> from being checked out in two linked worktrees at the same time.
>>
>> It's just a thought; I have no idea whether it is practical...
>
> I'm not sure whether it's worth trying to reuse the same linked
> worktree mechanism for notes trees, when (a) the concept of "checking
> out" a notes tree is so different, as explained above, and (b)
> currently the only use case for a notes worktree is during a notes
> merge.

I have a very similar feeling except that I'd replace "linked
worktree mechanism" with "checkout mechanism".  If we were to
introduce such a new checkout mechanism that flattens a fan-out
paths, with "sparse checkout"-like behaviour, the current "checkout
mechanism" would not be reused, but the resulting system would
benefit from "linked worktree mechanism" just as much as the normal
multiple worktree layout benefits from it.  You'd want to make sure
only one such worktree has the checkout of one refs/notes/* ref,
everything in refs/* is shared across the repository and its
worktrees, and certain things like MERGE_HEAD and the index inside
$GIT_DIR/ are not shared, which are what the linked worktree
mechanism gives us.
