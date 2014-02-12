From: Stefan Zager <szager@chromium.org>
Subject: Re: Make the git codebase thread-safe
Date: Wed, 12 Feb 2014 10:12:20 -0800
Message-ID: <CAHOQ7J8gvwpwJV2mBPDaARu3cQ54-ZDQ6iGOwKuJRr9Z+XBL7g@mail.gmail.com>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
	<CACsJy8Bsc6sywL9L5QC-SKKmh9J+CKnoG5i78WfUbAG9BdZ8Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Zager <szager@chromium.org>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 12 19:12:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDeIO-0002de-KT
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 19:12:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753744AbaBLSMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 13:12:24 -0500
Received: from mail-vc0-f172.google.com ([209.85.220.172]:44299 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753721AbaBLSMV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 13:12:21 -0500
Received: by mail-vc0-f172.google.com with SMTP id lf12so7422671vcb.3
        for <git@vger.kernel.org>; Wed, 12 Feb 2014 10:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=H0sazK6rig2A2owtPMsVuvZ1qJRdyCNG+6yJJAqXhSw=;
        b=HDuNIwYhqEt7m2A3008zseyKZpL8/ppbChCkPgZEvOu6bwWp3D8F0GKkl4YrbVFs0k
         VTF0qgSwUDgdbWvjJse5PfVCqJMbY+Us6FpdBVbD4ctjINYlt6CmUdZvq2n0m/rRvNxL
         zxS43irZHUwecNlMuh3xgJ6lpKyMyQ2LQuL4oIQN9hYphVoIrEzwK3wy04sn5F/xijdG
         DVIlrMHcpGyYhLUFANqeO3H9B7con4qS1hj7WlpHBnTZxKs7nabuNeQpaEEjAwP0Y4MH
         Za7Bfg7mVFX6WpdRjBVHMWK9DnjJvGo3sNFVaB601g1ntXLESnFFGikkHkwZjpAu3uO6
         FVuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=H0sazK6rig2A2owtPMsVuvZ1qJRdyCNG+6yJJAqXhSw=;
        b=TG3YzfNUcAr4WOO34X19y+NLoQ1uC7wBbuuhlVf1qiweteUawGSKeaYJWAxek0RqHp
         6NrXrnyLvI/EgztQlmhwdYvqL51GfI5bU5k9FjOLingYuUiqwBRQkhQ3JcGNbw6yQChj
         /Hr6r5v+EvXItXPTMmYjZ3w//TbHnPxUWyCkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=H0sazK6rig2A2owtPMsVuvZ1qJRdyCNG+6yJJAqXhSw=;
        b=bbSrW2UUwsBCaX+IhUzp3kI6AQIEXQBpSiisbzqyfBVJnTRMTdGbkH3WaNpP9DHYK3
         /EjlD+CWLM7GWWDL7NaRhWf//80s5cP2WtRUEXZ75oHKQs6DuJ7gC5Ftv/m2ApwCJR46
         XsbIBOrO6Sr4CHtg5LP6hGm1k2yKjFwIi4/XPssKh9n+JGFnvuXGFkXp/2yRRPApsEvL
         2tUXR0SO30QfR8gAS4RJGFJr375QggycYVuHDE4Z9u9GxhBu0Lh7YWSmEWbJVvd5JGRt
         ext3HmS6ccZyw4IOPotXxodNcsBG7fknJnaorS6dZx52xIZsqVbLXyn+ogYBSSCJ18Oe
         Mspw==
X-Gm-Message-State: ALoCoQlhQyVABb1kF2DipdSgRGD+buo46YlQXPH1GdcXp1tiKuqcGXy4kZnEYly3g9l6krQzAGqaceA8zqVT0arLlY0JVNxBhK1iZPyrG1kVYWztpFnWJyYTT1iHITaFJPVTJIVOQfOD55ppKXc/fbuza9/udljSDS1rdxRxuiSqivLG2QcYpFFSd66i1BmuP8+C88+aCAms
X-Received: by 10.52.164.39 with SMTP id yn7mr13791437vdb.25.1392228740286;
 Wed, 12 Feb 2014 10:12:20 -0800 (PST)
Received: by 10.52.168.226 with HTTP; Wed, 12 Feb 2014 10:12:20 -0800 (PST)
In-Reply-To: <CACsJy8Bsc6sywL9L5QC-SKKmh9J+CKnoG5i78WfUbAG9BdZ8Rw@mail.gmail.com>
X-Google-Sender-Auth: T79SWiwteII4YHl7lcBpRdI8oRk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242000>

On Tue, Feb 11, 2014 at 6:11 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>
> I have no comments about thread safety improvements (well, not yet).
> If you have investigated about git performance on chromium
> repositories, could you please sum it up? Threading may be an option
> to improve performance, but it's probably not the only option.

Well, the painful operations that we use frequently are pack-objects,
checkout, status, and blame.  Anything on Windows that touches a lot
of files is miserable due to the usual file system slowness on
Windows, and luafv.sys (the UAC file virtualization driver) seems to
make it much worse.

With threading turned on, pack-objects on Windows now takes about
twice as long as on Linux, which is still more than a 2x improvement
over the non-threaded operation.

Checkout is really bad on Windows.  The blink repository is ~200K
files, and a full clean checkout from the index takes about 10 seconds
on Linux, and about 3:30 on Windows.  I used the Very Sleepy profiler
to see where all the time was spent on Windows: 55% of the time was
spent in OpenFile, and 25% in CloseFile (both in win32).  My immediate
goal is to add threading to checkout, so those file system calls can
be done in parallel.

Enabling the fscache speeds up status quite a bit.  I'm optimistic
that parallelizing the stat calls will yield a further improvement.
Beyond that, it may not be possible to do much more without using a
file system watcher daemon, like facebook does with mercurial.
(https://code.facebook.com/posts/218678814984400/scaling-mercurial-at-facebook/)

Blame is something that chromium and blink developers use heavily, and
it is not unusual for a blame invocation on the blink repository to
run for 30 seconds.  It seems like it should be possible to
parallelize blame, but it requires pack file operations to be
thread-safe.

Stefan
