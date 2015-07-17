From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Documentation/git: fix stale "MULTIPLE CHECKOUT MODE" reference
Date: Fri, 17 Jul 2015 10:03:44 -0700
Message-ID: <xmqqa8uu3edr.fsf@gitster.dls.corp.google.com>
References: <1437092222-11131-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 19:03:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZG93A-0001zv-K5
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 19:03:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754104AbbGQRDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 13:03:48 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35138 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771AbbGQRDr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 13:03:47 -0400
Received: by pactm7 with SMTP id tm7so64150398pac.2
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 10:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ck/iuNpMVmTuIXeNiWHn+m8alO1McQCD1uGA2ZWF8vo=;
        b=slvkqirgBgU2zZV6fkhYnROB8Dwlth0q0ez2AfQmhFwAXql/5phyLRhDccVvsXUQ7b
         dR5Q92jrujLIpnxl2X7h+Ziqmj23s7rOZu95hV5WmMJ5ZYyFWXWaRIpTc6d/GplaVguo
         UHQxy6M6L8o3wiq7Fya6S3RLCtKCE0TgeecMRtsSv1FcS/LblCIETM/KetUh8t6IdMY9
         rjwb+CIEj3SwboW4Pw8b0bmB/xan5gFdpLcb2xqpUkifnBzWvQeZ+vjVdLVUiUrOYyab
         /orKhtePPKVbn5PlkOPvEvLw9/AgNGbI6iwglqfi30Remzs/t/5Geat+eiMMMQKXXIro
         B3Tg==
X-Received: by 10.66.119.174 with SMTP id kv14mr31130331pab.5.1437152626537;
        Fri, 17 Jul 2015 10:03:46 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:902a:e9ec:1aae:aea2])
        by smtp.gmail.com with ESMTPSA id qs5sm11779998pbb.37.2015.07.17.10.03.45
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jul 2015 10:03:45 -0700 (PDT)
In-Reply-To: <1437092222-11131-1-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Thu, 16 Jul 2015 20:17:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274084>

Eric Sunshine <sunshine@sunshineco.com> writes:

> This should have been changed by 93a3649 (Documentation: move linked
> worktree description from checkout to worktree, 2015-07-06).
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  Documentation/git.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index d4aa3f6..eb38027 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -845,7 +845,7 @@ Git so take care if using Cogito etc.
>  	normally in $GIT_DIR will be taken from this path
>  	instead. Worktree-specific files such as HEAD or index are
>  	taken from $GIT_DIR. See linkgit:gitrepository-layout[5] and
> -	the section 'MULTIPLE CHECKOUT MODE' in linkgit:checkout[1]
> +	the linkgit:git-worktree[1] for
>  	details. This variable has lower precedence than other path
>  	variables such as GIT_INDEX_FILE, GIT_OBJECT_DIRECTORY...

Thanks.  I have two comments.

"if using Cogito etc.", which is totally outside the topic of this
patch, is way outdated. Perhaps we would want to remove or replace
it.

The other one is more heavy.  Do we even want to have and expose
GIT_COMMON_DIR environment variable?

The primary reason why we added GIT_DIR, GIT_OBJECT_DIRECTORY
etc. in the early days of Git was because we didn't exactly know
what kind of layout and flexibility was needed from "various SCMs
that sit on top of Git core", and we wanted to make progress rapidly
without making decisions back then.  But it is not 2005 anymore.

Suppose a file "gitdir: /home/gitster/w/src/.git/worktrees/rerere"
(call that $GIT_DIR) is there, and there is $GIT_DIR/commondir. Is
there any valid reason why somebody may want to use only part of
that arrangement and have a $GIT_COMMON_DIR that points at a place
different from $GIT_DIR/commondir points at to override only a part
of the setting?

Or perhaps there is a plain vanilla $GIT_DIR that does not have
$GIT_DIR/commondir.  Is there any valid reason why somebody may want
to reuse only part of that directory as if it were a linked checkout
and then use $GIT_COMMON_DIR to redirect the access to the meat of
the repository elsewhere?

The safety that comes from the primary checkout and the secondary
checkouts all knowing everybody else is lost in such a use case,
that is the whole point of adding this new feature.  The fact that
$GIT_COMMON_DIR/worktrees/* and $GIT_DIR/commondir reference each
other is what gives us object-prune-safety and multi-checkout-safety.

Unless I am mistaken, I think a separate GIT_COMMON_DIR environment
variable that can be tweaked by end-user is nothing but a source of
future bugs and user confusion, without giving us any useful
flexibility.
