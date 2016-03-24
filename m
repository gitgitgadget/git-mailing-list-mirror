From: Stanislav Kolotinskiy <stanislav@assembla.com>
Subject: Re: [PATCH] git-send-pack: Fix --all option when used with directory
Date: Thu, 24 Mar 2016 19:49:13 +0200
Message-ID: <56F42899.9090909@assembla.com>
References: <1458750262-25765-1-git-send-email-stanislav@assembla.com>
 <20160323212213.GA19920@sigill.intra.peff.net> <56F3F267.30900@assembla.com>
 <20160324173731.GD6341@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Dave Borowitz <dborowitz@google.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 24 18:49:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj9Nr-0005Eu-M1
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 18:49:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264AbcCXRtT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 13:49:19 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:34297 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbcCXRtR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 13:49:17 -0400
Received: by mail-wm0-f45.google.com with SMTP id p65so284999315wmp.1
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 10:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=assembla-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=kKBvjxARVtiyBKowHNnFy3WuqZ8zsU5ZJE1p8HIikRs=;
        b=YlsQlpunefcrvaL+n29V32ndyjiY73JwQv+ZWyea2JQJW+2GspLQvZhIb2ZYr6SvZY
         QnQ7bloTCanrEEpuaetpkjdePhhGPD/l/9TmZoYCV4SQcMQ97JcjiwbsG9TFpQeXpNAn
         GvwJpfH9Ehlp5SXR6p5cCb4rTbqgkqgABRxuukZBfmVnV1P/LmjFPHeThQfNBPhn7vnK
         9Dyfp4sFh78INf/xL2CwP0yH3KhSRk5bo+bGPX0YqFEhrjZF1nPR4CZNC+eKtQXVTDnS
         QcaJxItk5IXhqyM9tuYMZXPTwhTqpUSTC5Gc4Hon/bfK5GWBOIgGrJO3LpB5U9Awx2Gd
         0bKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=kKBvjxARVtiyBKowHNnFy3WuqZ8zsU5ZJE1p8HIikRs=;
        b=ZoJyKJ+oiiUO7gx5MbVHgrZj3ed1K7ipDkCb/crps+dBN47n5rUvmBr2fjXLKWVDnV
         bsajvJEoErSi2GX6SiYvxZlRz9VEJkTjXkTGQ9sIgHzQhxQ+gjWKFpIvay8yGpYOSG4Z
         3O7CmYYGXEnlhcmLgwjXq5KV1q/kFDiGaTV2lkulPn+P+6PWEUJey3letRpUp9SxzYt4
         RdIPUJgbtOMmK7+Z1DY1tYppbGig46Ci9fzvFtBBfgRKO1nM5zCzb1zvGEVJldfhRxNJ
         3E3TeptdjsWsCXJgDtKozZPklCGxDDEDcopIUT66ZM0gorJELF4pzeVYEB6/4WhDYAsZ
         BCUA==
X-Gm-Message-State: AD7BkJKlL+PGZCB00QLgPsvoPd9A5Q/4YURJiWL6WDLVGRIS93jJCGsLsorObu9C+hD6jA==
X-Received: by 10.194.189.231 with SMTP id gl7mr11153595wjc.162.1458841756115;
        Thu, 24 Mar 2016 10:49:16 -0700 (PDT)
Received: from [192.168.1.104] (host-static-92-115-177-146.moldtelecom.md. [92.115.177.146])
        by smtp.googlemail.com with ESMTPSA id r8sm8365588wjz.34.2016.03.24.10.49.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Mar 2016 10:49:14 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <20160324173731.GD6341@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289773>

On 24/03/16 19:37, Jeff King wrote:
> I guess a follow-up to my question is: what does "git send-pack" do that
> "git push" does not? Again, this is just for my curiosity (the answer
> may be "nothing, we just happened to build our scripts around
> send-pack", and that is perfectly fine).
Well, this is some really old code (eight years old), and git version 
used at the moment was around 1.6. So I'm pretty much sure that it just 
happened to be the decision of the developer that wrote this piece of code.

--
Stanislav
