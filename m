From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv5 23/23] Provide 'git merge --abort' as a synonym to 'git
 reset --merge'
Date: Sun, 24 Oct 2010 20:32:18 -0500
Message-ID: <20101025013217.GA25355@burratino>
References: <1287965333-5099-1-git-send-email-johan@herland.net>
 <1287965333-5099-24-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, bebarino@gmail.com, avarab@gmail.com,
	gitster@pobox.com, srabbelier@gmail.com,
	Thomas Rast <trast@student.ethz.ch>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Oct 25 03:36:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PABz4-0005k4-Bl
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 03:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383Ab0JYBgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 21:36:16 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:57469 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479Ab0JYBgP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 21:36:15 -0400
Received: by ywk9 with SMTP id 9so1782574ywk.19
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 18:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=nrJCSOTFz/2r8MwwWlu7cSX4N2ykBINUD3vDpGav57A=;
        b=vzLz9hHeMMcrTlB3KCav6zM3OwE2VrNkMjY94dMzh6/ubhh9NQyxIEkCN+6nwO1Lxo
         g3p4nc+Z6t4zDo2VIlGIwGtDgpWzhcH4zsYnuVTZD7Z6gNWwU3kiwfZvS+9ku4Wtwhfj
         jzjZqfLsyvgXAvqrJ7zV/TRRve3WxWYRKQYsc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=uiGWxYc7DRGAysZWiNE503TxqeT70BfdZvsiyp/FTrc5re38owIJ/r14Kbs8Hv+Q1O
         p7CroaP6ODTLQGxit2v947ddx28ZNr9M2VALaVQbzFXZAeHbfHG1xC7eB02TUP+fHRoN
         U7CN2TWnaWv5tpL4P50xpiS/COUExcFuqWQQE=
Received: by 10.150.144.10 with SMTP id r10mr10462730ybd.34.1287970573919;
        Sun, 24 Oct 2010 18:36:13 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id q8sm2319616ybk.0.2010.10.24.18.36.11
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 18:36:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287965333-5099-24-git-send-email-johan@herland.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159921>

Johan Herland wrote:

> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -13,6 +13,7 @@ SYNOPSIS
>                                                     However, if there
> +were uncommitted changes when the merge started (and these changes
> +did not interfere with the merge itself, otherwise the merge would
> +have refused to start), and then additional modifications were made
> +to these uncommitted changes, 'git merge --abort' will not be able
> +reconstruct the original (pre-merge) uncommitted changes. Therefore:

I do not find this clear.  Could you give an example?

References:

 http://thread.gmane.org/gmane.comp.version-control.git/136356/focus=136773
 http://thread.gmane.org/gmane.comp.version-control.git/151799/focus=151812

> +--abort::
> +	Abort the current conflict resolution process, and
> +	reconstruct the pre-merge state.
> ++
> +Any uncommitted worktree changes present when the merge started,
> +will only be preserved if they have not been further modified
> +since the merge started.

Ah, maybe I see: is the problem this procedure?

 1. Make changes to file foo.c (without staging them).
 2. Try a merge (which cannot touch foo.c, or the merge would have
    been aborted automatically) which fails with conflicts.
 3. As a result of semantic conflicts, make some changes to foo.c.
 4. Wish to return to the state from the end of step 1.

But I find the following more likely:

 1. Make changes to file foo.c (without staging them).
 2. Try a merge (which cannot touch foo.c, or the merge would have
    been aborted automatically) which fails with conflicts.
 3. Walk away in disgust.
 4. Return, make some more changes to foo.c.
 5. Notice the merge in progress --- oh! --- and abort it.

> --- a/t/t7609-merge-abort.sh
> +++ b/t/t7609-merge-abort.sh
> @@ -3,95 +3,271 @@
>  test_description='test aborting in-progress merges'
>  . ./test-lib.sh
>  
> +# Set up repo with conflicting and non-conflicting branches:
> +#
> +# master1---master2---foo_foo  <-- master
> +#        \
> +#         --clean1             <-- clean_branch
> +#                 \
> +#                  --foo_bar   <-- conflict_branch

[It might be nice to include this in test_description for use by
 "./t7609-merge-abort.sh --help".]

> +# - dirty worktree before merge matches contents on remote branch

Or maybe this was the example.  Here was Junio's explanation of it:

| It will discard the change, the one you independently picked up, but the
| change agreed with what was done by the the trash history that you are
| cancelling merge with.  You wouldn't miss losing the same change as in
| that trash history.

In other words, if the change is also on a remote branch that you want
not to merge with anyway, it is not likely to be terribly important to
preserve it in the local tree.  (This is a trade-off between
convenience in two different scenarios.)

Hope that helps (sorry for the ramble).
