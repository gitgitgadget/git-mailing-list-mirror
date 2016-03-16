From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/RFC/GSoC 07/17] rebase-common: implement refresh_and_write_cache()
Date: Wed, 16 Mar 2016 20:56:09 +0800
Message-ID: <CACRoPnS1VikcT3qutXTT5SMLLHeo87M_wzqVKvYG02X7HUCZcw@mail.gmail.com>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
	<1457779597-6918-8-git-send-email-pyokagan@gmail.com>
	<xmqqshzs9369.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Sam Halliday <sam.halliday@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 13:56:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agAzs-0000Pp-NO
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 13:56:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754978AbcCPM4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 08:56:12 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:32823 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648AbcCPM4L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 08:56:11 -0400
Received: by mail-lf0-f46.google.com with SMTP id h198so18455533lfh.0
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 05:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=ItjWanF9tiJMphGzxGbHZK1F69RDINWr1D3k8KT0N5M=;
        b=Tc0qUTrdrOCOhXS0GJSTL0/LukAm52f14RqD6GtoKlgEUN4h6dA+8PwQlJwjJTgRm7
         4QV+VyQwt1BV0QnCS9peON5c73Gu2VchKsIkXIkS1+4h4x3G11i99FkQjMv5BReNdZRW
         yGI/aQvgIYHxhN+XtL8WkJHbavS/fXuUDRpo61bZVwzwhisZZc5J+vRlmodZadi3FiDV
         wdlIxLN89nZ0C4/m5KIWt5CPxDh7q3Xs83S/Uhv4VWON/zGOvcwj6F9p4OjUdMAiguVC
         WvkNr1CbNljynjb15BIyezEE/OXYwTAWNvx5gwlZ9+0WC4+8bDj5BuMr+c9RnlM/78Ea
         4wbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ItjWanF9tiJMphGzxGbHZK1F69RDINWr1D3k8KT0N5M=;
        b=TZUODZpFAoearExxGgwJi0NF4htbVfiE0opgee6TtyABMioz5T1Q6OJN60+SoQprXm
         fcDt7x4QCCixerH54nbLh4r+GpbNq9gp4kewWlTtPQWGopNB5MhqMbTHpnki40+eg5KW
         qFu0mhCcynUNIUWqSu3JJ0qLZQwh5Y+2lisDsxjU90es4IdoWFjVigxdnP3s4YgDfHDn
         pJuvMUHnkEX5FmNdL+LtyQjk+r1EB3ZtQo1fLXKSEGlKFnpIFBF83LwgV4Hnyvo4CvWi
         abkEW/lra/2L9wBYeq9VOpqd8/uDTXjlgd0JhaFBHOHN1ZcLEDLc4UDvYjuCbzg+9Ve1
         TUmA==
X-Gm-Message-State: AD7BkJJ0AeBNyTNQ5grLFi4Jl2DUcu0xD3x3jPINU7nWaSHSj99N91DRoDQ4AHqqxHn1I26jUvdQA1KwyUrxGQ==
X-Received: by 10.25.81.144 with SMTP id f138mr1377615lfb.146.1458132969442;
 Wed, 16 Mar 2016 05:56:09 -0700 (PDT)
Received: by 10.112.207.74 with HTTP; Wed, 16 Mar 2016 05:56:09 -0700 (PDT)
In-Reply-To: <xmqqshzs9369.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288968>

On Tue, Mar 15, 2016 at 5:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>
>> In the upcoming git-rebase to C rewrite, it is a common operation to
>> refresh the index and write the resulting index.
>>
>> builtin/am.c already implements refresh_and_write_cache(), which is what
>> we want. Move it to rebase-common.c, so that it can be shared with all
>> the rebase backends, including git-am.
>
> Your rebase-am might be one of the rebase backends, but git-am is
> not, so it is misleading to count it among "all the rebase
> backends".
>
> I would think that a better home for refresh_and_write_index() is
> right next to write_locked_index(), with #define in cache.h for
> refresh_and_write_cache(), just like others.

Okay, thanks for suggesting a better location.

Regards,
Paul
