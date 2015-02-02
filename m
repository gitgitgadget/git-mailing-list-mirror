From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 00/19] Introduce an internal API to interact with the
 fsck machinery
Date: Mon, 02 Feb 2015 12:41:56 +0100
Organization: gmx
Message-ID: <060e1e6a5530dfb311074b0aa854b281@www.dscho.org>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1422737997.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 02 12:42:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIFOM-0000Gf-OG
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 12:42:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754077AbbBBLmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 06:42:07 -0500
Received: from mout.gmx.net ([212.227.15.19]:55678 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752030AbbBBLmE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 06:42:04 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MQ2Wx-1YLq1m2Iip-005E15; Mon, 02 Feb 2015 12:41:57
 +0100
In-Reply-To: <cover.1422737997.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:Pyk+rdWWbQuEaIe/MqkYtOyUJCIErwgxa8zT769Ctvg308sTjIr
 zA3lGwwSxVYLWxq9dNr4bcXegSsGvuKX3qTtMUGJf3EKGcP8LHZ9+boWpUU7CAVj4cfMBNh
 ro9vxgTwmV75BtAKwe7rIi3FH0rIKcj0FOAi0VOJIT0koR1Bc8RWKF7zZkkMe9B4l1XFscG
 eYG+GiI/hWhH1Bb1Nq+lA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263257>

Hi all (in particular Junio),

On 2015-01-31 22:04, Johannes Schindelin wrote:

> [...] switch to fsck.severity to address Michael's
> concerns that letting fsck.(error|warn|ignore)'s comma-separated lists
> possibly overriding each other partially;

Having participated in the CodingStyle thread, I came to the conclusion that the fsck.severity solution favors syntax over intuitiveness.

Therefore, I would like to support the case for `fsck.level.missingAuthor` (note that there is an extra ".level." in contrast to earlier suggestions).

The benefits:

- it is very, very easy to understand

- cumulative settings are intuitively cumulative, i.e. setting `fsck.level.missingAuthor` will leave `fsck.level.invalidEmail` completely unaffected

- it is very easy to enquire and set the levels via existing `git config` calls

Now, there is one downside, but *only* if we ignore Postel's law.

Postel's law ("be lenient in what you accept as input, but strict in your output") would dictate that our message ID parser accept both "missing-author" and "missingAuthor" if we follow the inconsistent practice of using lowercase-dashed keys on the command-line but CamelCased ones in the config.

However, earlier Junio made very clear that the parser is required to fail to parse "missing-author" in the config, and to fail to parse "missingAuthor" on the command-line.

Therefore, the design I recommend above will require two, minimally different parsers for essentially the same thing.

IMHO this is a downside that is by far outweighed by the ease of use of the new feature, therefore I am willing to bear the burden of implementation.

Do you agree?

Ciao,
Dscho
