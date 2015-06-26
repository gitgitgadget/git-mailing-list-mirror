From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] p5310: Fix broken && chain in performance test
Date: Fri, 26 Jun 2015 15:27:20 -0700
Message-ID: <xmqq616artpz.fsf@gitster.dls.corp.google.com>
References: <1435354020-11675-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: peff@peff.net, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 00:27:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8c5n-0006NJ-TM
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jun 2015 00:27:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547AbbFZW1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 18:27:24 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36951 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620AbbFZW1W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 18:27:22 -0400
Received: by igblr2 with SMTP id lr2so22460975igb.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 15:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=jhL9O9e9mvQjZaoFhcMB7aIX+q3gSI+yLGGZVTsq83w=;
        b=QVUZDzOMU6yvLRosB87c98Ck2ZPYHj+dF70BIrff0laVuuXUR8sivhPU+opgpvdqyW
         XexVyk3TEMoFYJ8ndeFuu0QEPi4fOmnjORw6ySuZOcSPOZCGp2l+wt9GWdK8/vsclXZ8
         0y3Bs7fTy5u0SQ93Da2CdcSN/QK9AwAVlBR6f4/tddXLmCJcyqaXGY96G0ofZRfjWG3v
         1Hoh6ypo0AzklBbiYpDODPulEZ1x3WrSn1u1MyOmCL+xMWgxl6xZlBfLDnG51IPJzY9Y
         maO6pc5OL6NTqOa1on+OgRKzz/OiyohaPGvtAu4RRwKQeKSnRoZCWXeTF8VcPpJhLVx4
         78rA==
X-Received: by 10.107.155.74 with SMTP id d71mr5201765ioe.29.1435357642375;
        Fri, 26 Jun 2015 15:27:22 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6587:7c7a:db33:ca35])
        by mx.google.com with ESMTPSA id pg7sm159178igb.6.2015.06.26.15.27.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Jun 2015 15:27:21 -0700 (PDT)
In-Reply-To: <1435354020-11675-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 26 Jun 2015 14:27:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272838>

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>

Thanks.  How did you find this (does the auto &&-chain test apply to
t/perf stuff as well)?

Will queue.

> ---
>  t/perf/p5310-pack-bitmaps.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/t/perf/p5310-pack-bitmaps.sh b/t/perf/p5310-pack-bitmaps.sh
> index f8ed857..de2a224 100755
> --- a/t/perf/p5310-pack-bitmaps.sh
> +++ b/t/perf/p5310-pack-bitmaps.sh
> @@ -39,14 +39,14 @@ test_expect_success 'create partial bitmap state' '
>  
>  	# now kill off all of the refs and pretend we had
>  	# just the one tip
> -	rm -rf .git/logs .git/refs/* .git/packed-refs
> -	git update-ref HEAD $cutoff
> +	rm -rf .git/logs .git/refs/* .git/packed-refs &&
> +	git update-ref HEAD $cutoff &&
>  
>  	# and then repack, which will leave us with a nice
>  	# big bitmap pack of the "old" history, and all of
>  	# the new history will be loose, as if it had been pushed
>  	# up incrementally and exploded via unpack-objects
> -	git repack -Ad
> +	git repack -Ad &&
>  
>  	# and now restore our original tip, as if the pushes
>  	# had happened
