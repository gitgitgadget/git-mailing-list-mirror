From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] notes: handle multiple worktrees
Date: Wed, 29 Jul 2015 00:50:56 +0200
Message-ID: <CALKQrgcX2aPc4cac2p-w8FE9K7X+A5tFWtNcS-N6EOC9gTvfZw@mail.gmail.com>
References: <xmqqegjsdq3n.fsf@gitster.dls.corp.google.com>
	<1438118624-26107-1-git-send-email-dturner@twopensource.com>
	<xmqqtwsoaq45.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git mailing list <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 00:51:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKDiJ-0001bF-90
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 00:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbbG1WvG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 18:51:06 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:63488 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbbG1WvE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 18:51:04 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1ZKDiA-000N05-79
	for git@vger.kernel.org; Wed, 29 Jul 2015 00:51:02 +0200
Received: by ykdu72 with SMTP id u72so108795786ykd.2
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 15:50:56 -0700 (PDT)
X-Received: by 10.13.206.133 with SMTP id q127mr40209907ywd.10.1438123856297;
 Tue, 28 Jul 2015 15:50:56 -0700 (PDT)
Received: by 10.37.208.71 with HTTP; Tue, 28 Jul 2015 15:50:56 -0700 (PDT)
In-Reply-To: <xmqqtwsoaq45.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274864>

On Wed, Jul 29, 2015 at 12:12 AM, Junio C Hamano <gitster@pobox.com> wrote:
> David Turner <dturner@twopensource.com> writes:
>> Prevent merges to the same notes branch from different worktrees.
>> Before creating NOTES_MERGE_REF, check NOTES_MERGE_REF using the same
>> code we use to check that two HEADs in different worktrees don't point
>> to the same branch.  Modify that code, die_if_checked_out, to take a
>> "head" ref to examine; previously, it just looked at HEAD.
>>
>> Reported-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: David Turner <dturner@twopensource.com>
>> ---
>
> Thanks for following through.  As I didn't report anything, I do not
> deserve that label, but it's OK ;-)
>
> I know that it is a requirement to protect NOTES_MERGE_REF from
> being used by multiple places for "notes merge" to play well with
> the multi-worktree world order, but because I do not know if that is
> sufficient, I'm asking a few people for further review.

As just stated in a related thread, I don't think it makes sense to
have NOTES_MERGE_REF per worktree, as the notes merge is always
completely unrelated to the current worktree (or the current branch
for that matter). AFAICS this patch is all about handling per-worktree
NOTES_MERGE_REFs, and as such I'm NAK on this patch. Instead, there
should only be one NOTES_MERGE_REF per _repo_, and although we might
want to expand to allow multiple concurrent notes merges in the
future, that is still a per-repo, and not a per-worktree thing, hence
completely unrelated to David's current effort.

...Johan
