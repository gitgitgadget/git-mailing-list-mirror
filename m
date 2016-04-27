From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 27/83] builtin/apply: move 'read_stdin' global into cmd_apply()
Date: Wed, 27 Apr 2016 15:13:21 +0200
Message-ID: <CAP8UFD2kS8NihKQ4OtzOKNhjqBA-o-pNTA3CYpNGQ0ZfM8DWqA@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-28-git-send-email-chriscool@tuxfamily.org>
	<xmqqy480dsi0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 15:13:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avPHY-0008Sf-6P
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 15:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752290AbcD0NNY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 09:13:24 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:34847 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbcD0NNX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 09:13:23 -0400
Received: by mail-wm0-f54.google.com with SMTP id e201so38314229wme.0
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 06:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=i8tgAnoO2grpQSs052EuS2X8Km0Bn+eVIQeLCegMapk=;
        b=q3mOx9a0NEBO0XfbWhaN3zVUP6xrwtoTXJW1jzEqf0bndVFuoPsxon6MCtFuk7ffdb
         ZpT2VyAJwUjybpaHYulF/0KfpqjC8uJWAjoCsPC/8v5ufzPGBLtFgQY51UeAWbZwfRhe
         YMp7Psdc011qQ0bWegHTzwQqjq94zTNaS4uf11gjaRH1uqDv/6WxJdUGI4N2KYoJ/q6E
         n8De0OnoocpdyMcv3D/0r0Uk7OvSAPbz4Sv4VuLtaoCTQzn8LNddtRsovWGtqc8jD6Wm
         ouodLtBopcY5rZ8Snre3k445xeI1OsVtQdtOmAOWeEEgsSM3XQZYALJwmTyxIzbMI3XL
         AJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=i8tgAnoO2grpQSs052EuS2X8Km0Bn+eVIQeLCegMapk=;
        b=CeADrHraWGkSgWPPnmbrfDwtiS0Jr4Qph24E3xNKQpqT5b4IrzY1G3kByiC3hIQXYR
         MG+jjZH6KG0fNLPu464+gHmc2yof2+Tw+fX0aTgQJGAFIbYCeu00hAlAZ3YJhAdu8m8K
         y1GtPUcnCPAaMPXHUiM3E0h6p29DgVoXkpB0GF+0X97pMthDUZwGPQ1M9/X318HfKmxA
         DdpfEF8DtXFA5CO/bz94N5dFEYeDh8Z0klLSMsUaKv0Ff+kNEOhCMW7bDmo+9nd20sp4
         tnUgX8KulgmjnbP1swxS93Xdm5R0QtN6XAdBCJa79m2m7kAftLwtES1/tnlX4kQAA8EI
         YXqQ==
X-Gm-Message-State: AOPr4FUKVAnvyb7pxVN73U4DeyzPeonfNNmzFQk1Ss8406/vtV3PdT6qsKpXEHx6fgp0ppm27D4t4KrHE2gi7g==
X-Received: by 10.28.129.22 with SMTP id c22mr25045043wmd.89.1461762801644;
 Wed, 27 Apr 2016 06:13:21 -0700 (PDT)
Received: by 10.194.95.129 with HTTP; Wed, 27 Apr 2016 06:13:21 -0700 (PDT)
In-Reply-To: <xmqqy480dsi0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292723>

On Tue, Apr 26, 2016 at 10:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>  builtin/apply.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Makes sense but do so immediately next to 06/83, "options" thing?

Ok, in the next reroll this patch will be immediately next to 06/83.
