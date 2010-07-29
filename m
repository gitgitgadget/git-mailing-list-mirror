From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: [PATCH] filter-branch tests/docs: avoid \t in sed regexes
Date: Thu, 29 Jul 2010 17:02:40 +0200
Message-ID: <4C519810.6090108@dbservice.com>
References: <AANLkTin5sv8NQ_8NZkQpW9HG4zYZDZHNF80EWK8Km4Mr@mail.gmail.com> <0bb511ca2d155ea7e37850a78375da1803032d6c.1280409717.git.trast@student.ethz.ch> <4C519498.3000702@dbservice.com> <201007291652.52506.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Adam Mercer <ramercer@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jul 29 17:03:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeUdR-000646-AC
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 17:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754469Ab0G2PC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 11:02:56 -0400
Received: from office.neopsis.com ([78.46.209.98]:50819 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754396Ab0G2PCz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 11:02:55 -0400
X-Spam-Status: No, hits=0.0 required=5.0
	tests=AWL: 0.066,BAYES_00: -1.665,TOTAL_SCORE: -1.599,autolearn=ham
X-Spam-Level: 
Received: from calvin.caurea.org ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Thu, 29 Jul 2010 17:02:41 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.7) Gecko/20100713 Thunderbird/3.1.1
In-Reply-To: <201007291652.52506.trast@student.ethz.ch>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152180>

On 7/29/10 4:52 PM, Thomas Rast wrote:
> Tomas Carnecky wrote:
>> *** t7003-filter-branch.sh ***
>> *   ok 17: use index-filter to move into a subdirectory
> 
> Oh, I know.  The test isn't correct, it should be something like the
> patch below.  Otherwise a failure in git-diff (namely that
> directorymoved:newsubdir is invalid) is never detected, and since the
> output in this case is empty, also the test -z succeeds.  Can you
> apply that and see if it makes the test fail for you?
> 
> diff --git i/t/t7003-filter-branch.sh w/t/t7003-filter-branch.sh
> index e90da6d..a8e0c48 100755
> --- i/t/t7003-filter-branch.sh
> +++ w/t/t7003-filter-branch.sh
> @@ -148,7 +148,9 @@ test_expect_success 'use index-filter to move into a subdirectory' '
>  	          GIT_INDEX_FILE=\$GIT_INDEX_FILE.new \
>  			git update-index --index-info &&
>  		  mv \"\$GIT_INDEX_FILE.new\" \"\$GIT_INDEX_FILE\"" directorymoved &&
> -	test -z "$(git diff HEAD directorymoved:newsubdir)"'
> +	git diff HEAD directorymoved:newsubdir > actual &&
> +	test ! -s actual
> +'
>  
>  test_expect_success 'stops when msg filter fails' '
>  	old=$(git rev-parse HEAD) &&

Now the test fails. And with the other patch applied on top of it, the
test passes again.

tom
