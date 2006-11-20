X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eran Tromer <git2eran@tromer.org>
Subject: Re: Feature request: git-pull -e/--edit
Date: Mon, 20 Nov 2006 15:42:13 +0200
Message-ID: <4561B0B5.1020305@tromer.org>
References: <7vy7q67tf2.fsf@assigned-by-dhcp.cox.net>	<20061120024308.18620.qmail@science.horizon.com> <7v8xi67qhq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 20 Nov 2006 13:43:42 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061107 Fedora/1.5.0.8-1.fc5 Thunderbird/1.5.0.8 Mnenhy/0.7.4.0
In-Reply-To: <7v8xi67qhq.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31913>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gm9Qg-0006KZ-2V for gcvg-git@gmane.org; Mon, 20 Nov
 2006 14:43:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934165AbWKTNnR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 08:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934166AbWKTNnR
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 08:43:17 -0500
Received: from line108-16.adsl.actcom.co.il ([192.117.108.16]:46783 "EHLO
 lucian.tromer.org") by vger.kernel.org with ESMTP id S934165AbWKTNnQ (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 08:43:16 -0500
Received: from [192.168.4.6] ([192.168.4.6]) by lucian.tromer.org
 (8.13.8/8.12.11) with ESMTP id kAKDh6MA019169; Mon, 20 Nov 2006 15:43:07
 +0200
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 2006-11-20 05:21, Junio C Hamano wrote:
> linux@horizon.com writes:

>> (Indeed, it might be nice to come up with a way of including a piece of
>> the "please pull" e-mail, similar to the way that git-applypatch works.)
> 
> That is a lot more relevant example.  For example, I could
> imagine that Linus coming up with a wrapper that is fed a series
> of e-mails and:
> 
[snip]
>    - otherwise annotate the commit message with the explanation
>      of the series taken from the pull request message.
[snip]
>  - People can say "git pull -m 'I am doing this merge for such
>    and such reason' $URL $branch" to _include_ that message in
>    the resulting merge commit;
> 
>  - The same can be said about "git merge -m 'comment' $branch".


What about fast forwards? Do you get to record the explanation for the
series only if the guy you pulled from didn't bother to do a rebase?
That's broken.

Let's face it, the merge commits generated when pulling have two
completely independent uses:
1. They're technically necessary for joining DAG nodes that don't all
   lie on one path.
2. They're useful as a record of workflow and a place to put comments.

The two uses are nearly independent.
Consider the following silly DAG.

  A------------F master
   \          /
    B--C--D--E

Yes, E and F have identical trees. But it's actually *very useful*, if
the commit message at F says "merged branch foo containing experimental
bar from quux". And it shows up nicely when looking at gitk.

Of course, you could just fast-forward instead:

  A--B--C--D--E master

but then you lose a meaningful and useful part of the historical record.

There are the obvious bad consequences if you make this the default,
but how about adding a --force-commit option to merge and pull?

You'd need to educate users on how to use this responsibly to avoid
noise, but that's not any different from existing stuff like rebase and
revert. Most users won't even know it exists.

And to answer Linus: yes, it's expected that only non-leaf developers
will use --force-commit on regular basis, but that's not because
maintainers are technically special in any way. It's just because
maintainers have something useful to say ("someone's private topic
branch, starting at A and ending at E, has just been accepted into my
all-important public repo and here's why"). Anyone else can do the same
if he feels likewise.

