From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: bug report : 2.3.5  ssh repo not found
Date: Sat, 25 Apr 2015 23:34:45 +0200
Message-ID: <553C0875.3090706@web.de>
References: <553B2CC8.9020204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Chris <chrisb.duck@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 25 23:35:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ym7j5-0003IV-2s
	for gcvg-git-2@plane.gmane.org; Sat, 25 Apr 2015 23:35:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbbDYVew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2015 17:34:52 -0400
Received: from mout.web.de ([212.227.17.12]:56951 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771AbbDYVev (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2015 17:34:51 -0400
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MD8BU-1YVfhr1vI4-00GaNs; Sat, 25 Apr 2015 23:34:47
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <553B2CC8.9020204@gmail.com>
X-Provags-ID: V03:K0:VhysgJnJ0zleHVI1eHChO+L0327/Dc8rkF5G4Jnf0Yueb5XfYQV
 ESV3Zm6YzPlLFY3CGrJBnqMmrt+g51v24KArNUlHhOFR9t2xfeV1RdWLz9oJCR0UlraQUks
 3yCDGz6iuWWjwHGnNvsvz3l0AmVV8UWHBrhrVvzvvMbZmrhcz4TXovxbUIFpDM4KaxvPnwX
 gkmA7QluZEBRU0ckvy6cQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267801>

On 2015-04-25 07.57, Chris wrote:
> Hello,
> 
> Using git version 2.3.5 with kernel 3.19.3-3-ARCH #1 SMP PREEMPT x86_64 I see the following error message when pulling or cloning a repo over ssh:
> 
> """
> git clone ssh://user@mydomain:/home/user/path/to/project.git
> Cloning into 'project'...
> ssh: Could not resolve hostname mydomain:: Name or service not known
> fatal: Could not read from remote repository.
> 
> Please make sure you have the correct access rights
> and the repository exists.
> """
> 
> Obviously I changed the url to hide credential info
> 
> After ensuring DNS was OK and being able to ssh to that instance directly I tried downgrading git to my distro's last installed version of git version 2.2.2 and now I can clone / pull / push to/from that repo without issue.
> 
> Is this a bug?
> 
> Best,
> Chris

It's a know issue/bug, sorry for the inconvenience.

There are 2 options:
Either:

change the URL
git clone ssh://user@mydomain:/home/user/path/to/project.git
into
git clone ssh://user@mydomain/home/user/path/to/project.git

(In other words, remove the ':' after the hostname)


Or
Compile Git yourself from the latest git.git/master, which has this fix:

commit 9718c7c0c2a92585729d0f2e05ebf2c44b0cc56a
Merge: a59ac46 6b6c5f7
Author: Junio C Hamano <gitster@pobox.com>
Date:   Mon Apr 20 15:28:33 2015 -0700

    Merge branch 'tb/connect-ipv6-parse-fix'
    
    An earlier update to the parser that disects an address broke an
    address, followed by a colon, followed by an empty string (instead
    of the port number).
    
    * tb/connect-ipv6-parse-fix:
      connect.c: ignore extra colon after hostname
