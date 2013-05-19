From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 1/2] Doc rebase: Describe rebase as excluding merge
 commits
Date: Sun, 19 May 2013 11:08:04 -0700
Message-ID: <20130519180804.GE3362@elie.Belkin>
References: <1368964329-1600-1-git-send-email-philipoakley@iee.org>
 <1368964329-1600-2-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun May 19 20:08:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue81n-0007KV-Kj
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 20:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700Ab3ESSIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 14:08:10 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:39479 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337Ab3ESSIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 14:08:09 -0400
Received: by mail-pb0-f52.google.com with SMTP id xa7so4702867pbc.11
        for <git@vger.kernel.org>; Sun, 19 May 2013 11:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Cm/yQlPoy8RZf7cTqbmZsDP2QCQn212WYoK/woWu+iE=;
        b=ejB5jnF83qMKuzP7PHJyca8PHAVeCiEXiziSwGVOmJNb9Y4hRZyPPs0NWabxmTPekc
         BytTgJsX8sv0HBao2GPksk4Z4mpEH3LpHjolf2vzRlSduCa5K/LyNrGkv3y8txe+xE5s
         xXDk+YU9tvVHuwkeMQbWJssUcyNO95+nwQX0gBaH99bBRX53gOUQfUOktzUdZCnLNW9K
         Pz/GgREo8F9ITwUoUPiy2Z8zN//WCu1LNdpEx5a4MHZx2heJqU0l2tKoUbeVYYRBPTpJ
         aLqernG60qwG9tmXiUHwYXNV75TqWDCmeWiReltQLtGlK7GZ4uwIeeuBdcY2uggoGfaj
         cRnQ==
X-Received: by 10.68.58.165 with SMTP id s5mr57025071pbq.220.1368986888660;
        Sun, 19 May 2013 11:08:08 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id aj2sm20540828pbc.1.2013.05.19.11.08.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 19 May 2013 11:08:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1368964329-1600-2-git-send-email-philipoakley@iee.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224903>

Philip Oakley wrote:

> Describe rebase in the description section.

It already does that. :)  I think you mean "start with a summary",
which is a valuable improvement.

> Include a softer paraphrased version from the crytic, well-loved,
> but sometimes parodied, Name description, and tell users that merge
> commits are excluded by default.

I don't really follow this paragraph.  Are you saying "The NAME line
is cryptic, but let's copy it anyway, since it is better than nothing"?

[...]
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -16,6 +16,10 @@ SYNOPSIS
>  
>  DESCRIPTION
>  -----------
> +'git rebase' will transfer local commits, excluding merge commits
> +by default, to the head of the branch's upstream, or onto a new base
> +if given.
> +

Not about this patch, but some day it would be nice to standardize on
one tense for the DESCRIPTION sections of manpages.  Some git commands
use the imperative ("Reply local commits, excluding merge commits, on
top of ..."), some use the present indicative ("Replays local commits,
excluding merge commits, ..."), and some use the future ("Will replay
local commits, excluding merge commits, ...").

The traditional tense for Unix manpages is the present indicative.
But you are right to match the rest of the description here.

>  If <branch> is specified, 'git rebase' will perform an automatic
>  `git checkout <branch>` before doing anything else.  Otherwise
>  it remains on the current branch.

The description has become very long by now.  I wonder if it's
possible to break it into chunks, like so?

	DESCRIPTION
	-----------
	<brief description of the purpose of the command, including some token
	mention of *why* a user would want to use it (e.g., "so that the patches
	apply cleanly to their new base").>

	It proceeds using the following steps:

	 1. If <branch> is specified, ...
	 2. Decides which commits will need to be applied.
	    These are plain, non-merge commits that are ancestors of HEAD but
	    not of <upstream>.
	 3. Checks out <upstream>.  (<Explanation that technically it
	    detaches HEAD at this step.>)
	 4. Reapplies the commits listed on step (2), one by one, in order.
	    If merge failures are encountered, the program will exit and allow
	    the user to resolve them and resume or cancel the rebase.  See
	    the RESPONDING TO MERGE CONFLICTS section below for details.
	 5. Once all of the commits from step (2) have been applied, updates
	    <branch> to point to the new HEAD.

	The result is an updated <branch> that ...

	OPTIONS
	-------
	...

	EXAMPLES
	--------
	Assume the following history exists and the current branch is "topic":
	...

Description of specific options like "--preserve-merges" and "--onto"
could move out of the DESCRIPTION section and to the OPTIONS section.

What do you think?

Thanks,
Jonathan
