From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH] http: honor no_http env variable to bypass proxy
Date: Thu, 10 Mar 2016 09:46:01 +0100
Message-ID: <CA+EOSBkfj1bt+yf2KQTzVoAPRkbB6MGUaJEmJV54Efz+0FOOwg@mail.gmail.com>
References: <5652e025323b60ccf5a59bcbdc7266d4f4e32fc4.1456758964.git.xin.jiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jiang Xin <xin.jiang@huawei.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 09:46:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adwES-0007yY-Tt
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 09:46:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754537AbcCJIqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 03:46:05 -0500
Received: from mail-vk0-f44.google.com ([209.85.213.44]:36778 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819AbcCJIqC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 03:46:02 -0500
Received: by mail-vk0-f44.google.com with SMTP id c3so87345645vkb.3
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 00:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=qo5zF96AYRDgqz5YzW0UoiRWVItSJmimekFH1nsEmH0=;
        b=kX0KWSckq9582+9oAEOqtwtn500FlCqCqVEDxCP+xHWDpiuUaO5dqbsGweQqRe6y7g
         XCz0P/KfR774ld7IZT60j1JVZ6fzsPnveGia/driBGPynIYEGypLkgUjHPw6Lt49IC5p
         E0GyRayatZrDPeMMRisttvJxsMiQd1MqnCy6xWjhIJwg11O4Lzeh1KPs/uir2clOZDtl
         RSLU6uO66U7yHFeCGX/Vg7ZST9k7cxE0xfb11ov0i7BoPjuuYtp35zS4TUt93KiQuvv3
         axXG5HjH/o3WoeCLGihGIfj35bSTRk/5W1jF0Fo4greQB3Dybe0PLL0olDRunTZRRvcV
         ZvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=qo5zF96AYRDgqz5YzW0UoiRWVItSJmimekFH1nsEmH0=;
        b=KlSn+PVV0zbQrAswp9jgvdPOJL+atqXI+UexDRIDvJNzvrO5da0OVqZvYcN1NIbaBI
         hs5D3n3wCa1U2z28kkZnfcW8oNQA11w8few2ZFVgnywgN2J7H3eixFW72T2AdmB4Tytx
         5DuNWQT23a0WdsP38nFKaAhDlRDdtbcrpIPMVTqCztnIqu/CCu1CyuS+Ddx6IwSnXmmc
         bZEbetc87vN3o0mQuhbrcKPCr+hKlq/fab9TFN6KS3SR1itrhF08DjDx7RijQQLgGl84
         0x3dKw/mxlyeMJ7XBq5pjA6JE4HhYPWa0/K+l9BIBWA6fNDqwbv3raNpCoydb4mzx4qY
         Z21w==
X-Gm-Message-State: AD7BkJKZ77d7LyV6wRvmwmYX9j7hDQGq6KJ0vhAjOeDZsE8NLUshxfgGlpQ4x9HrVw6c0DtkL7tW+adZHXezWQ==
X-Received: by 10.31.47.207 with SMTP id v198mr2405774vkv.6.1457599561495;
 Thu, 10 Mar 2016 00:46:01 -0800 (PST)
Received: by 10.31.56.10 with HTTP; Thu, 10 Mar 2016 00:46:01 -0800 (PST)
In-Reply-To: <5652e025323b60ccf5a59bcbdc7266d4f4e32fc4.1456758964.git.xin.jiang@huawei.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288603>

2016-02-29 16:16 GMT+01:00 Jiang Xin <worldhello.net@gmail.com>:
> From: Jiang Xin <xin.jiang@huawei.com>
>
> Curl and its families honor several proxy related environment variables:
>
> * http_proxy and https_proxy define proxy for http/https connections.
> * no_proxy (a comma separated hosts) defines hosts bypass the proxy.
>
> This command will bypass the bad-proxy and connect to the host directly:
>
>     no_proxy=* https_proxy=http://bad-proxy/ \
>     curl -sk https://google.com/
>
> Before commit 372370f (http: use credential API to handle proxy auth...),
> Environment variable "no_proxy" will take effect if the config variable
> "http.proxy" is not set.  So the following comamnd won't fail if not
> behind a firewall.
>
>     no_proxy=* https_proxy=http://bad-proxy/ \
>     git ls-remote https://github.com/git/git
>
> But commit 372370f not only read git config variable "http.proxy", but
> also read "http_proxy" and "https_proxy" environment variables, and set
> the curl option using:
>
>     curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);
>
> This caused "no_proxy" environment variable not working any more.
>
> Set extra curl option "CURLOPT_NOPROXY" will fix this issue.
>
> Signed-off-by: Jiang Xin <xin.jiang@huawei.com>
Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>  http.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/http.c b/http.c
> index 1d5e3bb..69da445 100644
> --- a/http.c
> +++ b/http.c
> @@ -70,6 +70,7 @@ static long curl_low_speed_limit = -1;
>  static long curl_low_speed_time = -1;
>  static int curl_ftp_no_epsv;
>  static const char *curl_http_proxy;
> +static const char *curl_no_proxy;
>  static const char *http_proxy_authmethod;
>  static struct {
>         const char *name;
> @@ -624,6 +625,11 @@ static CURL *get_curl_handle(void)
>                 }
>
>                 curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);
> +#if LIBCURL_VERSION_NUM >= 0x071304
> +               var_override(&curl_no_proxy, getenv("NO_PROXY"));
> +               var_override(&curl_no_proxy, getenv("no_proxy"));
> +               curl_easy_setopt(result, CURLOPT_NOPROXY, curl_no_proxy);
> +#endif
>         }
>         init_curl_proxy_auth(result);
>
> --
> 2.8.0.rc0.1.g9eb3984.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
