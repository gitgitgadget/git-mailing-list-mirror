From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC] Pinning of submodules
Date: Sun, 6 Sep 2015 19:43:35 -0400
Message-ID: <CAPig+cRwAjTF6_rT8+nhbsZTYcZqneWSZ_LTCo9z2m5+SEGwWg@mail.gmail.com>
References: <55E78522.1030107@gmail.com>
	<55E78780.2040801@gmail.com>
	<CAPig+cQ6Ls1iasVsTwbpqGWt9=7gBuWjWAPmSMJCStsdPUwCgg@mail.gmail.com>
	<55ECB956.1080909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Mark Levedahl <mlevedahl@gmail.com>
To: Anders Ro <anders.ronnbrant@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 01:43:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYjb3-0002NQ-1D
	for gcvg-git-2@plane.gmane.org; Mon, 07 Sep 2015 01:43:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950AbbIFXnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2015 19:43:37 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:36061 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722AbbIFXng (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2015 19:43:36 -0400
Received: by ykcf206 with SMTP id f206so66543442ykc.3
        for <git@vger.kernel.org>; Sun, 06 Sep 2015 16:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=bkqfqRHW2eNKE5vrzlkVDlOipb/OdJJrmt8BjAO5YCg=;
        b=hsMlJV/g2/bMshVPcVcbgztdcbzZO++HXclyT4FzFM5ZJeQ3HzxZl0W/+UsKlKimPU
         2w4u+2ipAAMqdvOQ5i/CdjB0hL+LcgZiEwG+qtoLgLWcftJkGW/kkXIXgbiV4DnAfc48
         mremhq/HQPTX9A8oYnQKsEMvPWLaFvRIX6321cSve9gpL1WhdNd8yMn+hUU3ueC9wnFK
         g+SaWPxQ/cJS4BRiggudHbDrj0E/BE4TWkyxRrviO0dOAI2quglSNkBshWXlp6YnVuMt
         vbBQx4bp/xHNOlQdwuCShGvtVsXkjJvnWxvbpg4ZDdINNGU1Ak/K8xo1paUNdVh9xehU
         DJFw==
X-Received: by 10.170.138.214 with SMTP id f205mr17245798ykc.84.1441583015715;
 Sun, 06 Sep 2015 16:43:35 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Sun, 6 Sep 2015 16:43:35 -0700 (PDT)
In-Reply-To: <55ECB956.1080909@gmail.com>
X-Google-Sender-Auth: V2B3v-Tkr7lYjxePBPKZNSHjYE8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277441>

On Sun, Sep 6, 2015 at 6:08 PM, Anders Ro <anders.ronnbrant@gmail.com> wrote:
> On 04/09/15 07:02, Eric Sunshine wrote:
>> On Wed, Sep 2, 2015 at 7:34 PM, Anders Ro <anders.ronnbrant@gmail.com> wrote:
>>> git-submodule.sh: pin submodule when branch name is '@'
>>>
>>> Setting branch name to '@' for a submodule will disable 'git submodule
>>> update --remote' calls for that specific submodule. I.e. instead of
>>> follow the unspecified default choice of master, nothing is being
>>> updated. This is useful when multiple submodules exist but not all
>>> should follow the remote branch head.
>>
>> With the disclaimer that I'm not a submodule user (to which the
>> answer might be obvious): What benefit is there in using a magic
>> value like this ("@") over, say, an explicit configuration setting?
>
> From what I have understood (not a submodule expert yet) the '@' is an
> invalid branch name and should therefore not collide with any current
> branches. My idea was to disable the '--remote' option when the user
> have explicitly set an invalid branch name to not modify any current
> behaviour. Though having an explicit option is of course more
> clarifying. The current behaviour though is that empty branch name means
> "follow master" which is somewhat unintuitive.

My concern in asking was that some future person might come up with
another scenario which also wants to use a "magic value" and would
have to invent / arrive at another "illegal" representation. Hence, an
explicit setting might be more appropriate. However, as stated, I
don't even use submodules, so I may be far off the mark. I've cc'd a
few of the submodule maintainers with the hope that they will chime
in.

>>> +test_expect_success 'set branch name to "@" for submodule pinned' '
>>> +(cd super && git config --replace-all submodule.pinned.branch "@") &&
>>> +test "$(cd super && git config --get submodule.pinned.branch)" = "@"
>>
>> What is the last line testing? It appears to be testing the behavior
>> of git-config, which is outside the scope of this test script.
>>
>> Once combined, you can use test_config rather than git-config, since
>> test_config will ensure that the config setting is undone when the
>> test exits.

In light of this recent thread[1] which shows that
test_when_finished() and, consequently, test_config() are
non-functional in subshells, I have to retract the advice to use
test_config() in this situation. Instead, at this time, it probably
would be best to continue using "git-config" as you do here...

>>> +test_expect_success 'remove branch name "@" for submodule pinned (unpin)' '
>>> +(cd super && git config --unset-all submodule.pinned.branch) &&
>>
>> If you take the above advice and use test_config in the previous
>> test, then this won't be needed.

and "git-config --unset-all" here.

Later, once [1] has landed in "master" (or perhaps "next"), this can
be revisited and updated to use "test_config -C"[2].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/277323/focus=277370
[2]: http://thread.gmane.org/gmane.comp.version-control.git/277323/focus=277372
