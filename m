From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH] gitk: Fix how remote branch names with / are drawn
Date: Wed, 13 Apr 2016 07:35:58 -0400
Message-ID: <CANoM8SXixymz3=NQWgG5vSo7XDNh18_OzrNXU4+Y8CQ0LkB6sw@mail.gmail.com>
References: <1460512743-27100-1-git-send-email-odinguru@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: David Holmer <odinguru@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 13:36:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqJ64-0007kQ-PA
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 13:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760017AbcDMLgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 07:36:22 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:33313 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759978AbcDMLgT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 07:36:19 -0400
Received: by mail-io0-f175.google.com with SMTP id o126so66079147iod.0
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 04:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=30e3RUbVoEM81Zccy+VtPw9QHcq0wFQX82gCURRBjzk=;
        b=Fl/+RBPpPAOXTrlFYtUiXW0KyOXsyotU4fl5nKsVQtri5mdhgHaYsUWW8Q+6tuxsIB
         HkOlPrlhFdShrm1pzMFEz97xUgonZMDjr1OiRO95cE3LEOl4DtXZL2tswOvGSfGhf+6Y
         0zBhEAFEn8dsNIOHTVYnUfZ34ILsb21L0RNoa6558YJX/koJ8qDwvuBu1L8xGs2eonm+
         6g+h/9C/ZZbTSOFcX+CH9wFkhnPfa0omkBxT+gY1r9xTahbBRb/HgfQHYmJAEAtx6cs8
         v/SrW/pclfIKt7Nk3OcSk6MESBwtuzvKxMxhKJI1VUonHYSLCkJ/fJKDrIkD7kpRyUGG
         oX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=30e3RUbVoEM81Zccy+VtPw9QHcq0wFQX82gCURRBjzk=;
        b=m7NK83+xAdNjgc8f6nPeNf2ze5kRyJjUvrYjzHcvaYDNrBHq8jR9UIf/C7g9+U9TYy
         Kaxg03Umk0lp5sm0ajSGhkbOVH+qcWH09JY6Yf1ja+ypFfQ1E+4LiwX+1CIVPQGKDC0d
         8icFy9vcXMAIQc9bHFQ3wg89CFw2+ZJQtJ+NuZXMOlmQdSNiGH/S6LWQYA/laivor9UT
         Yw+E4wlyPNrQLykx2g1j6BxZmKv1ulGedYnEUJZ4Yqo8+5eUhU4oecWSTT/A/llF8dE7
         aFSqe/dBItGP+N984y9t6DWseoF8FG9aRrD8Ul7BLcbqq9O7z8tCE7Ansc2ymoTD8xs8
         bDjQ==
X-Gm-Message-State: AOPr4FUBGVHNaYr+vsYSGLMPGJv/f/T0t5UFqNdew0vI/KDkps/CMEumhI8PClgTqYavNERypnrYafdaShg4qw==
X-Received: by 10.107.19.104 with SMTP id b101mr8140876ioj.57.1460547378251;
 Wed, 13 Apr 2016 04:36:18 -0700 (PDT)
Received: by 10.107.7.193 with HTTP; Wed, 13 Apr 2016 04:35:58 -0700 (PDT)
In-Reply-To: <1460512743-27100-1-git-send-email-odinguru@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291390>

On Tue, Apr 12, 2016 at 9:59 PM, David Holmer <odinguru@gmail.com> wrote:
> Consider this example branch:
>
> remotes/origin/master
>
> gitk displays this branch with different background colors for each part:
> "remotes/origin" in orange and "master" in green. The idea is to make it
> visually easy to read the branch name separately from the remote name.
>
> However this fails when given this example branch:
>
> remotes/origin/foo/bar
>
> gitk displays this branch with "remotes/origin/foo" in orange and "bar" in
> green. This makes it hard to read the branch name "foo/bar". This is due
> to an inappropriately greedy regexp. This patch provides a fix so the same
> branch will now be displayed with "remotes/origin" in orange and "foo/bar"
> in green.
>
> Signed-off-by: David Holmer <odinguru@gmail.com>
> ---
>  gitk | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/gitk b/gitk
> index 805a1c7..ca2392b 100755
> --- a/gitk
> +++ b/gitk
> @@ -6640,7 +6640,7 @@ proc drawtags {id x xt y1} {
>             set xl [expr {$xl - $delta/2}]
>             $canv create polygon $x $yt $xr $yt $xr $yb $x $yb \
>                 -width 1 -outline black -fill $col -tags tag.$id
> -           if {[regexp {^(remotes/.*/|remotes/)} $tag match remoteprefix]} {
> +           if {[regexp {^(remotes/[^/]*/|remotes/)} $tag match remoteprefix]} {
>                 set rwid [font measure mainfont $remoteprefix]
>                 set xi [expr {$x + 1}]
>                 set yti [expr {$yt + 1}]
> --

This likely fixes the problem for most situations, but doesn't for a
remote with a '/' in the name.  Yet, I think this is a better state
than the present.

Is the regex `[^/]*/` more efficient than '.*?/`?  Or do you find the
former more readable?
