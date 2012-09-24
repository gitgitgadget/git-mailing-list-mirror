From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: GIT_DIR vs. --git-dir
Date: Mon, 24 Sep 2012 14:41:28 +0700
Message-ID: <CACsJy8DHGtktnvvziA_+Fp6a4VFsE9_=zkWKNBJU7Ro_QO+==A@mail.gmail.com>
References: <5060097F.9050203@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Sep 24 09:42:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TG3JG-0005Rj-2h
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 09:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754801Ab2IXHl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 03:41:59 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:51494 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754169Ab2IXHl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 03:41:59 -0400
Received: by ieak13 with SMTP id k13so10140611iea.19
        for <git@vger.kernel.org>; Mon, 24 Sep 2012 00:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/fLcFBoPmFXazABKSQLkoV0tLyNlhhAXFfWCcm5QgKI=;
        b=Ls3WHocDG4Kkzf2S1EjYPUPedL2ubE2ljC4BtuqT4KEJsMjHNV+tLxhNVeZAeHI33Z
         kGtpnk9SxLke3bn9KFmyA0MrB5JRKAcPbSdiaSmYbAurrGzxNB1Zcw7F6Xs0pwLxv3Av
         6jaUQlfpafbI5tVKu/b29g2c/giLJK8bF8E59XzIRuPaiOJuzh+BhOsP6a9wicUfOfYH
         pjB6F5oZnYHvppTPexTT00nn3bNfdmJRgFMOKUiN5J4G9Fg9EGuRy6/oc3WK0y4Ut8e4
         5HxlIkVN/juQjhG2bzBkPQZyx9+JHWFewoxUr++2AoT5Vp1xhhvg0MRKDwoYlIC1x9uH
         lKrw==
Received: by 10.42.62.143 with SMTP id y15mr8888688ich.38.1348472518826; Mon,
 24 Sep 2012 00:41:58 -0700 (PDT)
Received: by 10.64.29.199 with HTTP; Mon, 24 Sep 2012 00:41:28 -0700 (PDT)
In-Reply-To: <5060097F.9050203@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206257>

On Mon, Sep 24, 2012 at 2:19 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> [mjg@localhost ~]$ GIT_DIR=~/.githome git rev-parse --show-toplevel
> /home/mjg
>
> [mjg@localhost ~]$ git --git-dir=~/.githome rev-parse --show-toplevel
> fatal: Not a git repository: '~/.githome'
>
> Huh?

The message looks pretty clear to me that ~ is not expanded.

> Ok, so most users probably would not try further and blame git, but:
>
> [mjg@localhost ~]$ git --git-dir=/home/mjg/.githome rev-parse
> --show-toplevel
> /home/mjg
>
> (All this is with core.worktree set to /home/mjg.)
>
> So, while I do understand that we don't expand '~' in any of these cases
> and it's only a matter of bash tilde expansion kicking in or not, we
> might want to do something about it. (--git-dir=$HOME/.githome gets
> expanded, as well, and --git-dir=.githome works from the appropriate cwd
> only).

"~" is a shell feature. Know your shell. If we make an exception for
--git-dir, we might have to support --blahblah=~/somewhere. That's a
lot of changes and we might mistakenly over-expand something. Users
running git on cmd.exe may get surprised that "~" is expanded. We
could print an advice "did you mean $HOME/.githome?". That could still
be a lot of changes, but it's no-op so less worries of breaking
something. I prefer doing nothing in this case.
-- 
Duy
