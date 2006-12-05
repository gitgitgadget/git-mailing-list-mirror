X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [RFC/PATCH] git-reset to remove "$GIT_DIR/MERGE_MSG"
Date: Mon, 4 Dec 2006 22:19:02 -0800 (PST)
Message-ID: <953031.74197.qm@web31806.mail.mud.yahoo.com>
References: <7v4psbknvb.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Tue, 5 Dec 2006 06:19:23 +0000 (UTC)
Cc: ltuikov@yahoo.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=LRNPlHy2P1mfmcSHN+SjnNe87JNxl5F+WZlaS4kJqGV25SxLG09+XYMsCY0CA/7hPM+IWvmgVaHj2xIR2OzWOScTs9jzWliEMZCp6IJADvRqJR9XL4AfEiBaSxIXAhAOKZh00TNunfPiARLmQyx45kSwZHIcIYEkcz6bR6Jb1rU=;
X-YMail-OSG: nrspdfEVM1lvfqk60F.zIJDGPTtHTozYf.f2xrIQDPN1V9WM2AkTfYejgp6C73qMGbeDJQ1tlXzN6CPtu4jc61u6FknJOUwlD9Q0EHL6thYtRPsnXdUrGZys5QW9mqRQfWDfuBZ7isE-
In-Reply-To: <7v4psbknvb.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33308>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrTeC-00074P-T4 for gcvg-git@gmane.org; Tue, 05 Dec
 2006 07:19:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967180AbWLEGTI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 01:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968381AbWLEGTI
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 01:19:08 -0500
Received: from web31806.mail.mud.yahoo.com ([68.142.207.69]:43303 "HELO
 web31806.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 SMTP id S967180AbWLEGTH (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006
 01:19:07 -0500
Received: (qmail 74571 invoked by uid 60001); 5 Dec 2006 06:19:03 -0000
Received: from [68.186.49.209] by web31806.mail.mud.yahoo.com via HTTP; Mon,
 04 Dec 2006 22:19:02 PST
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org

--- Junio C Hamano <junkio@cox.net> wrote:
> An earlier commit a9cb3c6e changed git-commit to use the
> contents of MERGE_MSG even when we do not have MERGE_HEAD (the
> rationale is in its log message).
> 
> However, the change tricks the following sequence to include a
> merge message in a completely unrelated commit:
> 
> 	$ git pull somewhere
> 	: oops, the conflicts are too much.  forget it.
>         $ git reset --hard
>         : work work work
>         $ git commit
> 
> To fix this confusion, this patch makes "git reset" to remove
> the leftover MERGE_MSG that was prepared when the user abandoned
> the merge.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>

Acked-by: Luben Tuikov <ltuikov@yahoo.com

> 
> ---
> 
>  * Marked as RFC because I suspect I am missing a valid use case
>    where a user might want to say "reset" as part of continuing
>    the conflicted merge resolution, although I do not think of
>    any offhand...

I also cannot think of any offhand.  Should be safe to commit.

     Luben


> 
>  git-reset.sh |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/git-reset.sh b/git-reset.sh
> index 3133b5b..c0feb44 100755
> --- a/git-reset.sh
> +++ b/git-reset.sh
> @@ -63,6 +63,7 @@ case "$reset_type" in
>  	;;
>  esac
>  
> -rm -f "$GIT_DIR/MERGE_HEAD" "$GIT_DIR/rr-cache/MERGE_RR" "$GIT_DIR/SQUASH_MSG"
> +rm -f "$GIT_DIR/MERGE_HEAD" "$GIT_DIR/rr-cache/MERGE_RR" \
> +	"$GIT_DIR/SQUASH_MSG" "$GIT_DIR/MERGE_MSG"
>  
>  exit $update_ref_status
> 
> 
> 
