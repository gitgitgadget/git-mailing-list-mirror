From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [Patch] Prevent cloning over http from spewing
Date: Mon, 22 Jun 2009 20:10:20 +0800
Message-ID: <be6fef0d0906220510r416d66aaoc2171bdcc61ec3a4@mail.gmail.com>
References: <m3vdnda9f7.fsf@localhost.localdomain>
	 <20090603191050.GB29564@coredump.intra.peff.net>
	 <20090603191555.GL3355@spearce.org>
	 <be6fef0d0906040545j7bd754e0j2c60af833e2ac4a4@mail.gmail.com>
	 <20090604160152.GA13984@sigill.intra.peff.net>
	 <be6fef0d0906070331y5fd596d1k67893a96a4d872ac@mail.gmail.com>
	 <be6fef0d0906070421j7913b0d7w6f7bb97aa7fd6814@mail.gmail.com>
	 <20090608122430.GD13775@coredump.intra.peff.net>
	 <be6fef0d0906100703j57d109d5mb38e41330caa089b@mail.gmail.com>
	 <20090611111141.GB4409@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, sparse@infidigm.net,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 22 14:17:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIiSi-0006aq-JQ
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 14:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbZFVMRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 08:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbZFVMRM
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 08:17:12 -0400
Received: from mail-px0-f174.google.com ([209.85.216.174]:64564 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbZFVMRM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 08:17:12 -0400
Received: by pxi4 with SMTP id 4so13504pxi.33
        for <git@vger.kernel.org>; Mon, 22 Jun 2009 05:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AM659mkX+cYPhmhyHcRbfzIof68MrevKTBb771BipKc=;
        b=iAtPd83hQW+XljD6uvEQ7vsQoibUah6KyuK91cL+1TI/vwtB1mmpmmxl5XbIQIA+UZ
         ARWmwdGcqjEU4e8pTs9eUzRiyBp9TENy662g7q1h2wOVcVKPnyTHp/JCDQND1YhO2h1v
         fjiNJ9E+FaSnNR/D4gawfO47Sx/tM9UE6/+Qs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=X77t3efyPJtyJstqlBSF5VkPV7fkbaO1uuAlfxmj3KxntAqSbVsAudPn+Dh2/ZBNbp
         ZwUcCk+NZZpjy4otrXkfO+UNPukSl8lproR4fMzVlY17G42rEyzVQH9B4pHhYwkSO29Z
         cOkXWxXGCfM6VCMJbzoIEJMteMcEuvSVbBgCA=
Received: by 10.142.230.9 with SMTP id c9mr2606888wfh.2.1245672620870; Mon, 22 
	Jun 2009 05:10:20 -0700 (PDT)
In-Reply-To: <20090611111141.GB4409@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122030>

Hi,

note: this time, I haven't anything to show for in my repo; sorry.

On Thu, Jun 11, 2009 at 7:11 PM, Jeff King<peff@peff.net> wrote:
> On Wed, Jun 10, 2009 at 10:03:10PM +0800, Tay Ray Chuan wrote:
>
>> > My first complaint is that it is way too long. It wrapped in my
>> > 80-column terminal, causing all sorts of visual confusion.
>>
>> The byte counts can really take up alot of space. Perhaps we should
>> just show the size (MiB) and completed percentage, sans byte counts?
>
> I think that makes sense. Especially because the (X/Y) in git's progress
> output usually refers to the number of _objects_, and there is nothing
> in the output to indicate that it is actually a byte count here.
>
> I think it will need some tweaking of the progress code to show the
> percentage but not the actual byte counts, but it should be a relatively
> simple change.

Ok.

>> Fetching of objects and packs take place separately; it doesn't mean
>> that when '0' objects are being fetched, we're definitely fetching
>> something else (eg. packs). Perhaps we should "hide" the "Fetching 0
>> objects" part when the number of simultaneous object fetches is 0?
>
> Yes, though I really wonder if the "fetching" number is all that useful
> even when it is not zero. The _most_ important thing is to show the user
> that something is happening, and we are waiting on the network. And I
> think we largely show that through the "total bytes sent" and throughput
> counters.

Ok also.

My understanding of this point now: if we're fetching non-objects
*(like packs, pack indices), we wouldn't display "Fetching X objects"
at all, regardless of X. But if we're not fetching any non-objects and
we're waiting for loose objects fetching to finish (ie. we're fetching
1 loose object or more), then we would display "Fetching X objects".

>> The total number of objects (320) increases as we "walk" the commits;
>> sometimes we need to fetch the "walked" objects, sometimes we don't
>> (eg. in packs we've fetched already). There's no way to know in
>> advance the total; hence, the continually updating of the total. I
>> don't think there's it's a problem; the idea is to let the user be
>> sure that git is active.
>
> Right. But I think we are better off showing simple increasing numbers
> (like bytes or objects transferred) than misleading or inaccurate
> guesses of totals. The latter creates more frustration, I think.

Ok.

>> Yeah, we do download packs one at a time (as I said above).
>
> But from what you wrote elsewhere in the message, it sounds like we may
> be downloading a pack _and_ a loose object at the same time. So my
> suggestion doesn't quite work in that case.

In addition to that, it isn't possible to calculate the number of pack
indices to be fetched, because we're fetching them as we go along (see
http.c::http_get_info_packs() in 'master'), so that's a potential
problem. I wonder if you (or anyone reading this) has any suggestions
on this?

I still think we can use your idea of one-fetch-one-verify per pack,
even though objects are fetched simultaneously.

Here's what a "git clone http://repo" would look like, after
incorporating points from our discussion so far:

 Fetching info/refs: Z%, x MiB | y KiB/s, done
 Fetching objects/info/packs: Z%, x MiB | y KiB/s, done
 Fetching pack index (1 of 3): Z%, x MiB | y KiB/s, done
 Fetching pack index (2 of 3): Z%, x MiB | y KiB/s, done
 Fetching pack index (3 of 3): Z%, x MiB | y KiB/s, done
 Fetching pack (1 of 3): Z%, x MiB | y KiB/s, done
 Verifying pack (1 of 3): Z%, (X/Y), done
 Fetching pack (2 of 3): Z%, x MiB | y KiB/s, done
 Verifying pack (2 of 3): Z%, (X/Y), done
 Fetching pack (3 of 3): Z%, x MiB | y KiB/s, done
 Verifying pack (3 of 3): Z%, (X/Y), done
 Fetching 2 objects, done.
 Checking out files, done.

(I made up the last line.)

>> the linux-2.6 repo has only 1 pack (and no http-alternates), so this
>> is weird.
>
> Maybe we are fetching from different places:

Thanks. I realise the weird percentage values you saw were due to
out-of-range numeric calculations, so actually, your point didn't
count, but thanks anyway.

-- 
Cheers,
Ray Chuan
