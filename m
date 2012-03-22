From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH v2 2/3] Adjust stat width calculations to take --graph
 output into account
Date: Thu, 22 Mar 2012 21:28:09 +0100
Message-ID: <4F6B8B59.4010106@in.waw.pl>
References: <1332444461-11957-1-git-send-email-lucian.poston@gmail.com> <1332444461-11957-2-git-send-email-lucian.poston@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Bo Yang <struggleyb.nku@gmail.com>
To: Lucian Poston <lucian.poston@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 21:28:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAocQ-0000iA-3X
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 21:28:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325Ab2CVU2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 16:28:17 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:56091 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932141Ab2CVU2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 16:28:16 -0400
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=[192.168.0.12])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SAocJ-0003TK-5q; Thu, 22 Mar 2012 21:28:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120104 Icedove/8.0
In-Reply-To: <1332444461-11957-2-git-send-email-lucian.poston@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193710>

On 03/22/2012 08:27 PM, Lucian Poston wrote:
> The recent change to compute the width of diff --stat did not take into
> consideration the output from --graph. The consequence is that when both
> options are used, e.g. in 'log --stat --graph', the lines are too long.
>
> Adjust stat width calculations to take --graph output into account.
(1)
> Adjust stat width calculations to reserve space for required characters before
> scaling the widths for the filename and graph portions of the diff-stat. For
> example, consider:
>
> " diff.c |   66 ++-"
>
> Before calculating the widths allocated to the filename, "diff.c", and the
> graph, "++-", reserve space for the initial " " and the part between the
> filename and graph portions " |   66 ". Then, divide the remaining space so
> that 5/8ths is given to the filename and 3/8ths for the graph.
(2)

Hi,

I think that (1) is good. It fixes the bug and even makes the code more 
readable. But (2) should be separated, IMHO... There was a motivation 
for the layout in 1b058bc30df5f: not changing previous behaviour ("... 
at least 5/8 of available space is devoted to filenames. On a standard 
80 column terminal, or if not connected to a terminal and using the 
default of 80 columns, this gives the same partition as before.").
(2) would change the way format-patch --stat output looks, which 
probably is not wanted.

-
Zbyszek


> Update the affected test, t4502.
>
> Signed-off-by: Lucian Poston<lucian.poston@gmail.com>
> ---
>   diff.c                 |   66 ++++++++++++++++++++++++++++++++---------------
>   t/t4052-stat-output.sh |    4 +-
>   2 files changed, 47 insertions(+), 23 deletions(-)
