From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v8 39/44] refs.c: move the check for valid refname to lock_ref_sha1_basic
Date: Thu, 22 May 2014 10:57:23 -0700
Message-ID: <CAL=YDWk5EbkLy7Jd2Mv6-rRKry=6dqgoSqjFj0ZHaWw4xR-_MA@mail.gmail.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<1400174999-26786-40-git-send-email-sahlberg@google.com>
	<20140522014242.GO12314@google.com>
	<CAL=YDW=fqDFFMomX-GDyANsABz6E5zww+JKgD6V0A+mc6Ja96g@mail.gmail.com>
	<20140522174427.GP12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 22 19:57:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnXFC-0004hT-Ox
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 19:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbaEVR50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 13:57:26 -0400
Received: from mail-ve0-f170.google.com ([209.85.128.170]:57231 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbaEVR5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 13:57:24 -0400
Received: by mail-ve0-f170.google.com with SMTP id db11so4884341veb.15
        for <git@vger.kernel.org>; Thu, 22 May 2014 10:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5lf5E+k76K51CT2vwIKl7TcIN0CQxGAYrKEXd6eIDNQ=;
        b=lN8c+bPeICkMvs6fuPAQ8wT2WmfrGjhs+gYw8URZqbKd+s9D2gMgBInTEyQtlVji9C
         ICG3vq3oXR7H7pcjkKQGRkfUhAqAcPHozExPkGR/v5VNYO74KEsBLaVdAVcqtyWORgj9
         2yxLDmeOb+8SX2MNQF7FV+26zeTaTJtCGiHr14D5wB9OkdZV/6rKaCJNZmZuVyzOMxwk
         87wFJAkC2f5A5G52tk18uxUsSnhdnYMHycoqIyBQLaT3VfL4UvLwwo3lZrhozFbiZNlR
         ODi1qkCqXkPyzjDr9Fa8+obMXMakqwN6FtboUixE61SdRNdg02kzVcPI1lBCw1ltl2Iy
         9rsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=5lf5E+k76K51CT2vwIKl7TcIN0CQxGAYrKEXd6eIDNQ=;
        b=g80Ltu4OhbyILepPa5+0fl8OlwEsHtrNtdfI+t8y3sfC6MUitpZuFCGqzfmIH/m6P8
         CBnq+NEkvjqTp8CtBqCA2JEGAFYsdWjC4Nwn2+Pt79+TrV9Fg0KYD3zM2DDCUS9/d/Kd
         wqbkMHprtFpgltdgGkXntFxOIv4KiZ7lbBNodxd6Zzt+cBFW1VHl5YS1qTdZa+CPqGm+
         JCbjg2JYQayPIXT4GKyrGpB0QSsc/p86hTPC4iE0YBdVkU7e/0eparCsB+C9TaNqr+m/
         K7uB2LIGU/6mzB6Lj9dv3XXul6C1r6Dz1Wmt4VcYQQkyQy9AHsrRa5ksUrR+mdEt1Lth
         Wgyg==
X-Gm-Message-State: ALoCoQnSNerU1vqPC0J2cO1zYlLzcTvUbchJgy3E9deS/76m+alHVcg+WCyceZ5bBts1AsdfJuIM
X-Received: by 10.52.136.98 with SMTP id pz2mr1492470vdb.70.1400781443350;
 Thu, 22 May 2014 10:57:23 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Thu, 22 May 2014 10:57:23 -0700 (PDT)
In-Reply-To: <20140522174427.GP12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249924>

On Thu, May 22, 2014 at 10:44 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>> On Wed, May 21, 2014 at 6:42 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>
>>>         $ git rev-parse HEAD >.git/refs/heads/foo..bar
>>>         $ git branch -m foo..bar something-saner
>>>         fatal: Invalid branch name: 'foo..bar'
>>>
>>> "git branch -m" has an explicit codepath ("recovery = 1;") to handle
>>> this case, but it looks like it was not well tested and regressed in
>>> v1.7.8-rc0~19^2~7 (resolve_ref(): verify that the input refname has
>>> the right format, 2011-09-15).
>>>
>>> Is what the recovery codepath of branch -m does misguided?
> [...]
>> I don't think we should allow external caller any other way to
>> access/modify refs than through
>> the transaction api. This may make it awkward to handle cases such as
>> foo/../bar was created  and how would you now delete it ?
>>
>> The exception to this I think would be 'git fsck'. We could allow fsck
>> to have low level access to the backing store and allow it to access
>> the files directly,
>> or allow fsck to set magic flags that disable various checks.
>
> Interesting.  Do you mean that 'git fsck' should notice invalid refnames
> and have an option to repair them on its own?

I think that would be useful.
But it would prompt the user before it does any changes. Even for a
fsck it would be rude to do any changes without asking the user.

'.git/refs/heads/foo^G^G^G.........bar' it not a valid ref.
[s kip] [d elete] [r ename] ?


>
> That would be a big change from what git fsck currently does --- it's
> currently read-only (except for "fsck --lost-found", which is read-only
> except in the .git/lost-found/ directory).  If there's an option to
> check refnames only and not have to wait for the full check of all
> objects then I think it makes sense.
>
> In the meantime, 'git branch -m' and 'git update-ref -d' (which were
> the historical ways to do this kind of repair) are already broken, so
> at least this patch doesn't seem to make anything worse. :/  (I
> haven't checked all callers, though.)
>
> Jonathan
