From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/8] run-command: Call get_next_task with a clean child process.
Date: Wed, 21 Oct 2015 14:07:32 -0700
Message-ID: <CAGZ79kacfCG67yRLhM000wdxGxFCXXB840hiEd_vKRmOn7EzeQ@mail.gmail.com>
References: <1445381030-23912-1-git-send-email-sbeller@google.com>
	<1445381030-23912-3-git-send-email-sbeller@google.com>
	<xmqq37x56sz6.fsf@gitster.mtv.corp.google.com>
	<xmqqh9lkufpt.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 23:07:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zp0bi-00026Y-8M
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 23:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754970AbbJUVHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 17:07:34 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:33238 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbbJUVHd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 17:07:33 -0400
Received: by yknn9 with SMTP id n9so62989160ykn.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2015 14:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=I/YB1gK36pA3HuRDiG1yeEl3bo2NXuRJhIIPJoxOK6w=;
        b=KAtwfDA1w3kuIBOhBRJzwF3GN2kTQFoy6So+Fy4NDfXHi/xJJbxVYR9kei/LGXj76F
         Aj079jfzzWdtnYTS3W+9dysVpq3txBnB321MikZ7O9601obAioO7TN+zWnfwyTO0tNiX
         o2Ud+E8ulCaieU7wV7JaWTnfu0FQao0Zu89RLjuX/FTyiTZYRfAA32lscmo2DK6vMnBq
         VHVyr3Y2szlWBL7ftqyHGZMl3eYeyxVTBOw5klI1RAAwDQdA/FFAN1lS6wf76ep1c23h
         WtqDr07v3VdWhSOrVAsdAWJ9xnWtXLTJeIeN43OCsoPFcF+2459p+/a2X7qCKHkAUujw
         GCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=I/YB1gK36pA3HuRDiG1yeEl3bo2NXuRJhIIPJoxOK6w=;
        b=cuiywSuRq9hDHdGvAhW5mHDMIdt1kbDF+buyV3CEo/Vl5ffE3l0gMkvB/OXvEl+V8V
         g4Jksb01jTgMg3HSxmg8wvvUDWqXrR/o3GQG8ws60LgPfxxnuv7/b/TgUcnn1Xd7/8TL
         JL08cOT4/WBIOJi9pPJhlbv8sggbSf6Ay9Fhz1C0JW1VwNxXfhnWh/U3+oq+D0MdcVmS
         H75WMmB+XTtdYIaVxZwaI+VwumaEZZ0Wx9+2/cLzZr7JCAdqADnLgeNs0XNw2LMSkrpE
         L63nae1PucQxRHwJmzfzKIpJpQp2ml4GtExwiyXiLrMQW0tUMZDoqB8YZqE/VTE0gxNy
         t8AQ==
X-Gm-Message-State: ALoCoQk+4QNCIVqXzNKZoOX1UlhQxcHKBynpXmTPg8j3CTpuAtG9TP36UbMX3T+MghoQVtD8chAd
X-Received: by 10.129.75.208 with SMTP id y199mr9257290ywa.48.1445461652667;
 Wed, 21 Oct 2015 14:07:32 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Wed, 21 Oct 2015 14:07:32 -0700 (PDT)
In-Reply-To: <xmqqh9lkufpt.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280022>

On Wed, Oct 21, 2015 at 1:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> And of course we already have these array-clear calls in
>> finish_command().
>>
>> So I agree that deinit helper should exist, but
>>
>>  * it should be file-scope static;
>>
>>  * it should be called by finish_command(); and
>>
>>  * if you are calling it from collect_finished(), then existing
>>    calls to array-clear should go.
>>
>> Other than that, this looks good.
>
> I'll queue this instead (the above squashed in and description
> corrected).
>

Thanks,
Stefan
