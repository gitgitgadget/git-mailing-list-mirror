From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Git clone fails during pre-commit hook due to GIT_WORK_TREE=.
 (regression 2.5 -> 2.6)
Date: Tue, 1 Dec 2015 18:59:50 +0100
Message-ID: <CACsJy8A0WJYb7k6+JUOk9Y_hOMhinWP1T30GHG8fLqkmgMdbhQ@mail.gmail.com>
References: <CA+dzEB=2LJXiLSTqyLw8AeHNwdQicwvEiMg=hVEX0-_s1bySpA@mail.gmail.com>
 <CA+dzEB=XiGVFg+AhuJM-jUCPmgZKCJHTp3sinrFt8yzXeC_63Q@mail.gmail.com>
 <CAGZ79kY=t9SeoXjgeJjfCMD2=6g3JJxDxcnY6JeJCpUqaN+eOA@mail.gmail.com>
 <CACsJy8C7xoV9faGpbn_5XGt-CmCj--fgXaCFR-ngs=-pWUnrCA@mail.gmail.com>
 <CACsJy8Ciuirgk9D_fbQ5pgo-8u1AnM+zBdKUHcz_HLfRqM9QxQ@mail.gmail.com> <xmqqwpsz6y5b.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Anthony Sottile <asottile@umich.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 01 19:00:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3pEO-0005Dm-Hb
	for gcvg-git-2@plane.gmane.org; Tue, 01 Dec 2015 19:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756687AbbLASAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2015 13:00:45 -0500
Received: from mail-lf0-f43.google.com ([209.85.215.43]:35276 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756632AbbLASAW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 13:00:22 -0500
Received: by lfdl133 with SMTP id l133so19211630lfd.2
        for <git@vger.kernel.org>; Tue, 01 Dec 2015 10:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=i/lS4Zansxd3NisY+L5BN7j3T+7bSaOtpRbITlcvVYQ=;
        b=sdU3GZzlVjSGtHLueecsgml42lKm0yAaNFwYUFNVuuseb+/kw7LqnP25Nmk0yKOPhY
         EAGZMHVWShvXTQ80Q66mStdruSsJ1Su6p5VpykrK5E0uc0XhhWkY4gjsAyGXK7xI6klV
         0TBc1qJcSITVnhShQxzsRWP/Gl5cLWoOFoivavD8MYKTMezUV/BuCPQ/Q3iPKD2OqDzE
         vx2Qx/VofwxRf20hQXEw7j/bFHun5Q98MgXUNPQ2dqKbnw+RuAXttSs96Oqtn5YR0A4S
         Rda1n8xPjtrShOMIWzHIDY2ulokpiBDCAL+HSHMO09c/dz2R4eLktQF3V6e1LKT6cvP5
         BscA==
X-Received: by 10.25.168.6 with SMTP id r6mr30094583lfe.94.1448992820551; Tue,
 01 Dec 2015 10:00:20 -0800 (PST)
Received: by 10.112.199.5 with HTTP; Tue, 1 Dec 2015 09:59:50 -0800 (PST)
In-Reply-To: <xmqqwpsz6y5b.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281841>

On Mon, Nov 30, 2015 at 9:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> I was wrong, GIT_WORK_TREE support was added in git-clone many years
>> ago in 20ccef4 (make git-clone GIT_WORK_TREE aware - 2007-07-06). So
>> my change accidentally triggers an (undocumented) feature. We could
>> add a hack to ignore GIT_WORK_TREE if GIT_DIR is set too, but I don't
>> think people will like it. I don't really like reverting d95138e
>> (setup: set env $GIT_WORK_TREE when work tree is set, like $GIT_DIR -
>> 2015-06-26) because another bug reappears.
>
>> So I'm out of options..
>
> Perhaps d95138e can be reverted and then the bug it tried to fix can
> be fixed in a different way somehow?
>
> (I am not quite up to speed yet, so the above may turn out to be
> infeasible--take it with a large grain of salt please).

That would mean we do not set $GIT_DIR too early. While it sounds
good, it could be just another trap, and could be a lot of
reorganizing setup code. I'm more tempted to revert 20ccef4, with
deprecation warning for some releases, and a new git-clone option for
the same functionality. But let me sleep on it (and everybody please
give ideas if you have any). Meanwhile, maybe reverting d95138e should
be done any way for now. Broken aliases are not as bad as broken
hooks.
-- 
Duy
