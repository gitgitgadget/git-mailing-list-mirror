From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [ITCH] pull.default
Date: Tue, 19 Mar 2013 00:51:24 +0530
Message-ID: <CALkWK0kftNGt-xhLH8f+tVUNUF_qBDkTVcAEoiQKp_NRdPOftg@mail.gmail.com>
References: <CALkWK0nT9hE_kRt3DLXfP45OwCSLurMOzuTqepxhkWjagbFDUQ@mail.gmail.com>
 <7vy5dkmt7k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 18 20:22:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHfdQ-0006B7-9A
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 20:22:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754946Ab3CRTVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 15:21:47 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:42781 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754937Ab3CRTVp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 15:21:45 -0400
Received: by mail-ie0-f180.google.com with SMTP id qd14so1591880ieb.39
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 12:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ZP3OrMPSzXxIHfYksV24ivspi/LDTFgBWog1ze8c3fc=;
        b=dUN6lws1gDFihsYdsQHm9oMVpcLIFeJqbrKq17UxilDB7u2K67OVTYClZ9kzvh8FmS
         Scac0gqiMoA+jwbyj2Xl+/HCf3HJBceGgPUSvRwRrmivGP43hHE6I2W57kAcUwNFxoaA
         /ftq5P4LQXpypsnn65yXVcnyheDnYqvNyI3aI0SR1Z1V9vKIjNu4g2xeP2ii6NO98Pg3
         zU2XPUjc1bRagdxOF/cy/pEmpujRVPPXuyPJgc50tSd6WEiGK+OfXUvyBLxULNvWZJOe
         wQItINrQgnTq8t5jJQjraJ45n5ahpIplyxXtRLlOfzIrMmtfBuODQOzWhSd+boIY+Bfa
         CnYQ==
X-Received: by 10.50.108.235 with SMTP id hn11mr41304igb.107.1363634504669;
 Mon, 18 Mar 2013 12:21:44 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Mon, 18 Mar 2013 12:21:24 -0700 (PDT)
In-Reply-To: <7vy5dkmt7k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218439>

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> I usually use `git fetch`, inspect state, and then merge/ rebase
>> accordingly.  Unfortunately, this is very sub-optimal as I can
>> automate this 80% of the time.  I want to be able to decide what to do
>> on a repository-specific basis, and hence propose a pull.default which
>> can be set to the following:
>> 1. fetch.  Just fetch.  (I will set this as my default in ~/.gitconfig)
>> 2. fast-forward.  Fetch.  If the FETCH_HEAD is directly ahead of HEAD,
>> `stash`, merge, and stash apply.  Otherwise, do nothing.
>> 3. rebase.  Fetch.  stash, rebase, stash apply. `git pull n` will do
>> rebase --onto master HEAD~n instead of rebase.
>> 4. reset.  Fetch, stash, reset --hard FETCH_HEAD, stash apply.
>>
>> Ofcourse, it should print a message saying what it did at the end.
>>
>> What do you think?
>
> Many other possibilities are missing.  "fetch and merge", for
> example.
>
> You seem to be generalizing the "--rebase" and "--ff-only" options
> of "git pull" with 2 and 3, which may (or may not) make sense.
>
> I think you can shrink and enhance the above repertoire at the same
> time by separating "do I want to have stash and stash pop around"
> bit into an orthogonal axis.  The other orthogonal axes are "Under
> what condition do I integrate the work from the upstream?" (e.g.
> "only when I do not have anything, aka, ff-only") and "How would I
> integrate the work from the upstream?" (e.g. "rebase my work" and
> "discard anything I did aka reset --hard").

Excellent I was hoping to start a discussion like this.  My initial
thought was designing a custom script that git-pull will execute like
a hook; we should, however, be able to get away with designing enough
configuration orthogonal configuration variables.  For anything more
complex, just do it by hand!

> By the way, I do not think you should start your design from a
> configuration (this is a general principle, not limited to this
> case).  Think about what the smallest number of independent options
> you need to add to express various workflows, and then turn them
> into configuration variables that can set the default, all of which
> have to be overridable from the command line.

Will do.  Expect a draft soon.
