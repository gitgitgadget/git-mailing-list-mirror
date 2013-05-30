From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/4] commit: reload cache properly
Date: Thu, 30 May 2013 07:35:53 -0500
Message-ID: <CAMP44s1O=VTu8EZi+yOfGMccCpS+pozvZJuDW1mK95U8-YEquA@mail.gmail.com>
References: <1369915136-4248-1-git-send-email-felipe.contreras@gmail.com>
	<1369915136-4248-2-git-send-email-felipe.contreras@gmail.com>
	<87ehcok6gl.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Adam Spiers <git@adamspiers.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Boyd <sboyd@codeaurora.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu May 30 14:36:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui25H-0002ae-Uk
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 14:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754020Ab3E3Mf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 08:35:56 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:40934 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753304Ab3E3Mfz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 08:35:55 -0400
Received: by mail-la0-f45.google.com with SMTP id fr10so185350lab.32
        for <git@vger.kernel.org>; Thu, 30 May 2013 05:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Tkc2fhKeR6xExNvFGrOfuo8HUuOfAbweltbnje96xT4=;
        b=OTsW7dGB+Dzc8myl8r9Tyv1Uq/c3JES0mQpJKWTXXqEAZAI8Su/mNspxESgFoLMhb3
         eacqLz+yk/REYiQdTlOP+34J9Inghc/25hqpMpOfECJAbk9GPMmcVnVlxCWfGhg4O/9D
         PnGoVBI7GZUNaRDEJp70besoHcLs5E7mD2H9ecjqLUrg3Q1ZabjKmixGVe8odDrj1VMh
         IyvNhYqDyEmxskb98rCVIMr3mGwo6jQ+Jw4OGux0iITrsgATI/rvgWYHclCRoxf+eGxg
         mXoSQVPtxbRGZLb3rM0y0ZtY/dV7l2UZqwmY4z4jGdAcqWyQZL654Xe5ltlp8K+dKJwG
         X/wQ==
X-Received: by 10.112.138.131 with SMTP id qq3mr3688864lbb.46.1369917353957;
 Thu, 30 May 2013 05:35:53 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Thu, 30 May 2013 05:35:53 -0700 (PDT)
In-Reply-To: <87ehcok6gl.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225978>

On Thu, May 30, 2013 at 7:17 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> We are supposedly adding files, to to which cache if 'the_index' is
>> discarded?
> [...]
>>       if (!current_head) {
>>               discard_cache();
>> +             if (read_cache() < 0)
>> +                     die(_("cannot read the index"));
>>               return;
>>       }
>
> It is not obvious to me that this is a correct change.  discard_cache()
> without subsequent reloading could also legitimately be used to empty
> the index.  So if you are fixing a bug, please justify the change and
> provide a testcase to guard against it in the future.

So istate->initialized is false, yet somebody can still add entries to
the cache? What happens when somebody else tries to initialize this
cache? All the entries there will be lost, even though nobody
discarded it afterwards.

-- 
Felipe Contreras
