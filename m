From: Stanislav Kolotinskiy <stanislav@assembla.com>
Subject: Re: [PATCH] git-send-pack: Fix --all option when used with directory
Date: Thu, 24 Mar 2016 15:57:59 +0200
Message-ID: <56F3F267.30900@assembla.com>
References: <1458750262-25765-1-git-send-email-stanislav@assembla.com>
 <20160323212213.GA19920@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Dave Borowitz <dborowitz@google.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 24 14:58:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj5mN-0000gk-4X
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 14:58:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbcCXN6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 09:58:22 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:32979 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbcCXN6W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 09:58:22 -0400
Received: by mail-wm0-f46.google.com with SMTP id l68so275804860wml.0
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 06:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=assembla-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=9R1f4uiKQ57vdXCRyNewTdc+41VaikOQU8x111tTidA=;
        b=FFr9DEYKgclqXaHhJjHDRGs1ZJ2nAbVvmIerK2D1XnmTYSNb8rR/5UxoBoB+22aj42
         Ay5oi5znxGj7LJxIPTxFwsTUkT3OKwfJvMu0UkulbxN65D5Kl9vUmZgXjvOhZSopHoeT
         PYv/xzEw12YUc11gjyzN13D6dqZvpMSw8O1Uc36ZTZ2Al01gsP95JyAywNM3muJebWLJ
         F+Q2bb2o1V3faugaZ25pMs4Iz7cqdMuGJtjepQ7TJ9pqiVqU6/DBnNC7UPkkFbUauLhh
         bmVs8GywFnGnIYtpAkrrIG01TtwPDDgr/ujRvS8tEE5qehpWeer9t1aKjdTutfcxkqC2
         chIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=9R1f4uiKQ57vdXCRyNewTdc+41VaikOQU8x111tTidA=;
        b=NcCeuWvUPRf4A1H8Ug4FX6G7rNnGsfN7/vt9e7x3bw9x+ujH8cJPeMLDnVoxhkvFwU
         Jmma0C/kzZS0C91tjwJHog1z8G852XmkttcY1LIejsSr59W46Am9yxT58vF63vrAYiqT
         outZ+qt8voYrTc80ZTZWwippkDImxqgWk1g04DZm0XDGeLcI/QfMiKwuLY+JzdsiGu+v
         g48Mx/hWlTwcrs0D8/gDIGALtILIY5+9xM6NunBGBPW1JSTf372pV6XXhYc2NljfdRj1
         uWAiA9DlxZQ1i6fNwO2BsXc1O/zckTISFrtnlnLr58GOcQ7x64Rt/aP8kQWKeiLZ4q3a
         42mg==
X-Gm-Message-State: AD7BkJI8wLO5xHloyTke82McvpWPO2k34l8w/cTv9rzr/hj5BPSXajcgKqy0sQKXfzTxOw==
X-Received: by 10.28.55.74 with SMTP id e71mr34592014wma.26.1458827881456;
        Thu, 24 Mar 2016 06:58:01 -0700 (PDT)
Received: from [192.168.88.127] ([217.26.172.139])
        by smtp.googlemail.com with ESMTPSA id t8sm7490502wjy.41.2016.03.24.06.57.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Mar 2016 06:58:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <20160323212213.GA19920@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289745>

On 23/03/16 23:22, Jeff King wrote:
> Not that it matters for this bug, but for my own curiosity, what do you
> use "send-pack --all" for? I've generally assumed that nobody directly
> calls send-pack themselves these days, but of course we have no data to
> support that either way. So I am always interested to hear about unusual
> use cases.
Well, here at Assembla we're using send-pack --all for creating forks
from repos in a quick and efficient way.
> The tests are roughly grouped by functionality. send-pack tests are in
> the t540x range, and this should probably go there. Though I also
> suspect it could easily be added to the end of an existing test script,
> which is preferable.
I'm not really comfortable (yet) with git tests, so thanks for pointing 
to that.
I did see t5400, but thought that bug fixes should bring their own, 
separate,
test files. Also, thanks for all the explanations and for the adaptation 
of my
test to a way better version!

I'm going to update the patch and will send another version. Thanks again!

--
Regards,
Stanislav
