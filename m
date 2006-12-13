X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Remove uncontested renamed files during merge.
Date: Wed, 13 Dec 2006 11:31:25 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612131129550.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061213095540.GA25001@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 13 Dec 2006 10:31:36 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20061213095540.GA25001@spearce.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34202>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuROe-0005VR-EG for gcvg-git@gmane.org; Wed, 13 Dec
 2006 11:31:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932654AbWLMKb3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 05:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932656AbWLMKb3
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 05:31:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:43443 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932654AbWLMKb2
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006 05:31:28 -0500
Received: (qmail invoked by alias); 13 Dec 2006 10:31:27 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp033) with SMTP; 13 Dec 2006 11:31:27 +0100
To: "Shawn O. Pearce" <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 13 Dec 2006, Shawn O. Pearce wrote:

> Prior to 65ac6e9c3f47807cb603af07a6a9e1a43bc119ae we deleted a
> file from the working directory during a merge if the file existed
> in the working directory before the merge started but was renamed
> by the branch which is being merged in.  This broke in 65ac63 as
> git-merge-recursive did not actually update the working directory
> on this uncontested rename case.
> 
> [...]
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 9d53bcd..741d17f 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -873,7 +873,7 @@ static int process_renames(struct path_list *a_renames,
>  			struct diff_filespec src_other, dst_other;
>  			int try_merge, stage = a_renames == renames1 ? 3: 2;
>  
> -			remove_file(1, ren1_src, 1);
> +			remove_file(1, ren1_src, 0);

I _think_ that the "0" should be "!index_only". After all, these functions 
are not only called on the virtual merges, but also on the final merge, 
which indeed should update the working directory. And since it is a 
rename, the old file has to go.

Ciao,
