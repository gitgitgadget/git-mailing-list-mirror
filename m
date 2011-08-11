From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/6] sequencer: Remove sequencer state after final commit
Date: Thu, 11 Aug 2011 15:17:55 -0500
Message-ID: <20110811201755.GJ2277@elie.gateway.2wire.net>
References: <1313088705-32222-1-git-send-email-artagnon@gmail.com>
 <1313088705-32222-7-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 11 22:18:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qrbhb-0004vh-2h
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 22:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753557Ab1HKUSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 16:18:00 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42393 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164Ab1HKUR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 16:17:59 -0400
Received: by gxk21 with SMTP id 21so1573392gxk.19
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 13:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=T/tai7t5TaPDOWg21S8iSO0nAfh+1t9VITK6c8yNyaE=;
        b=SDEKIUQINdJvJ1s1Xebt+Jmm+saXRk9I3soAP8Ne+mKJXz9yYEIg41BptXzPcxOQ54
         3hf63EaGE9rSdS3nYhEW7CImJsgkzzZr+DxFzaZcHE92cqLDhclftSTiqehcOC1Nvg/l
         WhvoR5m5EAdFEwWx4fZPFEJyLxVgqQ0sQmsnM=
Received: by 10.150.170.13 with SMTP id s13mr1106068ybe.48.1313093878686;
        Thu, 11 Aug 2011 13:17:58 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-69-68.dsl.chcgil.sbcglobal.net [69.209.69.68])
        by mx.google.com with ESMTPS id s4sm1329130ybf.26.2011.08.11.13.17.57
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 13:17:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1313088705-32222-7-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179142>

Hi,

Ramkumar Ramachandra wrote:

> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -26,6 +26,7 @@
>  #include "unpack-trees.h"
>  #include "quote.h"
>  #include "submodule.h"
> +#include "sequencer.h"
>  
>  static const char * const builtin_commit_usage[] = {
>  	"git commit [options] [--] <filepattern>...",
> @@ -1521,7 +1522,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  	unlink(git_path("MERGE_MODE"));
>  	unlink(git_path("SQUASH_MSG"));
>  
> -	if (commit_index_files())
> +	/* Remove sequencer state if we just finished the last insn */
> +	if (sequencer_count_todo() == 1)
> +		remove_sequencer_state(1);
> +
> +       if (commit_index_files())
>  		die (_("Repository has been updated, but unable to write\n"

Whitespace damage?

I think even this is too much knowledge of sequencer details on "git
commit"'s part.  It should be enough to say

	Dear sequencer, I'm commiting!

and let the sequencer take care of the rest.
