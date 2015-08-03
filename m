From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] notes: handle multiple worktrees
Date: Mon, 3 Aug 2015 20:27:45 +0700
Message-ID: <CACsJy8B-HV8NS_FCuoy3pvLRr4B7S4CGO4StNxXaB=WLt8=94w@mail.gmail.com>
References: <xmqqegjsdq3n.fsf@gitster.dls.corp.google.com> <1438118624-26107-1-git-send-email-dturner@twopensource.com>
 <xmqqtwsoaq45.fsf@gitster.dls.corp.google.com> <CALKQrgcX2aPc4cac2p-w8FE9K7X+A5tFWtNcS-N6EOC9gTvfZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git mailing list <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Aug 03 15:28:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMFmu-0003zZ-IX
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 15:28:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799AbbHCN2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 09:28:16 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:33275 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761AbbHCN2P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 09:28:15 -0400
Received: by igbpg9 with SMTP id pg9so71728569igb.0
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 06:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fMQMP8MgbwuSvnj1dSVs5AIqiR4trSgTtwwRIhbzEMM=;
        b=g6JWt7gVBt6DQoZcs+hBt5LkZJjd4qz9enGK+4UUn+mfxJ7Nzz1AXMvhv9IlvbSIoi
         wYDUj1RXmO2KEPUESGYc3LOX3TM44AH678XiP4P7MDVw9tK++VSk2xJIUbsB4qgkucSE
         cVO/6TIDlPvxVe1KaW6zmM7UPGiaWkstJCvbOwmSzHi/4+vpLZ7KTgnSu3mxzsk+Ei+m
         l/Zz0i06XVhfl4DxRKckXjWd0+AQy+Kof79PGPmqz0/XpU78gISR+XmSst8Pa0f4n2xk
         4Wp+1QH4juoe3YMn+hy6yPHXzgxxm3Rzk4WZARZ7i1/twDUtxMlAO4Ab4mwAR60lqMaD
         XYSQ==
X-Received: by 10.50.59.211 with SMTP id b19mr21071421igr.42.1438608494991;
 Mon, 03 Aug 2015 06:28:14 -0700 (PDT)
Received: by 10.107.191.193 with HTTP; Mon, 3 Aug 2015 06:27:45 -0700 (PDT)
In-Reply-To: <CALKQrgcX2aPc4cac2p-w8FE9K7X+A5tFWtNcS-N6EOC9gTvfZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275165>

On Wed, Jul 29, 2015 at 5:50 AM, Johan Herland <johan@herland.net> wrote:
> On Wed, Jul 29, 2015 at 12:12 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> David Turner <dturner@twopensource.com> writes:
>>> Prevent merges to the same notes branch from different worktrees.
>>> Before creating NOTES_MERGE_REF, check NOTES_MERGE_REF using the same
>>> code we use to check that two HEADs in different worktrees don't point
>>> to the same branch.  Modify that code, die_if_checked_out, to take a
>>> "head" ref to examine; previously, it just looked at HEAD.
>>>
>>> Reported-by: Junio C Hamano <gitster@pobox.com>
>>> Signed-off-by: David Turner <dturner@twopensource.com>
>>> ---
>>
>> Thanks for following through.  As I didn't report anything, I do not
>> deserve that label, but it's OK ;-)
>>
>> I know that it is a requirement to protect NOTES_MERGE_REF from
>> being used by multiple places for "notes merge" to play well with
>> the multi-worktree world order, but because I do not know if that is
>> sufficient, I'm asking a few people for further review.
>
> As just stated in a related thread, I don't think it makes sense to
> have NOTES_MERGE_REF per worktree, as the notes merge is always
> completely unrelated to the current worktree (or the current branch
> for that matter). AFAICS this patch is all about handling per-worktree
> NOTES_MERGE_REFs, and as such I'm NAK on this patch. Instead, there
> should only be one NOTES_MERGE_REF per _repo_, and although we might
> want to expand to allow multiple concurrent notes merges in the
> future, that is still a per-repo, and not a per-worktree thing, hence
> completely unrelated to David's current effort.

I agree. Luckily sharing NOTES_MERGE_REF is as short as

diff --git a/path.c b/path.c
index 10f4cbf..52d8ee4 100644
--- a/path.c
+++ b/path.c
@@ -94,7 +94,7 @@ static void replace_dir(struct strbuf *buf, int len,
const char *newdir)
 static const char *common_list[] = {
  "/branches", "/hooks", "/info", "!/logs", "/lost-found",
  "/objects", "/refs", "/remotes", "/worktrees", "/rr-cache", "/svn",
- "config", "!gc.pid", "packed-refs", "shallow",
+ "config", "!gc.pid", "packed-refs", "shallow", "NOTES_MERGE_REF",
  NULL
 };
 --
Duy
