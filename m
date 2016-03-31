From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] builtin/apply: free patch when parse_chunk() fails
Date: Thu, 31 Mar 2016 19:58:41 -0400
Message-ID: <CAP8UFD18trj9NDuyExB=v8F=sPpUWoL6JdiN9xim-Jo=vkmR9Q@mail.gmail.com>
References: <1458156911-26649-1-git-send-email-chriscool@tuxfamily.org>
	<CAP8UFD2uT8dF+LMEGVdM6QZztqr_FbX=UQ01U0ttODFUk4AxbA@mail.gmail.com>
	<xmqq37r6l0il.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 01:58:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1almUD-0000UP-3I
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 01:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757408AbcCaX6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 19:58:44 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36515 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755198AbcCaX6n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 19:58:43 -0400
Received: by mail-wm0-f42.google.com with SMTP id 127so2201972wmu.1
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 16:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=v49tmdnP04VTWY0EZHuoHGM3W5ozNHyyXz5g/Izq5j8=;
        b=VT116ivSwxVJDAa6CH0EPirq5E0/yPC+8ZmDFKc9c8GjoYT7A46eLeGeRqPlWJQqeW
         5go94PvmmH9MW2+EbZU/lK1MGMVA3EbRbSLPo3IsmXbLSN482WNDjfwyl267WiRgb64S
         O0aKiUu542/MTwJpAo+GciE3UcKtdwihcILF2mW1/BbIYgxZ71fC7v3L67F1wX/EONVk
         IAVQdmlVyITi7Jpf1CSDH9gH6OxfQsPDBYUshlnHS7M0fkshXrEj41ESvl1eJK0SmqE1
         JFcn8oD0pz4F9ZmAYPLNVEVEBZNla5arfaUPp1GvYaxkvPRSfj6IWVS4Zt1u63HASIrW
         qATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=v49tmdnP04VTWY0EZHuoHGM3W5ozNHyyXz5g/Izq5j8=;
        b=Xh4/tdU0hgdR7zbWRC2Lh6GMWT12Kr4Tjd6ulcHB0/NEtOaWyWX2ZspUG5hxk40s0v
         MyN7C8JrC6k8EG+W8e260IAtG8zvCf0L2p5XED3kNhIR9l/2oB+yh7UhteVM6c64yXPA
         HNW/OyZXrRnJ126RCZfaWBW4TCgZq6pCEb8uN6rSLBv4zN86VSbTytJnqdrHQ65MeOch
         hoKy98GogevM/8sA2qotpnpAS18MeHp6sSBLb7bAEkpQRvGnpB/H++qKlFAO8eRn/afZ
         /lS/aZLmGPbaMZhSI5I60rL7YoTKrBELphPZlAcicPfRhss2PxIAkMc0mu53NtUZbS2X
         xr/w==
X-Gm-Message-State: AD7BkJKi+1xkxCv29SfOFGCwV3GUdl4P/I0YT7Vfu43jfj6SegGqzRcvmas7KiBOF42BI8F2gL4E0bbqA3C3Pg==
X-Received: by 10.194.2.202 with SMTP id 10mr1595818wjw.94.1459468721994; Thu,
 31 Mar 2016 16:58:41 -0700 (PDT)
Received: by 10.194.151.131 with HTTP; Thu, 31 Mar 2016 16:58:41 -0700 (PDT)
In-Reply-To: <xmqq37r6l0il.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290490>

On Fri, Apr 1, 2016 at 12:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> On Wed, Mar 16, 2016 at 3:35 PM, Christian Couder
>> <christian.couder@gmail.com> wrote:
>>> When parse_chunk() fails it can return -1, for example
>>> when find_header() doesn't find a patch header.
>>>
>>> In this case it's better in apply_patch() to free the
>>> "struct patch" that we just allocated instead of
>>> leaking it.
>>
>> Maybe this patch has fallen through the cracks too.
>
> Anything worthy of discussion that you sent during the feature
> freeze, please resend them to the list for discussion.

It looks like only the two patches I replied to have not been applied to next.
I had also sent a three patch long series
(http://thread.gmane.org/gmane.comp.version-control.git/289559), but
we agreed that only two of them could be merged for now and that's
what you did already (fda3e2c and db354b7).

By the way my guess is that replying to them is ok, but you ask to
"resend them", so I am wondering if you really prefer them to be
resent rather than just replied to.

Thanks!
