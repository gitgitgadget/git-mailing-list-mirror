From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 3/7] url: add str wrapper for end_url_with_slash()
Date: Mon, 22 Nov 2010 11:14:34 -0600
Message-ID: <20101122171433.GB2084@burratino>
References: <1290433298-6000-1-git-send-email-rctay89@gmail.com>
 <1290433657-4444-1-git-send-email-rctay89@gmail.com>
 <1290433657-4444-2-git-send-email-rctay89@gmail.com>
 <1290433657-4444-3-git-send-email-rctay89@gmail.com>
 <1290433657-4444-4-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 22 18:14:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKZyX-0006am-Tw
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 18:14:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962Ab0KVROk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Nov 2010 12:14:40 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54527 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790Ab0KVROj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Nov 2010 12:14:39 -0500
Received: by vws13 with SMTP id 13so3516639vws.19
        for <git@vger.kernel.org>; Mon, 22 Nov 2010 09:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=nFQa9MJrfnDFMF9lW4/wNgrwswajmX4v9pRsStG0G1Y=;
        b=wkzepxN5NMqFqkteHBAEEIdsdHhu8FQs8hiKmqIBF7o/SrijP8mQI2pMA/6lscaL9f
         r2x6z6Q8N6UsqXmC8BFAIp+b7MJCFuu0zZa5cG0CdU2XklP9x9mbxsiYoRsH+SlCmSa6
         NH0GoOmcVmFmPhVfRy2kb6zmuv16i/CorKahY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=rVtACUnvogcMOwGzlQJlndoeQg7W/h5huDp7wr4/9LfJwQDo5RN4bNtxjMn7f/JU8P
         R6u52Mh/IyMHuYnLhMGFOSlrfEH7SkFt/v9CPyIXTvfXpOIuawPSGrjOYs8nu10R7xUb
         JFhH0UJbEbzLhtzHUmvBVYUMpi0b79fbIKMfc=
Received: by 10.220.183.72 with SMTP id cf8mr1603233vcb.108.1290446078347;
        Mon, 22 Nov 2010 09:14:38 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id fs21sm1750881vbb.0.2010.11.22.09.14.36
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 22 Nov 2010 09:14:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1290433657-4444-4-git-send-email-rctay89@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161903>

Tay Ray Chuan wrote:

> --- a/url.c
> +++ b/url.c
> @@ -132,3 +132,11 @@ void end_url_with_slash(struct strbuf *buf, const char *url)
>  	if (buf->len && buf->buf[buf->len - 1] != '/')
>  		strbuf_addstr(buf, "/");
>  }
> +
> +void str_end_url_with_slash(const char *url, char **dest) {
> +	struct strbuf buf = STRBUF_INIT;
> +	end_url_with_slash(&buf, url);
> +	if (dest)
> +		free(*dest);
> +	*dest = strbuf_detach(&buf, NULL);

I think this should be

	end_url_with_slash(&buf, url);
	free(*dest);
	*dest = strbuf_detach(...

If dest were NULL, the assignment would segfault anyway.  If dest were
non-NULL and *dest NULL, the free() would be a no-op.
