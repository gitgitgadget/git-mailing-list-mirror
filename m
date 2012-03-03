From: Jared Hance <jaredhance@gmail.com>
Subject: Re: [PATCH 1/3] Use =?utf-8?b?c3RhcnR1cF9pbmZvLT5wcmVmaXg=?= rather than prefix.
Date: Sat, 3 Mar 2012 23:23:09 +0000 (UTC)
Message-ID: <loom.20120304T002121-25@post.gmane.org>
References: <cover.1330740964.git.jaredhance@gmail.com> <b564d95b1efcd91874beb6d410253f86617f8fa6.1330740964.git.jaredhance@gmail.com> <7v8vji87kg.fsf@alter.siamese.dyndns.org> <CACsJy8DtZLCLfeHNP_eq9kVZxjV3xh3gs6pgQCi=FDZ_Je7_Gw@mail.gmail.com> <7vbood742a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 04 00:23:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3yIs-0005Nd-GS
	for gcvg-git-2@plane.gmane.org; Sun, 04 Mar 2012 00:23:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338Ab2CCXXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 18:23:23 -0500
Received: from plane.gmane.org ([80.91.229.3]:45661 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752033Ab2CCXXX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 18:23:23 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1S3yIJ-0005BZ-R7
	for git@vger.kernel.org; Sun, 04 Mar 2012 00:23:20 +0100
Received: from cpe-174-101-220-163.cinci.res.rr.com ([174.101.220.163])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 04 Mar 2012 00:23:19 +0100
Received: from jaredhance by cpe-174-101-220-163.cinci.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 04 Mar 2012 00:23:19 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 174.101.220.163 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20100101 Firefox/10.0.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192143>

Junio C Hamano <gitster <at> pobox.com> writes:

> Hrm, that explanation is understandable, but it strongly makes me suspect
> that this change is making the code _more_ error prone in the longer term.
> 
> When somebody wants to add a new caller to a non-builtin, they need to
> think about what prefix to pass, and would realize that they need to call
> setup_git_directory() to get it. With the updated code, they can totally
> forget and call it without any initialized startup_info.
> 
> Adding a totally new command is rare, new non-builtin is rarer, and adding
> trace to it is even more so, so it may not be worth worrying about, but I
> wonder if there is a cheap way to check such a programming mistake.
> 

Well, there are really four options:
- Old code, where user must pass in prefix
- New code, where user must call setup_git_directory()
- Have the function deliver a nice diagnostic error message if startup_info
hasn't been initialized
- Have the function call setup_git_directory() if startup_info hasn't been
initialized

I think one of the latter two is the most sane here.
