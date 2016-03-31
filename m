From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] builtin/apply: free patch when parse_chunk() fails
Date: Thu, 31 Mar 2016 18:29:18 -0400
Message-ID: <CAP8UFD2uT8dF+LMEGVdM6QZztqr_FbX=UQ01U0ttODFUk4AxbA@mail.gmail.com>
References: <1458156911-26649-1-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 01 00:29:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1all5l-0004el-5e
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 00:29:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758281AbcCaW3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 18:29:20 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37954 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757468AbcCaW3T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 18:29:19 -0400
Received: by mail-wm0-f41.google.com with SMTP id 20so792509wmh.1
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 15:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=YDFLiyJ/Hg8TlCKNVadIaT4SW54KRCdp1RmfTC6Wf5Q=;
        b=m10Sz8zTa8/xmRdiRRFLbeHNH8Zzjc0X4k/PlrDoJCzIZ/HkQd1btw9cOa6cYt+dGA
         lmbMhmuhTg7Q7jzFvCX8mcLq/m2DK+F2yx0QbI2LFp550cFfpjfybuNIWrfaioIZRhkS
         0ai/nKk/lxIhYWnnJZf2T5nL/e8RfMXwrZPkWp5FmeSyYsJkp9nBYVGLae46SvmS1R/j
         K6cmbsQxs2AJh4RtBPwMYDPFfqIo6MZdthwrhszOa+HxMbokUxEFpTL2Z/fFDtCzR54u
         pjjHfb2iknc5AXjtz+fQ0zrpSq6paWogNHYHz1XZ1brwmQzqpRohPUuGa2J3NYg9/X0w
         A6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=YDFLiyJ/Hg8TlCKNVadIaT4SW54KRCdp1RmfTC6Wf5Q=;
        b=Z2q93uIiNQk4wZy8lRbevK1uQRBZ3dRcF9VVGCgyd40Yh0lI/6BYK12lW3VBCiS23u
         /6DSajb7spl1E1aGuiZHsNWdNGNr2OHW+RAePvfUACBa7uAEIhEb9KAsyg8CERojn1xZ
         wkJs3eDKwwwLV8ciE6gZdNIbyUZtX/4RZL3L0IIUhYhm3l+wJUQL6aOAr2aHhnU/3gf7
         tQ0CNGy2y88pFEnKS0Cvq3Ihji/vvWtSw5Pt38SMpzqsVF1R3zb0s8eXfY/favr35K9M
         ck4t1zUvxdReTXvtUMtq5EFL478bE4hcT4iHXRhThXHoZVM7MbSr7gt8ZrgAYXvGq2L/
         xl0g==
X-Gm-Message-State: AD7BkJKpsK4hzfhmH6Dnv4OsIO9jQ8aCi7QwyvIpSAtbZOeJXcR0vofE9Acdg4ziJwXe8ztZLOStRyaQAJoJSw==
X-Received: by 10.28.158.15 with SMTP id h15mr57141wme.89.1459463358158; Thu,
 31 Mar 2016 15:29:18 -0700 (PDT)
Received: by 10.194.151.131 with HTTP; Thu, 31 Mar 2016 15:29:18 -0700 (PDT)
In-Reply-To: <1458156911-26649-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290481>

On Wed, Mar 16, 2016 at 3:35 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> When parse_chunk() fails it can return -1, for example
> when find_header() doesn't find a patch header.
>
> In this case it's better in apply_patch() to free the
> "struct patch" that we just allocated instead of
> leaking it.

Maybe this patch has fallen through the cracks too.
