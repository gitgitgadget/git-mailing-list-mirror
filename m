From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] http: add support for specifying an SSL cipher list
Date: Thu, 7 May 2015 23:53:19 -0400
Message-ID: <CAPig+cSvau6=TGrse0J86MY2Sb0qRfoOQybhLkfqCCS2s7NQXQ@mail.gmail.com>
References: <1431008210-673-1-git-send-email-lars@redhat.com>
	<1431056685-12337-1-git-send-email-lars@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Lars Kellogg-Stedman <lars@redhat.com>
X-From: git-owner@vger.kernel.org Fri May 08 05:53:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqZM0-000675-Tf
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 05:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbbEHDxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 23:53:21 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:36249 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbbEHDxU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 23:53:20 -0400
Received: by igbpi8 with SMTP id pi8so11136285igb.1
        for <git@vger.kernel.org>; Thu, 07 May 2015 20:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=zgKaL25LUqLYSFW6dvidA/YuXNAzCjaDU7o54EBdErg=;
        b=BZ1nXibhQ7efOFNPH6Ec+dle1HMFjdEIXOAipNs0ma87vRbGflfx5jZWn6f7RHg42F
         yUPGuixa0WYMpb4Dg1o5UsWjn54j5E1DYjGfsEjcebdt3kkKpvj8d78YhDQc13Ghigtq
         OD18tywG6aw4slQ0pa7ZYwyEWtyplwsJtoGt+seEH1oa3x6sHi1houp6n1Ra4hVt1PrG
         KHBuFYnXRt6DYNUQ2xU0jkflrD7cky74PILoKGBh8ykWSxeRgCBUgD/fwkqjY/Dw8WSp
         rlGBqkZeRxlAWh1UQhlNXP4r+RWWq0LvFU2EaP2TFPhBt9KXXg4+xMGNZMzRBk1QjrbV
         B7oA==
X-Received: by 10.107.169.74 with SMTP id s71mr2394802ioe.46.1431057199771;
 Thu, 07 May 2015 20:53:19 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Thu, 7 May 2015 20:53:19 -0700 (PDT)
In-Reply-To: <1431056685-12337-1-git-send-email-lars@redhat.com>
X-Google-Sender-Auth: FKo6IvfCO__YkFnGyoIb5bECoJE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268601>

On Thu, May 7, 2015 at 11:44 PM, Lars Kellogg-Stedman <lars@redhat.com> wrote:
> Teach git about a new option, "http.sslCipherList", which permits one to
> specify a list of ciphers to use when negotiating SSL connections.  The
> setting can be overwridden by the GIT_SSL_CIPHER_LIST environment
> variable.
>
> Signed-off-by: Lars Kellogg-Stedman <lars@redhat.com>
> ---
> diff --git a/http.c b/http.c
> index 4b179f6..3a39d07 100644
> --- a/http.c
> +++ b/http.c
> @@ -187,6 +188,9 @@ static int http_options(const char *var, const char *value, void *cb)
>                 curl_ssl_verify = git_config_bool(var, value);
>                 return 0;
>         }
> +       if (!strcmp("http.sslcipherlist", var)) {
> +               return git_config_string(&ssl_cipherlist, var, value);
> +       }

Style nit: None of the other conditionals in http_options() use curly
braces when the 'if' body is a one-liner.

>         if (!strcmp("http.sslcert", var))
>                 return git_config_string(&ssl_cert, var, value);
>  #if LIBCURL_VERSION_NUM >= 0x070903
