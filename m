From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/RFD 0/3] worktree.* config keys and submodule and multiple worktrees
Date: Mon, 9 Feb 2015 16:35:29 +0700
Message-ID: <CACsJy8D8Ur4W348t-WFUPrb7SQxmff5MJ4aRp+w+ZiQ7VVvipg@mail.gmail.com>
References: <1423401394-13675-1-git-send-email-pclouds@gmail.com> <54D79EAB.6060301@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Max Kirillov <max@max630.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 09 10:36:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKklB-0000Kx-NM
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 10:36:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760277AbbBIJgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 04:36:00 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:36027 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759875AbbBIJgA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 04:36:00 -0500
Received: by ierx19 with SMTP id x19so8639442ier.3
        for <git@vger.kernel.org>; Mon, 09 Feb 2015 01:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/9ETjA2xJ1nvN+Ha2ufdUBoZrWDnRFWWF55bxUZyWFc=;
        b=UF42NaIuHwWNtTme3hgW9oP6AIJq0RzvW8daxEbkydHNA+KDe6BaTKMzRC19dnRXLK
         IiSUnRPzV8B7In5DNxwEZPMRHObT8NbKMZqHdKi53xCbK1+EFsBEGBNq4DB2vS7uxqjH
         Oir4sir4cZ2ZZJqZhBaxvtq8Gvb0qno6+QsXjY5OxlFaEfxcXcBgLOi7MiU6+EPDGURc
         tLm4r3yRgB8be+wT1eHG7neaXzIVfKiid7ocQ9WVUJMlxihB2x3myoMUnCJ1Q0v+ivrl
         b4B6V14TjjKd8trCiDs/geV7SCdLgPT/4OQC4lGJ67X9dOgAuFM97OVjp865fn0b1oUU
         AP6w==
X-Received: by 10.50.107.36 with SMTP id gz4mr15871673igb.25.1423474559368;
 Mon, 09 Feb 2015 01:35:59 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Mon, 9 Feb 2015 01:35:29 -0800 (PST)
In-Reply-To: <54D79EAB.6060301@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263556>

On Mon, Feb 9, 2015 at 12:36 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> I wonder if it's worth all the hassle to invent new names. Wouldn't
> it be much better to just keep a list of per-worktree configuration
> value names and use that inside the config code to decide where to
> find them for multiple work trees. That would also work easily for
> stuff like EOL-config and would push the complexity in the config
> machinery and not onto the user.

It's certainly possible to relocate core.worktree to outside
$GIT_DIR/config. But I don't think it helps. If anything it'll make it
harder to distinguish the old setup and the new one. I think we need a
clear signal that will make old git barf on new setup, to be safe.
Maybe stepping core.repositoryformatversion, or breaking .git file
format when we switch to the new setup (with $GIT_COMMON_DIR).

Or.. perhaps we could use the old setup for "primary" worktree and the
new one for secondary worktrees of the same submodule. In these
secondary submodules, $GIT_COMMON_DIR is enough to make old git reject
them. And we could just reuse core.worktree, if we can make
core.worktree in $GIT_DIR/config.worktree shadow one in
$GIT_DIR/config..

Need to study git-submodule.sh some more..
-- 
Duy
