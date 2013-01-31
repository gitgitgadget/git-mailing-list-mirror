From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 1/3] gpg: Close stderr once finished with it in verify_signed_buffer()
Date: Thu, 31 Jan 2013 10:06:34 -0800
Message-ID: <510AB2AA.4000400@codeaurora.org>
References: <1359597666-10108-1-git-send-email-sboyd@codeaurora.org> <1359597666-10108-2-git-send-email-sboyd@codeaurora.org> <20130131055053.GA11912@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 31 19:07:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0yXJ-0002fR-BD
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 19:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754729Ab3AaSGg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 13:06:36 -0500
Received: from wolverine02.qualcomm.com ([199.106.114.251]:32522 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484Ab3AaSGf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 13:06:35 -0500
X-IronPort-AV: E=Sophos;i="4.84,578,1355126400"; 
   d="scan'208";a="23457564"
Received: from pdmz-ns-snip_114_130.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine02.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Jan 2013 10:06:34 -0800
Received: from [10.46.166.8] (pdmz-ns-snip_218_1.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id AED7B10004C7;
	Thu, 31 Jan 2013 10:06:34 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <20130131055053.GA11912@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215136>

On 01/30/13 21:50, Jeff King wrote:
>
> The strbuf_read above will read to EOF, so it should be equivalent (and
> IMHO slightly more readable) to do:
>
> diff --git a/gpg-interface.c b/gpg-interface.c
> index 0863c61..5f142f6 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -130,8 +130,10 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
>  	write_in_full(gpg.in, payload, payload_size);
>  	close(gpg.in);
>  
> -	if (gpg_output)
> +	if (gpg_output) {
>  		strbuf_read(gpg_output, gpg.err, 0);
> +		close(gpg.err);
> +	}
>  	ret = finish_command(&gpg);
>  
>  	unlink_or_warn(path);
>
> But that is a minor nit; either way, the patch looks good to me.

Looks better. I'll resend with this.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
