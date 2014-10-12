From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: $GIT_DIR/info/exclude fails to negate a pattern defined by core.excludesfile
Date: Mon, 13 Oct 2014 06:53:36 +0700
Message-ID: <CACsJy8Aj-_VhiiG9ogoABaGs69TQ+HyEnOVb75UT53W5+YcKVg@mail.gmail.com>
References: <CAD03jn4md9YJZ3fFWmvjiO2KSztc-02QpznXO3LJeiZDz8YhrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git ML <git@vger.kernel.org>
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 01:54:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdSxp-0000Cl-0N
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 01:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752575AbaJLXyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2014 19:54:09 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:64564 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681AbaJLXyH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2014 19:54:07 -0400
Received: by mail-ig0-f179.google.com with SMTP id h18so8739165igc.0
        for <git@vger.kernel.org>; Sun, 12 Oct 2014 16:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YfrkVT0TcX4vi67wkDfuKNkq1t34iTh6/d7/3+YQUlI=;
        b=MV2IR1kzQdMM9HiH+1fqiskhb3KRJyp8NTKP1QU6mj2pf59nXiuVobJW+iqIvxH9Cr
         gxwevDOgxny+mYywpQFhUXhYZw7/3J3VxnJa60wTzF85C8Bsz5tq0W9XCRfS3014EdIC
         o/Y2WEji5MzN2Vf09Tk9KtfAmSDofAASjNyk51e6eFWG1dhe/RsigDqGkexnzau/G3NE
         HmWZtY36uCCh+8oaFAHWf/Vn5LGPp06PBW6PgpxG357QL1ImkFCt2+goao0lZlP4DkuU
         /W5f14xTR+kxCUhsW58gT/AzcmjcmO4J5UHRlNICRCXxw9x9lpQUFYxf2xwxni9iuGCq
         eSAw==
X-Received: by 10.42.62.6 with SMTP id w6mr32684605ich.24.1413158046506; Sun,
 12 Oct 2014 16:54:06 -0700 (PDT)
Received: by 10.107.131.1 with HTTP; Sun, 12 Oct 2014 16:53:36 -0700 (PDT)
In-Reply-To: <CAD03jn4md9YJZ3fFWmvjiO2KSztc-02QpznXO3LJeiZDz8YhrQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 12, 2014 at 9:58 AM, Dun Peal <dunpealer@gmail.com> wrote:
> I have the pattern `*.out` defined in my `core.excludesfile`.
> According to the documentation[1], patterns defined in
> `$GIT_DIR/info/exclude` take precedence over `core.excludesfile`, so
> for one particular project that needs to track some `.out` files, I
> created `$GIT_DIR/info/exclude` with just one pattern: `!*.out`.
>
> Yet for some reason, `git status` still fails to report newly created
> `.out` files for that project. Am I misunderstanding the
> documentation?

We process in groups, so rules in core.excludesfile are in one group,
those in $GIT_DIR/info/exclude in another group. Negative patterns
only has effects within their group, so !*out in .../exclude can't
revert *.out in core.excludesfile. Probably implementation limitation,
not by design..

But even if we flatten them into one group, i'm not sure you can
achieve that. The patterns would be

!*.out
*.out

"!*.out" has nothing to revert because it's before "*.out".
-- 
Duy
