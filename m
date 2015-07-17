From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 14/22] worktree: add: suppress auto-vivication with
 --detach and no <branch>
Date: Fri, 17 Jul 2015 19:20:40 -0400
Message-ID: <20150717232040.GA85140@flurp.local>
References: <1437174017-81687-1-git-send-email-sunshine@sunshineco.com>
 <1437174017-81687-15-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 01:20:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGEw0-0001s2-KC
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 01:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300AbbGQXUs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 19:20:48 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:35572 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170AbbGQXUr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 19:20:47 -0400
Received: by igcqs7 with SMTP id qs7so47935009igc.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 16:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qu32vFM/xu7Zrluxq5AQB4Y7JsI0ls+qretC7VfnKlU=;
        b=Fs5J7+4YE2SL+ewCISyJH5nKPISoV9NW0c0FkCoG3g5KIw7u0hQFFqDD/PeRFHvIc+
         mKnKhVBqRd8IsfxQS2ieLt01rV+jlHV6jpr4OTjkNz7NcMeAAkq5aPhJf43rnRAr1lYt
         TACbQVX/smFH3yePDSJ6n8NEv8Cd0tlwiISCEI5Sqq7/+QHIWjcOStNHHRgJBQkJL2Tp
         X37JMVmH1/quY8j9tyQnJ+yDvha+dIqJqzV6myzrtvLexbUgCekosfN545jp+i6FThib
         HtK1O+MQmxPMgofIS1Tsv9/106SQhgBlDGY25R6KwpfjjjGTK31H5UkLhPH+SWmzPbbJ
         olFw==
X-Received: by 10.50.225.40 with SMTP id rh8mr952026igc.39.1437175246790;
        Fri, 17 Jul 2015 16:20:46 -0700 (PDT)
Received: from flurp.local (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id o66sm8454449ioo.5.2015.07.17.16.20.45
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jul 2015 16:20:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1437174017-81687-15-git-send-email-sunshine@sunshineco.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274151>

On Fri, Jul 17, 2015 at 07:00:09PM -0400, Eric Sunshine wrote:
> Fix oversight where branch auto-vivication incorrectly kicks in when
> --detach is specified and <branch> omitted. Instead, treat:
> 
>     git worktree add --detach <path>
> 
> as shorthand for:
> 
>     git worktree add --detach <path> HEAD
> 
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  builtin/worktree.c      |  2 +-
>  t/t2025-worktree-add.sh | 14 ++++++++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)

I meant, but forgot, to include a documentation update with this patch.
Here it is as a squash-in:

---- 8< ----
From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 23/22] fixup! worktree: add: suppress auto-vivication with --detach and no <branch>

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-worktree.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index da71f50..834a61c 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -51,9 +51,9 @@ Create `<path>` and checkout `<branch>` into it. The new working directory
 is linked to the current repository, sharing everything except working
 directory specific files such as HEAD, index, etc.
 +
-If `<branch>` is omitted and neither `-b` nor `-B` is used, then, as a
-convenience, a new branch based at HEAD is created automatically, as if
-`-b $(basename <path>)` was specified.
+If `<branch>` is omitted and neither `-b` nor `-B` nor `--detached` used,
+then, as a convenience, a new branch based at HEAD is created automatically,
+as if `-b $(basename <path>)` was specified.
 
 prune::
 
-- 
2.5.0.rc2.378.g0af52e8
