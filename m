From: Christopher Cameron <christopher.cameron@live.com>
Subject: Re: Problem with &quot;dashless options&quot;
Date: Tue, 27 Apr 2010 17:55:20 +0000 (UTC)
Message-ID: <loom.20100427T194730-644@post.gmane.org>
References: <D69FA890-4249-4DC9-B8AE-C9F105F1AD3B@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 27 22:25:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6rLI-00031f-SC
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 22:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754865Ab0D0UZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 16:25:07 -0400
Received: from lo.gmane.org ([80.91.229.12]:33792 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754582Ab0D0UZG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 16:25:06 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O6rL5-0002xb-Kp
	for git@vger.kernel.org; Tue, 27 Apr 2010 22:25:03 +0200
Received: from adsl-99-60-1-241.dsl.pltn13.sbcglobal.net ([99.60.1.241])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 22:25:03 +0200
Received: from christopher.cameron by adsl-99-60-1-241.dsl.pltn13.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 22:25:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 99.60.1.241 (Mozilla/5.0 (Macintosh; U; PPC Mac OS X 10_4_11; en) AppleWebKit/531.9 (KHTML, like Gecko) Version/4.0.3 Safari/531.9)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145945>

Henrik Tidefelt <tidefelt <at> isy.liu.se> writes:

> Some of the git sub-commands work fine (for instance,  
> checkout, status, remote), while push gives an error as follows:
> 
> $ git push isy next
> fatal: BUG: dashless options don't support arguments

I encountered the exact same problem.  There are a sequence of
#defines in parse_options.h which are supposed to initialize option
structs (OPT_END, OPT_STRING, etc).  These structures only partially 
initialize the structure, leading to, for instance, junk bits in the flags 
word of OPT_STRING.
 type: 9
 short_name: m
 long_name: master
 flags: 74636f6e
You were seeing some commands affected vs not depending on how
they use the options macros.

I changed my local source to fill out the full struct, and I never saw 
the bug again.
