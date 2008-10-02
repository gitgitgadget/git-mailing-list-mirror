From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] format-patch: autonumber by default
Date: Thu, 2 Oct 2008 16:17:46 -0400
Message-ID: <91634D16-B28A-4458-97A9-C469B5AF4E5D@silverinsanity.com>
References: <48E4D73B.9090508@op5.se> <1222970291-5337-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <ae@op5.se>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 22:19:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlUda-0006oQ-BV
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 22:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753953AbYJBURw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 16:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753880AbYJBURw
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 16:17:52 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:58892 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753511AbYJBURv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 16:17:51 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 919111FFC4C0; Thu,  2 Oct 2008 20:17:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.1.7-deb
Received: from [192.168.1.109] (cpe-69-205-127-75.rochester.res.rr.com [69.205.127.75])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id A554C1FFC438;
	Thu,  2 Oct 2008 20:17:40 +0000 (UTC)
In-Reply-To: <1222970291-5337-1-git-send-email-giuseppe.bilotta@gmail.com>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97369>


On Oct 2, 2008, at 1:58 PM, Giuseppe Bilotta wrote:

> diff --git a/builtin-log.c b/builtin-log.c
> index fc5e4da..5187dc2 100644
> --- a/builtin-log.c
> +++ b/builtin-log.c
> @@ -426,7 +426,7 @@ static int istitlechar(char c)
>
> static const char *fmt_patch_suffix = ".patch";
> static int numbered = 0;
> -static int auto_number = 0;
> +static int auto_number = 1;
>
> static char **extra_hdr;
> static int extra_hdr_nr;
> @@ -484,6 +484,10 @@ static int git_format_config(const char *var,  
> const char *value, void *cb)
>  			auto_number = 1;
>  			return 0;
>  		}
> +		if (value && !strcasecmp(value, "noauto")) {
> +			auto_number = 0;
> +			return 0;
> +		}
>  		numbered = git_config_bool(var, value);
>  		return 0;
>  	}

format.numbered is a tri-state config option right now: {yes, no,  
auto}.  With this patch, if you add "[format] numbered = false" into  
your config, you still get auto-numbering.

A better way to do this might be to default both numbered and  
auto_number to true and only use auto_number is numbered is true.  Or  
turn off auto-numbering when numbering is turned off just below your  
hunk.

Either way, "noauto" is a bad idea.  It's spelled "no" or "false".

~~ Brian Gernhardt
