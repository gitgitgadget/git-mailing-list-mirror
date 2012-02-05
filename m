From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD] Rewriting safety - warn before/when rewriting published history
Date: Sun, 5 Feb 2012 16:05:27 +0100
Message-ID: <201202051605.28548.jnareb@gmail.com>
References: <201202042045.54114.jnareb@gmail.com> <1328452328-sup-6643@pinkfloyd.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Sun Feb 05 16:06:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ru3fD-00038c-OD
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 16:06:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754693Ab2BEPFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 10:05:30 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:47722 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754182Ab2BEPF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 10:05:29 -0500
Received: by eekc14 with SMTP id c14so1862098eek.19
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 07:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=JvafG9HjjMH9HLz/AlQRetlH3L8tdaP4RIaMNmp623s=;
        b=V/eAMyxpv7DTso6DZXjTW9E1281ngVgcRtacQNNNyscrCbhoGWjff34zJv7dixzJs6
         TM0D5FBvY5URhS87Xx5LYIBUXymvl5u4HbyBGnKIEtnq2R1oC/VlE+FlOtig3R1qHtd4
         FQEBuPDiGCG/zSdf5jsMNYKB8h663vNIdMYX4=
Received: by 10.14.28.199 with SMTP id g47mr4560780eea.16.1328454327644;
        Sun, 05 Feb 2012 07:05:27 -0800 (PST)
Received: from [192.168.1.13] (abvp235.neoplus.adsl.tpnet.pl. [83.8.213.235])
        by mx.google.com with ESMTPS id n56sm49161973eeh.6.2012.02.05.07.05.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Feb 2012 07:05:26 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1328452328-sup-6643@pinkfloyd.chass.utoronto.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189942>

On Sun, 5 Feb 2012, Ben Walton wrote:
> Excerpts from Jakub Narebski's message of Sat Feb 04 14:45:53 -0500 2012:
> 
> Hi Jakub,
> 
> These items are as much about UI as anything else, I think.  UI that
> better helps users to know the state of their commits and branches can
> only be a good thing.  People that have used git for a while and are
> comfortable with it may not see the need/point of these, but I think
> they could both really help new users.

As I said, 1500+ git users would like to have such feature, according
to latest Git User's Survey.

> > In Mercurial 2.1 there are three available phases: 'public' for
> > published commits, 'draft' for local un-published commits and
> > 'secret' for local un-published commits which are not meant to be
> > published.
> 
> How do you envision such a feature in git?
> 
> A 'draft' commit (or chain of commits) could be determined from the
> push matching definitions and then marked with simple decorations in
> log output...This would extend the ability of status to note that your
> are X commits ahead of foo.  This would see any commit on a branch
> that would be pushed automatically decorated with a 'draft' status.

I think that in its basic form (treating all remotes equally) commits
in 'public' phase would be those reachable from remote-tracking branches.
Otherwise commits would be in 'draft' phase, unless explicitly marked
as 'secret' (it we implement 'secret' phase, that is).

The safety new I think of would (similarly to Mercurial phases) prevent
or warn about amending published commit, and rebasing commits which were
already published (in 'public' phase).  That would require modifications
to git-commit and git-amend, I think...

Maybe even Git could refuse or warn on the local side about non
fast-forward update of public branch, to help users of third-party tools.
 
> > While default "push matching" behavior makes it possible to have
> > "secret" commits, being able to explicitly mark commits as not for
> > publishing might be a good idea also for Git.
> 
> Do you see using configuration or convention to achieve this?
> 
> For example, any branch named private/foo could, by convention, be
> un-pushable without a force option?  Alternately, a config item
> similar to the push matching stuff to allow the users to designate
> un-pushable branches could work too.

I'm not sure, but the config item might be a good solution.  Git would
skip publishing 'secret' commits (commits from 'secret' branch) if it
would otherwise publish it due to glob refspec, and refuse (or warn)
publishing 'secret' branches explicitly.

Currently if you use default "push matching", then those branches that
you didn't push explicitly wouldn't be pushed.  But that does not prevent
pushing them by accident, and does not give UI to check if branch is
private or not (e.g. to use in git-aware shell prompt).

-- 
Jakub Narebski
Poland
