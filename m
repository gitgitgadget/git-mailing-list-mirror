From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 3/3] rev-list --min-parents,--max-parents: doc and test
 and completion
Date: Mon, 21 Mar 2011 13:45:14 -0500
Message-ID: <20110321184514.GA1850@elie>
References: <cover.1300702130.git.git@drmicha.warpmail.net>
 <8bad49d4e4897be623b7af3096498a5803dbbd89.1300702130.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 19:45:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1k6k-0002eV-GW
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 19:45:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818Ab1CUSpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 14:45:31 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59232 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511Ab1CUSp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 14:45:29 -0400
Received: by gyf1 with SMTP id 1so1979784gyf.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 11:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=K1cj/AnFWkHZbIgdpJ1ljN5jBq7Ksle8Lks6Gv/RrUM=;
        b=rNWPor8sLs5r4Ls90knV41I4lzDb0DPnHoYz3BhaJA91qgH7MoGO6OKzvoGww9CwSq
         syyxduApVN9wOe3g6oC7AucGOIKJcUIsoKXZLv3fShEVefVh3z33B2KwkgJAJwWwH5Fh
         eNHmKIpTpVWMerEWxeoptq8lOCmb0DpyhSTw4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MGbQ/pb0/mqLDFE4NKRL3YSAQ4ia0XuLLLnCkUm1XijQVWGUiaQqnRUHaBnGu5TVJ9
         kpwff8VVNYzFkI1eewfEpNaCU4bdKpfsuQEf273F0wHdYQLzs9n8Ppq78GU2Q2qoeC+D
         bfQbsDbHDDAA5KF4pb8Zfkme/4QUJN0an91Xk=
Received: by 10.236.154.165 with SMTP id h25mr1818839yhk.365.1300733128324;
        Mon, 21 Mar 2011 11:45:28 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id h28sm1332724yhm.97.2011.03.21.11.45.25
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Mar 2011 11:45:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <8bad49d4e4897be623b7af3096498a5803dbbd89.1300702130.git.git@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169641>

Michael J Gruber wrote:

> Based on mg/rev-list-one-side-only (in next) to save Junio a build conflict
> resolution.

Not a serious problem, but I wish it hadn't been.  What particular
functionality from that branch does this use?

Ah, now that I check it seems that that is to change a use of
no_merges in the implementation of --cherry to use the new API?  Makes
sense (and good catch).  With that hunk skipped, the patches apply to
master.

> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -72,11 +72,24 @@ endif::git-rev-list[]
>  
>  --merges::
>  
> -	Print only merge commits.
> +	Print only merge commits. This is equivalent to `--min-parents=2`.
>  
>  --no-merges::
>  
> -	Do not print commits with more than one parent.
> +	Do not print commits with more than one parent. This is
> +	equivalent to `--max-parents=1`.
> +
> +--min-parents::
> +--max-parents::
> +
> +	Show only commits which have at least resp. at most that many

ENOPARSE.  I guess parentheses around "resp. at most" would work as
a minimal fix, but it might be better to say:

 --min-parents=<n>::
	Show only commits which have at least <n> parents.

 --max-parents=<n>::
	Show only commits which have at least <n> parents.

and perhaps to put

 git log --max-parents=0::
	Lists all root commits.

 git log --min-parents=3::
	Lists all octopus merges.

under EXAMPLES.

> +	commits, where negative parameters for `--max-parents=` denote
> +	infinity (i.e. no upper	limit).

Seems hackish.  Maybe --no-max-parents could denote infinity?

> ++
> +In particular, `--max-parents=1` is `--no-merges`, `--min-parents=2` is
> +`--merges` (only), `--max-parents=0` gives all root commits and
> +`--min-parents=3` all octopuses.
> +
>  
>  --first-parent::

It seems there is an extra newline here.

> --- a/t/t6009-rev-list-parent.sh
> +++ b/t/t6009-rev-list-parent.sh
> @@ -1,9 +1,17 @@
>  #!/bin/sh
>  
> -test_description='properly cull all ancestors'
> +test_description='ancestor culling and limiting by parent number'
>  
>  . ./test-lib.sh
>  
> +check_revlist () {
> +	rev_list_args="$1" &&
> +	shift &&
> +	git rev-parse "$@" >expect &&
> +	git rev-list $rev_list_args --all >actual &&
> +	test_cmp expect actual
> +}
> + 

"git am" warns about trailing whitespace on the line after the closing
brace (nothing that --whitespace=fix can't fix, though).

Thanks for factoring this out btw.  It makes the tests themselves
very easy to read.

> +test_expect_success 'rev-list override and infinities' '
> +
> +	check_revlist "--min-parents=2 --max-parents=1 --max-parents=3" tripus normalmerge &&
> +	check_revlist "--min-parents=1 --min-parents=2 --max-parents=7" tetrapus tripus normalmerge &&
> +	check_revlist "--min-parents=2 --max-parents=8" tetrapus tripus normalmerge &&
> +	check_revlist "--min-parents=2 --max-parents=-1" tetrapus tripus normalmerge
> +'

7 and 8 don't mean infinity any more, do they?  What is this test
checking?
