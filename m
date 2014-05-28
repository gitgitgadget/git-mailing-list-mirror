From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: Git chokes on large file
Date: Wed, 28 May 2014 17:05:58 +0200
Message-ID: <5385FB56.6020009@virtuell-zuhause.de>
References: <201405271647.s4RGlDJc024596@hobgoblin.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: "Dale R. Worley" <worley@alum.mit.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 28 17:06:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpfQh-0006xs-9s
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 17:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909AbaE1PGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 11:06:07 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:42970 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752060AbaE1PGF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 May 2014 11:06:05 -0400
Received: from p3ee2f974.dip0.t-ipconnect.de ([62.226.249.116] helo=[192.168.100.43]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1WpfQW-0007th-3p; Wed, 28 May 2014 17:06:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <201405271647.s4RGlDJc024596@hobgoblin.ariadne.com>
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1401289565;9973b1b3;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250288>

Am 27.05.2014 18:47, schrieb Dale R. Worley:
> Even doing a 'git reset' does not put the repository in a state where
> 'git fsck' will complete:

You have to remove the offending commit also from the reflog.

The following snipped creates an offending commit, big_file is 2GB which
is too large for git on windows, and later removes it completely so that
git fsck passes again.

-----------------------------------
git init
echo 1 > some_file
git add some_file
git commit -m "add some_file"
git add big_file
git commit -m "add big_file" # reports malloc error without the -q flag
git log --stat # malloc error
git reset HEAD^1
git fsck --full --strict --verbose # fails
git reflog expire --expire=now --all # remove all reflog entries
git gc --prune=now
git fsck --full --strict --verbose # passes
-----------------------------------
