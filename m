From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: New special handing of '@' character broke my use case
Date: Wed, 14 Aug 2013 18:36:23 +0100
Message-ID: <520BC017.7050907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 14 19:36:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9ezq-0007rP-KD
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 19:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760047Ab3HNRg2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 13:36:28 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:59004 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760013Ab3HNRg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 13:36:27 -0400
Received: by mail-wi0-f178.google.com with SMTP id j17so2257980wiw.17
        for <git@vger.kernel.org>; Wed, 14 Aug 2013 10:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=ayL+nbdz8rKgVaGQuXdQlCexLo5FCPI7Vow8dixIRqc=;
        b=wMFwy0QLCrHRpdQpqVew2SWhcbIbpMl/Dt1BFP3jiSGucX+YQp47CFG253w3DET3uP
         ocylF82SaNiAzh8CAXFjxZJGHLNokCUT25H4tezhMehYTxGnhVVRMNdeOGnQLEkndK90
         g9Za8abM1dgj+10dRUCV85TLBcnDe2pv6qhrxUOLS3d0aS5LumaalXKXfyCtzwBzVCrh
         CjzCwBpcby5iOdnLJ3sTBImS49j9R//jx6FkqujWC4vlRP29ILzJd6l7bOY38ejSrYmi
         Eg5bHEGqU//8EiWK06eKK4zTZRCwG+NTLevnuC2UePXYR/VvgJsSjVkpRwfjEjR6hd/p
         b+5w==
X-Received: by 10.180.75.239 with SMTP id f15mr2824450wiw.42.1376501786060;
        Wed, 14 Aug 2013 10:36:26 -0700 (PDT)
Received: from marcovaldo.dub.corp.google.com ([2620:0:1040:205:8a51:fbff:fe5c:1cad])
        by mx.google.com with ESMTPSA id e7sm4332912wiy.4.2013.08.14.10.36.24
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 14 Aug 2013 10:36:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130804 Thunderbird/17.0.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232303>

Hello list.

In the last year or so, I developed a personal idiom of using a
naming scheme of "@/BRANCH-NAME/<NUM>"to "save" the older versions
of branches I'm going to rebase (interactively or not).  Here is an
idealized example of my use case:

   $ git co --help
   `git co' is aliased to `checkout'
   $ git co -b topic
   $ ... hack hack hack ...
   $ git co master && git pull # Let's say this brings in 100 commits
   $ git co topic # I want to rebase this to avoid merge conflicts later
   $ git branch @/topic/1 # So I save "original version" of the branch
   $ git rebase master # Do the rebase, solve conflicts etc.
   $ ... hack hack hack (20 commits) ...
   # Here I notice botched commits messages and badly-ordered
   # commits in the last 10 commits or so.  I want to fix that.
   $ git branch @/topic/2 # Save "latest version" of the branch
   $ git rebase -i HEAD~12 # Fix issues

My problems is that some new automagical interpretation of the bare '@' 
character (introduced after 1.8.3) has destroyed my use case:

   $ /usr/bin/git --version
   git version 1.8.3
   $ git --version
   git version 1.8.4.rc2
   $ git co master
   $ /usr/bin/git branch @/foo    # Old git
   $ git branch
     @/foo   # <-- good
   * master
   $ git branch                   # New git.
     @/foo    # <-- good
     HEAD/bar # <-- BAD!
   * master

I don't want to ask you to revert this new behaviour, but I'd like to
at least have an option to disable it.  Even better if such an option is 
already present -- in which case, could you just point me at it?

Failing that, I can re-train myself to use another character (like '='
or '+') to take the same role '@' has hold for me until today, no big
deal.  But in that case, I'd like some assurance that such a character 
is not going to be turned into a magical character some time in the 
future ;-)

Thanks,
   Stefano
