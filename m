From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH] rev-parse: fix --git-common-dir when executed from
 subpath of main tree
Date: Fri, 8 Apr 2016 08:35:51 -0400
Message-ID: <CANoM8SWCiJch-nXq=-=ELKOc6tV-TNg6U-hcc9W69Fz4rz+j+g@mail.gmail.com>
References: <1459734143-95832-1-git-send-email-rappazzo@gmail.com> <CACsJy8CgNy8+s0j+UUVVDk1ru702mtkTrO6QsYNpisGY-eAYGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 14:36:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoVe6-0001kN-Ju
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 14:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758267AbcDHMgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 08:36:13 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:35127 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756811AbcDHMgM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 08:36:12 -0400
Received: by mail-io0-f180.google.com with SMTP id g185so129895763ioa.2
        for <git@vger.kernel.org>; Fri, 08 Apr 2016 05:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cGPmJquZfT/euAhwaZRPMF7VV/Fy3WaeMcqZK+KjS8Q=;
        b=pRXD4yvaNgqErwJ4u8HMjpKcuaz3pcBJABCSSDP/0HaAdKn/smCJNyYMz+ZcNPAzCs
         dT2vNvwBISbdLXrTJB8yTPC7cJ6V0dpilhJIxau+AzuqtvdK9idjM80pEHjh2VENVZsL
         p2bTybgB7FHjRdw0P3blV6ewiL4i4VNpdTxeTh7UqWgepPC4KTFOwx6S7kjvsmaYD6W4
         HmLPZ9w+WR90xtDSamVQdOQz0rjGUKOo1CIgv9EM8gHz1o1ZkuppSZmkOLjyBWZDkrOW
         TpAgjyT32bGf4LVeHkPLz7uUZZ/2gVUH01HgjA7B7toLn8PV4se/AZa9G4JgK6705R6n
         NVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cGPmJquZfT/euAhwaZRPMF7VV/Fy3WaeMcqZK+KjS8Q=;
        b=LxXF5bzle6YxHsuUr2YwtzrSGUTEl5rN/KCjnbtIqdvC6Rsu5Ze9vhNgOywsQk2CLM
         d7v4Rhe0rihjc0drv85IThsd4rXhvsGyuHHGPJO+YQGChbUkidhifPB/uGF1xKNj2pM5
         DIE1ye+WB2F0Y6FwGbIrCmrVAQkJGmkJNga260j5hpMdpMdmhBzANT64dnsmyreCh3GX
         gx+MM/5Ka/KY6NcVv6fMygNDH9yceWpnMbcF2sBCTZibMO8ZWdqZBY1hVpTLBQRnVI11
         J2F4oSM0b16bXu+uNZe3zPDGUjGI6vWZDN0kXeZJbk8oJyggAuiumRv6bnB/XIPqRjEc
         zcVQ==
X-Gm-Message-State: AD7BkJK2z+DRAI1uOJPe7WY5Fa+Arpgk0I+fVHobmi1Y7iw93m0/2/QBapa0H87nHecWPykwye2i9gsJ5C0aLQ==
X-Received: by 10.107.136.140 with SMTP id s12mr10340491ioi.109.1460118970992;
 Fri, 08 Apr 2016 05:36:10 -0700 (PDT)
Received: by 10.107.7.193 with HTTP; Fri, 8 Apr 2016 05:35:51 -0700 (PDT)
In-Reply-To: <CACsJy8CgNy8+s0j+UUVVDk1ru702mtkTrO6QsYNpisGY-eAYGw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291030>

On Fri, Apr 8, 2016 at 7:47 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Apr 4, 2016 at 8:42 AM, Michael Rappazzo <rappazzo@gmail.com> wrote:
>> Executing `git-rev-parse --git-common-dir` from the root of the main
>> worktree results in '.git', which is the relative path to the git dir.
>> When executed from a subpath of the main tree it returned somthing like:
>> 'sub/path/.git'.  Change this to return the proper relative path to the
>> git directory (similar to `--show-cdup`).
>
> I faced a similar problem just a couple days ago, I expected "git
> rev-parse --git-path" to return a path relative to cwd too, but it
> returned relative to git dir. The same solution (or Eric's, which is
> cleaner in my opinion) applies. --shared-index-path also does
> puts(git_path(... and has the same problem. Do you want to fix them
> too?

Sure, I can do that.  I will try to get it up soon.
