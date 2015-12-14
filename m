From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 0/8] Rerolling sb/submodule-parallel-fetch for the time
 after 2.7
Date: Mon, 14 Dec 2015 21:40:50 +0100
Message-ID: <566F2952.8000307@kdbg.org>
References: <1450121838-7069-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com
To: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 21:41:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8ZvV-0004ri-LP
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 21:40:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbbLNUkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 15:40:52 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:58703 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932075AbbLNUkw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 15:40:52 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3pKF3k5XBdz5tlJ;
	Mon, 14 Dec 2015 21:40:50 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 6637E53A9;
	Mon, 14 Dec 2015 21:40:50 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
In-Reply-To: <1450121838-7069-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282405>

Am 14.12.2015 um 20:37 schrieb Stefan Beller:
> I am sending out a new version for replacing sb/submodule-parallel-fetch for
> the time after the 2.7 release.
>
> The content are
>   * all patches as in the branch sb/submodule-parallel-fetch
>   * inlcuding the fixups as suggested by Hannes,
>   * write a message to the debug log for better testing and debugging purposes
>    (a patch cherry picked from the series which is supposed to build on top of this)
>
> The patches themselves were rebased such that there are no fixup commits
> any more, but we get things right the first time.
>
> The commit message of "run-command: add an asynchronous parallel child processor"
> has slightly been updated to mention the fact that we don't want to use waitpid(-1)
> but rather use the assumption of child's stderr living as long as the child itself.

Thanks! I rebased a version of sb/submodule-parallel-fetch that includes 
my suggested improvements, and the result is identical to this series 
except for the trace output mentioned in the last bullet point.

With or without addressing my note about the commit message in 6/8:

Acked-by: Johannes Sixt <j6t@kdbg.org>

> Thanks,
> Stefan
>
>
> Jonathan Nieder (1):
>    submodule.c: write "Fetching submodule <foo>" to stderr
>
> Stefan Beller (7):
>    xread: poll on non blocking fds
>    xread_nonblock: add functionality to read from fds without blocking
>    strbuf: add strbuf_read_once to read without blocking
>    sigchain: add command to pop all common signals
>    run-command: add an asynchronous parallel child processor
>    fetch_populated_submodules: use new parallel job processing
>    submodules: allow parallel fetching, add tests and documentation
>
>   Documentation/fetch-options.txt |   7 +
>   builtin/fetch.c                 |   6 +-
>   builtin/pull.c                  |   6 +
>   git-compat-util.h               |   1 +
>   run-command.c                   | 335 ++++++++++++++++++++++++++++++++++++++++
>   run-command.h                   |  80 ++++++++++
>   sigchain.c                      |   9 ++
>   sigchain.h                      |   1 +
>   strbuf.c                        |  11 ++
>   strbuf.h                        |   8 +
>   submodule.c                     | 141 +++++++++++------
>   submodule.h                     |   2 +-
>   t/t0061-run-command.sh          |  53 +++++++
>   t/t5526-fetch-submodules.sh     |  71 ++++++---
>   test-run-command.c              |  55 ++++++-
>   wrapper.c                       |  35 ++++-
>   16 files changed, 747 insertions(+), 74 deletions(-)
>
