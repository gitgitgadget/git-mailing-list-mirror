From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: [PATCH 1/2] stash drops the stash even if creating the branch
 fails because it already exists
Date: Tue, 28 Sep 2010 15:21:55 +0200
Message-ID: <4CA1EBF3.7090701@dbservice.com>
References: <1285673120-43354-1-git-send-email-tom@dbservice.com> <1285679992-7638-2-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, tla@land.ru, gitster@pobox.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 15:22:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0a8P-0007cH-1T
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 15:22:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753975Ab0I1NWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 09:22:10 -0400
Received: from office.neopsis.com ([78.46.209.98]:50211 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753102Ab0I1NWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 09:22:09 -0400
X-Spam-Status: No, hits=0.0 required=5.0
	tests=BAYES_00: -1.665,TOTAL_SCORE: -1.665,autolearn=ham
X-Spam-Level: 
Received: from calvin.caurea.org ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Tue, 28 Sep 2010 15:21:56 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <1285679992-7638-2-git-send-email-jon.seymour@gmail.com>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157421>

On 9/28/10 3:19 PM, Jon Seymour wrote:
> From: Tomas Carnecky <tom@dbservice.com>
> 
> This bug was disovered by someone on IRC when he tried to 'git stash branch <branch> <stash>'
> while <branch> already existed. In that case the stash is dropped even though it isn't
> applied on any branch, so the stash is effectively lost. I think that shouldn't happen,
> so here is a test.

This line was missing from my original patch, sorry about that:
Signed-off-by: Tomas Carnecky <tom@dbservice.com>

> ---
>  t/t3903-stash.sh |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 9ed2396..0f6b2e4 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -545,4 +545,15 @@ test_expect_success 'invalid ref of the form stash@{n}, n >= N' '
>  	git stash drop
>  '
>  
> +test_expect_failure 'stash branch should not drop the stash if the branch exists' '
> +	git stash clear &&
> +	echo foo > file &&
> +	git add file &&
> +	git commit -m initial &&
> +	echo bar > file &&
> +	git stash &&
> +	test_must_fail git stash branch master stash@{0} &&
> +	git rev-parse stash@{0} --
> +'
> +
>  test_done
