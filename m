From: Michael G Schwern <schwern@pobox.com>
Subject: Re: [PATCH 1/8] SVN 1.7 will truncate "not-a%40{0}" to just "not-a".
Date: Sat, 28 Jul 2012 12:32:04 -0700
Message-ID: <50143E34.8090802@pobox.com>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
 <1343468872-72133-2-git-send-email-schwern@pobox.com>
 <20120728141652.GA1603@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, normalperson@yhbt.net
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 21:32:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvCkH-0004OG-4g
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 21:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752929Ab2G1TcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 15:32:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47249 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752322Ab2G1TcG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 15:32:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E98B682C0;
	Sat, 28 Jul 2012 15:32:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=mZhful3UE0RL
	mmYT9ux+E9AWCjU=; b=s+iRNBU1sNZplKdV+CDO+kvuMbpC8jthC9jVS2sMPQXx
	OPfCzpFPjULbN9H+UnuwoTUQtJnslIDuPsP947hfo4CUmR8XKnlc1kWfmBgRAQmS
	vlza+Xqs8yL36Fzqn0Ve+an95qypQahw5q6oUuABJaNMgrOY7dP/gniaiU4K8xg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=czOx2d
	FMLpnLt3vKCqGJwOmyjJzb+/s6TRxIiQbHKy8wVEa5sAU0bVDKpy2ouqwsu9iLGJ
	G7ud9RAIhsN0OPaOrB/Y6K4N4TfDGp9FF5xhnPED5KEzH1+O+qHnxreS6KlXiJ+v
	9EmkEY7uoyEahAN9cmAvTEXAXeoz+dZIe4Hyc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D635482BF;
	Sat, 28 Jul 2012 15:32:05 -0400 (EDT)
Received: from windhund.local (unknown [71.236.173.173]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F335482BC; Sat, 28 Jul
 2012 15:32:04 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0)
 Gecko/20120713 Thunderbird/14.0
In-Reply-To: <20120728141652.GA1603@burratino>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: E9DC826A-D8EA-11E1-A468-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202459>

On 2012.7.28 7:16 AM, Jonathan Nieder wrote:
> Michael G. Schwern wrote:
> 
>> Rather than guess what SVN is going to do for each version, make the test use
>> the branch name that was actually created.
> [...]
>> -		git rev-parse "refs/remotes/not-a%40{0}reflog"
>> +		git rev-parse "refs/remotes/$non_reflog"
> 
> Doesn't this defeat the point of the testcase (checking that git-svn
> is able to avoid creating git refs containing @{, following the rules
> from git-check-ref-format(1))?

Unless I messed up, entirely possible as I'm not a shell programmer, the test
is still useful for testing SVN 1.6.  Under SVN 1.6 $non_reflog should be
'not-a%40{0}reflog' as before.


> Do you know when SVN truncates the directory name?

IIRC its silently does it during the "svn cp".


> Would historical
> SVN repositories or historical SVN servers be able to have a directory
> named with a %40 in it, or has this been disallowed completely,
> leaving problematic historical repositories to be dumped with old SVN,
> tweaked, and reloaded with new SVN?

Dunno, lemme check...

$ source ~/bin/svn16
$ svnadmin --version
svnadmin, version 1.6.18 (r1303927)
...
$ svnadmin create svnrepo
$ mkdir project project/trunk project/branches project/tags
$ echo foo > project/trunk/foo
$ svn import -m 'test import' project
file:///Users/schwern/tmp/test/svnrepo/project
Adding         project/tags
Adding         project/trunk
Adding         project/trunk/foo
Adding         project/branches

Committed revision 1.
$ rm -rf project/
$ svn cp -m 'reflog' file:///Users/schwern/tmp/test/svnrepo/project/trunk
'file:///Users/schwern/tmp/test/svnrepo/project/branches/not-a%40{0}reflog'

Committed revision 2.
$ svn ls file:///Users/schwern/tmp/test/svnrepo/project/branches
not-a@{0}reflog/
$ source ~/bin/svn17
$ svn --version
svn, version 1.7.5 (r1336830)
...
$ svn ls file:///Users/schwern/tmp/test/svnrepo/project/branches
not-a@{0}reflog/

If you make it with SVN 1.6 its still there with SVN 1.7.  That's good, it
means you can ship a prebuilt repository and check it against SVN 1.7.

The bad news is the new code segfaults on it.  I don't know if that's the SVN
1.7 API choking on its own stuff or because of my changes or both.  If you set
up the test I can try and fix it.  Otherwise I'll just flounder in shell.


-- 
"I went to college, which is a lot like being in the Army, except when
 stupid people yell at me for stupid things, I can hit them."
    -- Jonathan Schwarz
