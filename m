From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git-upload-pack: the timeout gets corrupted?!
Date: Sun, 11 Mar 2007 09:01:46 -0700
Message-ID: <45F427EA.8000905@zytor.com>
References: <45F35F38.1080206@zytor.com> <7vy7m4wcfb.fsf@assigned-by-dhcp.cox.net> <45F3CAAF.7030909@zytor.com> <Pine.LNX.4.63.0703111314150.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 11 17:02:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQQUu-00081v-GF
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 17:02:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933797AbXCKQCJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 12:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933798AbXCKQCJ
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 12:02:09 -0400
Received: from terminus.zytor.com ([192.83.249.54]:48249 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933797AbXCKQCI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 12:02:08 -0400
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id l2BG1kER023793
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 11 Mar 2007 09:01:47 -0700
User-Agent: Thunderbird 1.5.0.9 (X11/20070212)
In-Reply-To: <Pine.LNX.4.63.0703111314150.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: ClamAV 0.88.7/2807/Sun Mar 11 01:57:00 2007 on terminus.zytor.com
X-Virus-Status: Clean
X-Spam-Status: No, score=2.3 required=5.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_96_XX,PLING_QUERY,RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL
	autolearn=no version=3.1.8
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.1.8 (2007-02-13) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41936>

Johannes Schindelin wrote:
> 
> Something like this (totally untested):
> 
>  upload-pack.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/upload-pack.c b/upload-pack.c
> index 498bf50..bafd90f 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -119,6 +119,8 @@ static void create_pack_file(void)
>  		int i;
>  		struct rev_info revs;
>  
> +		close(0);
> +
>  		pack_pipe = fdopen(lp_pipe[1], "w");
>  
>  		if (create_full_pack)

Shouldn't that be close(lp_pipe[0]);?

> @@ -167,6 +169,10 @@ static void create_pack_file(void)
>  		const char *argv[10];
>  		int i = 0;
>  
> +		close(0);
> +		close(1);
> +		close(2);
> +
>  		dup2(lp_pipe[0], 0);
>  		dup2(pu_pipe[1], 1);
>  		dup2(pe_pipe[1], 2);
> 

Those close()'s are redundant with the dup2's...

	-hpa
