From: Gavin Guo <tuffkidtt@gmail.com>
Subject: =?windows-1252?Q?Re=3A_How_to_fix_=93Your_branch_and_=27origin=2Fmaster=27_ha?=
	=?windows-1252?Q?ve_diverged=94_after_editing_a_commit_that_came_before_a_pul?=
	=?windows-1252?Q?l=3F?=
Date: Sun, 21 Nov 2010 22:45:13 +0800
Message-ID: <AANLkTikCnX5aBrmh9+wnb9JyOiynv0zhrpdMJwbhL2ji@mail.gmail.com>
References: <AANLkTikr+uGrO2EB9WQk+CXeOm7jiYxdbhGzRRvgc9B9@mail.gmail.com>
	<20101120043628.GB20725@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yang Zhang <yanghatespam@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 21 15:45:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKBAR-0005T7-HM
	for gcvg-git-2@lo.gmane.org; Sun, 21 Nov 2010 15:45:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753966Ab0KUOpQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Nov 2010 09:45:16 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51729 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543Ab0KUOpP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Nov 2010 09:45:15 -0500
Received: by bwz15 with SMTP id 15so5339714bwz.19
        for <git@vger.kernel.org>; Sun, 21 Nov 2010 06:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=emZGXgYdTUsigJ5/v2mY3Hp34z9SIxXePB7wETIu818=;
        b=kZOc33wkLMqM0pyR7KYFEB0iWeyCz9X5G35YqsWwT4NLkJUeuW8Rxijv2K6QC4yEC4
         zbEH1Hk17rHDjLhGrWGxwIFp8CCbsjiaxiaGh12hhDifiimNWM2KdcYhgAkA8hVzzqxw
         eCBuCZrBs/t5hpjKFd3nd3olvFl/ehI9gIipk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=e8j88BbfkPbFqh9Ae1/ggXdIOpG/+2G1eCfAmOjG9xi+XhiBiAKJR5GcurhBvK/TM7
         S7ToPkDI2aukVCo4v8AwWe4SOfRwZM1aQW/YzcupG0EDfpHAdif/S7Z+Vh/YksC28XQz
         urKcCV/fIOGwnvXZ6cc4qkgfB61g7qcKrgZuo=
Received: by 10.204.122.140 with SMTP id l12mr2489476bkr.157.1290350713759;
 Sun, 21 Nov 2010 06:45:13 -0800 (PST)
Received: by 10.204.123.69 with HTTP; Sun, 21 Nov 2010 06:45:13 -0800 (PST)
In-Reply-To: <20101120043628.GB20725@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161863>

> To fix it, what you want to do is recreate the history on top of B' a=
s
> it happened on top of B. So first you go back to C', the last commit
> just before the commits from upstream that were rewritten. (you will
> have pick its sha1 out of the log):
>
> =A0git checkout -b temp B'

I think you mean git checkout -b temp C'

> You should then have:
>
> =A0A--B'--C'
>
> on a temporary branch. Now re-pull from upstream (you could also
> manually rebase those commits, but this is probably simpler, especial=
ly
> if there actually was a merge):
>
> =A0git pull remote_name branch_name
>
> Note that you need to explicitly mention where you pulled from, since
> the temp branch will not be configured to pull in the same way (if yo=
u
> don't have any special config set up, it should be "git pull origin
> master").
>
> And now you have:
>
> =A0A--B'--C'--D--E
>
> at which point we can rebase the last bit of your branch on top:
>
> =A0git rebase --onto temp F'^ branch_name
>
> where "branch_name" is the name of the branch where this mess happene=
d
> (presumably "master"), and F' is the first commit that is worth savin=
g
> after you pulled from upstream. And that gives you:
>
> =A0A--B'--C'--D--E--F''--G''--H''
>
> where F'' corresponds to the original F, but actually has a different
> commit id (because of different parentage) than F or F'.
>
> At that point your original branch should be in the state you want. Y=
ou
> can delete the temp branch with "git branch -D temp".

I'm sorry that I can't understand "your original branch should be in
the state you want" ?
You only create a temp branch, and rebase some commits on it, right ??
What does that related to original branch ??

> So that's the most general way to do it. It's a little convoluted
> because of the way rebase works (you can't say "rebase those commits =
on
> top of me", but rather have to say "rebase me on top of these commits=
",
> which leads us to use the temporary branch).

Gavin Guo
