From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git log -p unexpected behaviour - security risk?
Date: Sun, 21 Apr 2013 09:09:39 -0700
Message-ID: <20130421160939.GA29341@elie.Belkin>
References: <CAHQ6N+qdA5Lck1_ByOYPOG4ngsztz3HQSw8c_U_K8OnDapj4bQ@mail.gmail.com>
 <20130420140051.GB29454@ruderich.org>
 <7vd2towdiq.fsf@alter.siamese.dyndns.org>
 <CAHQ6N+pKb-44rOM7ocYMvSDyimvAGZppX1Gc=st59aVKzJSBKw@mail.gmail.com>
 <20130421102150.GJ10429@elie.Belkin>
 <CAHQ6N+rXE42NOyQPfLiDN8jYfL8w06hEE5MFLeFNxMR4ORD0aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Simon Ruderich <simon@ruderich.org>,
	Git List <git@vger.kernel.org>,
	Tay Ray Chuan <rctay89@gmail.com>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 18:09:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTwpy-0002NH-Vo
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 18:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009Ab3DUQJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 12:09:53 -0400
Received: from mail-da0-f52.google.com ([209.85.210.52]:49196 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854Ab3DUQJw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 12:09:52 -0400
Received: by mail-da0-f52.google.com with SMTP id j17so379121dan.11
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 09:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=pSLvataf96CENkMVWAZY+g9x+wftYXaebRRJ67n6pXA=;
        b=roHxDD7SaaKZalAb4V5+A209fH3mPpE8Ohz5aG2VGM5lwWF5iy0b9/1UagbMfvqH4H
         sdHE7/tRybYgy7KyLD8BKT7WDtz3VHDqeSs8UizEUiLmmz12jYhT2K5/JKBQZ6NKO8yw
         5Brz4Asnd4rWUEyybebSGAGkogjotBk5BJAU0zYdjraKoj32qTMgHuQ/B1vPIZ6oljsB
         uLGK6DGAMOvSUv5qMPQ5d+9Ev7hWTO3u6Ye98uzkbXhKzgewe8pDsdqmAVzWPW2z/y3F
         VdLswyNzNcWa2+u0n6Oq8hzU1zol/UdUT41Hek4cuBeEVK10S9/+o/o0tyiySs7A3S0N
         KVyw==
X-Received: by 10.68.129.232 with SMTP id nz8mr28464699pbb.25.1366560591969;
        Sun, 21 Apr 2013 09:09:51 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ad7sm21444288pbd.14.2013.04.21.09.09.49
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 09:09:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHQ6N+rXE42NOyQPfLiDN8jYfL8w06hEE5MFLeFNxMR4ORD0aw@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221956>

John Tapsell wrote:
> Jonathan Nieder wrote:

>> If anyone relies on "git log -p" or "git log -p --cc" output to make
>> sure that the untrusted code they use doesn't introduce unwanted
>> behavior, they are making a serious mistake.
[...]
> You can't just push all the blame on the user for bad defaults.

The thing is, I'm not convinced this is a bad default.  "Shows no diff
at all for merges" is easy for a person to understand.  It is much
easier to understand its limitations than -c and --cc.  For that
reason, it is a much *better* default for security than --cc or -c
(even though I believe one of the latter would be a better default for
convenience).

I agree that this is an important documentation bug, since
introductory documentation does not explain clearly enough how
"git log -p" will act for merges.

>> A merge can completely
>> undo important changes made in a side branch and "-c" and "--cc" will
>> not show it.
>
> Wait, what?  This is getting even worse then!  Can you expand on this please?

If a given file matches one of its parents, there is nothing to show
in the combined diff format.  Otherwise every merge would have a very
long diff.

If what you really want is the diff against the first parent, you
can use -m --first-parent with -p.  If you want the diffs against each
parent, you can use -m -p.

[...]
>>  Unfortunately that doesn't protect you from
>> maliciously written commits that will be encountered when bisecting.
>> At some point you have to be able to trust people.
>
> Seriously?  Your reasoning for awful defaults is that you should just
> trust people?

I didn't set the defaults.  I'm explaining how the tool currently
behaves in response to your question.  A person can do many
unfortunate things if you blindly trust them and merge from them.

For example, whenever git adds (or plans) support for a new header
line in commit objects, before you've upgraded, a prankster can
provide a bad value for that header line in objects they hand-craft.
"git fsck" in your older version of git will accept the resulting
objects on the assumption that they came from a newer version of git,
so you won't notice.  Later you upgrade Git and "git fsck" considers
the objects malformed.  Clients with "[transfer] fsckobjects" enabled
start to reject your history.  That is, this person has made your
repository corrupt in the eyes of "git fsck".

The usual excellent integrity checking will let you pinpoint the
problem to the merge from that untrusted person so you can avoid
trusting them again, and all the data will be there to recover without
them.  So it is auditable later.  But this does mean that with the
current design, there is some level of trust required to let someone
commit into your history unless you inspect their work with a
fine-toothed comb.

All that said, if someone has ideas for improving git's support for
such inspection, that would be great.  "-c" just isn't it.  "-c" can
be a good tool for finding honest mistakes, but it doesn't protect
well against an adversary.

In the meantime, if you didn't intend to trust those people this much,
this might mean your procedures (and git's documentation, for the sake
of others in the same boat) need some changes.  Sorry to be the bearer
of bad news.

Hope that helps,
Jonathan
