From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 10/16] worktree: make branch creation distinct from
 worktree population
Date: Sun, 12 Jul 2015 08:20:20 +0700
Message-ID: <CACsJy8A8QkeFa3FyCkv8dp-J52NGGaN-AV3oG7W8tNtYqDO-cw@mail.gmail.com>
References: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com> <1436573146-3893-11-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Jul 12 03:20:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZE5wt-00023I-Dm
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jul 2015 03:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130AbbGLBUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 21:20:50 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:35794 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859AbbGLBUu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 21:20:50 -0400
Received: by iecuq6 with SMTP id uq6so216525948iec.2
        for <git@vger.kernel.org>; Sat, 11 Jul 2015 18:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gGVoqnMmAYpLYkESE6JQsPbiUjhuKrTQO/Dx8SGXHDU=;
        b=tIuBPM9DogRYIMd0ndiCc8VOyaj1B7X1Uz0q+BQwN1c0KcYF2TuCpr/UhtG6SXXVfS
         v7C5r0HKOR8TW6M5bOoV691iVefcweLBS8NOpfEsMmfB16Uk1FVhH6GZOCOoJafDLo1z
         Uvvc4/ouek2zfy29DZWa1u9CQweCjr1CRhHGwKZVF77HhXiiaJ0PmiDc7QVfZMHLC0mf
         VJHTcv3KiFCcNl+tcmCkTwNiUGsZCWYYhJBoUEOWUEjhLTqXx6c28dOwqZw5AghWkxPv
         RKu29uqGDq7OlKYxxzVRNR5lWU8fMGv0G81VxoinWyepTgA4TFkWCrdjd1k6XcuuU5Na
         s5vg==
X-Received: by 10.107.134.22 with SMTP id i22mr11586299iod.111.1436664049403;
 Sat, 11 Jul 2015 18:20:49 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Sat, 11 Jul 2015 18:20:20 -0700 (PDT)
In-Reply-To: <1436573146-3893-11-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273879>

On Sat, Jul 11, 2015 at 7:05 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> The plan is eventually to populate the new worktree via "git reset
> --hard" rather than "git checkout". Thus, rather than piggybacking on
> git-checkout's -b/-B ability to create a new branch at checkout time,
> git-worktree will need to do so itself.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>
> I considered calling branch-related API, such as create_branch(),
> directly, however, git-branch provides extra value which may be useful
> in the future (such as when --track and --orphan get added to
> git-worktree), so it seemed wise to re-use git-branch's implementation
> rather than duplicating the functionality. If this proves the wrong
> choice, then the series can either be re-rolled or follow-on patches can
> address the issue.

I don't know much about ref handling code (especially after the big
transaction update), so i may be wrong, but do we need to invalidate
some caches in refs.c after this? The same for update-ref in the other
patch. We may need to re-read the index after 'reset --hard' too if we
ever need to do touch the index after that (unlikely though in the
case of 'worktree add')
-- 
Duy
