From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/6] notes: replace pseudorefs with real refs
Date: Tue, 28 Jul 2015 22:00:11 -0700
Message-ID: <xmqq4mknblt0.fsf@gitster.dls.corp.google.com>
References: <1438107144-24293-1-git-send-email-dturner@twopensource.com>
	<1438107144-24293-3-git-send-email-dturner@twopensource.com>
	<xmqqpp3cds44.fsf@gitster.dls.corp.google.com>
	<xmqqegjsdq3n.fsf@gitster.dls.corp.google.com>
	<CALKQrgdLC_sLkM3jyH6pnDoY+RTHr9wJR_VH6iirBWmvyHYcVA@mail.gmail.com>
	<xmqqpp3bc2u6.fsf@gitster.dls.corp.google.com>
	<CALKQrgfxc83-yjrCWZqC+pyPhbQDgYbrpCDSaBk78YypO=BXOg@mail.gmail.com>
	<xmqqlhdzby5o.fsf@gitster.dls.corp.google.com>
	<55B824BD.8000003@alum.mit.edu>
	<xmqqh9onbu53.fsf@gitster.dls.corp.google.com>
	<CALKQrgff1AKBCsdFBTcthMb61gQwb4CjH=P7TPfpy1unMJ2_=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	David Turner <dturner@twopensource.com>,
	Git mailing list <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Philip Oakley <philipoakley@iee.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jul 29 07:00:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKJTa-00086s-L1
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 07:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbbG2FAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 01:00:15 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:35021 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047AbbG2FAO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 01:00:14 -0400
Received: by pdrg1 with SMTP id g1so82610679pdr.2
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 22:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=gkUpdHJ66K5UdVwDaSbMoK6XO1ipn9fIPxR04GAfQ4I=;
        b=mbMq2l1md/VRQRm+cMHNUBU9KeFs1oRLZR2Tr+PhO1MCfqE91kKb5pUIEZWIABetSx
         BpPJBPY4bVyMYjZpT86oRCB8BqZ6aSPkq6wIhWbyyVDDXLW8NaIGtZymyROOH+vgJTdf
         Ju0xdC3uL1X4y8Ghwx1izcgteUKcLQBE0mtdKr7/yKkL3opxD25JQhqnkDcTBDOFUj/L
         xO9r0tJC3mcnx/PtOuAZP3QAJ1/zLsGCk/u2+OspJnZBLvCaCv1kqvLmsLvUL5hE/sI3
         zwZQ94IpTlaSvsqa3WYUcNnuZGPhH3+3xTklQ/5ZpKfU7PBtG/S+UJ6HPoXuJV56D50g
         CiMQ==
X-Received: by 10.70.1.102 with SMTP id 6mr88751396pdl.32.1438146013512;
        Tue, 28 Jul 2015 22:00:13 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e592:68fd:3f1d:35f9])
        by smtp.gmail.com with ESMTPSA id k5sm29821598pdo.48.2015.07.28.22.00.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 Jul 2015 22:00:12 -0700 (PDT)
In-Reply-To: <CALKQrgff1AKBCsdFBTcthMb61gQwb4CjH=P7TPfpy1unMJ2_=g@mail.gmail.com>
	(Johan Herland's message of "Wed, 29 Jul 2015 04:53:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274881>

Johan Herland <johan@herland.net> writes:

> On Wed, Jul 29, 2015 at 4:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> So doing the absolute minimum, leaving the "now what can we do to
>> improve notes-merge process?" outside the scope of the topic.
>
> That's exactly what I was also trying to do: David's topic should not
> have to deal with NOTES_MERGE_* at all. Simply leave it all as
> something that belongs in $GIT_COMMON_DIR, and let's solve concurrent
> unrelated notes merges as a wholly independent, separate topic.

Here, it perhaps is showing that you are unfamiliar with the linked
worktree topic.

Things directly under .git/, like HEAD, MERGE_HEAD, etc., are per
worktree (i.e. not shared across working trees).  You have to work
to make them shared, i.e. per repo.  David's earlier one downcased
them while still keeing them directly under .git/ but I think it is
ugly and in general a wrong way to mark what is shared and what is
per worktree.  E.g. index is not shared, even though the name is all
lowercase.

You will be updating that mechanism when you truly make the
notes-merge a per refs/notes/* ref thing (not per repo, not per
worktree).  Perhaps you will use refs/notes-merge/$foo that is
shared across worktrees as the replacement for NOTES_MERGE_REF that
currently is used to merge into refs/notes/$foo, or something like
that, to pursue your "per ref" goal.  At that point, NOTES_MERGE_REF
based design needs to be scrapped anyway; it should not matter if
NOTES_MERGE_REF is per worktree (not shared) or per repo (shared) in
the meantime.

Doing absolute minimum means that $GIT_DIR/NOTES_MERGE_REF should be
left per worktree, like MERGE_HEAD, etc., without doing anything
like downcasing or moving it under refs/notes-merge/ (which I think
is a better way to make it shared, if we wanted to), which is
additional special casing that will be a wasted effort that would
not matter in the end result.
