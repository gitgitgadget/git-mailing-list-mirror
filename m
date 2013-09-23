From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH 4/9] fast-export: add new --refspec option
Date: Sun, 22 Sep 2013 21:59:24 -0400
Message-ID: <523FA07C.9040909@bbn.com>
References: <1377789808-2213-1-git-send-email-felipe.contreras@gmail.com> <1377789808-2213-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 23 03:59:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNvQy-0007zl-2K
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 03:59:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330Ab3IWB72 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Sep 2013 21:59:28 -0400
Received: from smtp.bbn.com ([128.33.1.81]:38367 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753324Ab3IWB71 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Sep 2013 21:59:27 -0400
Received: from socket.bbn.com ([192.1.120.102]:42996)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VNvQt-00096e-2G; Sun, 22 Sep 2013 21:59:27 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 8F6CD3FF4D
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <1377789808-2213-5-git-send-email-felipe.contreras@gmail.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235178>

On 2013-08-29 11:23, Felipe Contreras wrote:
> So that we can covert the exported ref names.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/git-fast-export.txt |  4 ++++
>  builtin/fast-export.c             | 30 ++++++++++++++++++++++++++++++
>  t/t9350-fast-export.sh            |  7 +++++++
>  3 files changed, 41 insertions(+)
> 
> diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
> index 85f1f30..221506b 100644
> --- a/Documentation/git-fast-export.txt
> +++ b/Documentation/git-fast-export.txt
> @@ -105,6 +105,10 @@ marks the same across runs.
>  	in the commit (as opposed to just listing the files which are
>  	different from the commit's first parent).
>  
> +--refspec::
> +	Apply the specified refspec to each ref exported. Multiple of them can
> +	be specified.
> +

Do you mean '--refspec=<refspec>' and/or '--refspec <refspec>'?

How are the multiple refspecs specified?  Space/comma/colon separated
list?  Or multiple '--refspec' arguments with one refspec per '--refspec'?

> diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
> index 34c2d8f..dc6666f 100755
> --- a/t/t9350-fast-export.sh
> +++ b/t/t9350-fast-export.sh
> @@ -504,4 +504,11 @@ test_expect_success 'refs are updated even if no commits need to be exported' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'use refspec' '
> +	git fast-export --refspec refs/heads/master:refs/heads/foobar master | \
> +		grep "^commit " | sort | uniq > actual &&
> +	echo "commit refs/heads/foobar" > expected &&
> +	test_cmp expected actual
> +'
> +
>  test_done
> 

I think it'd be good to add a test for multiple refspecs.

-Richard
