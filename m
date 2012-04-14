From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5570: use explicit push refspec
Date: Sat, 14 Apr 2012 16:40:01 -0700
Message-ID: <7viph1288e.fsf@alter.siamese.dyndns.org>
References: <20120414182907.GA3915@ecki> <20120414183225.GB3915@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Zbigniew =?utf-8?Q?J?= =?utf-8?Q?=C4=99drzejewski-Szmek?= 
	<zbyszek@in.waw.pl>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Apr 15 01:41:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJCaL-0001n5-1K
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 01:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755343Ab2DNXkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 19:40:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42431 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754925Ab2DNXkF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 19:40:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC77963AD;
	Sat, 14 Apr 2012 19:40:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h92q7z0l3PRWJgsI82sPZ4HIHxg=; b=IiwZX8
	nt57KQxPao0M9F6ITmN0+4IbthkuYMHm4w6jtLm1v+IjSh1ZzzM/miYl7dC6ftqm
	ZWJV6lLnfaiSiKgNDwIgVjDdZWr9uQGc6jJ0X2tk3kExcVmDhYBVZJdCbsTEFV1X
	8L8dbOTh7UJurRDAM2c54xLmoWfeEoIGrAgsE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nPbtMRY1ZcDMtBPRaKSNquqZk+y2wMft
	dqEPBpI5J6kLydUHtSRzkZLS2vYonPt+7HoDT5+mzh0/whJFpcK3+mv/Oj8aIR8Y
	6XUFbFfupGPDji/SkvJ2Zs5NPnMdWEiCi0HSdmguSz4PvvlU0J0DD2FSDCmDzJ+k
	q2xAWeVlOGo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF89063AC;
	Sat, 14 Apr 2012 19:40:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2DFE63A8; Sat, 14 Apr 2012
 19:40:02 -0400 (EDT)
In-Reply-To: <20120414183225.GB3915@ecki> (Clemens Buchacher's message of
 "Sat, 14 Apr 2012 20:32:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 28133D38-868B-11E1-9EC8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195535>

Clemens Buchacher <drizzd@aon.at> writes:

> The default mode for push without arguments will change. Some warnings
> are about to be enabled for such use, which causes some t5570 tests to
> fail because they do not expect this output. Fix this by passing an
> explicit refspec to git push.

I wonder if a better fix is to configure "push.default = matching" in the
test repository.  Otherwise wouldn't the result of the push change once
the default changes?

> Signed-off-by: Clemens Buchacher <drizzd@aon.at>
> ---
>
> On Sat, Apr 14, 2012 at 08:29:07PM +0200, Clemens Buchacher wrote:
>> 
>> Note that t5570 fails on current pu, because of the push.default
>> warnings. I am sending an independent patch for that.
>
> Here we go.
>
>  t/t5570-git-daemon.sh |   30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
>
> diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
> index 7cbc999..a3a4e47 100755
> --- a/t/t5570-git-daemon.sh
> +++ b/t/t5570-git-daemon.sh
> @@ -103,14 +103,12 @@ test_remote_error()
>  		esac
>  	done
>  
> -	if test $# -ne 3
> -	then
> -		error "invalid number of arguments"
> -	fi
> -
> +	msg=$1
> +	shift
>  	cmd=$1
> -	repo=$2
> -	msg=$3
> +	shift
> +	repo=$1
> +	shift || error "invalid number of arguments"
>  
>  	if test -x "$GIT_DAEMON_DOCUMENT_ROOT_PATH/$repo"
>  	then
> @@ -122,7 +120,7 @@ test_remote_error()
>  		fi
>  	fi
>  
> -	test_must_fail git "$cmd" "$GIT_DAEMON_URL/$repo" 2>output &&
> +	test_must_fail git "$cmd" "$GIT_DAEMON_URL/$repo" "$@" 2>output &&
>  	echo "fatal: remote error: $msg: /$repo" >expect &&
>  	test_cmp expect output
>  	ret=$?
> @@ -131,18 +129,18 @@ test_remote_error()
>  }
>  
>  msg="access denied or repository not exported"
> -test_expect_success 'clone non-existent' "test_remote_error    clone nowhere.git '$msg'"
> -test_expect_success 'push disabled'      "test_remote_error    push  repo.git    '$msg'"
> -test_expect_success 'read access denied' "test_remote_error -x fetch repo.git    '$msg'"
> -test_expect_success 'not exported'       "test_remote_error -n fetch repo.git    '$msg'"
> +test_expect_success 'clone non-existent' "test_remote_error    '$msg' clone nowhere.git    "
> +test_expect_success 'push disabled'      "test_remote_error    '$msg' push  repo.git master"
> +test_expect_success 'read access denied' "test_remote_error -x '$msg' fetch repo.git       "
> +test_expect_success 'not exported'       "test_remote_error -n '$msg' fetch repo.git       "
>  
>  stop_git_daemon
>  start_git_daemon --informative-errors
>  
> -test_expect_success 'clone non-existent' "test_remote_error    clone nowhere.git 'no such repository'"
> -test_expect_success 'push disabled'      "test_remote_error    push  repo.git    'service not enabled'"
> -test_expect_success 'read access denied' "test_remote_error -x fetch repo.git    'no such repository'"
> -test_expect_success 'not exported'       "test_remote_error -n fetch repo.git    'repository not exported'"
> +test_expect_success 'clone non-existent' "test_remote_error    'no such repository'      clone nowhere.git    "
> +test_expect_success 'push disabled'      "test_remote_error    'service not enabled'     push  repo.git master"
> +test_expect_success 'read access denied' "test_remote_error -x 'no such repository'      fetch repo.git       "
> +test_expect_success 'not exported'       "test_remote_error -n 'repository not exported' fetch repo.git       "
>  
>  stop_git_daemon
>  test_done
