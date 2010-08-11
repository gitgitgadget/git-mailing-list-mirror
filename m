From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 9/9] commit: suppress status summary when no changes staged
Date: Wed, 11 Aug 2010 09:11:39 +0200
Message-ID: <201008110911.40133.trast@student.ethz.ch>
References: <20100725005443.GA18370@burratino> <20100725010230.GI18420@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 09:11:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oj5Td-0006Ln-D4
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 09:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263Ab0HKHLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 03:11:43 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:51075 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751898Ab0HKHLm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 03:11:42 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Wed, 11 Aug
 2010 09:11:41 +0200
Received: from thomas.site (129.132.211.83) by cas10.d.ethz.ch (172.31.38.210)
 with Microsoft SMTP Server (TLS) id 14.0.702.0; Wed, 11 Aug 2010 09:11:41
 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <20100725010230.GI18420@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153195>

Jonathan Nieder wrote:
> Example: before:
>
> 	$ git commit
> 	# On branch master
> 	# Changed but not updated:
[...]
> 	no changes added to commit (use "git add" and/or "git commit -a")
> 	$
>
> After:
>
> 	$ git commit
> 	no changes added to commit (use "git add" and/or "git commit -a")
> 	$

Either Junio just picked this up in the last push or I just never
noticed before, but this breaks t6040 which tests for the "On branch
..." stuff:

  ../trash directory.t6040-tracking-info$ git commit --dry-run
  # On branch follower
  # Your branch is ahead of 'master' by 1 commit.
  #
  nothing to commit (use -u to show untracked files)
  ../trash directory.t6040-tracking-info$ ~/g/git-commit --dry-run
  nothing to commit (use -u to show untracked files)

resulting in

  expecting success:
          (
                  cd test &&
                  git checkout b1 >/dev/null &&
                  # reports nothing to commit
                  test_must_fail git commit --dry-run
          ) >actual &&
          grep "have 1 and 1 different" actual

  Already on 'b1'
  not ok - 5 status

--
Thomas Rast
trast@{inf,student}.ethz.ch
