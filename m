From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/PATCH] worktree: replace "checkout --to" with "worktree new"
Date: Tue, 30 Jun 2015 18:11:46 -0400
Message-ID: <CAPig+cT0a201MVTsvvLrndr40GsMkyvtao33Gt=AFhvShtr=Kg@mail.gmail.com>
References: <1435640202-95945-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 01 00:11:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZA3ku-00011o-JI
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 00:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372AbbF3WLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 18:11:48 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:34527 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087AbbF3WLr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 18:11:47 -0400
Received: by ykfy125 with SMTP id y125so22593516ykf.1
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 15:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=uBeOstLQ7EyI5AqXTTDJ6nixcf/F81rFOfQxKoLezC4=;
        b=hZycxlIqymp9Gu3MgXPN1lwePtUDDiu0Vryi7sRjX+ylk0RZSGQwwXjbklqTOwcZX5
         CxvjJJv/xUbxTlpGksOuLX3lxRFIkpvS5iUPRLyeCI2AQFNWeAUJ7SYn/GZ9su1hR33n
         MiECuMellDAaxQI6xu4hwa9Gx1sc5sc1K/PFLGCOh1pszGQoeL73jcu5BJ2VlmAjTZpw
         YCfmepnQI3aL2zw6RKfSQAEktzqyWyW2UniHKqgsRqX7R27dCida/rDRZ0MYIjRCjluJ
         ZJ8WEqj12HaCbZq+cb2csILsHXjYb1u20/63ejJrQwMoF7ppdQ/RmSae9lSJl1DwxP3l
         cjWg==
X-Received: by 10.129.91.135 with SMTP id p129mr28977629ywb.95.1435702306442;
 Tue, 30 Jun 2015 15:11:46 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Tue, 30 Jun 2015 15:11:46 -0700 (PDT)
In-Reply-To: <1435640202-95945-1-git-send-email-sunshine@sunshineco.com>
X-Google-Sender-Auth: 2R_pmnmb8Xq9hfOcJIDlfHwv3to
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273107>

On Tue, Jun 30, 2015 at 12:56 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> The command "git checkout --to <path>" is something of an anachronism,
> encompassing functionality somewhere between "checkout" and "clone".
> The introduction of the git-worktree command, however, provides a proper
> and intuitive place to house such functionality. Consequently,
> re-implement "git checkout --to" as "git worktree new".
> [...]
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
> This is primarily a code and documentation relocation patch, with minor
> new code added to builtin/worktree.c. Specifically:
>
> * builtin/worktree.c:new() is new. It recognizes a --force option ("git
>   worktree new --force <path> <branch>") which allows a branch to be
>   checked out in a new worktree even if already checked out in some
>   other worktree (thus, mirroring the functionality of "git checkout
>   --ignore-other-worktrees").

Speaking of "git worktree new --force", should we revisit "git
checkout --ignore-other-worktrees" before it gets set in stone? In
particular, I'm wondering if it makes sense to overload git-checkout's
existing --force option to encompass the functionality of
--ignore-other-worktrees as well. I don't think there would be any
semantic conflict by overloading --force, and I do think that --force
is more discoverable and more intuitive.
