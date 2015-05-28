From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] git-am: add am.threeWay config variable
Date: Thu, 28 May 2015 10:57:31 -0700
Message-ID: <xmqqy4k8h9f8.fsf@gitster.dls.corp.google.com>
References: <1432675975-11020-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1432675975-11020-3-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<CACRoPnSnwA5GcYZjHHTepz4WzXYuJ+9nJqGsL92r_vnsNrN_-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 28 19:57:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy23p-0006vF-AL
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 19:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754448AbbE1R5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 13:57:38 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:36748 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754422AbbE1R5d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 13:57:33 -0400
Received: by igbpi8 with SMTP id pi8so118555080igb.1
        for <git@vger.kernel.org>; Thu, 28 May 2015 10:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=5DYMq5khvWedapkx6fCMv//k7Wpjb2B1TcPenSQvR1c=;
        b=LbOkkxx/g7QRqBAcpsd+rOVK4rWJqQ6rU+v2TUZuFlulaE0wmwC8RHWE9Ayi5Zw9wS
         iV7fgJ+fwIY6MFMeAKryvJ9cTQPArtaQFx2reUhRnww6yWQEQSdoS/d7pzD+ljTZWoro
         t6cdwcteR4twBHOu7gz356+m9fb5danyFm2Bypb3FBBCwCSBZnX1QKUHlWNNGDVV8ne9
         tU9bpeCi32LGg2VvRaxilclXNq+FosZM63S7DoAFAYv4QvFpvFAa2hmaio34OIaL93dN
         UESXStt97+TUh+07Xr8R2aRRKix3Bl7A9vqv/coD9oxtzggr2uh3aQhUMnB/2U1+SRer
         7ZFA==
X-Received: by 10.50.61.200 with SMTP id s8mr41005921igr.7.1432835853065;
        Thu, 28 May 2015 10:57:33 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:91c7:752b:4513:7344])
        by mx.google.com with ESMTPSA id w4sm2595779igl.22.2015.05.28.10.57.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 28 May 2015 10:57:32 -0700 (PDT)
In-Reply-To: <CACRoPnSnwA5GcYZjHHTepz4WzXYuJ+9nJqGsL92r_vnsNrN_-w@mail.gmail.com>
	(Paul Tan's message of "Thu, 28 May 2015 21:47:47 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270172>

Paul Tan <pyokagan@gmail.com> writes:

>> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
>> index 0d8ba48..3190c05 100644
>> --- a/Documentation/git-am.txt
>> +++ b/Documentation/git-am.txt
>> @@ -89,11 +89,13 @@ default.   You can use `--no-utf8` to override this.
>>         linkgit:git-mailinfo[1]).
>>
>>  -3::
>> ---3way::
>> +--[no-]3way::
>
> There's no need to mention --no-3way,...

Actually, we prefer to do it this way:

	-3::
	--3way::
	--no-3way::
		Describe what --3way does here.


$ git grep -e '^--no-' -e '^--\[no-\]' Documentation/




>>         When the patch does not apply cleanly, fall back on
>>         3-way merge if the patch records the identity of blobs
>>         it is supposed to apply to and we have those blobs
>> -       available locally.
>> +       available locally.  `am.threeWay` configuration variable
>> +       can be used to specify the default behaviour.  `--no-3way`
>> +       is useful to override `am.threeWay`.
>
> Usually configuration settings are mentioned in a separate section in
> the documentation "CONFIGURATION" (or not mentioned at all).

I can go either way, actually.  But if the description mentions
am.threeWay as a way to tweak the default, it also should spell out
the default when the configuration is not there at all.

> Also, there's no need to mention that --no-3way can be used to
> mention the configuration, as its usual (and expected) that the
> configuration value sets the default behavior, and the
> command-line switch can override i.

Yes.  Also --3way is useful to override `am.threeWay` set to `false` ;-)

> To end off, some off-tangent issues that are not related to the patch
> series in question, but since I'm looking at git-am.sh....
>
> I've noticed that in the block above that initializes all the variables,
>
>     sign= utf8=t keep= keepcr= skip= interactive= resolved= rebasing= abort=
>     messageid= resolvemsg= resume= scissors= no_inbody_headers=
>     git_apply_opt=
>     committer_date_is_author_date=
>     ignore_date=
>     allow_rerere_autoupdate=
>     gpg_sign_opt=
>
> threeway is not initialized at all, and thus I think running
> "threeway=t git am blah" will affect the behavior of git-am.

Correct.  I overlooked this when I originally did threeway.  Perhaps
a preparatory bugfix patch is warranted before this one.

> Also, I noticed that we do not check for --no-interactive,
> --no-signoff, --no-keep, --no-whitespace, etc.

Even though adding support for them would not hurt, lack of these
are OK, as long as we do not have configuration variables to tweak
their defaults.
