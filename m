From: Doug Kelly <dougk.ff7@gmail.com>
Subject: Re: [PATCH 1/2] prepare_packed_git(): refactor garbage reporting in
 pack directory
Date: Wed, 13 Jan 2016 11:14:39 -0600
Message-ID: <CAEtYS8Qs2B3rP1PDGhoWGAgcj2c_pOTpt=s8qj9tWMjkLLFyhQ@mail.gmail.com>
References: <1439488973-11522-1-git-send-email-dougk.ff7@gmail.com>
	<CAPig+cS0ntr1sYzVAPjNCwd8ei4oGQRNs+W=qMBV4Z6NaRWCWA@mail.gmail.com>
	<xmqq37zhg8la.fsf@gitster.dls.corp.google.com>
	<xmqqbnbilw9u.fsf@gitster.mtv.corp.google.com>
	<CAEtYS8TR4mnaGpGDpB3cz_nu2hdCYTWf=PVCJbmzYi6YA53_bg@mail.gmail.com>
	<CAEtYS8Q1T-ig2KqZUoCCODs1YbjOmF__vbiH5rL-s6hNaUhZeA@mail.gmail.com>
	<xmqqr3k5a76v.fsf@gitster.mtv.corp.google.com>
	<CAEtYS8Rp0Eb7uHB8kJ=muVWy6u+beB7kAAWZqPgTYqfuKx3P2A@mail.gmail.com>
	<20151104200249.GC16101@sigill.intra.peff.net>
	<CAEtYS8S_ys3jT5ziWd7_u6Dn8b3LwnZYO7Pz6EegsmWpUM5riw@mail.gmail.com>
	<20151230073759.GA785@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 13 18:14:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJP0P-0001DI-7U
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 18:14:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755231AbcAMROl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 12:14:41 -0500
Received: from mail-qg0-f67.google.com ([209.85.192.67]:36233 "EHLO
	mail-qg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755083AbcAMROk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 12:14:40 -0500
Received: by mail-qg0-f67.google.com with SMTP id 6so48374570qgy.3
        for <git@vger.kernel.org>; Wed, 13 Jan 2016 09:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MxMt1OgxgsmzhbkG2ySyNAF9XvqDNL92zEhrDrhwVbI=;
        b=LZ6/EAcgNEy/W4fk1DiL/pNXAoGjqHTU1aF0BPzvcHoWMVuumPbtYJxukswFhE3ARK
         WGMa20zb37yoz3sAYMHOCAacsNJxt8mQMx4PeUYBmgHkjMWK9lYEJYKoCUokq4vCwfbj
         IyQN0PFid74ukDmg/odAzX9pDDL2CepuIq8DUL/VbNpovfj3ukm+2G0/RXlKVxdFS+1w
         A61MvPf1t5RC9N8Th+lANKH9cMtt60c8BIkBgyxZUhcgqAfVKh2Vmrz7T0KWq7PtPs6E
         ZiLKx5DH4przn7vYOAHYxS6PO6BUMXchm2zPS6kEspbA0RoShyAb/4Bzrwl/e+e39L8r
         4BvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=MxMt1OgxgsmzhbkG2ySyNAF9XvqDNL92zEhrDrhwVbI=;
        b=SFuTQgg8XAxa2XN9/hqik9/N8k+CRZCbXZhv7pBx4fPdJJr4+Q9IoSUF7gR1Og2pyJ
         W8yHV444FqXGvZA7MojadYe+tzriX07zTv4UBtumznz5ZqqDb6iFvYRNQ0PXzOveZJ4W
         93bRZUVf3P9GQqtcoL3vfi20ihSHeCgWDBOm0wu4tTRuknyWHHUgFEW7cC4my0QQsNj5
         2ybdFFBmUaEOovrbWqb4g/v3kykTOfwXSwffb9g2yCcNNSE3qxYPX1RtZMZXU+mhQ+w7
         O/1ixZdQDdo9qJT1jwUASu1wQDQwrf9X1aUl4gFIBRh2+9w7CqiAQKRL/pnCGMXXqN1O
         q0OA==
X-Gm-Message-State: ALoCoQnODoCjXInZTBgQ9UWfw/XKqwOyByFU1ez0Uio4vbaqL9vJWE349p6hkiLp9nf+GKF5YKFO5Bp4/PTWG7A6+93A6B4NKw==
X-Received: by 10.141.6.131 with SMTP id i125mr59744362qhd.68.1452705279108;
 Wed, 13 Jan 2016 09:14:39 -0800 (PST)
Received: by 10.55.15.148 with HTTP; Wed, 13 Jan 2016 09:14:39 -0800 (PST)
In-Reply-To: <20151230073759.GA785@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283944>

On Wed, Dec 30, 2015 at 1:37 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Nov 04, 2015 at 02:08:21PM -0600, Doug Kelly wrote:
>
>> On Wed, Nov 4, 2015 at 2:02 PM, Jeff King <peff@peff.net> wrote:
>> > Definitely cleaning up the .bitmap is sane and not racy (it's in the
>> > same boat as the .idx, I think).
>> >
>> > .keep files are more tricky. I'd have to go over the receive-pack code
>> > to confirm, but I think they _are_ racy. That is, receive-pack will
>> > create them as a lockfile before moving the pack into place. That's OK,
>> > though, if we use mtimes to give ourselves a grace period (I haven't
>> > looked at your series yet).
>> >
>> > But moreover, .keep files can be created manually by the user. If the
>> > pack they referenced goes away, they are not really serving any purpose.
>> > But it's possible that the user would want to salvage the content of the
>> > file, or know that it was there.
>> >
>> > So I'd argue we should leave them. Or at least leave ones that do not
>> > have the generic "{receive,fetch}-pack $pid on $host comment in them,
>> > which were clearly created as lockfiles.
>>
>> Currently there's no mtime-guarding logic (I dug up that conversation
>> earlier, though, but after I'd done the respin on this series)... OK,
>> in that case, I'll create a separate patch that tests/cleans up
>> .bitmap, but doesn't touch .keep.  This might be a small series since
>> I think the logic for finding pack garbage doesn't know anything about
>> .bitmap per-se, so it's looking like I'll extend that relevant code,
>> before adding the handling in gc and appropriate tests.
>
> I happened to be looking over your series again, and I noticed that we
> didn't end up with any mtime logic at all in what got merged.
>
> I _think_ that is probably OK, because we always write the pack,
> followed by the .idx, followed by the .bitmap (if any). And we don't
> drop .keep files (though I think we would perhaps note them as possible
> cruft?).
>
> So I don't think there are any races introduced here, but I wonder if we
> want to be a bit more conservative. Sorry to bring this up so much after
> the fact; I completely forgot about it when reviewing the patches.
>
> These changes are slated for the v2.7 release. Like I said, I don't
> think it's buggy, so we don't necessarily need to address it before the
> release. We could add an mtime check in the next cycle as a
> belt-and-suspenders safety, rather than a fix.
>
> -Peff

Yeah, I know I never got to adding the mtime logic, but for a simple (naive,
hard-coded) case, I did come up with a basic patch today.  I think this could
be extended to a configuration option(?) which would allow a default longer
than 10 seconds (an hour? a day?), then during the regression tests, we
could provide a shorter timeout to ensure the guarding both works and also
not wait forever for tests to complete.  Thoughts?

---
 builtin/gc.c     | 14 ++++++++++++--
 t/t5304-prune.sh |  2 ++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 79e9886..a4ce616 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -51,8 +51,18 @@ static struct string_list pack_garbage =
STRING_LIST_INIT_DUP;
 static void clean_pack_garbage(void)
 {
  int i;
- for (i = 0; i < pack_garbage.nr; i++)
- unlink_or_warn(pack_garbage.items[i].string);
+ /* Define a cutoff time for "new" garbage to prevent race conditions */
+ time_t cutoff = time(NULL) - 10;
+ for (i = 0; i < pack_garbage.nr; i++) {
+ struct stat s;
+ char *garbage = pack_garbage.items[i].string;
+ if (!stat(garbage, &s)) {
+ if (s.st_mtime < cutoff)
+ unlink_or_warn(garbage);
+ } else
+ fprintf(stderr, _("stat failed on pack garbage: %s"),
+ garbage);
+ }
  string_list_clear(&pack_garbage, 0);
 }

diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index cbcc0c0..7b4650f 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -272,6 +272,7 @@ test_expect_success 'clean pack garbage with gc' '
  : >.git/objects/pack/fake6.keep &&
  : >.git/objects/pack/fake6.bitmap &&
  : >.git/objects/pack/fake6.idx &&
+ sleep 10 &&
  git gc &&
  git count-objects -v 2>stderr &&
  grep "^warning:" stderr | sort >actual &&
@@ -291,6 +292,7 @@ test_expect_success 'ensure unknown garbage kept with gc' '
  : >.git/objects/pack/foo.keep &&
  : >.git/objects/pack/fake.pack &&
  : >.git/objects/pack/fake2.foo &&
+ sleep 10 &&
  git gc &&
  git count-objects -v 2>stderr &&
  grep "^warning:" stderr | sort >actual &&
-- 
2.6.1
