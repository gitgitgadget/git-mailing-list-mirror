From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [Bug?] log -p -W showing the whole file for a patch that adds to
 the end?
Date: Sat, 21 May 2016 20:42:48 +0200
Message-ID: <5740AC28.6010202@web.de>
References: <xmqqh9e5mvjs.fsf@gitster.mtv.corp.google.com>
 <xmqq4ma5msrd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:43:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4Bs4-0007vr-1v
	for gcvg-git-2@plane.gmane.org; Sat, 21 May 2016 20:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbcEUSm6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2016 14:42:58 -0400
Received: from mout.web.de ([212.227.15.3]:53412 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751179AbcEUSm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2016 14:42:57 -0400
Received: from [192.168.178.36] ([79.237.63.247]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0Lj2TO-1bh5e837y2-00dCqa; Sat, 21 May 2016 20:42:50
 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <xmqq4ma5msrd.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:LBSZuclfNx5m34gKU7Aa0gAIbBE1o7BXBrkrOBc1eGLlK1r+Sq5
 d9ktLWu0N5TUALUjT7rkFDKIMtUy5WspOchnRVRsqN06qwXDq61iZKeaEdzUbWwuWry8KwS
 67Qj0/Q6QrEZ6JFziBrSqGrxbtY+VaUBzx/xmmivcxlKyj6kftEGhD3QylRNvLKBmThXHgy
 dTe7/JbkxZc8p6W0jAm/A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+m0Z5H/jrks=:5uNJIJsMoLfvkZhqvJDny2
 z3zfMMrJ2E1veVWH7L56+qyY/gjW3qtIeB+FpGdjRuX4BX+k6bmRmKyKKEOeK1ea2VVO7R1mQ
 6xvgwQ/XpmDijobkQlAxmVXlybwD44t+hr/34VscrS0GqW430c+H/gJFuyhUDHkWair8OmS7u
 SYu8P18KXUu3oH4K/dh7EFkHo6Q3Zv+ZtrW8Tp2thWKY4hK4oj3B+ezTEjkdJ1R6vapKc00X7
 gLQc1yN5oovXMU9U3oIaExvXNvNxcYRN7S6CJF7EWBRxfvhZWUhHkdhKa97flV1Y905zylMKp
 UfyDFQWTR9TlNdj5FvR1tg76v+H+B0OJbDLpHImKDgQMXTll06XFgCO6pZU/1Ac6hGeuiJJ8w
 WcMpSITd2oMgThrsU3qAvxLiTo6VgLCe5Uyl8hBwwoft6aTTvAOiPY/jyQewTkyNS83Nf9bYz
 sYBKt3zshYsB+l4qHMQ/rQgTyQi3SDNmLoieUqXvNjB7dJjnucaHjOAKSERhrrkqq3HWvWYqZ
 NLWEBDvlyhKMDPGQhzJ087zYCLHBBt2yn+z7L3cdfN8jUQIdA49DoaAkTkzvPHdmlBbVzEl0j
 hFpJ5T7WChmVGVFWNiCVeCKwe5kDoddxcO/OwFLUZxqxDyThIjRoo25v4SRrdFVLCOsx6/nEM
 ui+Hekg5vFn61JXZPvdbHM7tqQCHiT8xrN2ZDqSUM5SUFKZxazK9hhRDsh5NS+21maBU2PJoG
 MJDyNmAfDZPA9Hzgz/s4K9MV5XJC0R3AcQC0kl0knTHgvcaJb7++psczC+1eU3KQoybCV4Ge 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295232>

Am 11.05.2016 um 00:51 schrieb Junio C Hamano:
> The helper function get_func_line() however gets confused when a
> hunk adds a new function at the very end, and returns -1 to signal
> that it did not find a suitable "function header line", i.e. the
> beginning of previous function.  The caller then takes this signal
> and shows from the very beginning of the file.  We end up showing
> the entire file, starting from the very beginning to the end of the
> newly added lines.

In this case we need to look at the added lines in the post-image to
see if the original context suffices.  We currently only look at the
pre-image.  And if we have to extend the context simply search from the
bottom of the pre-image.  That's what the second patch does; the first
one is just a small preparation.

The last three patches introduce special handling of empty lines.
Before them the code for -W only distinguished between function lines
and non-function lines.  Not allowing empty lines between functions to
extend the context with -W is most useful in the case of appended full
functions -- otherwise we'd get the preceding function shown as well as
it "belongs" to the empty line separating them.

And if we do that then it's easy and more consistent to stop showing
empty lines trailing functions with -W (unless they're already included
in the one requested with -u/-U, of course).  Doing the same for grep
then is only fair.

Considering empty lines as uninteresting collides with languages like
Whitespace.  I'm not sure -W was useful for it to begin with, though.
Any other possible downsides?

NB: Comments are still not handled specially.  That means they are
considered to be part of the preceding function.  Fixing that is not in
scope for this series.  (And I'm not sure it would be worth the hassle.)

  diff: factor out match_func_rec()
  diff: handle appended chunks better with -W
  diff: ignore empty lines before added functions with -W
  diff: don't include common trailing empty lines with -W
  grep: don't extend context to trailing empty lines with -W

 grep.c        | 28 ++++++++++++++++++++++++--
 xdiff/xemit.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 82 insertions(+), 9 deletions(-)
