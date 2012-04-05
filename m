From: Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH 0/5] Enhance git-rebases flexibiilty handling empty commits [v2]
Date: Thu,  5 Apr 2012 15:39:00 -0400
Message-ID: <1333654745-7898-1-git-send-email-nhorman@tuxdriver.com>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
Cc: Neil Horman <nhorman@tuxdriver.com>, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 05 21:40:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFsXi-0007vM-ID
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 21:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755856Ab2DETjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 15:39:32 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:57262 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726Ab2DETja (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 15:39:30 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SFsWh-0005Vk-0S; Thu, 05 Apr 2012 15:39:25 -0400
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194798>

git's ability to handle empty commits is somewhat lacking, especially when
preforming a rebase.  Nominally empty commits are undesireable entries, the 
result of commits that are made empty by prior commits covering the same changs.
But occasionally, empty commits are useful to developers (e.g. inserting notes 
into the development history without changing any code along the way).  In these
cases its desireable to easily preserve empty commits during operations like 
rebases.

This patch series enhances git to do just that.  It adds two options to the 
git-cherry-pick command, --allow-empty, which allows git cherry-pick to preserve
an empty commit, even if the fast forward logic isn't applicable during the 
operation, and --ignore-if-made-empty, which allows the user to restrict the 
application of --allow-empty to only those commits which were initially empty 
(not those commits made empty by a prior commit).  It also enhances git-rebase
to add a --keep-empty option, which implies the use of the above new options to
cherry-pick.  

I've tested these operations out myself here and they work well for me

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
CC: Jeff King <peff@peff.net>
CC: Phil Hord <phil.hord@gmail.com>
CC: Junio C Hamano <gitster@pobox.com>

---
Change notes:

Based on version 1 feedback from this list, the following changes have been made

V2)
	* Changed --keep-empty to --allow-empty in the git cherry-pick command

	* Converted run_git_commit to use argv_array

	* Updated cherry-pick --allow-empty description in man page
	
	* added ignore-if-made-empty option to git-cherry-pick

	* Added test to test suite to validate the new cherry-pick options

	* Updated git-rebase man page to be less verbose and more accurate in the
	description of the keep-empty option

	* squashed the addition of the keep-empty flag in git-rebase down to one
	commit from 3

	* fixed up coding style in git-rebase script

	* Optimized detection of empty commits

	* Only augmented git-rebase-editor message if empty commits are
	possible
	
