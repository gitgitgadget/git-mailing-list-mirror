From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [BUG] A part of an edge from an octopus merge gets colored, even
 with --color=never
Date: Tue, 17 May 2016 22:02:22 +0200
Message-ID: <573B78CE.1080200@kdbg.org>
References: <CAM-tV-_Easz+HA0GX0YkY4FZ2LithQy0+omq64D-OoHKkRe55A@mail.gmail.com>
 <573B6BF5.1090004@kdbg.org> <20160517194533.GA11289@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Noam Postavsky <npostavs@users.sourceforge.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 17 22:02:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2lCI-0003bR-6E
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 22:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbcEQUC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 16:02:26 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:30672 "EHLO bsmtp7.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750975AbcEQUCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 16:02:25 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp7.bon.at (Postfix) with ESMTPSA id 3r8Ssp4mxRz5tl9;
	Tue, 17 May 2016 22:02:22 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 3338E51EA;
	Tue, 17 May 2016 22:02:22 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <20160517194533.GA11289@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294909>

Am 17.05.2016 um 21:45 schrieb Jeff King:
> On Tue, May 17, 2016 at 09:07:33PM +0200, Johannes Sixt wrote:
>
>> Am 15.05.2016 um 15:05 schrieb Noam Postavsky:
>>> With a certain topology involving an octopus merge, git log --graph
>>> --oneline --all --color=never produces output which includes some ANSI
>>> escape code coloring. Attached is a script to reproduce the problem
>>> (creates a git repository in subdir log-format-test), along with
>>> sample graph and valgrind output (indicates some unitialialized memory
>>> access).
>>>
>>> I've observed the problem with Windows git versions 2.7.0, 2.5.3.
>>> I've NOT observed it with 1.9.5,
>>>
>>> On GNU/Linux the symptom only appears when running with valgrind, I
>>> tried versions
>>> 2.8.0, and 2.8.2.402.gedec370 (the last is where the valgrind output comes from)
>>>
>>
>> Sorry, I can't reproduce your observation. I ran the script you provided
>> with HOME=$PWD and a minimal .gitconfig that only sets user.email. But
>> valgrind is happy with both 2.8.0 and v2.8.2-402-gedec370 on my Linux box.
>
> Interesting. It replicates out of the box for me.

"Out of the box" are the magic words. I usually compile with -O0, which 
doesn't trigger the valgrind report.

When I compile with a 3.x based gcc on Windows, I see these warnings:

     CC color.o
color.c: In function 'color_parse_mem':
color.c:203: warning: 'c.value' may be used uninitialized in this function
color.c:203: warning: 'c.blue' may be used uninitialized in this function
color.c:203: warning: 'c.green' may be used uninitialized in this function
color.c:203: warning: 'c.red' may be used uninitialized in this function

(which triggered my curiosity in this bug report). But they seem to be 
unrelated and are most likely false positives.

-- Hannes
