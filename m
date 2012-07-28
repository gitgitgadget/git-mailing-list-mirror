From: "Michael G. Schwern" <schwern@pobox.com>
Subject: Fix git-svn for SVN 1.7
Date: Sat, 28 Jul 2012 02:47:44 -0700
Message-ID: <1343468872-72133-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, jrnieder@gmail.com, schwern@pobox.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 28 11:48:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv3di-0005Ib-OV
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 11:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757Ab2G1JsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 05:48:06 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57120 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329Ab2G1JsE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 05:48:04 -0400
Received: by pbbrp8 with SMTP id rp8so6503035pbb.19
        for <git@vger.kernel.org>; Sat, 28 Jul 2012 02:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=cGIF5fTsac9r5yrISOxbcphdnlgPLsSbhg2kPSeCNOg=;
        b=zvBLAgXtO/diaMLF3IRz/HkS3B1VOImnAfJ9i3oOs5aCkZjtBggxhnT8wHnt4aTc8s
         /Bcr6NqRNwLcNwDTAB+YB6cero/o1JXmTyfcU3CxZCPc1Hqh95iYxfMm2w8l7Hsnmux0
         N+cd2REseJeh9YBKsvQkUxJav0Y4bGgAVUw/EqyJ9AdFd9hodNImGyUgjcvMWBR3yJkT
         Qs3gVMD6zK+bm2JiYuYbudD1SXr6TI3ICDNKhTT9epgN/PMUyJ7pk7dxlGLfpZz9ljsk
         O+nYkd7qZ3gANENgr5qV99P6JWzXd94SQFoauvODoI+GPi5pnwQVLGhs4M3AlPMdaa4t
         p4Uw==
Received: by 10.68.225.231 with SMTP id rn7mr20326469pbc.13.1343468883550;
        Sat, 28 Jul 2012 02:48:03 -0700 (PDT)
Received: from windhund.local.net (c-71-236-173-173.hsd1.or.comcast.net. [71.236.173.173])
        by mx.google.com with ESMTPS id nv6sm3692274pbc.42.2012.07.28.02.48.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 Jul 2012 02:48:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202419>

This patch series fixes git-svn for SVN 1.7 tested against SVN 1.7.5 and
1.6.18.  Patch 7/8 is where SVN 1.7 starts passing.

There is one exception.  t9100-git-svn-basic.sh fails 11-13.  This appears
to be due to a bug in SVN to do with symlinks.  Leave that for somebody
else, this is the final submission in the series.

The work was difficult because the code relies on simple string equalty
when comparing URLs and paths.  Turning on canonicalization in one part
of the code would cause another part to fail if it also did not
canonicalize.  There's likely still issues.

A better solution would be to have path and URL objects which overload
the eq operator and automatically stringify canonicalized and escaped.

This patch series should be placed on top of the previous which
made accessors canonicalize.  I'm getting a bit ahead of things
by submitting it now, but I'd like to get the review process
rolling.
