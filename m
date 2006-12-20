X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: git-merge-recursive segmentation error
Date: Tue, 19 Dec 2006 18:38:29 -0800 (PST)
Message-ID: <655753.13323.qm@web31812.mail.mud.yahoo.com>
References: <7vpsafmh89.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Wed, 20 Dec 2006 02:38:40 +0000 (UTC)
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=yfzlHShrmXfbDs6lD3AkmTMo2sJcX1m87lshN/26v3P92OiW/pun+Y6K4WK+3j0SMx89GuGf/cZCDr9I3y8/qtTE+qVrDnl6HybcrW0W2s4C0frNjZ/M7n3T9KGqQfpUiVxlCQjlu3ROmVoMKGYE7GdBYdWXT/63vJMyQm0aZ7k=;
X-YMail-OSG: _y5bkMQVM1k.wpcimWkLywbF0GEb4ruG79_XiZ.2h_rAMlWCmgs7KMxg8VZrRp1rrciPO.7SFMGqZow3pOClCLdZG8f_t_vFhT8mTT3QxbSpzN2qbsKQQFQoDRxT4NtoNhoBCa10QE4-
In-Reply-To: <7vpsafmh89.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34900>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwrLl-0001on-C8 for gcvg-git@gmane.org; Wed, 20 Dec
 2006 03:38:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964793AbWLTCib (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 21:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbWLTCib
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 21:38:31 -0500
Received: from web31812.mail.mud.yahoo.com ([68.142.207.75]:36661 "HELO
 web31812.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 SMTP id S964793AbWLTCia (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec
 2006 21:38:30 -0500
Received: (qmail 15115 invoked by uid 60001); 20 Dec 2006 02:38:29 -0000
Received: from [64.215.88.90] by web31812.mail.mud.yahoo.com via HTTP; Tue,
 19 Dec 2006 18:38:29 PST
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

--- Junio C Hamano <junkio@cox.net> wrote:

> Junio C Hamano <junkio@cox.net> writes:
> 
> > Luben Tuikov <ltuikov@yahoo.com> writes:
> >
> >> I also ran git-bisect twice over two well known but overlapping
> >> good-bad regions and I get the same commit as being the culprit.
> >> It seems to be commit 1510fea781cb0517eeba8c378964f7bc4f9577ab.
> >>
> >>     Luben
> >
> > Ooooooops.
> 
> 1510fe is buggy and it is my fault.
> 
> For now, this _should_ get you keep going.
> 
> However, if this fixes it for you, that means we would still
> have the problem on Cygwin X-<.

Yep -- that fixed it.

Thanks,
    Luben


> 
> -- >8 --
> [PATCH] fix populate-filespec
> 
> I hand munged the original patch when committing 1510fea78.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> ---
>  diff.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/diff.c b/diff.c
> index 9974435..6e6f2a7 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1223,7 +1223,7 @@ static int reuse_worktree_file(const char *name, const unsigned char
> *sha1, int
>  	 * objects however would tend to be slower as they need
>  	 * to be individually opened and inflated.
>  	 */
> -	if (FAST_WORKING_DIRECTORY && !want_file && has_sha1_pack(sha1, NULL))
> +	if (!FAST_WORKING_DIRECTORY && !want_file && has_sha1_pack(sha1, NULL))
>  		return 0;
>  
>  	len = strlen(name);
> -- 
> 1.4.4.2.g205bf
> 
> 
> 
