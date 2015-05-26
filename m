From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/WIP PATCH 02/11] upload-pack: only accept capabilities on
 the first "want" line
Date: Tue, 26 May 2015 15:20:25 -0700
Message-ID: <CAGZ79ka6VOHpOcJ8Y_3DHApJoK=3msc6DigA6aOVxXYVHdB2Sg@mail.gmail.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
	<1432677675-5118-3-git-send-email-sbeller@google.com>
	<xmqqa8wrj85e.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 27 00:20:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxND5-0002VD-8c
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 00:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbbEZWU1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 May 2015 18:20:27 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35676 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbbEZWU0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 May 2015 18:20:26 -0400
Received: by qkdn188 with SMTP id n188so102061789qkd.2
        for <git@vger.kernel.org>; Tue, 26 May 2015 15:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=P8moBJRmQZWNqx6zETBoxIuTxSTegDUvcqj4JWyTQfg=;
        b=Lx7CWVB+3GER3eOCgRdHEZdt7GN9MTUs5lpS8zJOqlN2V3VBXxHMfksJoxqvdBGLRo
         LjfktPtc5q6QEjJ4/cVrZTZHsNyiMUZn0SiDyx3w+iSomYYoSnPsz5X9WeiOlQRgBmn1
         UPB6bZlDF4GtM0/VIeJPGecVHOFh/GKdqhjILM0f8NBnOkAYihAG53rCKgM8e9ul067j
         WwYc4OG2VuYzL8/n70AKEPV9As6sAya0MBQ3c9r85UFWFi3OV5eNFtKzHSzbqRe+tV3v
         HE1/n8dzZHC6jEpSPJcU6CYd8leYSnBGrXsPRzceGT70voFxQeLPJ4MyhGuAVTHUSIkb
         btjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=P8moBJRmQZWNqx6zETBoxIuTxSTegDUvcqj4JWyTQfg=;
        b=LoOloccaV0IFWrWo/rTIFMC3nbeohUseIISAFMKA16EbJEznCkJc5i0h2skP3KjIXq
         lqtL8nof/NhgUSkXLNkX6cHFIj1d2fWltkhzTxJYxVpawrlKuPhMp3WyccygyXl8uSnN
         eGueTgmXmgfy9f+UbtKIKPr/5i4a8GZ2tav2lTJgN1CpZO/jghojF1IqHxrA2NtPFlth
         K/Ecvk6osd2jOIftRRedIEu7nGNZSLSObXmmshyTLpVB5PORanSen5Y1EfKn3K+biMHQ
         rhO5CH7HhdaI7M1f98hGydmgQXQUUW2CDF+5rHhPT9bP0Gh12aUSuu46C+Hd1KqXGKtY
         sbeg==
X-Gm-Message-State: ALoCoQlRfxjobXSYYa2vf26ZeeYJfZV9UYZKbS0byTdtos6Crot+FOgQUBVaxH0AUIC9sO9URGug
X-Received: by 10.55.22.143 with SMTP id 15mr4085387qkw.85.1432678825806; Tue,
 26 May 2015 15:20:25 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Tue, 26 May 2015 15:20:25 -0700 (PDT)
In-Reply-To: <xmqqa8wrj85e.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270001>

On Tue, May 26, 2015 at 3:17 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Stefan Beller <sbeller@google.com> writes:
>
>> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>>
>> pack-protocol.txt says so and fetch-pack also follows it even though
>> upload-pack is a bit lax. Fix it.
>
> Hmm, I actually think the .txt file unsuccessfully tried to close
> the barn door after horse has long left.  The existing clients that
> read protocol capabilities keep the last-read copy and then
> overwrite it when a new one came, which is why we couldn't update
> the protocol by sending only incremental changes, etc. without
> breaking existing clients.

On the other hand I am not aware of any remote implementation
handing out capabilities after the first line, so this would not break
anything to my knowledge.

>
> I somehow thought that we already discussed why this was bad the
> first time Duy's patch was posted, but apparently we didn't.

/me checks the archive. I may have overlooked that part. :(

>
> X-<.
