From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: git checkout under 1.7.6 does not properly list untracked files
 and aborts
Date: Tue, 20 Sep 2011 12:26:23 -0600
Message-ID: <4E78DACF.3030200@workspacewhiz.com>
References: <4E6A7167.6070408@workspacewhiz.com> <4E779BA4.8070109@workspacewhiz.com> <4E78ACE2.60306@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Sep 20 20:25:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R650o-00043l-Dk
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 20:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762Ab1ITSZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 14:25:37 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:40205 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192Ab1ITSZg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 14:25:36 -0400
Received: (qmail 27270 invoked by uid 399); 20 Sep 2011 12:25:33 -0600
Received: from unknown (HELO ?192.168.1.11?) (jjensen@workspacewhiz.com@50.8.110.77)
  by hsmail.qwknetllc.com with ESMTPAM; 20 Sep 2011 12:25:33 -0600
X-Originating-IP: 50.8.110.77
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <4E78ACE2.60306@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181775>

----- Original Message -----
From: Michael J Gruber
Date: 9/20/2011 9:10 AM
> Can you provide a simple test case, such as this one:
>
> ---%<---
> #!/bin/sh
>
> rm -Rf utest || exit 1
> mkdir utest || exit 1
> cd utest || exit 1
> git init
> echo tracked>a
> git add a
> git commit -m a a
> git branch side
> echo tracked>b
> git add b
> git commit -m b
> cat b
> git checkout side
> cat b
> echo untracked>b
> cat b
> git checkout master
> cat b
> ---%<---
>
> Does this test reproduce your problem on msysgit?
As listed, your script produces the same results on msysGit.

It appears the issue is related to sparse checkouts:

---%<---
#!/bin/sh

rm -Rf utest || exit 1
mkdir utest || exit 1
cd utest || exit 1
git init
git config core.sparseCheckout true
echo *>.git/info/sparse-checkout
echo tracked>a
git add a
git commit -m a a
git branch side
echo tracked>b
git add b
git commit -m b
cat b
git checkout side
cat b
echo untracked>b
cat b
git checkout master
cat b
---%<---

-Josh
