From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH] http.c: use CURLOPT_RANGE for range requests
Date: Fri, 30 Oct 2015 18:43:26 -0400
Organization: Twitter
Message-ID: <1446245006.16007.0.camel@twopensource.com>
References: <1446244888-32610-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 30 23:43:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsIOY-0002Ss-Kc
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 23:43:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031628AbbJ3Wn3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 18:43:29 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:32998 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031524AbbJ3Wn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 18:43:27 -0400
Received: by qkdl128 with SMTP id l128so11586303qkd.0
        for <git@vger.kernel.org>; Fri, 30 Oct 2015 15:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:organization
         :content-type:mime-version:content-transfer-encoding;
        bh=KpEUiIJToEWQVEy/Ddn85WNRh4vgpdz4ziZwR5W8/fc=;
        b=hw0nDPT8wJjHt23FSsIlbNHtCRtvsvKqX0jga0NOnenS7wdbpPCSzL+e//4AwJ7qin
         cpypLQ8JqRHUdEBVl/KJ3LEsZMQj7Ee+KW46tMihfyqUV+xvdRiuyIZIFRQP55Bl6v7M
         1ehIdI0qDNJvP0tWSVSzoPSAlFCIvX6JetSI4K5Jvk2CVCf+eH/EVbRDUBf31QH+Wd0W
         uIqTujXNSBve7v3fpYunFD7uTRqUGNVsB8H1sgqjUeMqTwxZbIHxwuLq1aLriVO5aZZc
         c7Gt5JC3wN0YQI+A0uQZIW+71YBNvmz0vfBPWBIe4ZR6ptVHAWLbz2PTGXFoDMR8DII/
         tNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=KpEUiIJToEWQVEy/Ddn85WNRh4vgpdz4ziZwR5W8/fc=;
        b=gN/Su6DtPvXVo8sW0BPWriwNGdu2sILXzTLMjU7/3yILKVHHOZ6R/hV5CRfzDZaGgs
         Cr0rcXTagw+TKOMUqzYBv/eu7xRkYip4L6IDah7S1XWofe9JbW8oV9CO+k5lDJ9HOkyQ
         ScbFz8dg5OC+Epe9WwoRvoVcA5gOMUMYU/kOtUP7WVWG8jGF+JgCyNxdY4QLPoHtjwuz
         H6qaMMDdRaX91fYIueexrUsvVefRk5JaJTh9fLYZaL8XbwURzFTM0j7V66KnflXSe+zf
         +JK4OkDtf1yi/B3TOlndkhTDBBYPAmHGJJ6P4ERlhHz5yp5rk0tpEvIrr73ONi0IP59A
         xsAA==
X-Gm-Message-State: ALoCoQlwGSKJqKsYvnJNiSZtcN2PSpACyWqKs3oducEaaIaNxcDu8mIe6BYGuwk944u7JxCUrfu6
X-Received: by 10.55.40.211 with SMTP id o80mr13355392qko.93.1446245006316;
        Fri, 30 Oct 2015 15:43:26 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id r73sm3343914qha.48.2015.10.30.15.43.25
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2015 15:43:25 -0700 (PDT)
In-Reply-To: <1446244888-32610-1-git-send-email-dturner@twopensource.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280556>

Please disregard this; I noticed I missed a few instances.  Will reroll
shortly.


On Fri, 2015-10-30 at 18:41 -0400, David Turner wrote:
> A HTTP server is permitted to return a non-range response to a HTTP
> range request (and Apache httpd in fact does this in some cases).
> While libcurl knows how to correctly handle this (by skipping bytes
> before and after the requested range), it only turns on this handling
> if it is aware that a range request is being made.  By manually
> setting the range header instead of using CURLOPT_RANGE, we were
> hiding the fact that this was a range request from libcurl.  This
> could cause corruption.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  http.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/http.c b/http.c
> index 0f924a8..303b388 100644
> --- a/http.c
> +++ b/http.c
> @@ -1202,8 +1202,9 @@ static int http_request(const char *url,
>  			curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION,
>  					 fwrite);
>  			if (posn > 0) {
> -				strbuf_addf(&buf, "Range: bytes=%ld-", posn);
> -				headers = curl_slist_append(headers, buf.buf);
> +				strbuf_addf(&buf, "%ld-", posn);
> +				curl_easy_setopt(slot->curl, CURLOPT_RANGE,
> +						 &buf.buf);
>  				strbuf_reset(&buf);
>  			}
>  		} else
