From: Eric Raible <raible@nextest.com>
Subject: RFH: unexpected reflog behavior with --since=
Date: Tue, 8 Nov 2011 16:22:41 -0800
Message-ID: <4EB9C7D1.30201@nextest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 09 01:22:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNvwG-00082F-Bt
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 01:22:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500Ab1KIAWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 19:22:43 -0500
Received: from smtps.nextest.com ([12.96.234.114]:36365 "EHLO
	exchange.DOMAIN1.nextest.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755395Ab1KIAWn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2011 19:22:43 -0500
Received: from [131.101.151.102] (131.101.151.102) by
 Exchange.DOMAIN1.nextest.com (131.101.21.39) with Microsoft SMTP Server (TLS)
 id 8.2.176.0; Tue, 8 Nov 2011 16:22:41 -0800
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185120>

I'm trying to leverage the reflog to speed up our $dayjob build procedure
(it's complicated), and found unexpected behavior when limiting reflog
output with --since.

    git init reflog-test
    cd reflog-test

    touch a && git add a && git commit -m'add a'
    sleep 1
    touch b && git add b && git commit -m'add b'

    # add_b will be the time that b was added (email ends with '>')
    add_b=$(tail -1 .git/logs/HEAD | perl -e "print( <> =~ m/> (\S+)/ )")

    # It's reported correctly here:
    git log -g --oneline --since=$add_b

    # But after a reset no history isn't shown.
    git reset --hard HEAD^
    git log -g --oneline --since=$add_b

Is this a bug?  Of course everything is reported when --since isn't used,
but not so when limited with --since.

1.7.7.1.msysgit.0

Thanks - Eric
