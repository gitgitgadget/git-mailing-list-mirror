From: David Turner <dturner@twopensource.com>
Subject: Re: Feature request: git commit -A
Date: Tue, 24 Jun 2014 16:34:45 -0700
Organization: Twitter
Message-ID: <1403652885.22828.10.camel@stross>
References: <CAPgiXS7AizvtVNWR4dPXZ6nUQh7ujrrRFmd2SAktsUB0pidFVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Aidan Feldman <aidan.feldman@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 01:34:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzaEn-0007vW-EZ
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jun 2014 01:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848AbaFXXeu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 19:34:50 -0400
Received: from mail-qc0-f172.google.com ([209.85.216.172]:34635 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbaFXXet (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2014 19:34:49 -0400
Received: by mail-qc0-f172.google.com with SMTP id o8so1029176qcw.31
        for <git@vger.kernel.org>; Tue, 24 Jun 2014 16:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=rIOt4GM5C+VNYeBwIH+2EW3ACSJJjey7RouQvMUliGs=;
        b=AIPlbZZWiUtcpHGOzlflDl2wzQYI7OuRntjQkrqze0sq9vMCBXlUKpg5azR8WECTpN
         7VNnpBU7l69qQByO7v+JvncTX1jlQIFIScch1bVfigk4Q8Q9D5cKnN8IgwJSAqoygJkO
         wEoZsWER7+Wpw5P4Zdafy7S9FgPe2NGPn/ueax4m2ge30qKGD+ZG7RqS88X9aL7NPrQ8
         YmW1PcIcMxejRL/5eaSyGI9ysiTPFn8kcwEv6libaoyDKdqn+uzW2OQuMFkDPmdMMnbw
         6VJq1tu2gLkhhNlb+dxZpiVkvob6yFAX8xOe1hwntPlQJVUUIUP5SrElnmq4hKWfVCAU
         Y/DQ==
X-Gm-Message-State: ALoCoQlPVIQIzzH59xx67U3n0B4kZQU6zNKrwJMWZRDJv6Kc+tvRyKWmXp/Jos+NRmjVFpsUJKA1
X-Received: by 10.140.94.225 with SMTP id g88mr5990030qge.101.1403652888470;
        Tue, 24 Jun 2014 16:34:48 -0700 (PDT)
Received: from [172.25.140.220] ([8.25.197.27])
        by mx.google.com with ESMTPSA id j1sm2819416qaa.11.2014.06.24.16.34.46
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Tue, 24 Jun 2014 16:34:47 -0700 (PDT)
In-Reply-To: <CAPgiXS7AizvtVNWR4dPXZ6nUQh7ujrrRFmd2SAktsUB0pidFVw@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252427>

On Tue, 2014-06-24 at 15:01 -0400, Aidan Feldman wrote:
> Hi all-
> I work on the education team at GitHub and do a fair number of Git
> workshops.  One thing that I've always found difficult to explain to
> newbies is how the staging area works, and why it's useful.  As a
> hand-wave to simplify things, I usually have them use
> 
> git add -A
> git commit -m "..."
> 
> to not really have to worry about untracked vs. modified/removed files
> aren't included with `git commit -a` or `git add .`.  I would like to
> add a `-A` flag to the `commit` command, which effectively does a `git
> add -A` before committing.
> 
> I was trying to submit a patch myself, but couldn't even manage to
> find where the various flags are defined :-)  Does the feature sound
> reasonable?  Mind pointing me in the right direction of where this
> would be added?

Look at builtin/commit.c in the cmd_commit function.  You'll see:
		OPT_BOOL('a', "all", &all, N_("commit all changed files")),
Just add another one, 
		OPT_BOOL('A', "all-untracked", &all_untracked, N_("commit all changed
files as well as all non-excluded untracked files")),

That said, I am mildly opposed to this feature because it will
inevitably lead to cruft (and credentials) being checked into
repositories.  It's easier, but it's not simpler.
