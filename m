From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] http-backend: provide Allow header for 405
Date: Sun, 8 Sep 2013 21:18:12 -0700
Message-ID: <20130909041812.GA3430@elie.Belkin>
References: <1378664106-95936-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net,
	jkoleszar@google.com, gitster@pobox.com
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Sep 09 06:18:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIsvh-0007Nv-Is
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 06:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118Ab3IIESV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 00:18:21 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:35382 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892Ab3IIESV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 00:18:21 -0400
Received: by mail-pd0-f180.google.com with SMTP id y10so5640977pdj.39
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 21:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=RORJdJZBilH2dfDk37wRmPrs4CSVJV6jePLlZnUE7Gk=;
        b=ko81gYt4+k+ACEI/z6j2znnsnJgEFyTUzZihrmLZCgKgR0+leZubCJh7hV7NE5Mt5P
         01d6b0pUsu1bmKRkTUCvWGIpRxmPKSdN2AcoTbQhSJyLwHr3D6c+sX3UX+Bzmjp+0RDQ
         Zv9Lh6JXGY+Lx5ldnvimNNtbaWnaae+PM4eFAfUALXtlEh/3vqMfpjE9WRzV3phStvT6
         QAElxxpFYr2lkIaHhxwW19Kl2lO6PPDHTz9ehzsaQNP3p4dilAf8xAGmQO4OQRjoWjAk
         AeohVWo36cJ6pcumXfZka2VMDbcMQiCrZlws9EcRPM4CHoXvxwqxk4DgoBETAH1Pxzyd
         FNGQ==
X-Received: by 10.68.221.233 with SMTP id qh9mr16791805pbc.103.1378700300770;
        Sun, 08 Sep 2013 21:18:20 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id sy2sm13495598pbc.16.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 21:18:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1378664106-95936-1-git-send-email-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234307>

Hi,

brian m. carlson wrote:

> --- a/http-backend.c
> +++ b/http-backend.c
> @@ -594,8 +594,11 @@ int main(int argc, char **argv)
>  
>  			if (strcmp(method, c->method)) {
>  				const char *proto = getenv("SERVER_PROTOCOL");
> -				if (proto && !strcmp(proto, "HTTP/1.1"))
> +				if (proto && !strcmp(proto, "HTTP/1.1")) {
>  					http_status(405, "Method Not Allowed");
> +					hdr_str("Allow", !strcmp("GET", c->method) ?
> +						"GET, HEAD" : c->method);
> +				}
>  				else

Small style nit: the closing brace should go on the same line as the
"else", like so:

				if (proto && ...) {
					...
				} else
					http_status(400, "Bad Request");

Another micronit: the comparison should be !strcmp(c->method, "GET")
--- variable first, then constant it is being compared to.

The functional change looks good.

Thanks,
Jonathan
