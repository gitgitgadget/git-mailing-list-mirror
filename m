From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 2/5] t4211: demonstrate empty -L range crash
Date: Tue, 23 Jul 2013 19:59:42 +0200
Message-ID: <20130723175942.GA21019@goldbirke>
References: <1374589688-27751-1-git-send-email-sunshine@sunshineco.com>
 <1374589688-27751-3-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@inf.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jul 23 19:59:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1gsM-0006rr-PL
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 19:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933763Ab3GWR7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 13:59:51 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:55744 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933722Ab3GWR7u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 13:59:50 -0400
Received: from localhost6.localdomain6 (e179222206.adsl.alicedsl.de [85.179.222.206])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MN728-1V3ure494S-007Dtm; Tue, 23 Jul 2013 19:59:43 +0200
Content-Disposition: inline
In-Reply-To: <1374589688-27751-3-git-send-email-sunshine@sunshineco.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:QgqqqyBq8kDF8YUQu2VT93uD9CroQqbeIf334Oy/PgX
 RcU5yBTK7STHCcjlmIYvh4K8j1kofwIVL7Q6QlblPRfZHY9xmW
 P5Z8R+JSV/qiqU9EHBbSdFYxz35YYaZ3t4o89wCpnhFU7+Yxbo
 gb7bwBe+5SicBe8mDVvOetdnb3zw7LgzMVcLGem3Eua/Hgv7wP
 Q8I22IJ5KB6iLt6Sdde7YoJyIvtAgCas+u25uNI2Smwuvf99/7
 1yngnpEiJ+4r46IX7ZW59OlPvIaGroJBnLgHGtpS/aWFj5egnB
 A2r1T4q95mVaE+JXE1FLviKKOlRaRYdcdKDVL/95eLvfbOV/Zg
 AIhDipsQ/PPcxAgxpdpm/nZe5vLjFPagLtdnYJCPq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231046>

On Tue, Jul 23, 2013 at 10:28:05AM -0400, Eric Sunshine wrote:
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  t/t4211-line-log.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
> index 7776f93..1db1edd 100755
> --- a/t/t4211-line-log.sh
> +++ b/t/t4211-line-log.sh
> @@ -64,4 +64,12 @@ test_bad_opts "-L 1,1000:b.c" "has only.*lines"
>  test_bad_opts "-L :b.c" "argument.*not of the form"
>  test_bad_opts "-L :foo:b.c" "no match"
>  
> +# There is a separate bug when an empty -L range is the first -L encountered,
> +# thus to demonstrate this particular bug, the empty -L range must follow a
> +# non-empty -L range.
> +test_expect_failure '-L {empty-range} (any -L)' '
> +	n=$(expr $(cat b.c | wc -l) + 1) &&

You could avoid the 'cat' here and patch in 4/5 by doing $(wc -l <b.c).

(Side question: the test suite is full with similar constructs, i.e.
redirecting file contents to stdin, but why not just use wc -l b.c,
i.e. let wc open the file?)
