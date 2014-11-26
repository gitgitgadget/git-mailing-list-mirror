From: Paul Smith <paul@mad-scientist.net>
Subject: Why does git merge --squash fail when merge.ff is set to only?
Date: Wed, 26 Nov 2014 14:42:57 -0500
Organization: GNU's Not UNIX!
Message-ID: <1417030977.23650.42.camel@homebase>
Reply-To: paul@mad-scientist.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 26 20:46:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtiXb-0001Jc-OJ
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 20:46:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340AbaKZTqO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 14:46:14 -0500
Received: from qproxy1-pub.mail.unifiedlayer.com ([173.254.64.10]:42993 "HELO
	qproxy1-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751062AbaKZTqN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Nov 2014 14:46:13 -0500
Received: (qmail 29967 invoked by uid 0); 26 Nov 2014 19:42:59 -0000
Received: from unknown (HELO cmgw3) (10.0.90.84)
  by qproxy1.mail.unifiedlayer.com with SMTP; 26 Nov 2014 19:42:59 -0000
Received: from box531.bluehost.com ([74.220.219.131])
	by cmgw3 with 
	id LKiv1p00V2qhmhE01KiyP7; Wed, 26 Nov 2014 12:42:59 -0700
X-Authority-Analysis: v=2.1 cv=W++rC3mk c=1 sm=1 tr=0
 a=GcR8MKwCKDX7fzHfRD/fNg==:117 a=GcR8MKwCKDX7fzHfRD/fNg==:17 a=cNaOj0WVAAAA:8
 a=f5113yIGAAAA:8 a=IkcTkHD0fZMA:10 a=pBbsfl06AAAA:8 a=cdVwids0oJMA:10
 a=qenwzdlAJUAA:10 a=5y4faFyK3SkA:10 a=a2qg_i203ghgJXeBkK4A:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mad-scientist.net; s=default;
	h=Content-Transfer-Encoding:Mime-Version:Content-Type:Date:To:Reply-To:From:Subject:Message-ID; bh=yv6gkGm4J+wTFnWi6L1ia5I+03VIbRafC48+lZjy2/Y=;
	b=pNvbbaDRbFwZZM9iphhkWiH2ZQu6oZmmE0PoUviHXhX4oMfeK/t29tIK2PJHydJHk9Ty6ZiT7b1hLWo+dlSscEg3MBe3dBa3KfJ+JP7VhwcwsGPgjsLGa1J27w9U6SHR;
Received: from [72.74.248.26] (port=38425 helo=homebase.home)
	by box531.bluehost.com with esmtpsa (TLSv1.2:DHE-RSA-AES128-SHA:128)
	(Exim 4.82)
	(envelope-from <paul@mad-scientist.net>)
	id 1XtiUJ-0007kl-4g
	for git@vger.kernel.org; Wed, 26 Nov 2014 12:42:55 -0700
X-Mailer: Evolution 3.11.3-fta1~13.10 
X-Identified-User: {678:box531.bluehost.com:madscie1:mad-scientist.us} {sentby:smtp auth 72.74.248.26 authed with paul@mad-scientist.us}
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260297>

In our development process we always want to do rebase and only rarely
create merge commits, and so we have a recommendation to set the
merge.ff configuration attribute to "only".

This is great, however it appears to break git merge --squash (which we
also use constantly).

If I'm squash-merging from a branch which is not based on HEAD (cannot
use fast-forwarding) then I get the extremely cryptic error:

  $ git checkout master
  $ git pull
  $ git merge --squash my-branch
  fatal: Not possible to fast-forward, aborting.

I couldn't even understand what this error meant for a while: what was
being fast-forwarded here anyway?  It took me a lot of thought to
realize it was related to the merge.ff config setting.

Eventually I figured it out, and now have this workaround:

  $ git merge --ff --squash my-branch

But, shouldn't we consider this a bug?  I don't see any reason why
--squash should pay attention to the ff config setting, or command line
flags either for that matter.  IMHO when you add the --squash flag, the
ff options/config should be ignored.

Or, am I missing some subtle issue here?
