From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Pinning of submodules
Date: Tue, 08 Sep 2015 09:55:49 -0700
Message-ID: <xmqq37yoam0a.fsf@gitster.mtv.corp.google.com>
References: <55E78522.1030107@gmail.com> <55E78780.2040801@gmail.com>
	<CAPig+cQ6Ls1iasVsTwbpqGWt9=7gBuWjWAPmSMJCStsdPUwCgg@mail.gmail.com>
	<55ECB956.1080909@gmail.com>
	<CAPig+cRwAjTF6_rT8+nhbsZTYcZqneWSZ_LTCo9z2m5+SEGwWg@mail.gmail.com>
	<55EDEFDC.3040605@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Anders Ro <anders.ronnbrant@gmail.com>,
	Git List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Mark Levedahl <mlevedahl@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 08 18:56:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZMBa-0000oq-Tt
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 18:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755327AbbIHQzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2015 12:55:54 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36384 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754727AbbIHQzx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2015 12:55:53 -0400
Received: by padhk3 with SMTP id hk3so43857498pad.3
        for <git@vger.kernel.org>; Tue, 08 Sep 2015 09:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=cLZloHqd789KuFGKvbvYz0S6Mj/yckG48X/yNmml+5k=;
        b=u2CiJHkwCXf9+gYbUvRSkUd/YFyCzxIT7L97BFVYLDT4fckNyErrL3VJxhkgFucTM7
         mnu+otXkLp4lGb6KxZ96I3ok7YoLqliL19C19K7perAzKhh1dT8V5F0poF3hV85q1DuP
         2Tunf+HFvdO8taXN/ObRLZbXlr76hsiZKB6FJCQbjMqq5+Ym7QPvNo7V7LYE6wFOh7UA
         4JgetlbHM/SZDc0M1OdNk937L/QKTVLNz1HPWjBCseWaPCtGPOCgN1hDjM3LH0/FsslJ
         pXcOyt9S8aDUV3g7kbqPRsps/ym1aFcZ3JgD7T6xqEEMzbIS++u2MZe29yyh6IUKRYcJ
         hi/A==
X-Received: by 10.68.192.225 with SMTP id hj1mr60133548pbc.67.1441731352633;
        Tue, 08 Sep 2015 09:55:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:40ca:ccb5:4636:e6d])
        by smtp.gmail.com with ESMTPSA id f10sm4039965pdk.20.2015.09.08.09.55.50
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 08 Sep 2015 09:55:50 -0700 (PDT)
In-Reply-To: <55EDEFDC.3040605@web.de> (Jens Lehmann's message of "Mon, 7 Sep
	2015 22:13:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277505>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 07.09.2015 um 01:43 schrieb Eric Sunshine:
>
>> My concern in asking was that some future person might come up with
>> another scenario which also wants to use a "magic value" and would
>> have to invent / arrive at another "illegal" representation. Hence, an
>> explicit setting might be more appropriate. However, as stated, I
>> don't even use submodules, so I may be far off the mark. I've cc'd a
>> few of the submodule maintainers with the hope that they will chime
>> in.
>
> Added Trevor to the CC, who is the original author of --remote (see
> 06b1abb5b).
>
> While I believe that adding such functionality makes perfect sense,
> I do not find it terribly obvious that setting the branch to '@' will
> make --remote skip this submodule. I wouldn't care so much if we'd
> only use this value internally, but this is user visible (and has to
> be set by the user if she wants to skip a submodule in --remote).
>
> Setting the branch to an empty value feels a bit more natural, but
> I'm not so sure our config handling supports that well (we seem to
> assume in quite some places that empty equals unset). So I tend to
> prefer a new option for that.

As I stare at both the code change and log message of 06b1abb5
(submodule update: add --remote for submodule's upstream changes,
2012-12-19), I cannot shake this feeling that the change to default
submodule.$name.branch to 'master' is doubly misdesigned.

The stated goal of users of --remote is to declare "This submodule
does not care what the top-level integrator happened to have seen at
the tip when the integration of the history of submodule.  It always
follows the tip of a specific branch at the upstream."

If we were to use any default, the only justification would be "the
users of --remote would want this mode of update to happen for all
submodules, and having to specify which specific branch to be
followed is too cumbersome".  But if that is the case, defaulting to
'master' does not make any sense---if it defaulted to 'HEAD' for
each submodule, it may have made some sense, as that is the usual
convention to denote which branch is the default branch in a
repository.

Also Anders' proposal refutes that "when --remote is used, all
submodules should behave that way" assumption.

I wonder if it is a sensible way forward to introduce a new
configuration variable 'submodule.remoteFallBackBranch' so that the
users can customize this line (near l.800 in git-submodule.sh)

     branch=$(get_submodule_config "$name" branch master)

The possible values for that new configuration value would be:

   - an empty string: disable "update --remote" for any submodule
     '$name' for which submodule.$name.branch is not set.

   - 'master': behave the same way as the current code; we can make
     this the default, when submodule.remoteFallBackBranch is unset,
     to ease transition.

   - any user-chosen branch name. On notable example may be 'HEAD',
     which 06b1abb5 (submodule update: add --remote for submodule's
     upstream changes, 2012-12-19) should have chosen as the
     default.

But I am not the target audience of "update --remote", so let's hear
what the real-world use cases are.
