From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v3 00/14] ref-transactions-reflog
Date: Tue, 18 Nov 2014 10:36:44 -0800
Message-ID: <CAL=YDWn1x9TMGOWrmT5KMpQ_iBR0AQ5Ej1yr1pBb4==k0-vchw@mail.gmail.com>
References: <1416274550-2827-1-git-send-email-sbeller@google.com>
	<546B2CE0.6020208@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Nov 18 19:36:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqndy-0005Za-8h
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 19:36:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952AbaKRSgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 13:36:46 -0500
Received: from mail-vc0-f172.google.com ([209.85.220.172]:43410 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753903AbaKRSgp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 13:36:45 -0500
Received: by mail-vc0-f172.google.com with SMTP id hq11so6916353vcb.31
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 10:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BqyqWATKmUy/4+AvqzwAO+SKAIavoUinZoZG8Q2U4G8=;
        b=TO7cV8RqdX9QiuZFtwHrL1uf3fR3BaJ9k7b86KAa0QAVSzIdkTrqmiXdkVU8+kW8sF
         iPfv+UmpzRhWcM9aW15K/FvjKNCE/wYikUtqMvGjekkZvxpB/gMqR5uOajn/UWrQFx3I
         pZt2vOOQLadgdDo5HFrdo5t6OFn3MnvpmXNDU1i2VJf8ok1yp1ga9px/AacqUdt/vOBd
         A18BR1eHOeL4pwCOmZTfFVAK9rIhOf8488KLK4uB8+joW+BO2n+5mBMvTuhWQUh1QRqe
         KdARTRFIJ/SYM8arP5EIhszjUUceYA9goy1R24DHeuR0yUNmHcZH2Upsggrub7HIODPi
         F8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=BqyqWATKmUy/4+AvqzwAO+SKAIavoUinZoZG8Q2U4G8=;
        b=DNrpCsMgYwDXmo85lBoK0JmVweYxglZT9tgDN4FsSZVpWxpY2ZZf3t5KyFqwtIhde0
         A63MBkzdKDHOFa1MVvQqN33cVQWxShVOFu9QZuyGv8YKHrAP8m57svz2UzHaBGKTkeDC
         RV3ArtDJSpC37Oc0g5o+KEXFV+yg0xobfkabFWDrQbcWxkCDgt2m38jjanL4XsyXR/N0
         eKU0WIqY0cVZp9A3kPU3IerdkwfYnoLQPI4/Aw32dK9NFqQ0wLxbqcv3V70Ht6JMm/N8
         DS3snyCrsbPDcqm9dYPLAlQ4ossPP8aQdVatTq6AZgHlpREOCTJVbTsWeyqP91bDPYrU
         EkQw==
X-Gm-Message-State: ALoCoQliLvL9WII1Q8M6q7N78M/lE1EPjY9zP3n8chQzNFA1mrwO2s+zGqV22Va+79dRxgWRpzy+
X-Received: by 10.52.231.165 with SMTP id th5mr18719544vdc.43.1416335804794;
 Tue, 18 Nov 2014 10:36:44 -0800 (PST)
Received: by 10.52.76.167 with HTTP; Tue, 18 Nov 2014 10:36:44 -0800 (PST)
In-Reply-To: <546B2CE0.6020208@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 18, 2014 at 3:26 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 11/18/2014 02:35 AM, Stefan Beller wrote:
>> The following patch series updates the reflog handling to use transactions.
>> This patch series has previously been sent to the list[1].
>> [...]
>
> I was reviewing this patch series (I left some comments in Gerrit about
> the first few patches) when I realized that I'm having trouble
> understanding the big picture of where you want to go with this. I have
> the feeling that the operations that you are implementing are at too low
> a level of abstraction.
>
> What are the elementary write operations that are needed for a reflog?
> Off the top of my head,
>
> 1. Add a reflog entry when a reference is updated in a transaction.
> 2. Rename a reflog file when the corresponding reference is renamed.
> 3. Delete the reflog when the corresponding reference is deleted [1].
> 4. Configure a reference to be reflogged.
> 5. Configure a reference to not be reflogged anymore and delete any
>    existing reflog.
> 6. Selectively expire old reflog entries, e.g., based on their age.
>
> Have I forgotten any?
>
> The first three should be side-effects of the corresponding reference
> updates. Aside from the fact that renames are not yet done within a
> transaction, I think this is already the case.
>
> Number 4, I think, currently only happens in conjunction with adding a
> line to the reflog. So it could be implemented, say, as a
> FORCE_CREATE_REFLOG flag on a ref_update within a transaction.
>
> Number 5 is not very interesting, I think. For example, it could be a
> separate API function, disconnected from any transactions.
>
> Number 6 is more interesting, and from my quick reading, it looks like a
> lot of the work of this patch series is to allow number 6 to be
> implemented in builtin/reflog.c:expire_reflog(). But it seems to me that
> you are building API calls at the wrong level of abstraction. Expiring a
> reflog should be a single API call to the refs API, and ultimately it
> should be left up to the refs backend to decide how to implement it. For
> a filesystem-based backend, it would do what it does now. But (for
> example) a SQL-based backend might implement this as a single SELECT
> statement.

I agree in principle. But things are more difficult since
expire_reflog() has very complex semantics.
To keep things simple for the reviews at this stage the logic is the
same as the original code:
  loop over all entries:
     use very complex conditionals to decide which entries to keep/remove
     optionally modify the sha1 values for the records we keep
     write records we keep back to the file one record at a time

So that as far as possible, we keep the same rules and behavior but we
use a different API for the actual
"write entry to new reflog".


We could wrap this inside a new specific transaction_expire_reflog()
function so that other types of backends, for example an SQL backend,
could optimize, but I think that should be in a separate later patch
because expire_reflog is almost impossibly complex.
It will not be a simple SELECT unfortunately.

The current expire logic is something like :
  1, expire all entries older than timestamp
  2, optionally, also expire all entries that refer to unreachable
objects using a different timestamp
      This involves actually reading the objects that the sha1 points
to and parsing them!
  3, optionally, if the sha1 objects can not be referenced, they are
not commit objects or if they don't exist, then expire them too.
      This also involves reading the objects behind the sha1.
  4, optionally, delete reflog entry #foo
  5, optionally, if any log entries were discarded due to 2,3,4 then
we might also re-write and modify some of the reflog entries we keep.
or any combination thereof

  (6, if --dry-run is specified, just print what we would have expired)


2 and 3 requires that we need to read the objects for the entry
4 allows us to delete a specific entry
5 means that even for entries we keep we will need to mutate them.






>
> I also don't have the feeling that reflog expiration has to be done
> within a ref_transaction. For example, is there ever a reason to combine
> expiration with other reference updates in a single atomic transaction?

--updateref
In expire_reflog() we not only prune the reflog. When --updateref is
used we update the actual ref itself.
I think we want to have both the ref update and also the reflog update
both be part of a single atomic transaction.


> I think not.
>
> So it seems to me that it would be more practical to have a separate API
> function that is called to expire selected entries from a reflog [2],
> unconnected with any transaction.

I think it makes the API cleaner if we have a
'you can only update a ref/reflog/<other things added in the future>/
from within a transaction.'

Since we need to do reflog changes within a transaction for the expire
reflog case as well as the rename ref case
I think it makes sense to enforce that reflog changes must be done
within a transaction to just make it consistent.



>
> I am not nearly as steeped in this code as you and Ronnie, and it could
> be that I'm forgetting lots of details that make your design preferable.
> But other reviewers are probably in the same boat. So I think it would
> be really helpful if you would provide a high-level description of the
> API that you are proposing, and some discussion of its design and
> tradeoffs. A big part of this description could go straight into a file
> Documentation/technical/api-ref-transactions.txt, which will be a great
> (and necessary) resource soon anyway.
>
> Michael
>
> [1] Though hopefully there will be future reference backends that don't
> have to discard reflogs when a reference is deleted, so let's not bake
> this behavior too fundamentally into the API.
>
> [2] ...and/or possibly one to expire reflogs for multiple references, if
> performance would benefit significantly.
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
