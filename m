From: Andrew Pimlott <andrew@pimlott.net>
Subject: rebase --autosquash does not handle fixup! of fixup!
Date: Tue, 11 Jun 2013 11:05:30 -0700
Message-ID: <20130611180530.GA18488@oinkpad.pimlott.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 11 20:42:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmTW2-00089v-T4
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 20:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752371Ab3FKSlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 14:41:55 -0400
Received: from pimlott.net ([72.249.23.100]:41189 "EHLO fugue.pimlott.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750996Ab3FKSly (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 14:41:54 -0400
X-Greylist: delayed 2173 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Jun 2013 14:41:54 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pimlott.net; s=default;
	h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date; bh=/YW1sgfueFeplYl4qmwoPkmyE8q/zpwMF9xjtoIN/iQ=;
	b=BD1aXAxMv5nM2nrdUDO0eXeN8i/KnEx13mSYoGFIlMVIRk0XGs5raXQaKagaNOgsT5WZDnq6poEQJ+KYrV4cFKceNOgXfkUuRlinML/tcs+L/hFbUubwGmPJEDGCLp3rbVZrhI2p8rhSyLecSDK0pbE3hpjaNxA32Jwhd45NM2o=;
Received: from c-71-198-212-229.hsd1.ca.comcast.net ([71.198.212.229] helo=oinkpad.pimlott.net)
	by fugue.pimlott.net with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <andrew@pimlott.net>)
	id 1UmSwr-0004NY-MJ; Tue, 11 Jun 2013 11:05:37 -0700
Received: from andrew by oinkpad.pimlott.net with local (Exim 4.80)
	(envelope-from <andrew@pimlott.net>)
	id 1UmSwk-0005A1-E8; Tue, 11 Jun 2013 18:05:30 +0000
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227491>

git rebase -i --autosquash does not handle a fixup! of a fixup!, such as
the history:

    aaaaaaa fix nasty bug
    ...
    bbbbbbb fixup! fix nasty bug
    ...
    ccccccc fixup! fixup! fix nasty bug

--autosquash produces:

    pick aaaaaaa fix nasty bug
    fixup bbbbbbb fixup! fix nasty bug
    ...
    pick ccccccc fixup! fixup! fix nasty bug

This defeats the workflow I was hoping to use:

    git commit -m 'fix nasty bug'
    ...
    git commit --fixup :/nasty
    ...
    git commit --fixup :/nasty

The second :/nasty resolves to the previous fixup, not the initial
commit.  I could have made the regular expression more precise, but this
would be a hassle.

Would a change to support fixup! fixup! be considered?

Andrew

(Please Cc: me on replies.)
