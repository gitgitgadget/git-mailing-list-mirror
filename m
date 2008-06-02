From: Lea Wiemann <lewiemann@gmail.com>
Subject: Development strategy
Date: Mon, 02 Jun 2008 17:51:49 +0200
Message-ID: <48441715.4010507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: John Hawley <warthog19@eaglescrag.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 02 17:52:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3CKs-0008WP-9l
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 17:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752610AbYFBPvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 11:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752662AbYFBPvq
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 11:51:46 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:11923 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334AbYFBPvo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 11:51:44 -0400
Received: by fg-out-1718.google.com with SMTP id 19so766470fgg.17
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 08:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding:from;
        bh=eViWxe7dxgkdGqkz75BiV8Sn/b5bTweu4tlOJ2JC3ug=;
        b=KKslaDMs2nZ/rwuZ1f/nG5Xj3Tm3oSpuP6t7656AbVxaywEnXIKUN3+6mhRMu795fvxoSsZjTKlnrlBIGSdN5hLDJYg+GoKv7FkLIl347UflbeJgO6iaGbnRu3NVzFx3zSWFBT7t2l6adQYd9uCUSTxQgpqhkKXFQ4zTXNa2pAY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding:from;
        b=vvNxttuSI6DAH2EYz2Bjk1UOGIWbhqI1uQQ8tujBpnLc7IG9usXr4mU1UYd5RmeXk15PkDZ8g5hGw7HFPsYX5Xoiz8oTjHc+MtAHSKRPeI2ni8GSb2t+rnJgPtqQqTpaXU7UNVa/+hKDdxAz1ZFV91Q4ISafA29AWUayEkViBww=
Received: by 10.86.23.17 with SMTP id 17mr3784927fgw.32.1212421901876;
        Mon, 02 Jun 2008 08:51:41 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.231.153])
        by mx.google.com with ESMTPS id l12sm3882051fgb.6.2008.06.02.08.51.40
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 02 Jun 2008 08:51:41 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83536>

Hi everyone,

[For those uninitiated, this is about my GSoC project about adding 
caching to Gitweb, on which I am currently working full-time; my branch 
is here: http://repo.or.cz/w/git/gitweb-caching.git]

I'm seeing a process-wise problem arising with my current work on Git.pm 
and Gitweb, in that I'm producing patches at a higher frequency than the 
developer community can handle.  Right now, I have a stack of 7 patches 
that haven't been "approved" in any way (i.e. either they are under 
discussion or nobody has reviewed them) and that my future work will 
depend on.  Chronologically,

! 2f15087248 perl/Git.pm: add get_hash method
   abd799435c gitweb: use Git.pm, and use its get_hash method
! 5e53e2e67e t/test-lib.sh: add test_external
! c5c97f896c Git.pm: fix documentation of hash_object
! 8db2d73809 test suite for Git.pm
   261a54ff5b gitweb: removed unused parse_ref method [not posted yet]
   e9166526a3 Git.pm: add get_type method [not posted yet]

The patches marked "!" I cannot change without breaking at least one 
subsequent patch, so every time I want to make a change to one of those, 
I also need to change at least one subsequent commit, and worse, 
resubmit it to the mailing list.  (E.g. the the recent rename from 
parse_rev to get_hash necessitated two extra patches to accommodate the 
change.)

If I keep on committing revisions like I'm doing right now, I'll end up 
with a long queue of interdependent patches of which only the newest few 
are easily changeable.  Here are some ideas to prevent this:

1) My current patch frequency is probably too high, in particular if 
minor changes (like method renames or documentation changes) cause 
re-posts of patches.  Hence, I suggest that I stay on my branch for now 
and only post patches on which I actually want feedback, without 
reposting corrected versions after getting feedback.  That is, no 
patches just for "please someone approve this".

2) I should probably also try to squash patches into larger ones.  This 
will make it easier to make changes in older commits, since I don't have 
to edit several commits, and it reduces the probability of merge 
conflicts.  I'm not sure how much squashing is appropriate though: For 
example, would it be okay to squash a fix like "Git.pm: fix 
documentation of hash_object" into a larger "Git.pm: add and fix several 
methods" commit, where I only mention the documentation-fix in the log 
message?  It would certainly be helpful in that it reduces the number of 
conflicts, but it will make the logs coarser.

-- Lea
