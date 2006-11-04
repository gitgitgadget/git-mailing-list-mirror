X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Kevin Shanahan <kmshanah@disenchant.net>
Subject: Re: Problem with git-apply?
Date: Sat, 4 Nov 2006 21:19:13 +1030
Message-ID: <20061104104913.GD19667@cubit>
References: <20061104072349.GA19667@cubit> <7v8xir4k3w.fsf@assigned-by-dhcp.cox.net> <7v4ptf4jmj.fsf@assigned-by-dhcp.cox.net> <7vu01f34bo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 4 Nov 2006 10:49:34 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vu01f34bo.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30918>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgJ5V-0002ua-8w for gcvg-git@gmane.org; Sat, 04 Nov
 2006 11:49:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965242AbWKDKtR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006
 05:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965267AbWKDKtR
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 05:49:17 -0500
Received: from cirrus.netspace.net.au ([203.10.110.92]:21756 "EHLO
 mail.netspace.net.au") by vger.kernel.org with ESMTP id S965242AbWKDKtR
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Nov 2006 05:49:17 -0500
Received: from mail.localnet (dsl-202-45-120-45-static.SA.netspace.net.au
 [202.45.120.45]) by mail.netspace.net.au (Postfix) with ESMTP id 3CC73170147;
 Sat,  4 Nov 2006 21:49:13 +1100 (EST)
Received: by mail.localnet (Postfix, from userid 1000) id 71543BB00D2; Sat, 
 4 Nov 2006 21:19:13 +1030 (CST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Sat, Nov 04, 2006 at 02:15:55AM -0800, Junio C Hamano wrote:
> Actually it was a small problem in the patch parsing code.  Can
> you give this a try?

Yes, this patch works for me.

Cheers,
Kev.

> ---
> diff --git a/builtin-apply.c b/builtin-apply.c
> index 11397f5..db7cdce 100644
> --- a/builtin-apply.c
> +++ b/builtin-apply.c
> @@ -1043,10 +1043,14 @@ static int parse_single_patch(char *line
>  		 * then not having oldlines means the patch is creation,
>  		 * and not having newlines means the patch is deletion.
>  		 */
> -		if (patch->is_new < 0 && !oldlines)
> +		if (patch->is_new < 0 && !oldlines) {
>  			patch->is_new = 1;
> -		if (patch->is_delete < 0 && !newlines)
> +			patch->old_name = NULL;
> +		}
> +		if (patch->is_delete < 0 && !newlines) {
>  			patch->is_delete = 1;
> +			patch->new_name = NULL;
> +		}
>  	}
>  
>  	if (0 < patch->is_new && oldlines)
