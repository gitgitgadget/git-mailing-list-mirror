From: Chris Angelico <rosuav@gmail.com>
Subject: Configuring a third-party git hook
Date: Wed, 19 Mar 2014 22:16:51 +1100
Message-ID: <CAPTjJmomAnrjjyfSvDJijBP2pUN_kqVCRr+UbZkQHQy295A85A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 12:16:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQEUU-0000KG-A6
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 12:16:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758728AbaCSLQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 07:16:52 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:63862 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758087AbaCSLQv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 07:16:51 -0400
Received: by mail-pa0-f41.google.com with SMTP id fa1so8842637pad.0
        for <git@vger.kernel.org>; Wed, 19 Mar 2014 04:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Ofe24Ia+IkJ8X5AwwJkTHww1gY2FxVHOV2okTpiOfnc=;
        b=ojNdwDmu/G9pVDN9ivAY+KuOk1H/Mo4rrqQYaHZmRqmsXCLroBb+9byVaek0sMTsxR
         AP2b8ugvAMt/JvdUaTg4lIlyWCCloZUt9ombjxl/OyZmAXkUQtahvYEW3grK4uLysrU4
         XHOm83Ah7vpVY29L0SFiTba1A7i0SkSJqlY+3yfqaIft3oMHWjWwDWdHy14WP9oyapSW
         9ZR4mODVrQ7ONnPIxGtB8guGH9MYfAAjEBTkrRtmjZDC4FBYSOzioB/T7Cnxh5beQrNg
         ARfZHduQ2zWuOCFOCL26bAvosqej066R/9EzZddKM2QbY5avfBVXKiNpRodUaLNPdDwE
         IiNg==
X-Received: by 10.68.197.36 with SMTP id ir4mr38070481pbc.46.1395227811257;
 Wed, 19 Mar 2014 04:16:51 -0700 (PDT)
Received: by 10.68.33.7 with HTTP; Wed, 19 Mar 2014 04:16:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244433>

I have a bit of a weird question. Poking around with Google searches
hasn't come up with any results, so I'm asking here :)

Short version: What's the most appropriate way to configure a git hook?

Long version: I have a git hook (handles prepare-commit-msg and
commit-msg) and part of what it does can search 'git log' for a single
file. It doesn't really care about the full history, and wants to be
reasonably fast (as the user is waiting for it). It's just a
convenience, so correctness isn't a huge issue. The easiest way to
keep it moving through quickly is to limit the search:

$ git log ...other options... HEAD~100 some-file.pike

The problem with this is that it doesn't work if HEAD doesn't have 100
great-great-...-grandparents - plus, it's way too specific a number to
hard-code. I might want it different on different repos (and the
script is shared, and is available for other people to use).

Now, if this were something in git core, I'd expect to set that value
of 100 with 'git config', but this is my own script. Is it right to
use 'git config' for something that isn't controlled by the core code
of git? I've tentatively used "git config rosuav.log-search.limit"
(with 0 or absence meaning "omit the argument" ie search the whole
history), and am wondering if that's a really really bad idea.

Here's the script in question:
https://github.com/Rosuav/shed/blob/master/githook.pike#L36

Two parts to the question, then. Firstly, is it acceptable to use 'git
config' for a hook like this? And secondly, either: Is there a naming
convention to follow? or, what alternative would you recommend?

Thanks in advance for any ideas/tips!

ChrisA
