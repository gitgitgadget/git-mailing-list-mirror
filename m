From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v2 2/3] p7300: add performance tests for clean
Date: Sat, 11 Apr 2015 19:59:41 +0200
Message-ID: <20150411175941.GA32735@hank>
References: <1428770587-9674-1-git-send-email-erik.elfstrom@gmail.com>
 <1428770587-9674-4-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Erik@vger.kernel.org,
	=?iso-8859-1?Q?Elfstr=F6m_=3Cerik=2Eelfstrom=40gmail=2Ecom=3E?=@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 11 19:59:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ygzh8-0006F5-VR
	for gcvg-git-2@plane.gmane.org; Sat, 11 Apr 2015 19:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754828AbbDKR7p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Apr 2015 13:59:45 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:34062 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754058AbbDKR7o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2015 13:59:44 -0400
Received: by widjs5 with SMTP id js5so36190503wid.1
        for <git@vger.kernel.org>; Sat, 11 Apr 2015 10:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=84EtdGCDGIExnYIhXNyPe5baThq8o/J3aznKTPTszao=;
        b=krjkgh/Wu/9+GGJSevH9LPdOUPuAm3q1Pdlsi4qp78UHAQTO425b5wktBS1NUr7I1Z
         5uvcJZS5zDUWWzbb5O9QKLA+FoaD3crZvbKhmd295TJgQjbKNzXEkFitybCTQ2PHp8RK
         m0OQDNLhinq5NtvCYtouZlcfN522uFwl96+0mt6rQpJCg99xDnGuWVVVTMeAnJbtA3Pv
         d7/0CMacPsb53D7c0cVUElikoNSqRgIVjM3/rZMI7DA6+dnv20IcjukMnScGvQ4aoTV6
         /hfJaRyV5qs+p62//0ZN2RToqlN8omneg7JJblBA2He8Hjt9abgU7DTNJsRRn3CTwqzU
         4cCQ==
X-Received: by 10.180.86.201 with SMTP id r9mr7491661wiz.56.1428775183232;
        Sat, 11 Apr 2015 10:59:43 -0700 (PDT)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id 14sm3740000wjv.0.2015.04.11.10.59.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Apr 2015 10:59:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1428770587-9674-4-git-send-email-erik.elfstrom@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267028>

On 04/11, Erik Elfstr=F6m wrote:
> Signed-off-by: Erik Elfstr=F6m <erik.elfstrom@gmail.com>
> ---
>  t/perf/p7300-clean.sh | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100755 t/perf/p7300-clean.sh
>
> diff --git a/t/perf/p7300-clean.sh b/t/perf/p7300-clean.sh
> new file mode 100755
> index 0000000..af50d5d
> --- /dev/null
> +++ b/t/perf/p7300-clean.sh
> @@ -0,0 +1,37 @@
> +#!/bin/sh
> +
> +test_description=3D"Test git-clean performance"
> +
> +. ./perf-lib.sh
> +
> +test_perf_large_repo
> +test_checkout_worktree
> +
> +test_expect_success 'setup untracked directory with many sub dirs' '
> +	rm -rf 500_sub_dirs 50000_sub_dirs clean_test_dir &&
> +	mkdir 500_sub_dirs 50000_sub_dirs clean_test_dir &&
> +	for i in $(test_seq 1 500)
> +	do
> +		mkdir 500_sub_dirs/dir$i || return $?
> +	done &&
> +	for i in $(test_seq 1 100)
> +	do
> +		cp -r 500_sub_dirs 50000_sub_dirs/dir$i || return $?
> +	done
> +'
> +
> +test_perf 'clean many untracked sub dirs, check for nested git' '
> +	rm -rf clean_test_dir/50000_sub_dirs_cpy &&
> +	cp -r 50000_sub_dirs clean_test_dir/50000_sub_dirs_cpy &&

Maybe this would be a good place to use test_perf_cleanup, which I
introduced a while ago and you can find in the
tg/perf-lib-test-perf-cleanup branch?  It probably won't influence the
performance a lot, but still better separate the code that actually
needs to be tested from the cleanup/preparation code.  Ditto in the
other test.

> +	git clean -q -f -d  clean_test_dir/ &&
> +	test_dir_is_empty clean_test_dir
> +'
> +
> +test_perf 'clean many untracked sub dirs, ignore nested git' '
> +	rm -rf clean_test_dir/50000_sub_dirs_cpy &&
> +	cp -r 50000_sub_dirs clean_test_dir/50000_sub_dirs_cpy &&
> +	git clean -q -f -f -d  clean_test_dir/ &&
> +	test_dir_is_empty clean_test_dir
> +'
> +
> +test_done
> --
> 2.4.0.rc0.37.ga3b75b3
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
