From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 21/25] checkout: support checking out into a new
 working directory
Date: Thu, 27 Feb 2014 01:59:03 -0500
Message-ID: <CAPig+cRnAm1fz0u2UHEWeZvERbwgOsSe=m3wWLMVvmjzUnRarg@mail.gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1392730814-19656-22-git-send-email-pclouds@gmail.com>
	<CAPig+cSDT72MHFdwnZHBwEUiJQiQAkc-nv0vK166O8EuXVtgbw@mail.gmail.com>
	<CACsJy8BkAOk4d3nFP_CtUN4Feer0sHy8H8vpbUWcZcYMLYgYyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 07:59:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIuw2-0005dZ-QK
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 07:59:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbaB0G7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 01:59:06 -0500
Received: from mail-yh0-f44.google.com ([209.85.213.44]:51177 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbaB0G7E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 01:59:04 -0500
Received: by mail-yh0-f44.google.com with SMTP id f73so2222332yha.17
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 22:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=7cQZdFLxkh5Y8syi/FO7E70HCu50KpW3hZIJl7RWwsU=;
        b=IZAQCFs1wkl7iHEI76aCrRV6FTTSpDcyfUVfeMSdXoIP2dLhKf/AYDb4gZ7lQoWS7Y
         9IYDGZKSZUichdIAUD8gEk0OWMfbHJIlhrLYvWbh9kiH5qiGriYNEHZOzd/Axd4H3RZb
         5VK9UbMt0xtwON0JEqOow+68t0VhEvh8oVZUHG67RzMlIyIg1Y1NirWCAvQXyqRidtPN
         Ooz8qCGGbmfBMhDzgZDOE7zrooOYVaGYg5W0lN7P+biSLgKNS/WOx9wAOdvDA1rSXxPu
         umGbtFErFvPVJqutWCzqyPmq/DhRTig6I1sG9seYK0DXt1V8Hht7T5YCBUExkvncLgbT
         3VRg==
X-Received: by 10.236.111.82 with SMTP id v58mr269021yhg.108.1393484343471;
 Wed, 26 Feb 2014 22:59:03 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Wed, 26 Feb 2014 22:59:03 -0800 (PST)
In-Reply-To: <CACsJy8BkAOk4d3nFP_CtUN4Feer0sHy8H8vpbUWcZcYMLYgYyg@mail.gmail.com>
X-Google-Sender-Auth: P-xcOjhFYOvCzHalIuIabdS5KYQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242786>

On Wed, Feb 26, 2014 at 6:19 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Feb 27, 2014 at 3:06 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> +       len = strlen(path);
>>> +       if (!len || is_dir_sep(path[len - 1]))
>>> +               die(_("'--to' argument '%s' cannot end with a slash"), path);
>>
>> What is the purpose of this restriction?
>
> Laziness on my part :) Because the following loop searches backward to
> get the `basename $path`, trailing slash would make it return empty
> base name. I could have just removed the trailing slash here instead
> of dying though. Thanks for catching.

Thanks for the explanation. I thought that that might be the case.

>>> +       for (name = path + len - 1; name > path; name--)
>>> +               if (is_dir_sep(*name)) {
>>> +                       name++;
>>> +                       break;
>>> +               }
