From: =?iso-8859-1?Q?M=E5rten?= Kongstad <marten.kongstad@gmail.com>
Subject: Re: [PATCH v2] diff --shortstat --dirstat: remove duplicate output
Date: Sun, 1 Mar 2015 17:01:25 +0100
Message-ID: <20150301160125.GB5307@laptop>
References: <xmqqegp9gyof.fsf@gitster.dls.corp.google.com>
 <1425195546-15637-1-git-send-email-marten.kongstad@gmail.com>
 <54F2E931.7020200@web.de>
 <54F320E9.1000006@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	gitster@pobox.com, johan@herland.net, marten.kongstad@gmail.com
To: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 01 17:01:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YS6JC-0007mD-4d
	for gcvg-git-2@plane.gmane.org; Sun, 01 Mar 2015 17:01:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960AbbCAQBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2015 11:01:30 -0500
Received: from mail-la0-f44.google.com ([209.85.215.44]:37767 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421AbbCAQB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2015 11:01:29 -0500
Received: by labhs14 with SMTP id hs14so25878983lab.4
        for <git@vger.kernel.org>; Sun, 01 Mar 2015 08:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=36V5Abj1x59fuV++rn6Dj4OXrBxMx7Ndtls5WXiYF5M=;
        b=eYXGMkKXniNiL5o6QsXRSqos6lVEYtnGPR08jtJrCX3K5jZ3Kd4qbj5dXVMmpkD8TP
         Hdw8G5zH3A2nIOIvwCBMYxdhZC4cg9m/BdNe/TQaJ0+Bj25h858UGndMvI2fAJon+pK5
         avzv9ZhBKxjnBt93uBogPskZuV9K9YOkVYLqB5jDplvm3yD2GqCx4r8suyK9Dfey4xKP
         UxuZ703a+b1kqVQFfwwiYzfopN+MaJVk1RG+G5gG4p4ZKVgnKWjyRLW0RMD8/7KQqYyq
         Y4/6TuY11W8iUJyKnszDG/ohcppsvVR4GVgIwv/Io3/czB3DejekLOLDIlXAKdnGnfv8
         /ExA==
X-Received: by 10.152.2.193 with SMTP id 1mr20648983law.17.1425225688273;
        Sun, 01 Mar 2015 08:01:28 -0800 (PST)
Received: from laptop ([95.109.106.222])
        by mx.google.com with ESMTPSA id fb5sm1994373lbc.34.2015.03.01.08.01.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 01 Mar 2015 08:01:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <54F320E9.1000006@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264561>

On Sun, Mar 01, 2015 at 03:23:37PM +0100, Michael J Gruber wrote:
[]
> If I would have had to guess from the documentation: What does "git diff
> --dirstat --shortstat" do? I would have answered: It displays both the
> dirstat and the shortstat.
> 
> So, is what you are trying to "fix" a peculiarity of
> "--dirstat=changes", or do you simplify prefer --dirstat and --shortstat
> to override each other?
> 
> Maybe I'm overlooking something (and that's not a rhetorical
> conditional), but if you specify both options when you want the output
> of only one them, the answer would be the obvious one, not a patch,
> wouldn't it?
> 
> If there is indeed a good reason to change the behavior it should be
> documented.
I interpret the documentation the same way as you do. The problem is
that the dirstat is displayed twice for --dirstat=changes (or
--dirstat=files):

$ git diff --dirstat=changes,10 --shortstat v2.2.0..v2.2.1
 23 files changed, 453 insertions(+), 54 deletions(-)
  33.5% Documentation/RelNotes/
  26.2% t/
  46.6% Documentation/RelNotes/
  16.6% t/

but only once for --dirstat=lines:

$ git diff --dirstat=lines,10 --shortstat v2.2.0..v2.2.1
 23 files changed, 453 insertions(+), 54 deletions(-)
  33.5% Documentation/RelNotes/
  26.2% t/

This behaviour is either a bug, or an inconsistency not immediately apparent to
the user.

The proposed patch will make the 'changes' and 'files' cases behave like
'lines', i.e. output one shortstat and (only) one dirstat:

$ patched-version-of-git diff --dirstat=changes,10 --shortstat v2.2.0..v2.2.1
 23 files changed, 453 insertions(+), 54 deletions(-)
  46.6% Documentation/RelNotes/
  16.6% t/
