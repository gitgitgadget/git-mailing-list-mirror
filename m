From: "Adam Liter" <adam.liter@gmail.com>
Subject: Re: Question about git filter-branch with signed commits
Date: Sat, 25 Jul 2015 20:24:04 -0500
Message-ID: <9A494528-F43E-4FEE-A31F-FB8B1E85A1AD@gmail.com>
References: <5085A037-0E20-4FA4-B553-E54345F4FAA5@gmail.com>
 <CA+P7+xo+0cb38qjAJwrOtRahDwWgSvG+-5-6XAF6BpRSvnMXgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Cc: git@vger.kernel.org
To: "Jacob Keller" <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 26 03:24:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJAfn-0007NX-3V
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jul 2015 03:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbbGZBYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2015 21:24:10 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33793 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755078AbbGZBYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2015 21:24:09 -0400
Received: by iecrl10 with SMTP id rl10so38578569iec.1
        for <git@vger.kernel.org>; Sat, 25 Jul 2015 18:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type;
        bh=YX1/N1N9h0ED1+Sia7R7+pGrtXuIfAUdcNW+c+peaPc=;
        b=ozDQxBxQngm+GkmY6ZRrtKjDkrFJq5DHI5Vvpmvl6/YtBpXRd7Eey9cQ5ZeoAQZOli
         7LWEcHKVC6gWV7ffS33E4wOjJ42ohCiV9GHuXu+tvIHwoNRuDjRDVIfq2bVD8fPDyBI5
         029O8HAzo3xRFNciGvizQ4fm6rK8xqQ7tLGLvrXF5bt+ZyBAOHAix6OQEbUkVhy+b1Fm
         5xVG2VNs7/mslIKAgQLs8lf2T5jEYfTgV6KYY/WI80+0OVPIYIGt/vIyjCNeyEvIL8MV
         XuyFAs3+sjnA/PK57rVWnH+OWymds3tSBW5EORVmufTkhdA5RaBl0SmOKh4rR6lulJoN
         x2nA==
X-Received: by 10.50.61.197 with SMTP id s5mr7309577igr.51.1437873848262;
        Sat, 25 Jul 2015 18:24:08 -0700 (PDT)
Received: from [192.168.0.4] (c-73-36-170-161.hsd1.il.comcast.net. [73.36.170.161])
        by smtp.gmail.com with ESMTPSA id 71sm8526990ioh.24.2015.07.25.18.24.06
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 25 Jul 2015 18:24:07 -0700 (PDT)
In-Reply-To: <CA+P7+xo+0cb38qjAJwrOtRahDwWgSvG+-5-6XAF6BpRSvnMXgw@mail.gmail.com>
X-Mailer: MailMate (1.9.1r5084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274624>

>> I'm trying to clean up the commit history of a git repository by 
>> removing
>> certain files. The repository contains signed commits, and when I try 
>> to use
>> git filter-branch, the PGP signature is converted to the first line 
>> of the
>> commit message.
>
> It should be possible to craft a filter that removes the signatures
> entirely. It is not possible to craft a filter-branch which retains
> the signatures in any *valid* form, though you could re-create new
> signatures assuming you have all the private keys (ie: you're the one
> who signed all the commits).
>
> You can't keep the signatures alone, because then they wouldn't be
> valid, since the data they signed is not the same now. Normally
> signatures are used so that you can verify "yes, so-and-so is the
> person who did this thing and no one else could have faked it).

Ah, okay, that makes sense.

>> Is this the expected behavior? If so, is there something that I can 
>> do to
>> prevent this from happening?
>
> I'm not sure why it's putting the first line at the top of the commit.
>
>> I'm using git v. 2.4.6. I tried reducing the behavior to a simple 
>> case. I
>> asked about this on Stack Overflow
>> (http://stackoverflow.com/q/31552774/2571049), but the question 
>> hasn't
>> really gotten any uptake, so I thought I would try asking here too.
>>
>> In trying to reproduce the behavior in a minimal way, I did the 
>> following:
>>
>> mkdir pgp-git-test
>> cd pgp-git-test
>> git init
>> touch a.txt
>> git add a.txt
>> git commit -m "Add a.txt" -S
>> touch b.txt
>> git add b.txt
>> git commit -m "Add b.txt" -S
>> git filter-branch --index-filter 'git rm --cached --ignore-unmatch 
>> a.txt'
>> --prune-empty HEAD
>> git log --oneline --decorate
>> b4efdf0 (HEAD -> master)  iQIcBAABCgAGBQJVrvqHAAoJ [...] -----END PGP
>> SIGNATURE-----
>> 9f82e63  iQIcBAABCgAGBQJVrvp7AAoJ [...]  -----END PGP SIGNATURE-----
>>
>> As can be seen after running git log --oneline --decorate, the PGP 
>> signature
>> has become the first line of the commit. The rest of the commit 
>> message is
>> still there, but it's on a line below the PGP signature.
>>
>> How can I prevent this from happening when using git filter-branch?
>
> You probably need to run all the commits through a filter first which
> strips out all signature info, and then re-write the commits to remove
> the file. You can't leave the signatures in there alone, as they would
> no longer be valid, and people who try to verify them would fail.

Do you know of a good way to do this? I'm pretty new to git, and I 
haven't had much luck searching online or looking through the 
documentation for ideas of how to even filter out the PGP signatures 
before filtering out a certain file from the commit history.

If you could even point me in the right direction, I would really 
appreciate it. Do you think there is a way to do this all automatically, 
so that it would be possible to keep track of which commits have had 
their signatures removed and then resign them after filtering out the 
file (I am the one who signed the commits originally), or would that be 
impossible since the SHA-1 hashes of the commits will change?

>> Also, one thing that I was a bit surprised about when trying to 
>> create this
>> minimal example is that the first commit is still there. Does anyone 
>> know
>> why the commit history still contains the first commit, since the 
>> first
>> commit only involved the file a.txt and since I passed --prune-empty 
>> to git
>> filter-branch? Shouldn't this commit have been eliminated from the 
>> log?
>
> I'm not sure about this part, sorry.

No worries. Thanks for your help and your initial response. I appreciate 
it!

>> Thanks in advance for the help! I'm relatively new to git, so 
>> apologies for
>> bugging you all if this is a trivial error on my part. Thanks!
>>
>> Best,
>> Adam Liter
>
> Regards,
> Jake
