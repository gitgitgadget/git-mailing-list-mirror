From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: A few "linked checkout" niggles
Date: Fri, 17 Jul 2015 13:02:57 -0400
Message-ID: <CAPig+cRSHwmmF9cCUbRrDCCW4kvg9PeOUxP5VQpSGfxzMxHWOQ@mail.gmail.com>
References: <xmqqoajdui8w.fsf@gitster.dls.corp.google.com>
	<55A8F4B1.9060304@drmicha.warpmail.net>
	<CACsJy8BZEhMJPdw4K_kihA1kTPBVsAt=zW-cemzO7V+xfDih8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 19:03:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZG92N-0001Z5-Ko
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 19:03:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754827AbbGQRC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 13:02:59 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:33148 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753102AbbGQRC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 13:02:57 -0400
Received: by ykfw194 with SMTP id w194so14236269ykf.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 10:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=niO1faxuC8zclaM+1rjaSvmj8dYu/2sDo8HBAg4ML+U=;
        b=BqBW5C0SINcZIboVUyq0B1YYgSi9KtO8z3dE0LEQgnITN1IpJq5tVl7LDCQ0ARGXR7
         JmJsiWzSwmdjd/y5DFvdW7F8JWp6BB5bTJMXyWj+2fHu8cEr+jV9aAI3VRTf0FGknFC3
         YGDid1O8cQT5KuNNkmWEw5PHidVGTRzDhm+9q3KT5DV16wvCMmkAtghiHJ/MpVZaWBEO
         hG+SHYZmM+euDJUdSxBBTPEqf5Ebnc0pHTV7vLYd4pu20lnAfP+Fj4DNkmKK0r5XBNbe
         ocnsv+3Tj/TrP5EY0C70f4gRu5iqYjivpTzqn1z1U99azsDv0L/gT+h3o4aQeZrn3w+Y
         qDew==
X-Received: by 10.170.196.4 with SMTP id n4mr16272682yke.127.1437152577153;
 Fri, 17 Jul 2015 10:02:57 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Fri, 17 Jul 2015 10:02:57 -0700 (PDT)
In-Reply-To: <CACsJy8BZEhMJPdw4K_kihA1kTPBVsAt=zW-cemzO7V+xfDih8Q@mail.gmail.com>
X-Google-Sender-Auth: CxRXuoqHwyC14R7Ed7FJ7GneY5M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274083>

On Fri, Jul 17, 2015 at 8:49 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Fri, Jul 17, 2015 at 7:27 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Two more observations:
>>
>> $ git worktree add /tmp/gitwt
>> Enter /tmp/gitwt (identifier gitwt)
>> Switched to a new branch 'gitwt'
>>
>> Now I'm in /tmp/gitwt at branch gitwt. Right? No. I'm in the original wd
>> at the original branch.
>>
>> So either we cd to the new location or quelch these messages or add a
>> message that we're actually back.
>
> s/Enter/Preparing/ ?

Presumably you're using 'master'. The "Switched to a new branch"
message is an artifact of using git-checkout for the back-end
operation, however, what is queued in 'pu' no long uses git-checkout
at all, so that message is gone.

I agree with Duy that s/Enter/Prepare/ would be a good idea. I don't
think we want to drop the message altogether as Junio suggested since
other messages such as "Checking out files:..." and "HEAD is now
at...." follow it, thus "Prepare..." provides context indicating that
those additional messages apply to the new worktree rather than the
current one.

>> The other:
>>
>> linked worktrees are prefect for short term tests on detached heads.
>> Even the manual page advertises detach. But:
>>
>> $ git worktree add  --detach /tmp/gitwtt
>> Enter /tmp/gitwtt (identifier gitwtt)
>> fatal: '--detach' cannot be used with '-b/-B/--orphan'
>>
>> Maybe it's the auto-naming logic stepping on detached toes ;)
>
> Problem with master (but not with pu) because "-b gitwtt" is
> automatically added. I think this is 1eb07d8 (worktree: add:
> auto-vivify new branch when <branch> is omitted - 2015-07-06)
> forgetting about --detach. Actually it's still a problem with 'pu'
> because the branch 'gitwtt' is created unnecessarily.

Yep. Again, that fatal error is an artifact from git-checkout being
used as the back-end on 'master'. What is queued on 'pu' doesn't fail,
however, as Duy notes, the auto-vivication incorrectly kicks in and
creates a new branch unnecessarily. That'll have to be fixed in v3.
