From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: ephemeral-branches instead of detached-head?
Date: Wed, 14 Aug 2013 12:02:24 +0530
Message-ID: <520B2478.3000100@gmail.com>
References: <CA+CP9O6on2NXo6o4_0NoULnT8sgUD3pvvkFZvCTM5xKb38qOeA@mail.gmail.com> <7veh9z1gym.fsf@alter.siamese.dyndns.org> <CA+CP9O5fhyQrn3SboafocWJjaAywJHC0T-bw+AXk_8RX53hJ6Q@mail.gmail.com> <CACsJy8Dke6Pezqsdcjzejc_cWCgOGTGs8LifjM2h2TQJy7N4HA@mail.gmail.com> <7vk3jpy1qt.fsf@alter.siamese.dyndns.org> <520AC9A8.4030104@gmail.com> <7vmwolujvb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>, David Jeske <davidj@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 14 08:32:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9Udc-000504-C2
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 08:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430Ab3HNGcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 02:32:33 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:42470 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301Ab3HNGcc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 02:32:32 -0400
Received: by mail-pd0-f179.google.com with SMTP id v10so5935364pde.10
        for <git@vger.kernel.org>; Tue, 13 Aug 2013 23:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ODHarzYq1Rz3tw3/dQ3WHwlkSXoQBKEr8kLqoR1UkvA=;
        b=xbtZJTAh0nqJODjAqryr2SOrvHhaQV/LPIZEUaEUa7iE+9wEpN+yjHEsNzImEmCjrd
         a9+9XUm2Veq4vTABtX7bS6nz3/cacA0bOJoNXkUZ/Db+syDQJgUop4fKZeOz8jpSHXgy
         cWYcVul9jfC7gkLaIFhQjA1QqmFtzs8+x88WeFVUfNGIaBPTIGJU2Q8CE6L+lDIE8Wxc
         qcBhX+CGcoMq47zXhqPgyim/KWWCJm4IPZz9GoL8X133XvUXUcnwa9TPy2DCMAT0NRAE
         gdxOi72j6pQuAvsZ5W8hABm1tdYzDDsHeFju9OxDwCTwj1/6RbkS29Q4i9947Vo/wS+M
         n3vg==
X-Received: by 10.66.255.104 with SMTP id ap8mr1307871pad.53.1376461952048;
        Tue, 13 Aug 2013 23:32:32 -0700 (PDT)
Received: from sita-lt.atc.tcs.com (atcmail.atc.tcs.com. [203.200.212.145])
        by mx.google.com with ESMTPSA id zi1sm9142329pbb.28.2013.08.13.23.32.28
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 13 Aug 2013 23:32:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130805 Thunderbird/17.0.8
In-Reply-To: <7vmwolujvb.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232260>

On 08/14/2013 07:14 AM, Junio C Hamano wrote:
> Sitaram Chamarty <sitaramc@gmail.com> writes:
> 
>>     # all reflog entries that are not on a branch, tag, or remote
>>     d1 = !gitk --date-order $(git log -g --pretty=%H) --not --branches --tags --remotes
>>     # all dangling commits not on a branch, tag, or remote
>>     d2 = !gitk --date-order $(git fsck | grep "dangling.commit" | cut -f3 -d' ') --not --branches --tags --remotes
>>
>> (Apologies if something like this was already said; I was not following
>> the discussion closely enough to notice)
> 
> Yup.
> 
> A potential problem is that the output from "log -g --pretty=%H" or
> "fsck | grep dangling" may turn out to be humongous.  Other than
> that, they correctly compute what you want.

I thought I mentioned that but I can't find my email now so maybe I
didn't.

In practice though, I find that, bash at least seems happy to take
command lines as long as 7+ million characters long, so with the default
reflog expire times, that should work out to 10,000 commits *per day*.
[Tested with: echo {1000000..1900000}  > junk; echo `cat junk` | wc]

Incidentally, am I the only one who thinks the default values for
gc.reflogexpire (90 days) and gc.reflogexpireunreachable (30) should be
reversed?

In terms of recovering potentially lost commits at least, it seems it
would make more sense that something that is UNreachable have a longer
expiry, whereas stuff that's reachable... that's only a quick "gitk"
browse away.

Design question: is the primary purpose of the reflog "what was I doing
X days ago" or is it "I need some code from a commit that got rebased
out [or whatever] X days ago"?

I have always only used the reflog for the latter.
