From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: help reverting a merge
Date: Mon, 30 Nov 2009 00:31:26 -0800
Message-ID: <4B1382DE.1030506@gmail.com>
References: <dd18b0c30911291524q7ea7e9c7v980340ddf7269519@mail.gmail.com> <20091130081315.GA587@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 30 09:31:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF1fO-0002f3-VV
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 09:31:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067AbZK3IbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 03:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751944AbZK3IbT
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 03:31:19 -0500
Received: from mail-gx0-f212.google.com ([209.85.217.212]:64093 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbZK3IbS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 03:31:18 -0500
Received: by gxk4 with SMTP id 4so1624699gxk.8
        for <git@vger.kernel.org>; Mon, 30 Nov 2009 00:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=7of+ucU1for0Gdj88FWNB5Pva1MNVM8F3IPphjKqLiA=;
        b=oUw5PDZX1m6/HjlbNMjrNaFCYZ5th17xGqGAZENh5l0Ti0yV0Xc4YXTUfdO4FtFqKz
         V9fxpdmeJRZKEFvbr2f5ljl27RY5pjvqKmeQe18rHhG90p0LCHRBNxVeyaJA4vL81oX7
         SBYirlz7MzKIgPbl+0ILj7oJOj1BTs+qXHNoI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=PbYRnxtD4Oj4WTTa74DI0wg9vC0nx19mx9cotz54/ARPi/tM5/crh0OMx6xFkRmLqx
         /mGd+C69W6HWjRCrGhlo7PCKrs6sL6SkkdGLP1ARrwNnHuH7m16f845EMPahRsRS02c3
         XLRNfBXF0rK+qsrG4qWCxIJv9dfAxucE/Am2k=
Received: by 10.150.45.36 with SMTP id s36mr6601706ybs.334.1259569884897;
        Mon, 30 Nov 2009 00:31:24 -0800 (PST)
Received: from ?10.0.0.95? (cpe-76-173-26-187.socal.res.rr.com [76.173.26.187])
        by mx.google.com with ESMTPS id 9sm1539837ywf.50.2009.11.30.00.31.23
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 30 Nov 2009 00:31:24 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20091114 Lightning/1.0pre Thunderbird/3.0b4
In-Reply-To: <20091130081315.GA587@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134082>

On 11/30/09 00:13, Jeff King wrote:
> On Sun, Nov 29, 2009 at 03:24:09PM -0800, Justin Mattock wrote:
>
>> I've done a bisect on a problem with the kernel,
>> and am a bit confused on what to do. i.g. the
>> results are showing this:
>> a03fdb7612874834d6847107198712d18b5242c7 is the first bad commit
>>
>> [...]
>>
>> how do I find out the commits in this merge to automatically
>> revert to find the problem that's causing this bug?
>
> There is some discussion here:
>
> http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#bisect-merges
>
> Basically neither merged branch was buggy on its own, but together they
> have a bug.  You can try rebasing the two sides of the merge into a
> linear history, and then bisecting on that:
>
>    # order doesn't matter here, but rebasing 12e0933 on top makes more
>    # sense since it has many fewer commits between it and the merge-base
>    # (and you'll need to fix up conflicts manually, so the smaller the
>    # rebase the better)
>    git checkout 12e0933
>    git rebase 202c467
>
>    # to be safe, confirm that the rebase result shows your bug;
>    # we know that 202c467 doesn't have the bug, or we would not have
>    # bisected to the merge commit before
>    test test test
>    git bisect start
>    git bisect bad HEAD
>    git bisect good 202c467
>
> which should give you the specific commit on the side branch where the
> breakage occurred.
>
> This has been discussed as a technique before, and I have a feeling in
> the back of my mind that maybe there was talk of having git-bisect help
> with this case, but I don't think anything ever came of it. Christian
> (cc'd) would probably know more.
>
> -Peff
>

ahh cool..
I'll have a read on this in the
morning(late now)and see if I can do this
to find the bug.(keep in mind might take
some time i.g. not good at using git,
but am willing to learn a thing or two).

Justin P. Mattock
