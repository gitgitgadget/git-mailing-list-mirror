From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Resumable clone
Date: Sat, 5 Mar 2016 16:40:15 +0700
Message-ID: <CACsJy8CESL6vH22mGSLRE1OKTEbGz2Vqmsv5bY3mn_E+03wADw@mail.gmail.com>
References: <CANtyZjSJf5_xbsBC5tUaazFT3uiEgJnx2_kHLwYwKcn50Jy_qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Kevin Wern <kevin.m.wern@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 10:40:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ac8hg-0003gh-PS
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 10:40:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759786AbcCEJkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 04:40:49 -0500
Received: from mail-lb0-f176.google.com ([209.85.217.176]:33994 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754415AbcCEJkr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 04:40:47 -0500
Received: by mail-lb0-f176.google.com with SMTP id cf7so69210761lbb.1
        for <git@vger.kernel.org>; Sat, 05 Mar 2016 01:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jOOenh2JspdygwYALyiNJUsgWrX2rmNQsGKQJgauDTY=;
        b=gmMvvq0FP1Mqy1jt7UV4M5wQX6X+QKPJGERGN/f47LxyoaFWzSkeq7/HrC3Uf+frjW
         z1NW+XvMU1/K+zM3LnbJvV4f51pOLq+HEMClryzy6aXBdHTaR7P857MRpDbt73prlpXX
         nPJt21KJQcPOndDuZ4QE0eEugeGxaXWMiniwatC2LXAcdpcbYXnhF4Hv1be/grK5Iop5
         GnT69fQh0cBSxInp3m99tOEIaZEpxI6h6khoEBTJkvT1R7whAaIopkAoN7oU+eK2cP8I
         waooh7+n6rxHbYUynRtcD3c0kvwYi9kPugiS8BH8ulIL3zbI2dc2JWKCql6NvCJQOO0b
         Mjbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jOOenh2JspdygwYALyiNJUsgWrX2rmNQsGKQJgauDTY=;
        b=P+P03L5ziNYzrmUDQNZom36qwtDSwWlaRkUIXPzdwtwDchyDXJkGuT3hgbBmadNV4M
         bTC9oQ4X/ZHPeag9v8yskOHWfGLzAXipzkgCw/hLln5Q0NI7k/JpIVlAArBEbuZm6aE3
         AKtpWng8VBMoLFLg00ugsNLbCS+L8GQ3/uOIDh5igwGUTkSXwF8xdcs9BR+BZCZwsQcp
         lMvkjJS7wPrcIb+qoFKX1nlFT6trIdi4qnsP6KVmZ3UpKg4EZnywxXb/rlC+ok+rHRHy
         FcyUbvCHYhT9xU/WvpZVWn+Kls00htpPx3Uz8z8WHg3zSj5rlylVVNI20dX8XFFeomNs
         C/6Q==
X-Gm-Message-State: AD7BkJIoTuaJJbKCtxZWOGHp3+ECcklwZdRq0ZN27bAFj6tJtpEKFtn4QYaH70WDXu4kEHFpkZF3SZO8ADCvqQ==
X-Received: by 10.25.24.100 with SMTP id o97mr212288lfi.112.1457170845510;
 Sat, 05 Mar 2016 01:40:45 -0800 (PST)
Received: by 10.112.167.10 with HTTP; Sat, 5 Mar 2016 01:40:15 -0800 (PST)
In-Reply-To: <CANtyZjSJf5_xbsBC5tUaazFT3uiEgJnx2_kHLwYwKcn50Jy_qg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288307>

On Sat, Mar 5, 2016 at 4:23 PM, Kevin Wern <kevin.m.wern@gmail.com> wrote:
> Hey, all,
>
> A while ago, I noticed that if a clone is interrupted, it has to be
> restarted completely. When I looked up the issue, I saw that someone
> suggested resumable clones as a feature as early as 2007.  It doesn't
> seem like any progress has been made on this issue, so I began looking
> at relevant code yesterday to start working on it.
>
> Is someone working on this currently?  Are there any things I should
> know moving forward?  Is there a certain way I should break
> down/organize the feature when writing patches?

Resumable clone is happening. See [1] for the basic idea, [2] and [3]
for some preparation work. I'm sure you can help. Once you've gone
through at least [1], I think you can pick something (e.g. finalizing
the protocol, update the server side, or git-clone....)

[1] http://thread.gmane.org/gmane.comp.version-control.git/285921
[2] http://thread.gmane.org/gmane.comp.version-control.git/288080/focus=288150
[3] http://thread.gmane.org/gmane.comp.version-control.git/288205/focus=288222
-- 
Duy
