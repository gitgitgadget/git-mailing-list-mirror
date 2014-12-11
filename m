From: Kelson <kelson@shysecurity.com>
Subject: Re: [PATCH] added git-config support for diff.relative setting
Date: Thu, 11 Dec 2014 16:41:07 -0500
Message-ID: <548A0F73.80109@shysecurity.com>
References: <548947A0.7000608@shysecurity.com> <CACsJy8CBRzbVrKnKPACuqxLw2N3PiK2O2nE4-C_3jfEp6-2p=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 22:41:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzBUQ-0005CI-Bi
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 22:41:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965336AbaLKVlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2014 16:41:13 -0500
Received: from mail-qg0-f50.google.com ([209.85.192.50]:49153 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934302AbaLKVlL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2014 16:41:11 -0500
Received: by mail-qg0-f50.google.com with SMTP id i50so4473157qgf.37
        for <git@vger.kernel.org>; Thu, 11 Dec 2014 13:41:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=INXRRnVCN0nVWEWTyls6IaK1hgpNvA+vkUa4SBfdQGM=;
        b=BOH3PwwIKhJoMmIVAZsq2XLkh8osyFLrXUWNIEk1J3h4dMTqnh1RNB9fGvua8jg7K2
         Euh8rhMOyP4WEliqsgCSp8OFKR3FF0UfN8vm9xgIdh1d9DmXkCrvfSLrslS8gJWPwkIj
         YbYwaf5I0gjsPDpu897umFM2v9nGfANacxDkTJZd1RW2FPEpUh8IWPT1pRuv6cNZQN2f
         faGSc2BHYAoZGzrudECT5y6eLXHiTtcyIpld/ZRpaT6RvPk5NZemuMaRb2dzEePvq96+
         dkUMWhV5en/swS+hUPOzAN8MkbWJPbUiiJhoYIUJamN2hZ+X3uYxcubo3aa7cjihV9w5
         adfw==
X-Gm-Message-State: ALoCoQnrQuvegRZH2A4xscQh6VZbg3bD0agk5vkQzIqAPu5Aj0VDuScKdAd1xO7B7dDz/JoK4OvO
X-Received: by 10.140.84.111 with SMTP id k102mr22905486qgd.76.1418334070671;
        Thu, 11 Dec 2014 13:41:10 -0800 (PST)
Received: from [10.0.0.22] (pool-100-36-60-151.washdc.fios.verizon.net. [100.36.60.151])
        by mx.google.com with ESMTPSA id j91sm2206780qgd.8.2014.12.11.13.41.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Dec 2014 13:41:10 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <CACsJy8CBRzbVrKnKPACuqxLw2N3PiK2O2nE4-C_3jfEp6-2p=g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261292>

That is quite manageable. I was concerned that --relative changes the UI 
(relative paths) and behavior (excluding files outside the current 
directory), which might not be clear if placed in just the UI component. 
You make a great point that git_diff_basic_config drives other commands 
though, like git-bisect, which --relative would not effect.

-----Original Message-----
From: Duy Nguyen <pclouds@gmail.com>
Sent: 12/11/2014 08:37 AM
To: Kelson <kelson@shysecurity.com>
CC: Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] added git-config support for diff.relative setting

On Thu, Dec 11, 2014 at 2:28 PM, Kelson <kelson@shysecurity.com> wrote:
> @@ -270,6 +270,14 @@ int git_diff_basic_config(const char *var, const char
> *value, void *cb)
>                  return 0;
>          }
>
> +       if (!strcmp(var, "diff.relative")) {
> +               if (git_config_bool(var, value))
> +                       DIFF_OPT_SET(&default_diff_options, RELATIVE_NAME);
> +               else
> +                       DIFF_OPT_CLR(&default_diff_options, RELATIVE_NAME);
> +               return 0;
> +       }
> +
>          if (starts_with(var, "submodule."))
>                  return parse_submodule_config_option(var, value);
>

This affects more than just git-diff. git_diff_ui_config() may be a
better place.
