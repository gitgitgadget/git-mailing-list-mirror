From: Matthew Rothenberg <mroth@khanacademy.org>
Subject: Re: PATH modifications for git-hook processes
Date: Wed, 15 Apr 2015 11:00:20 -0400
Message-ID: <CAKuTQSGapeUeZptdX1=Uv441Moo6X19RNR0oySU--F+Kj6Xz=w@mail.gmail.com>
References: <CAKuTQSGEmHHr-c+Tc2jM-JPkx6+_f3gp8Zjj8EuQy_e4=PvMzg@mail.gmail.com>
	<xmqqk2xe39zt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 17:00:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiOo9-0000JO-Bf
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 17:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754478AbbDOPAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 11:00:49 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:35526 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753586AbbDOPAr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 11:00:47 -0400
Received: by oign205 with SMTP id n205so25765166oig.2
        for <git@vger.kernel.org>; Wed, 15 Apr 2015 08:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=khanacademy.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=l/kclUF480MP2qjgERUofGwSj4cQqBF92rmJ7s7q3mY=;
        b=Kb9+/VU2tRNlZuPM9ArD/q+D8miV0IWhbaYR0RIv19oIfg3d0Gm/xIvefs4tO66jca
         GSOeRnRTIGpMixvW1lA1yXhOLpN3XD/+u6cdfnB66oOkXer8XfpsSOg4gC0CYQCh7B6C
         w8imx8SwUM8RyXq2QHdMhsuylI9I8U9TItay8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=l/kclUF480MP2qjgERUofGwSj4cQqBF92rmJ7s7q3mY=;
        b=aCmOCs7+IZ7YEAzo/LRKnJyV28aho+nEL1qtUwQAU5zbPjkzcWVWThendmBqDL16Kg
         sqRKwCWeiXA6ddM4LYxVBNeADpEVKZvBROpmi//JByBSlQdjP5d5G8UxkjFT0ITyNgfP
         0ZQao6UAOiXR7Qxg5xToTIETNBp6NSw9uo4Fn2JPC8+HqtlcLDKIS4P+EwYQ9D9T2Dbg
         tZYHTJttpMvcon79QIEGHhNZ1Wp+vff6GiElwAExW16dJql8fdB5vLpLGT7M0IAXRPCo
         xthVtgxE3aC4x+76/I+TutHzebM3h0+YEjHUDxx6C8AR/y2Y9EW8Q146iCv4ru2OeuOK
         IUnw==
X-Gm-Message-State: ALoCoQkf6Y8C1NN5qTUDjyoyFRhR853tpSDL0FyDy4j+UnzC2ZjR48rE1g8NTKmROmuCurVzOY3j
X-Received: by 10.182.153.4 with SMTP id vc4mr3486768obb.16.1429110020450;
 Wed, 15 Apr 2015 08:00:20 -0700 (PDT)
Received: by 10.76.112.37 with HTTP; Wed, 15 Apr 2015 08:00:20 -0700 (PDT)
In-Reply-To: <xmqqk2xe39zt.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267204>

Hmm, this all makes sense as to why it's happening, thank you.  In my
case the ` /usr/local/Cellar/git/2.3.5/libexec/git-core` (git
--exec-path) does give all the proper binaries and sub-binaries. It
shows up twice because the GIT_EXEC_PATH environment variable is used
too (which is the same in my case since it hasn't been overriden).
The /usr/local/bin therefore comes from **the path to the running
"git" itself**.

There still seems to be a potential issue I can't figure out how to
work around with this.  If **the path to the running "git" itself** is
in /usr/local/bin or some other common area, then that would still
always get prepended prior to external PATH -- which means **other**
external programs will inherit precedence overriding the system PATH
preferences.

For example, in our case, many scripts run in our specific Python
environment, which ala virtualenv is located in a user-specific path
(e.g. ~/.virtualenv/foo/bin/python), which appears earlier in the user
PATH so it affects all shell processes using `#!/usr/bin/env python`.
When a git-exec prepends /usr/local/bin, the system installed Python
is used instead.

There are other use cases I can think of that would cause this issue
as well -- user provides more recent version of "bazfoo" program in
~/bin which they prepend of their system PATH, git-exec then prepends
shared path of a system binary directory which also contains older
version of bazfoo, older version then gets used instead.

So, I guess what I'm looking for is:
  - A way to prevent the **path to the running "git" itself** portion
of setup_path from firing, (OR)
  - A way to specify (via env var?) paths that must remain in high
precedence even during a git-exec, e.g.:
      NEWPATH = [git --exec-path] : [GIT_EXEC_PATH] :
[$PROPOSED_HIGH_PRECENDENCE_PATH] : ['git itself' path] : [$PATH] (OR)
  - A way to refine git-exec default behavior to avoid this edge case
(my C is a little rusty but I'm happy to try to help out if we can
think of a good logic), (OR)
  - Something else clever I am not aware of.

Thanks so much for your assistance.

On Tue, Apr 14, 2015 at 1:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Matthew Rothenberg <mroth@khanacademy.org> writes:
>
>>  - what is the expected PATH modification behavior for subprocesses of
>> git-hooks? Is this documented anywhere?
>>  - what would be causing /usr/local/bin to be prepended here, and can
>> it be adjusted via preference?
>
> This is not limited to hooks and very much deliberate, I think.  In
> order to make sure anything that is called from "git" wrapper gets
> picked up from GIT_EXEC_PATH so that the matching version of the git
> subprogram is used, "git <cmd>" does this before running "git-<cmd>"
> (in git.c):
>
>         /*
>          * We use PATH to find git commands, but we prepend some higher
>          * precedence paths: the "--exec-path" option, the GIT_EXEC_PATH
>          * environment, and the $(gitexecdir) from the Makefile at build
>          * time.
>          */
>         setup_path();
>
> And setup_path() is defined in exec_cmd.c to start the new PATH with
> git-exec-path, and then the path to the running "git" itself, and
> then finally the external PATH.
