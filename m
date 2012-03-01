From: Phil Hord <hordp@cisco.com>
Subject: filter-branch vs. <rev-list options>
Date: Thu, 01 Mar 2012 18:39:07 -0500
Message-ID: <4F50089B.1090202@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 02 00:39:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3Fac-0006x8-K4
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 00:39:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753345Ab2CAXjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 18:39:09 -0500
Received: from rcdn-iport-4.cisco.com ([173.37.86.75]:52381 "EHLO
	rcdn-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205Ab2CAXjI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 18:39:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=1727; q=dns/txt;
  s=iport; t=1330645148; x=1331854748;
  h=message-id:date:from:mime-version:to:subject:
   content-transfer-encoding;
  bh=kqzve6mQBqkzFt6KsBLDv/7YDImvoXGttAk54IJTZm8=;
  b=b6jd/J2w0cchtdm1DhvJVhdPo41UbE7UhKhbRbPIZL13VT67hPXQY8vb
   yrCJBkpPWXsgi/lZ940x/KGGADPzIv/nWiAMvUIawY81MR1x11GZh7hrH
   9Durl0XitCtH9FyxWPDzCGCzgot7bCgg9rveeqqrah6VXQw6+4xWf/zs3
   8=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAKUHUE+tJV2Y/2dsb2JhbABDtBCBB4IWAWU9FhgDAgECAUsBDAgBAR6HZJo6AZ5hjDwMAQkSAgIHBgQDBAMIBAoIDgEKBgMChQqEIgSIT4xshV+NMQ
X-IronPort-AV: E=Sophos;i="4.73,513,1325462400"; 
   d="scan'208";a="63170015"
Received: from rcdn-core-1.cisco.com ([173.37.93.152])
  by rcdn-iport-4.cisco.com with ESMTP; 01 Mar 2012 23:39:07 +0000
Received: from [64.100.104.141] (dhcp-64-100-104-141.cisco.com [64.100.104.141])
	by rcdn-core-1.cisco.com (8.14.3/8.14.3) with ESMTP id q21Nd7oJ004628;
	Thu, 1 Mar 2012 23:39:07 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:9.0) Gecko/20111229 Thunderbird/9.0
X-Enigmail-Version: 1.3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191988>

I'm trying to pass some arguments to gilt-filter-branch, but it's not
doing what I expect.  The manual says that git-filter-branch ends with
'rev-list options'.  So I tested git-rev-list with this trivial example
and got what I wanted:
    $ git rev-list --not --remotes --not HEAD^..HEAD
    019483b7aedfef711b3c85eca000d812a3b501bd

But when I tried it with filter-branch it didn't work:
    $ git filter-branch --msg-filter cat --not --remotes --not HEAD^..HEAD
     Usage: git filter-branch [--env-filter <command>] [--tree-filter
<command>]
            [--index-filter <command>] [--parent-filter <command>]
            [--msg-filter <command>] [--commit-filter <command>]
            [--tag-name-filter <command>] [--subdirectory-filter
<directory>]
            [--original <namespace>] [-d <directory>] [-f | --force]
            [<rev-list options>...]

On the other hand, this works ok:
    $ git filter-branch --msg-filter catHEAD^..HEAD--not --remotes --not
    Rewrite 019483b7aedfef711b3c85eca000d812a3b501bd (1/1)
    WARNING: Ref 'refs/heads/master' is unchanged

git-filter-branch seems to be parsing its own switches and not
recognizing when they run out and the rest are "rev-list" options. 

Is there a way to force this break, or should I just expect to have to
rewrite the logic so that there's always a non-switch argument at the
start of the rev-list section?  Or am I just doing this wrong?

fwiw - I'm actually wanting to do this in a script:
    git filter-branch --msg-filter cat --not --remotes --not "$@"

I put my "--not --remotes --not" before the user arguments in case the
user arguments include an odd number of "--not" switches on its own.

Thanks,
Phil
