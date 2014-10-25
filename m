From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v3] git-svn: memoize _rev_list and rebuild
Date: Sat, 25 Oct 2014 05:44:26 +0000
Message-ID: <20141025054426.GA31107@dcvr.yhbt.net>
References: <1390443319-11239-1-git-send-email-manjian2006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Hin-Tak Leung <htl10@users.sourceforge.net>,
	Jakob Stoklund Olesen <stoklund@2pi.dk>
To: manjian2006@gmail.com
X-From: git-owner@vger.kernel.org Sat Oct 25 20:42:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xi6I9-0005xZ-8g
	for gcvg-git-2@plane.gmane.org; Sat, 25 Oct 2014 20:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbaJYSlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2014 14:41:20 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47562 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071AbaJYSk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2014 14:40:57 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49F401FB0C;
	Sat, 25 Oct 2014 05:44:26 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1390443319-11239-1-git-send-email-manjian2006@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

manjian2006@gmail.com wrote:
> From: lin zuojian <manjian2006@gmail.com>
> 
> According to profile data, _rev_list and rebuild consume a large
> portion of time.  Memoize the results of _rev_list and memoize
> rebuild internals to avoid subprocess invocation.

Hi, I am considering reverting _rev_list memoization because it
can increases memory usage a lot, which hurting fork() performance on
Linux.

Can you tell me if your original results are under Linux or another
kernel?  I may only disable _rev_list memoization under Linux and
leave other OSes unaffected, too.

I've merged some patches from Jakob to improve svn:mergeinfo
performance along with some followup patches to reduce memory
use.  However memory bloat is still a problem.

Currently in my "master" branch of git://bogomips.org/git-svn

Eric Wong (4):
      git-svn: reduce check_cherry_pick cache overhead
      git-svn: cache only mergeinfo revisions
      git-svn: clear global SVN pool between get_log invocations
      git-svn: remove mergeinfo rev caching

Jakob Stoklund Olesen (2):
      git-svn: only look at the new parts of svn:mergeinfo
      git-svn: only look at the root path for svn:mergeinfo
