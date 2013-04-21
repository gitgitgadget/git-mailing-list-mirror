From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git log -p unexpected behaviour - security risk?
Date: Sun, 21 Apr 2013 03:21:50 -0700
Message-ID: <20130421102150.GJ10429@elie.Belkin>
References: <CAHQ6N+qdA5Lck1_ByOYPOG4ngsztz3HQSw8c_U_K8OnDapj4bQ@mail.gmail.com>
 <20130420140051.GB29454@ruderich.org>
 <7vd2towdiq.fsf@alter.siamese.dyndns.org>
 <CAHQ6N+pKb-44rOM7ocYMvSDyimvAGZppX1Gc=st59aVKzJSBKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Simon Ruderich <simon@ruderich.org>,
	Git List <git@vger.kernel.org>,
	Tay Ray Chuan <rctay89@gmail.com>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 12:22:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTrPW-0003On-3H
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 12:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023Ab3DUKWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 06:22:00 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:52290 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752885Ab3DUKV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 06:21:59 -0400
Received: by mail-pa0-f49.google.com with SMTP id kp14so3017402pab.22
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 03:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=gePnJPF3dq5ot0onZCTRM0A67u2XhXVm8OOmKd6RNSE=;
        b=b1ICIagfzJfId3eJoZAVY1qhb4its0hq4G1lPKmi7qME5m3TTQraH8UONKUx82veij
         hqgDlQuO61hJCtFYIj5+jvqJQEgWE/ExvKJ06uyuDy7gNL9noUJpOvRoUeM5UhlV88xl
         wTo/ljBeRoqIsz4x2lxpeTVo+HORzi+DLVKU2XUAKTRep9WDQ4W6fs/z54MZaujeODR2
         ev4sGj7wSECxvPJeIrHni52CINTymO8lr92NbuiwqEC8SsqVCjhRcYEYRvrckw7Zxl4T
         zwV7uZ9UY75rsKvgs8EHjGxyza7erGylMVxmhWfWKhTbSsMMX/7u9KdepPv+h+MyR2G7
         apVA==
X-Received: by 10.66.138.109 with SMTP id qp13mr6886588pab.127.1366539719089;
        Sun, 21 Apr 2013 03:21:59 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id hp1sm22321349pac.3.2013.04.21.03.21.56
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 03:21:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHQ6N+pKb-44rOM7ocYMvSDyimvAGZppX1Gc=st59aVKzJSBKw@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221940>

John Tapsell wrote:

> I'm concerned that noone is taking this security risk seriously.

If anyone relies on "git log -p" or "git log -p --cc" output to make
sure that the untrusted code they use doesn't introduce unwanted
behavior, they are making a serious mistake.  A merge can completely
undo important changes made in a side branch and "-c" and "--cc" will
not show it.  The lack of "-c" cannot be a security issue here,
because in normal life adding "-c" isn't a secure deployment strategy.

That's why if you want to review the code you are pulling in as a
whole, it is worthwhile to do

	git diff HEAD...FETCH_HEAD

That is how you ask "What code changes does FETCH_HEAD introduce?"
before putting your stamp of approval on them by merging and pushing
out the result.  Unfortunately that doesn't protect you from
maliciously written commits that will be encountered when bisecting.
At some point you have to be able to trust people.

Hope that helps,
Jonathan
