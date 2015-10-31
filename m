From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 0/3] daemon: plug memory leak
Date: Sat, 31 Oct 2015 13:32:40 -0700
Message-ID: <CAGZ79kaXfkmSm0dn40kqrD95D2qpMo+NgEYbs=rVca5qnLTuMQ@mail.gmail.com>
References: <56348709.9080207@web.de>
	<20151031135304.GA28310@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 31 21:32:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZscpS-0000kv-3z
	for gcvg-git-2@plane.gmane.org; Sat, 31 Oct 2015 21:32:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbbJaUcl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Oct 2015 16:32:41 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:34389 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbbJaUcl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Oct 2015 16:32:41 -0400
Received: by ykdr3 with SMTP id r3so106817069ykd.1
        for <git@vger.kernel.org>; Sat, 31 Oct 2015 13:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=OkIa+pstkp7tqqW+2QVau7A3bPaW6MFH0GMyMyndqxE=;
        b=jV696RHcpnB/oankcduD2wG/1to1pl3htojRbHhG9CTcrijTTI46W4iYrPc+rMsuSY
         ju8bkbzd/4CaErC1lhBSVH5qfF3+q51X9/xtppFVf+wIzmvETf+Lj5KMoauVdW1hep6D
         0BM4hDTMr5sAc3uAAowmRuuo703xZtRAROE6YazXWKdIkOOgfgFe1f9wgEPPz/5Pxje/
         9Qqhki0GOvTgy9aoOdSuWrMtqPNL+TMV/m/hZWQnqEdlfF0lw3VzWErKVYf/IF9tyTne
         jrmZYaxQD6nkj/Zo8847zNkcAMUaw07Q+P85l/FMakcsaCyom+d3U4eom6EyVtDiFKB1
         tguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OkIa+pstkp7tqqW+2QVau7A3bPaW6MFH0GMyMyndqxE=;
        b=k9m5kgspakCoGZaEsxyTKpHnuYojstABUg+cOhFgWyG08wA2DQPUjg1LaLisvyYmGr
         RDLEmIszMyRwn6AEtK5tv2Gy1wyM3XkKo8SqneLLkYNS9P3hYE1AIe60dbzR0IPobRUI
         HPmZwZelgjDDQBBqPcL1i4iEk5scqMjvaUaDR8S3BTS8MSPSqjo6a1Q5YnWuOWGgURbI
         u6dDeEt1BWP/WyIZ7Mg6dq7axd7cDNSSbeXTZoQW4zBLBuG4AiWNnj+Q8sVkLaJn2A0i
         K7ZBuRv6bIPjWa3jKTdffyPM/nTY6uO/2u7Cch+xBoitkIoVygaKrqFA9hUZkHe5B1eE
         Mn+g==
X-Gm-Message-State: ALoCoQm2aJB9BKNUNTHckzOV++FiHQjl74GqvLdLVAvPLiYyzo4ng1USECtgmpzTnLXNI0qSovnS
X-Received: by 10.13.199.133 with SMTP id j127mr11039986ywd.176.1446323560311;
 Sat, 31 Oct 2015 13:32:40 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Sat, 31 Oct 2015 13:32:40 -0700 (PDT)
In-Reply-To: <20151031135304.GA28310@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280601>

On Sat, Oct 31, 2015 at 6:53 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Oct 31, 2015 at 10:16:57AM +0100, Ren=C3=A9 Scharfe wrote:
>
>> Changes since v1:
>> - Rebased on next, which already has a cleanup function.
>> - Added first patch for renaming it.
>>
>> Rene Scharfe (3):
>>   run-command: name the cleanup function child_process_clear()
>>   run-command: export child_process_clear()
>>   daemon: plug memory leak
>
> This round looks good to me. Thanks.

Looks good to me, too

Thanks
Stefan

>
> -Peff
