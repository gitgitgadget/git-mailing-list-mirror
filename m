From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFD] Rewriting safety - warn before/when rewriting published history
Date: Sat, 4 Feb 2012 20:45:53 +0100
Message-ID: <201202042045.54114.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 20:46:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtlYk-0002zL-64
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 20:46:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754433Ab2BDTqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 14:46:00 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:58171 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754386Ab2BDTp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 14:45:59 -0500
Received: by eekc14 with SMTP id c14so1633410eek.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 11:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-disposition
         :content-type:content-transfer-encoding:message-id;
        bh=62iWoQ3b9Hw/8JqjpedJz+8U62Eta2OmZB+I3LzpO3o=;
        b=LQLSZUuTyB3iErg2TX8DaOO22EMaLjWf617GISecNItNGVkfxFDFBHWMDMoelhGD5a
         +aerhYpVoNc2XBM3xdrp4nKkz9psHWX8FYXsAX3RP5FsmPFUHCneGdDSSrqbm8eywtqe
         LKKmNAQDXjRrzdzg2O7RfXKocLCfQvYfI/lSs=
Received: by 10.14.28.194 with SMTP id g42mr3770196eea.44.1328384754252;
        Sat, 04 Feb 2012 11:45:54 -0800 (PST)
Received: from [192.168.1.13] (abwp204.neoplus.adsl.tpnet.pl. [83.8.239.204])
        by mx.google.com with ESMTPS id b3sm38715803een.2.2012.02.04.11.45.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 04 Feb 2012 11:45:53 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189895>

Git includes protection against rewriting published history on the 
receive side with fast-forward check by default (which can be 
overridden) and various receive.deny* configuration variables,
including receive.denyNonFastForwards.

Nevertheless git users requested (among others in Git User's Survey) 
more help on creation side, namely preventing rewriting parts of 
history which was already made public (or at least warning that one is 
about to rewrite published history).  The "warn before/when rewriting 
published history" answer in "17. Which of the following features would 
you like to see implemented in git?" multiple-choice question in latest
Git User's Survey 2011[1] got 24% (1525) responses.

[1]: https://www.survs.com/results/Q5CA9SKQ/P7DE07F0PL

So people would like for git to warn them about rewriting history before 
they attempt a push and it turns out to not fast-forward.


What prompted this email is the fact that Mercurial includes support for 
tracking which revisions (changesets) are safe to modify in its 2.1 
latest version:

  http://lwn.net/Articles/478795/
  http://mercurial.selenic.com/wiki/WhatsNew

It does that by tracking so called "phase" of a changeset (revision).

  http://mercurial.selenic.com/wiki/Phases
  http://mercurial.selenic.com/wiki/PhasesDevel

  http://www.logilab.org/blogentry/88203
  http://www.logilab.org/blogentry/88219
  http://www.logilab.org/blogentry/88259
  

While we don't have to play catch-up with Mercurial features, I think 
something similar to what Mercurial has to warn about rewriting 
published history (amend, rebase, perhaps even filter-branch) would
be nice to have.  Perhaps even follow UI used by Mercurial, and/or
translating its implementation into git terms.

In Mercurial 2.1 there are three available phases: 'public' for
published commits, 'draft' for local un-published commits and
'secret' for local un-published commits which are not meant to
be published.

The phase of a changeset is always equal to or higher than the phase
of it's descendants, according to the following order:

      public < draft < secret

Commits start life as 'draft', and move to 'public' on push.

Mercurial documentation talks about phase of a commit, which might
be a good UI, ut also about commits in 'public' phase being "immutable".
As commits in Git are immutable, and rewriting history is in fact
re-doing commits, this description should probably be changed.

While default "push matching" behavior makes it possible to have 
"secret" commits, being able to explicitly mark commits as not for
publishing might be a good idea also for Git.


What do you think about this?
-- 
Jakub Narebski
Poland
