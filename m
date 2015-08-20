From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] generate-cmdlist: re-implement as shell script
Date: Thu, 20 Aug 2015 14:18:50 -0400
Message-ID: <CAPig+cRgMTZ1DUgcFHn+S0nZaRf-5NAWdhPnALwR4TqJPqcO6w@mail.gmail.com>
References: <1440015528-7791-1-git-send-email-sunshine@sunshineco.com>
	<xmqqmvxl7u0l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Renato Botelho <garga@freebsd.org>,
	=?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 20 20:19:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSUQS-0003wR-11
	for gcvg-git-2@plane.gmane.org; Thu, 20 Aug 2015 20:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbbHTSSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2015 14:18:52 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:36272 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863AbbHTSSv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2015 14:18:51 -0400
Received: by ykfw73 with SMTP id w73so46489516ykf.3
        for <git@vger.kernel.org>; Thu, 20 Aug 2015 11:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=saWmkiPHkDaTIlqFcSu8iwPcIUoRpLsISQWommeT7Zc=;
        b=BAQlEaZ665G+SM6xregUZQlOZnYtrP2V0D2lTkczed4Da4/QB5LrTOIshUp7AcD1nP
         eK0vXlJXWkiPtdZ/cPPXIJ67lzoJeuwpd43HzcI+vvShd56H64qNp7ECwRcaeDWeQm8x
         Eh6fFbd68QhZihrR0e5xYz1hQX99IBQPpzNsVa/D4AVxKtzn2NH0lX25RqLcFmxWmxyN
         fBTG4xfHMnA42Ymz8D7+sC+plgdn+aR0iobJLvwicduE4tyqAiw3qzVENBT8+IAmhjxm
         SCfxlB7+HabZeXhQFfr984cftKpvi7aqClJekDV6BNocT3lNbFQWYnduDtskn0UcTjOG
         5Yag==
X-Received: by 10.129.76.151 with SMTP id z145mr5601429ywa.17.1440094730646;
 Thu, 20 Aug 2015 11:18:50 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Thu, 20 Aug 2015 11:18:50 -0700 (PDT)
In-Reply-To: <xmqqmvxl7u0l.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: uY5A7xOLCgNDkSm9JSyAeAVictM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276257>

On Thu, Aug 20, 2015 at 1:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> +sed -n '
>> +     1,/^### common groups/b
>> +     /^### command list/q
>> +     /^#/d; /^[      ]*$/b
>> +     h;s/^[^         ][^     ]*[     ][      ]*\(.*\)/       N_("\1"),/p
>> +     g;s/^\([^       ][^     ]*\)[   ].*/\1/w '$tmp'
>> +     '
>> +printf '};\n\n'
>
> Unfortunately, this does not seem to work for me.  Even though sed
> stops reading after seeing the "### command list" line, I suspect
> that its stdin buffer has been filled with other lines that follow
> it from the input to the buffer size, consuming what you meant to
> feed the later 'grep $matchgrp"' with.
>
> This is a one-time thing, so I do not mind to update the Makefile
> so that it does not feed command-list.txt from the standard input
> but gives the path as "$1" to this script.

The original generate-cmdlist.sh doesn't take any arguments and just
hardcodes "command-list.txt". Feeding it instead on stdin seemed a
nice way to avoid reading the file twice, but alas is too fragile. I
don't mind passing it as an argument either, or just hardcoding it
again (though my preference leans toward passing it as an argument).
