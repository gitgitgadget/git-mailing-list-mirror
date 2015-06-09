From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: GNU diff and git diff - difference on myers
 =?UTF-8?Q?algorithm=3F?=
Date: Tue, 09 Jun 2015 10:25:44 +0200
Organization: gmx
Message-ID: <0add7d95076f5b112af90d8566c29203@www.dscho.org>
References: <CAB=NE6XRnKAY6t+dxT7vO_4wqngXvULh-CqezEAs2r99FkNCTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 10:26:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2Er9-0003kW-Fw
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 10:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753670AbbFIIZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 04:25:55 -0400
Received: from mout.gmx.net ([212.227.15.19]:64011 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752586AbbFIIZw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 04:25:52 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MX1hk-1YWOfm2a3w-00W1HB; Tue, 09 Jun 2015 10:25:46
 +0200
In-Reply-To: <CAB=NE6XRnKAY6t+dxT7vO_4wqngXvULh-CqezEAs2r99FkNCTg@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:rr6GL6J8aJtrZk/0v1udB62JMPPr3+qMPmbmP2suKErL0XotuNL
 U/Hk0LMLfoK/CM6mcJ6A59OybEV+kQ8ynbXDrXZDhZ+rpCpFndwcWh98JuQLL7wqIXpa8ZE
 NoWbZaYc9lUTt1dFm4hg//KHWnFJI8lT08lPSIXegYEvvU3FWuT54kHhPNErVRcX6/7MQiw
 +QVn7TpvAdsAhAikavE2w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ssXzfFMLen8=:Ue6xNtIbfCuAgaqStHk76Q
 qguSYOTrx9RT7x2WGUGI+9tlVXT4iZswUfiXJvMvOhWlXcleZyzY3xHHCOvL5781gZtH+euZN
 ga6pI0jfmEobssoevAC3EAd4OgvW+J4Qkc7pztyhUXNXeFVe6Lu16uG8AYukGrfFYltHWzBUI
 X90W2DfFoPqWWGEkhOXcQ3ZquLfuNLT7bkcOw+zzsc23//HxSFVMn+Imm+NAyvod1YGQiK2UG
 F6P4txpZEcuBWH+onCUrRdpn9m4SQkZlbmQF5L32T2SZumsj+UgiwAYVEUYlSeRe6dMVsH9oB
 6sXiEpcmtQ+kCMZF9+T80h4GgaL/BG303KGo8O+zda2gABVIxGHFlGSTn4ssRO4ZY21Wbu5Zn
 AL6IhTbSS8coU1rYY0fuMJ8PKCc8BBOun7CvFqvBjWybxwrSqzw78WM+bkMI4XWR2YjrnO8Al
 WNlQjOwtTZSjPDsj/HSkUY67qyllldoAzedMGablBoLRn08J9Zy30u198W+56WD5XRzJMQ4XO
 qRRNPoGufRKRsVYNfqo1loeYhbmfEihwixGtFGR3d3ToQ1g1YF8I035rfY5bpZxYvRJaOWl0D
 A5fi9xzIMUr2VEIIEScmV6hR1qZ1tGMr2bMaXg9vVBZh4oEXkV+1DAOdKxdrxcMX5Uzvqtz/Z
 LksV4NbpFMPnSauJvYjAyMs9OHugQ8IDR+OCO4hLG7wNimUbZd9tmks6591/fIhqUuKE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271151>

Hi Luis,

On 2015-06-08 20:34, Luis R. Rodriguez wrote:
> Based on a cursory review of the git code I get the impression that
> GNU diff and git 'diff' do not share any code for the possible diff
> algorithms.

Indeed, Git's diff machinery is based[*1*] ofn libxdiff[*2*], not on GNU diff.

> I'm in particularly curious more about the default "myers"
> algorithm.

Are you looking for a freely available implementation of the Myers algorithm? Or are you interested in understanding it?

Please note that Myers' algorithm is just one first step in most diff implementations (and that other diff algorithms have become popular, in particular because comparing strings can be accelerated by hashing the text lines first, and those hashes can also be used to identify matching pairs of unique lines, giving rise to yet another huge performance boost for typical uses).

The reason why Myers' algorithm is not sufficient for diff implementations is that it only optimizes the "edit distance", i.e. the amount of added/removed lines, while patches should be readable, too, i.e. prefer *consecutive* edits to disjunct ones.

Just to mention one post-processing technique that is so useful that I implemented it for Git[*3*]: the "patience diff" algorithm of Bram Cohen (of BitTorrent fame) finds matching pairs of unique lines -- think of a function from which another function is refactored, for example, intuitively you want the diff to keep the signature of the original function as a context line.

Disclaimer: While it is true that Gene and I shared an office for one month, and that I am once again working in the same institute as he does, all my knowledge about this algorithm stems from my reading his paper and implementing the algorithm in Java for use in JGit[*3*].

> I can take time to do a precise code review of the
> algorithms used on both GNU diff and git but if someone can already
> vet for any differences that'd be appreciated as it would save time.

Again, I am curious what your goal is? I am sure I can support your quest better when I understand what the purpose of this code review should be.

Ciao,
Johannes

Footnote *1*: https://github.com/git/git/commit/3443546f6ef57fe28ea5cca232df8e400bfc3883
Footnote *2*: http://www.xmailserver.org/xdiff-lib.html
Footnote *3*: https://github.com/git/git/blob/master/xdiff/xpatience.c
Footnote *4*: https://github.com/eclipse/jgit/blob/master/org.eclipse.jgit/src/org/eclipse/jgit/diff/MyersDiff.java
