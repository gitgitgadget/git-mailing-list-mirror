From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: t4111 fails under valgrind
Date: Wed, 4 Aug 2010 12:06:11 +0200
Message-ID: <201008041206.11367.trast@student.ethz.ch>
References: <201007301218.52437.trast@student.ethz.ch> <20100730183122.GA7578@dert.cs.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 04 12:06:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ogarx-0005as-7o
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 12:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117Ab0HDKGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Aug 2010 06:06:35 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:15548 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757429Ab0HDKGe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 06:06:34 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Wed, 4 Aug
 2010 12:06:33 +0200
Received: from thomas.site (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.0.702.0; Wed, 4 Aug
 2010 12:06:13 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <20100730183122.GA7578@dert.cs.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152571>

Jonathan Nieder wrote:
> -- 8< --
> Subject: t4111 (apply): refresh index before applying patches to it
> 
> "git apply", like most plumbing, does not automatically refresh the
> index file even if it is only stat-dirty.  So unless the two "cp"
> commands in reset_preimage() for a given file happen to have the same
> time stamp, there will be a spurious
> 
> 	error: sub/dir/file: does not match index
> 
> Refresh the index to eliminate this timing dependency.  Noticed by
> running the test with --valgrind (which slows things down a lot).
> 
> Reported-by: Thomas Rast <trast@student.ethz.ch>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> diff --git a/t/t4111-apply-subdir.sh b/t/t4111-apply-subdir.sh
> index 57cae50..a52d94a 100755
> --- a/t/t4111-apply-subdir.sh
> +++ b/t/t4111-apply-subdir.sh
> @@ -36,7 +36,8 @@ test_expect_success 'setup: subdir' '
>  		cp "$2" file &&
>  		cp "$2" sub/dir/file &&
>  		cp "$2" sub/dir/b/file &&
> -		cp "$2" objects/file
> +		cp "$2" objects/file &&
> +		test_might_fail git update-index --refresh -q
>  	}
>  '

Junio, can you pick this up?  t4111 consistently fails for me without
it.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
