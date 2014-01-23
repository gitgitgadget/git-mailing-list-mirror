From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 2/1] Make request-pull able to take a refspec of form local:remote
Date: Thu, 23 Jan 2014 11:57:30 -0800
Message-ID: <CA+55aFyGaaMOL5pBhZ1BHMr07oDi2MuS-fPu4nnxhjoy+F0AQw@mail.gmail.com>
References: <alpine.LFD.2.11.1401221535140.18207@i7.linux-foundation.org>
	<xmqqlhy6trfp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tejun Heo <tj@kernel.org>, Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 23 20:57:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6QPA-0006OV-1t
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 20:57:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbaAWT5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 14:57:32 -0500
Received: from mail-vb0-f41.google.com ([209.85.212.41]:36576 "EHLO
	mail-vb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535AbaAWT5b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 14:57:31 -0500
Received: by mail-vb0-f41.google.com with SMTP id g10so1344068vbg.0
        for <git@vger.kernel.org>; Thu, 23 Jan 2014 11:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=8DWxHhgsAcD+2THoT2n/yeTpC7roBcI1slGiwOMYA0k=;
        b=pZgAKYoRrgZmzBU+Dt37m4SqYX+f/rw//SQEOitt2KyPjl7dbvreI/Y0tCyu/rPsXH
         mYPuwzmM+nWmX1LxWaQSPxWF+ejeH5KaPTww7K+jOosR44w4SN3YSKRq8OxQ3u+k9ztC
         eVQNN2bRJhPIjI1oqmOx23ohjHpgGdLWGOXHm1NV94MMaceyJ/nwxnKFWCkX3wKQsAOW
         VqHiTqCwW5gmzd4InGSHTqhYLQMmr2uX8/Eho/M5l+3UNVCrov7KziexcHZ+R0GuqtSh
         yqpvoCAF+edNcrn0dhUIhw+PTyWebJrfsXmBVF6eqyNYA/CgbTA+N8WUQOvc8/izhO9+
         MyzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=8DWxHhgsAcD+2THoT2n/yeTpC7roBcI1slGiwOMYA0k=;
        b=Z/RzuOjs6kYXCmiMzQa3NBpI6Czf7V2iVrC9QPZqnCveUTM6v51ARNR1Z6ZiD4q38E
         EtFuGF+vUGh4f0CoQv5dklpwDYkrgx3IZ201TU6ps+JyvoZ0szkSH6kndhXcFrQVxg2F
         oJs7oTznTQNqRn79Fsp0NYy0WZuBf/O2INEXM=
X-Received: by 10.58.219.1 with SMTP id pk1mr28371vec.49.1390507050606; Thu,
 23 Jan 2014 11:57:30 -0800 (PST)
Received: by 10.221.8.73 with HTTP; Thu, 23 Jan 2014 11:57:30 -0800 (PST)
In-Reply-To: <xmqqlhy6trfp.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: t15AEDBiIrjQdBOFIfJozB49BW0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240936>

On Thu, Jan 23, 2014 at 11:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I am not sure if it is a good idea to hand-craft "resulting head is
> unique" constraint here.  We already have disambiguation rules (and
> warning mechanism) we use in other places---this part should use the
> same rule, I think.

If you can fix that, then yes, that would be lovely. As it is, I
couldn't find any easily scriptable way to do that.

>>  #
>>  # Otherwise find a random ref that matches $headrev.
>>  find_matching_ref='
>> +     my ($head,$headrev) = (@ARGV);
>> +     my ($found);
>> +
>>       while (<STDIN>) {
>> +             chomp;
>>               my ($sha1, $ref, $deref) = /^(\S+)\s+([^^]+)(\S*)$/;
>> +             my ($pattern);
>> +             next unless ($sha1 eq $headrev);
>> +
>> +             $pattern="/$head\$";
>
> I think $head is constant inside the loop, so lift it outside?

Yes. I'm not really a perl person, and this came from me trying to
make the code more readable (and it used to do that magic quoting
thing inside the loop, I just used a helper pattern variable).

>> +             if ($sha1 eq $head) {
>
> I think this is $headrev ($head may be $remote or HEAD), but then
> anything that does not point at $headrev has already been rejected
> at the beginning of this loop, so...?

No, this is for when "head" ends up not being a ref, but a SHA1 expression.

IOW, for when you do something odd like

    git request-pull HEAD^^ origin HEAD^

when hacking things together. It doesn't actually generate the right
request-pull message (because there's no valid branch name), but it
*works* in the sense that you can get the diffstat etc and edit things
manually.

It's not a big deal - it has never really "worked", and I actually
broke that when I then used "$remote" that doesn't actually have the
SHA1 any more.

>> +     if ($found) {
>>               print "$found\n";
>>       }
>>  '
>
> I somehow feel that this is inadequate to catch the "delayed
> propagation" error in the opposite direction.  The publish
> repository may have an unrelated ref pointing at the $headrev and we
> may guess that is the ref to be fetched by the integrator based on
> that, but by the time the integrator fetches from the repository,
> the ref may have been updated to its new value that does not match
> $headrev.  But I do not think of a way to solve that one.

Yes, so you'll get a warning (or, if you get a partial match, maybe
not even that), but the important part about all these changes is that
it DOESN'T MATTER.

Why? Because it no longer re-writes the target branch name based on
that match or non-match. So the pull request will be fine.

In other words, the really fundamental change here i that the "oops, I
couldn't find things on the remote" no longer affects the output. It
only affects the warning. And I think that's important.

It used to be that the remote matching actually changed the output of
the request-pull, and *THAT* was the fundamental problem.

> In any case, shouldn't we be catching duplicate matches here, if the
> real objective is to make it less likely for the users to make
> mistakes?

It would be good, yes. But my perl-fu is weak, and I really didn't
want to worry about it. Also, as above: my primary issue was to not
screw up the output, so the remote matching actually has become much
less important, and now the warning about it is purely about being
helpful, it no longer fundamentally alters any semantics.

So I agree that there is room for improvement, but that's kind of
separate from the immediate problem I was trying to solve.

              Linus
