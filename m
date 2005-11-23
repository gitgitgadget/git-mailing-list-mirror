From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] Add git-graft-ripple, a tool for permanently grafting history into a tree.
Date: 23 Nov 2005 06:37:55 -0800
Message-ID: <861x17pgzg.fsf@blue.stonehenge.com>
References: <11326926501602-git-send-email-ryan@michonline.com>
	<Pine.LNX.4.64.0511221652530.13959@g5.osdl.org>
	<20051123135150.GA16995@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 15:40:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EevlG-0007w4-SK
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 15:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbVKWOh5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 09:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbVKWOh5
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 09:37:57 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:41557 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1750838AbVKWOh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 09:37:56 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 2D4148F742;
	Wed, 23 Nov 2005 06:37:56 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 18613-01-57; Wed, 23 Nov 2005 06:37:55 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id C0D0B8F747; Wed, 23 Nov 2005 06:37:55 -0800 (PST)
To: Ryan Anderson <ryan@michonline.com>
x-mayan-date: Long count = 12.19.12.14.15; tzolkin = 6 Men; haab = 13 Ceh
In-Reply-To: <20051123135150.GA16995@mythryan2.michonline.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12628>

>>>>> "Ryan" == Ryan Anderson <ryan@michonline.com> writes:

Ryan> git_commit_tree():

Ryan> 	my $found;
Ryan> 	do {
Ryan> 		$found = 0;
Ryan> 		if ($csets{$old}{comments} =~ /\s([a-f0-9]{40})\s/ &&
Ryan> 			exists $newcsets{$1}) {

Ryan> 			my $tcommit = $1;

Ryan> 			$found = 1;
Ryan> 			$csets{$old}{comments} =~ s/$tcommit/$newcsets{$tcommit}/g;
Ryan> 		}
Ryan> 	} while ($found);

I hate artificial booleans.  This is better written as:

  {
    last unless my ($tcommit) = $csets{$old}{comments} =~ /\s([a-f0-9]{40})\s/;
    last unless exists $newcsets{$tcommit};
    $csets{$old}{comments} =~ s/$tcommit/$newcsets{$tcommit}/g;
    redo;
  }

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
