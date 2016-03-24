From: Stanislav Kolotinskiy <stanislav@assembla.com>
Subject: Re: [PATCH] git-send-pack: Fix --all option when used with directory
Date: Thu, 24 Mar 2016 19:47:12 +0200
Message-ID: <56F42820.5000003@assembla.com>
References: <1458750262-25765-1-git-send-email-stanislav@assembla.com>
 <xmqqpoujama8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 18:47:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj9Ls-0003XX-0O
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 18:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728AbcCXRrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 13:47:17 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:33436 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548AbcCXRrP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 13:47:15 -0400
Received: by mail-wm0-f41.google.com with SMTP id l68so285592445wml.0
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 10:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=assembla-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=zWMnGXgeLP8GsAgDIGWwcxaUuG+nho+JSJ/WAqOtUY0=;
        b=Y6/9/oqVCRikdCoSMUdhLqapauMW+7AIW2bqkwQrlN0E7W3HP43TmBdAZ7StlN9c+i
         Kr4+6j3642LM3vY/3skAR9IBQGyqcLwW96F6t4g2EzeodORx4K5qdDsrZ5ZQgXZ6m8UD
         QdycjfE8kAYu81N39y2hHCC2371tgcRtArEt+jxDaYq/wC8ZfxlykYMR+2K/re6uI3t6
         hXaoDC8V+bJvDfb+/zhckZN82h26g1BRE355EfthP8rBqLu/WkgE/Z72TsosUkzwW5Ad
         fWVCdPqcg757eLtqNrkDOyJDJbZrzqT/XZA9tyUavPPqHGtNR8AFeO8xDCqGsOBSzJo7
         /T8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=zWMnGXgeLP8GsAgDIGWwcxaUuG+nho+JSJ/WAqOtUY0=;
        b=aA6I+5o/eFHZCgVGDRZ08efi2MvMd4i6E/qJoGFWO0QI8mbeJerbpAjLjMMgL1+JP5
         BGtp/U5FFKOF9twgf3GEWcmM2ABz1wNDlHWAo1x3VSdMX2lgEE6WU9GKOrazQcKQdiUO
         +TJZR94tbDw8hA+dN4XFUu/3YP5g3WTuA+nsw7nyC7PSTtdOIwWxB+NjOiuHJiOLM8rj
         bjho4F0atpRbsv+q60Xc8xS59DQHLV6AaIbwWXZDltEN9QZtBGoqaBaYp5tW0tIIRUUj
         BkYG+3Pgay38AD8E/DgMDo9vrcmyhWac15CbU9e0goTQwnbKTrg55hSnYM7a20ddr3rx
         U8xw==
X-Gm-Message-State: AD7BkJK50KQsM5mqOndGFza+LpwsRATDrCZj4iSx9F1AywtoOMMivaReZneLJUG8St0KTw==
X-Received: by 10.28.217.82 with SMTP id q79mr11939618wmg.29.1458841634506;
        Thu, 24 Mar 2016 10:47:14 -0700 (PDT)
Received: from [192.168.1.104] (host-static-92-115-177-146.moldtelecom.md. [92.115.177.146])
        by smtp.googlemail.com with ESMTPSA id l135sm8789435wmb.13.2016.03.24.10.47.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Mar 2016 10:47:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <xmqqpoujama8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289772>

On 24/03/16 18:11, Junio C Hamano wrote:
> Please see "git shortlog --no-merges" output from recent history and
> notice that s/Fix/fix/ would make things more consistent.
Thanks for letting me know, I'll update that.
> Thanks for noticing; the above explanation however does not make it
> very clear why the symptom exhibits itself only when "directory" is
> given (it also is unclear if "target" being a directory is special,
> or if any remote repository specification, e.g. host:/path/to/dir,
> triggers the same problem).
I'll think about a better explanation and will post it here - thanks.

--
Regards,
Stanislav
