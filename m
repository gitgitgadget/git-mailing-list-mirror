From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] pkt-line: teach packet_get_line a no-op mode
Date: Sun, 17 Feb 2013 02:41:11 -0800
Message-ID: <20130217104111.GD6759@elie.Belkin>
References: <20130216064455.GA27063@sigill.intra.peff.net>
 <20130216064612.GA22626@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 17 11:41:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U71go-00045j-Ue
	for gcvg-git-2@plane.gmane.org; Sun, 17 Feb 2013 11:41:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755409Ab3BQKlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 05:41:18 -0500
Received: from mail-da0-f44.google.com ([209.85.210.44]:38967 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755343Ab3BQKlR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 05:41:17 -0500
Received: by mail-da0-f44.google.com with SMTP id z20so2046996dae.3
        for <git@vger.kernel.org>; Sun, 17 Feb 2013 02:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=6Khs3MYtxFftyGOqVd+iq77o3+ESAzSGlnEWYEpkc5M=;
        b=nqX/FegHf8jWRBGEh2fzAtQ9DvDi5eTvovQe1/RdPmqTvzpZZyX1W+XT/pSZjX73Bu
         0QAe449do64jz78LW0DYcdaVnefl/Y0aX2hLLFDQppxdUiLt7v9lFNipEopebNM+7hqg
         TxxRNNYCxrd/xDnb8o1rSVdOzVIsEppDCYBdFqGPglQa/IIQNfRxEouawrtxQ8Zgqhu/
         hsfWBp+7SS9RacBdKiAbwjwM9H7wnztYhGomMbkALjbzuM92HFsq356u2y5AziBbD/VE
         Z/nKEvhjCanCWpd1gJjygLn8GQ8zgxHZ62qO3lovR92Iv/vyx9T6EVME/gaZ37YUdxSF
         0hqg==
X-Received: by 10.68.143.167 with SMTP id sf7mr20547844pbb.21.1361097677406;
        Sun, 17 Feb 2013 02:41:17 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id k7sm86626208paz.13.2013.02.17.02.41.15
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 17 Feb 2013 02:41:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130216064612.GA22626@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216387>

Jeff King wrote:

> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -234,9 +234,10 @@ int packet_get_line(struct strbuf *out,
>  	*src_len -= 4;
>  	len -= 4;
>  
> -	strbuf_add(out, *src_buf, len);
> +	if (out)
> +		strbuf_add(out, *src_buf, len);
> +	packet_trace(*src_buf, len, 0);
>  	*src_buf += len;
>  	*src_len -= len;
> -	packet_trace(out->buf, out->len, 0);
>  	return len;

For what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

The above code has a structure of

	prepare to return(buf, len);
	trace(buf, len);

	discard used part of buf;
	return;

which is nice and readable.
Jonathan
