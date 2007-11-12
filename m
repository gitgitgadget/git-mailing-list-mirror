From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] Fix rev-list when showing objects involving submodules
Date: Tue, 13 Nov 2007 08:54:08 +1300
Message-ID: <4738AF60.90207@vilain.net>
References: <Pine.LNX.4.64.0711112335020.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 12 20:53:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrfM4-0002dX-3p
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 20:53:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753255AbXKLTxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 14:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752921AbXKLTxi
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 14:53:38 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:60354 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbXKLTxh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 14:53:37 -0500
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 3977021D014; Tue, 13 Nov 2007 08:53:35 +1300 (NZDT)
Received: from [192.168.69.104] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 77DDF21D012;
	Tue, 13 Nov 2007 08:53:31 +1300 (NZDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <Pine.LNX.4.64.0711112335020.4362@racer.site>
X-Enigmail-Version: 0.95.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=SPF_HELO_FAIL autolearn=no 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64695>

Johannes Schindelin wrote:
> The function mark_tree_uninteresting() assumed that the tree entries
> are blob when they are not trees.  This is not so.  Since we do
> not traverse into submodules (yet), the gitlinks should be ignored.
>
> diff --git a/revision.c b/revision.c
> index 931f978..81b5a93 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -69,7 +69,7 @@ void mark_tree_uninteresting(struct tree *tree)
>  	while (tree_entry(&desc, &entry)) {
>  		if (S_ISDIR(entry.mode))
>  			mark_tree_uninteresting(lookup_tree(entry.sha1));
> -		else
> +		else if (!S_ISGITLINK(entry.mode))
>  			mark_blob_uninteresting(lookup_blob(entry.sha1));
>  	}
>  
>   

Wouldn't it be better to check for what it is, rather than what it is not?

Sam.
