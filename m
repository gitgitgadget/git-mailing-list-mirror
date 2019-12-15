Return-Path: <SRS0=YD5J=2F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C30C43603
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 05:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFDC2072B
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 05:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="JZfOB2bW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfLOFd2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Dec 2019 00:33:28 -0500
Received: from ozlabs.org ([203.11.71.1]:55989 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfLOFd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Dec 2019 00:33:28 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
        id 47bCjy2KKrz9sPK; Sun, 15 Dec 2019 16:33:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1576388006; bh=ib28gwJUhPgTsnyRelJZ1TwPeSTvDlM5skJ48Xs3/gI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JZfOB2bWITRcEYqVPpbeAks1uj+iAPWpgnbek4wA7NZbyriT4RzOh96i0ximNtJyY
         Cta7diNWFnPwlYdyUgkMBwX0xOiJx3IO4pw/uM3jpm8X7SrST6TiepoUlLgm5XkaFD
         Iz2fAUekP/QGVRYp7V2Pjje5W6qM7kWVbMBqKoUfGUV3SOAedf1lg2gOpiTEasRykT
         XsfElXU59zliTaaxVYNFkbFtHemB7rvdPE3uV0hT478tITAgIxUEIeJ7T/4QscMlFb
         FJNA3kMfAs7CDoEPc5WzRMtaoQ1Tu7mRwQankj5l0XcXciRN3KHlDEU6xLdznf5XJe
         R0q4EUo8TOJrw==
Date:   Sun, 15 Dec 2019 15:19:24 +1100
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v2 1/2] gitk: drop quotes in copysummary format
Message-ID: <20191215041924.GA12512@blackberry>
References: <da9321b1bd56aafd16c8dcb99d5d628b79e2244e.1576100147.git.liu.denton@gmail.com>
 <cover.1576197846.git.liu.denton@gmail.com>
 <75dc131f0575cbe5d885af8897cbde054f7c07cf.1576197846.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75dc131f0575cbe5d885af8897cbde054f7c07cf.1576197846.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 12, 2019 at 04:44:49PM -0800, Denton Liu wrote:
> In an earlier commit[1], git learned the 'reference' pretty format. This
> format was very similar to the format that copysummary used but it omits
> the quotes surrounding the commit's subject. Remove the quotes from the
> format in copysummary in order to match the 'reference' pretty format.
> 
> It seems the consensus is that the unquoted form is used more often
> anyway[2] so this change should be acceptable.

I don't see any discussion about removing the quotes in the Linux
kernel community, and the Documentation/process/submitting-patches.rst
in the kernel tree says (or at least implies) that the quotes are
required.  So I am not convinced this change is a good thing to do.

In fact the gitk commit summary/reference format doesn't match what
the kernel wants exactly, in that gitk puts in the author-date, and
submitting-patches.rst doesn't have it.  There are maintainers that
have scripts that automatically check the format of Fixes: lines in
submaintainers' trees and send email if they detect one with the wrong
formatting.  Thus I would find it more convenient to change the format
to %h (\"s\") than to "%h (%s, %ad)".

Maybe the solution is to make the format customizable.

> [These commits are in git.git.]
> [1]: 1f0fc1db85 (pretty: implement 'reference' format, 2019-11-19)
> [2]: fb2ffa77a6 (SubmittingPatches: remove dq from commit reference, 2019-11-19)
> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  gitk | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/gitk b/gitk
> index abe4805ade..d07e3302de 100755
> --- a/gitk
> +++ b/gitk
> @@ -9429,7 +9429,7 @@ proc mktaggo {} {
>  proc copysummary {} {
>      global rowmenuid autosellen
>  
> -    set format "%h (\"%s\", %ad)"
> +    set format "%h (%s, %ad)"
>      set cmd [list git show -s --pretty=format:$format --date=short]
>      if {$autosellen < 40} {
>          lappend cmd --abbrev=$autosellen
> -- 
> 2.24.1.664.g198078bb5a

Paul.
