From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH] Better diagnostic for wrong branch configuration.
Date: Mon, 8 Oct 2007 14:00:48 +0100
Message-ID: <b0943d9e0710080600y55aeeeeei8dbd27d069c681e@mail.gmail.com>
References: <20071005204452.30902.60246.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Mon Oct 08 15:01:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IesEW-0005mI-1l
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 15:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755106AbXJHNAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 09:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755063AbXJHNAu
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 09:00:50 -0400
Received: from rv-out-0910.google.com ([209.85.198.189]:11279 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753919AbXJHNAt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 09:00:49 -0400
Received: by rv-out-0910.google.com with SMTP id k20so748064rvb
        for <git@vger.kernel.org>; Mon, 08 Oct 2007 06:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=2R33ccJVf/nGTqUugeCjUngUUfjclHPaM5WKnRA8KxU=;
        b=e641w8PY15IdxtFzoruJZSUVuiS4zFpC99jLvRzmof8r+hwCrJ1InKF+BatFmBhtgHRMZGb5Zvr9eyt1VvBFz+V4Nt5c7kCSWeqmsizni41rhAXx795AYRmahUeFr7zjPzoNDyvmmDC+/PjFQA++eWPcQgBZANtLAgW+wmVTyHk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JX8eayAWRH1HrfOPfYyemf2vRhDPy5RhXynAYgK7AWnEuMF6P0FwAWW3JEN27qvFqtzd+j/T4px8VlXjuwLBj2Gs8heyNuU71T4UyY8a2TLLhoycxxDNAPBejOdNQkUi2Hz888iqCw/VSYcG7LKbWjULkVz8dtwZLQcfY+/oMpU=
Received: by 10.141.62.9 with SMTP id p9mr1456331rvk.1191848448825;
        Mon, 08 Oct 2007 06:00:48 -0700 (PDT)
Received: by 10.140.187.15 with HTTP; Mon, 8 Oct 2007 06:00:48 -0700 (PDT)
In-Reply-To: <20071005204452.30902.60246.stgit@gandelf.nowhere.earth>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60316>

On 05/10/2007, Yann Dirson <ydirson@altern.org> wrote:
> --- a/stgit/git.py
> +++ b/stgit/git.py
> @@ -1003,11 +1003,14 @@ def fetch_head():
>          m = re.match('^([^\t]*)\t\t', line)
>          if m:
>              if fetch_head:
> -                raise GitException, "StGit does not support multiple FETCH_HEAD"
> +                raise GitException, 'StGit does not support multiple FETCH_HEAD'
>              else:
>                  fetch_head=m.group(1)
>      stream.close()
>
> +    if not fetch_head:
> +        raise GitException, 'No for-merge remote head found in FETCH_HEAD'

OK, I tried and it doesn't work with my StGIT over SVN configuration.

What I did is defining 'pull-policy' as 'fetch-rebase', 'fetchcmd' as
'git svn fetch' which doesn't create any FETCH_HEAD. The 'pullcmd' is
defined as 'git svn rebase' and it doesn't use any argument if
git.fetch_head() return None.

I also think it is better for the pull command to re-raise the
git.fetch_head exception as this one contains more detailed
information about the error (after the out.error call). It currently
shows that the remote head couldn't be found but there is the multiple
heads case raised by git.fetch_head.

-- 
Catalin
