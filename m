From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: How can I automatically create a GIT branch that represents a
 sequence of tags?
Date: Sun, 11 Aug 2013 05:16:29 -0500
Message-ID: <CAMP44s1_rUVt9a6GbKFc7b0OjNtq4cZzSqC+i_s1k0x+Zs08UQ@mail.gmail.com>
References: <CAFw3YtRLgUGGn9JV5K3P9XtMBcBeO7=VSM7PekSxtW6xCsfZ1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Kristian Freed <kristian.freed@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 11 12:16:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8Shc-0007n4-Qd
	for gcvg-git-2@plane.gmane.org; Sun, 11 Aug 2013 12:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753017Ab3HKKQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Aug 2013 06:16:32 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:35976 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872Ab3HKKQb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Aug 2013 06:16:31 -0400
Received: by mail-lb0-f181.google.com with SMTP id o10so4095699lbi.26
        for <git@vger.kernel.org>; Sun, 11 Aug 2013 03:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=W/KzCbIy/hnHysfqy901ubrdc0S75K+BXyanNqUKUiM=;
        b=JgnCIf1BGFpaQuFTxA/G55wmDoUffvNA6M8hLKgeWqXZf3BO1seCUrt3SJUlhTVteJ
         MBZ+lU3FFHA9oEw1yTmEGlK+nLMTaGAdFeW/uvfISrx5V1i0F8yJTBrNg2LfMQO/K6iK
         icvf1YQiq/pdVk9d1HeC1XqrHHt5CFOfHSK67I5sxFlZVWMxlvDE81pA4USSwt0hdwAk
         UzDdEay9jqC+CpeAJK49k2FDWZU3P0AXAKTYuXsZPl0ZXDTK8k6CaupRyWpOE0aSvYjk
         CsCW/GnczkTB5+SVQjf5VsLrwr9n8VKOlq9XK7qc+LeclldUGWJv0tvUp6aaSfvqD8qO
         QjaA==
X-Received: by 10.152.9.233 with SMTP id d9mr9209960lab.33.1376216189413; Sun,
 11 Aug 2013 03:16:29 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sun, 11 Aug 2013 03:16:29 -0700 (PDT)
In-Reply-To: <CAFw3YtRLgUGGn9JV5K3P9XtMBcBeO7=VSM7PekSxtW6xCsfZ1Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232131>

On Sat, Aug 10, 2013 at 5:29 PM, Kristian Freed
<kristian.freed@gmail.com> wrote:
> In our current setup, we have automatic tagging in git of all
> successful release builds. This makes it easy to go back to stable
> points in history and compare functionality, check when bugs were
> introduced etc.
>
> To help with this process further, it would be useful to be able to
> use git bisect, but as these are just a sequence of tags, not commits
> on a branch, git bisect will not work as is.

Why don't you just do 'git bisect skip' if the commit doesn't have a tag?

> Is there any tooling for automatically recreating a branch from a
> sequence of tags, where each generated commit is the calculated delta
> between each two neighbouring tags?

That would probably involve listing the wanted tags:

% git log --topo-order --simplify-by-decoration --decorate --oneline

And then generating the commits:

% git cat-file -p v1.8.3 > commit
# modify commit's parent
% git hash-object -w < commit

-- 
Felipe Contreras
