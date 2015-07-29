From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v3 2/6] notes: replace pseudorefs with real refs
Date: Wed, 29 Jul 2015 03:24:59 +0200
Message-ID: <CALKQrgeevWUE6tdPLWRKzRQLj5v5_9NyFqJCBraRArrZB-QNyw@mail.gmail.com>
References: <1438107144-24293-1-git-send-email-dturner@twopensource.com>
	<1438107144-24293-3-git-send-email-dturner@twopensource.com>
	<xmqqpp3cds44.fsf@gitster.dls.corp.google.com>
	<xmqqegjsdq3n.fsf@gitster.dls.corp.google.com>
	<CALKQrgdLC_sLkM3jyH6pnDoY+RTHr9wJR_VH6iirBWmvyHYcVA@mail.gmail.com>
	<xmqqpp3bc2u6.fsf@gitster.dls.corp.google.com>
	<CALKQrgfxc83-yjrCWZqC+pyPhbQDgYbrpCDSaBk78YypO=BXOg@mail.gmail.com>
	<xmqqlhdzby5o.fsf@gitster.dls.corp.google.com>
	<55B824BD.8000003@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Git mailing list <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Philip Oakley <philipoakley@iee.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jul 29 03:25:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKG7R-00022a-AE
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 03:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752618AbbG2BZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 21:25:09 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:65085 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbbG2BZH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 21:25:07 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1ZKG7F-0001Pp-51
	for git@vger.kernel.org; Wed, 29 Jul 2015 03:25:05 +0200
Received: by ykay190 with SMTP id y190so110985769yka.3
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 18:24:59 -0700 (PDT)
X-Received: by 10.129.133.199 with SMTP id v190mr40959857ywf.38.1438133099122;
 Tue, 28 Jul 2015 18:24:59 -0700 (PDT)
Received: by 10.37.208.71 with HTTP; Tue, 28 Jul 2015 18:24:59 -0700 (PDT)
In-Reply-To: <55B824BD.8000003@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274872>

On Wed, Jul 29, 2015 at 2:56 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Johan Herland <johan@herland.net> writes:
>> Here is where we start to differ. I would say that starting a notes
>> merge is completely unrelated to your worktree. Consider this:
>
> It sounds like what a notes merge really wants is a new linked worktree
> that has branch refs/notes/foo checked out:

Yes, almost. There are some complications with the concept of
"checking out" a notes tree:

 - The notes tree fanout must be flattened (so that when merging two
note trees with different fanout, conflicting notes (e.g. deadbeef...
and de/adbeef....) are turned into a file-level conflict in the notes
merge worktree (i.e. contents with conflict markers in
.git/NOTES_MERGE_WORKTREE/deadbeef...).

 - Notes trees may be very large (e.g. one note per commit for the
entire project history), so we want to avoid checking out as many
notes as possible. Currently we only checkout the notes that actually
do conflict, and keep the rest referenced from NOTES_MERGE_PARTIAL.

> * This would allow multiple notes merges to take place at the same time
> provided they target different merge references.
>
> * This would prevent multiple notes merges to the same notes reference
> at the same time by the same mechanism that prevents the same branch
> from being checked out in two linked worktrees at the same time.
>
> It's just a thought; I have no idea whether it is practical...

I'm not sure whether it's worth trying to reuse the same linked
worktree mechanism for notes trees, when (a) the concept of "checking
out" a notes tree is so different, as explained above, and (b)
currently the only use case for a notes worktree is during a notes
merge.


...Johan

> Michael
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
>

-- 
Johan Herland, <johan@herland.net>
www.herland.net
