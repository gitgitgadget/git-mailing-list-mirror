From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] resolve_gitlink_ref: ignore non-repository paths
Date: Fri, 22 Jan 2016 17:31:54 -0500
Message-ID: <20160122223154.GA15635@sigill.intra.peff.net>
References: <20160122222650.GA14772@sigill.intra.peff.net>
 <20160122222930.GB15560@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Krey <a.krey@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 23:32:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMkFN-0001u0-B9
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 23:32:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755192AbcAVWb6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 17:31:58 -0500
Received: from cloud.peff.net ([50.56.180.127]:58968 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754793AbcAVWb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 17:31:57 -0500
Received: (qmail 17889 invoked by uid 102); 22 Jan 2016 22:31:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jan 2016 17:31:56 -0500
Received: (qmail 6665 invoked by uid 107); 22 Jan 2016 22:32:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jan 2016 17:32:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jan 2016 17:31:54 -0500
Content-Disposition: inline
In-Reply-To: <20160122222930.GB15560@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284598>

On Fri, Jan 22, 2016 at 05:29:30PM -0500, Jeff King wrote:

> diff --git a/t/t3000-ls-files-others.sh b/t/t3000-ls-files-others.sh
> index 88be904..c525656 100755
> --- a/t/t3000-ls-files-others.sh
> +++ b/t/t3000-ls-files-others.sh
> @@ -65,6 +65,13 @@ test_expect_success '--no-empty-directory hides empty directory' '
>  	test_cmp expected3 output
>  '
>  
> +test_expect_success 'ls-files --others handles non-submodule .git' '
> +	mkdir not-a-submodule &&
> +	echo foo >not-a-submodule/.git &&
> +	git ls-files -o >output &&
> +	test_cmp expected1 output
> +'

BTW, I scratched my head about why I was able to use "expected1" here
without having to add "not-a-submodule" to it. But the answer is that
the directory itself does not get mentioned (it is not a file!), and we
seem to always exclude ".git" paths entirely.

I'm not sure if that's the best thing in every case (what if you have
precious content in a ".git" file?), but this does behave exactly as a
valid ".git" would with an empty HEAD ref. So I think it's a reasonable
behavior in practice.

-Peff
