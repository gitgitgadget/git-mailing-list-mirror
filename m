From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 8/8] reflog_expire(): lock symbolic refs themselves, not
 their referent
Date: Fri, 13 Feb 2015 10:21:22 -0800
Message-ID: <CAGZ79kZpCjcGeifbLztpNUSq7-3Yy2_GEVPGEQsxrgoZfLFU+g@mail.gmail.com>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
	<1423473164-6011-9-git-send-email-mhagger@alum.mit.edu>
	<CAGZ79kaBGAOt-R1=mSG5H-5p=2UWjZEesktVwQcDAWFC-OW2Eg@mail.gmail.com>
	<xmqq61b8t65x.fsf@gitster.dls.corp.google.com>
	<CAGZ79kaaQWRXhph=0g3SRHKXMoW8eAp7QG21yuWXWd7OW4M+uA@mail.gmail.com>
	<54DCDA42.2060800@alum.mit.edu>
	<CAGZ79kZgjRNS3zd4Tif6M66mjkP6-tDpy4FAtio8jiwqHxUtgw@mail.gmail.com>
	<54DE259C.4030001@alum.mit.edu>
	<xmqqoaoxoffe.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 19:21:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMKro-0002A6-Ck
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 19:21:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332AbbBMSVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 13:21:24 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:42472 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153AbbBMSVX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 13:21:23 -0500
Received: by iecrp18 with SMTP id rp18so6108079iec.9
        for <git@vger.kernel.org>; Fri, 13 Feb 2015 10:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=XgptafaR9JT5tltKy7igRpL8vWwqQ4eU8w2IXksTANY=;
        b=oPCI8ZLHBS4nEd+x8WmGIu2s9hEQSgh4UZ9hgplfBcIPpaQpXtX5w4mBnPWQhzM+UH
         7IUbPhtv4kIFuFbhQQ8HeU0cb4lbeV6JF1CQfRysiEnBaAFXi5oqSMJYtDjf+l1mnwCL
         D3hywzTP1J/wTLNyFa/IosJFIl36ECsJVkQU/09HaHnL4sb2uLpPAJbAfw5rzrmx9OBh
         9/Q1Gd9Q2wkIZ/J/dq7aCIMxQDEHgHcHhuxcUYuSlwG9KgonBlMehOsYqrQkbT9237qK
         hi+9sq7shlomdJ2fySe0NJ2FQ1dPRUgyd9dYtv20w49her3QU1TIEKZFnG0kIEwPQ7tH
         gxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=XgptafaR9JT5tltKy7igRpL8vWwqQ4eU8w2IXksTANY=;
        b=PMOsjOr0fxghVATQz1nntcbJp7t70jlS6YBoEDjtw0LlNUzz03Shcl1D/VVMeL1D3I
         YT4fIwrejOxatpZZyM1PPaVFd5kcDqVsX5XT3u5VQsx2UH6Q9eoO6KmZNDVudGJnoNx3
         VCqctROBb0Bt1vYehEwgBnhhYvfEaPpcqXwgccKBs/S3MfO0w46co71CeGvozWQBE/Pc
         YWWQ1Tix8qmLSqTZU7b0rvoXPLvC1/+O1Y/SUluF/GlSglIIvWNQwTO3UlX1hBss+a2H
         2YK0a5fiYZY60CqbH+EvCUwcvVEL9adnTO1iJdT4cD0UmXiMaDBRVY+Sht8QHRslO6F+
         c32A==
X-Gm-Message-State: ALoCoQnsUT6BMRnOf/JTChALzECG7zoyy9CnDgRF/3i4IjXVQ2WLewGSfUhkAL1ev3xSUTGVpDAV
X-Received: by 10.50.85.44 with SMTP id e12mr5476998igz.48.1423851682455; Fri,
 13 Feb 2015 10:21:22 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Fri, 13 Feb 2015 10:21:22 -0800 (PST)
In-Reply-To: <xmqqoaoxoffe.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263817>

On Fri, Feb 13, 2015 at 10:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> I also realized that Git's current policy is probably not tenable if one
>> process is re-seating a symref at the same time as another process is
>> expiring its reflog. The "git reflog expire HEAD" might grab
>> "refs/heads/master.lock" then start rewriting "logs/HEAD". Meanwhile,
>> "git checkout foo" would grab "HEAD.lock" (not being blocked by the
>> "expire" process), then rewrite it to "ref: refs/heads/foo", then grab
>> "refs/heads/foo.lock" before updating "logs/HEAD". So both processes
>> could be writing "logs/HEAD" at the same time.
>> ...
>> Switching to holding only "HEAD.lock" while updating "logs/HEAD" is the
>> right solution,...
>
> We convinced ourselves that not locking the symref is wrong, but
> have we actually convinced us that not locking the underlying ref,
> as long as we have a lock on the symref, is safe?
>
> To protect you, the holder of a lock on refs/remotes/origin/HEAD
> that happens to point at refs/remotes/origin/next, from somebody who
> is updating the underlying refs/remotes/origin/next directly without
> going through the symbolic ref (e.g. receive-pack), wouldn't the
> other party need to find any and all symbolic refs that point at the
> underlying ref and take locks on them?

As we're just modifying the ref log of HEAD in this case, we don't bother
with where the HEAD points to. The other party may change
refs/remotes/origin/next without us noticing, but we don't care here as
all we do is rewriting the ref log for HEAD.

If the other party were to modify HEAD (point it to some other branch, or
forward the branch pointed to), they'd be expected to lock HEAD and
would fail as we have the lock?


>
> As dereferencing a symbolic ref in the forward direction is much
> cheaper than in the reverse, and because you need to dereference it
> anyway, I wonder if we want the endgame to be "hold locks on both",
> not "just hold a lock on the symlink".

That would be the safest option indeed.
