From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 7/7] unpack-trees: free cache_entry array members for merges
Date: Mon, 3 Jun 2013 15:53:45 -0500
Message-ID: <CAMP44s2b7gNkiVddN8XVm_u4e4WkxWmvS0mB8XLRv-1tn2Qc9g@mail.gmail.com>
References: <1370188017-24672-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
	<1370188017-24672-8-git-send-email-rene.scharfe@lsrfire.ath.cx>
	<CAMP44s2ym5UEPo8kr6YKf1x_P_0L+o_9vWdCTA6MPDQsRy7d1A@mail.gmail.com>
	<51AB86BB.3080203@lsrfire.ath.cx>
	<CAMP44s0Af90Sfi47_mxEGRFHAsAhaoO6T1jjbj7SptucNO-k0w@mail.gmail.com>
	<51ABAA84.8090301@lsrfire.ath.cx>
	<CAMP44s3cqa-jETHX+ftbAVMx+oV6PMcVkdH63P93ER-4fH28Hw@mail.gmail.com>
	<51ABD00C.7080503@lsrfire.ath.cx>
	<CAMP44s2+Hx-6E7DkmWL_m92jDt5-Cj8FGHpACBZcqp1sn5Tfzw@mail.gmail.com>
	<51ABD99A.2030303@lsrfire.ath.cx>
	<CAMP44s2HotyK7hh0nFjCe+BBtu1pyqmkn6=yt9WV6UyhxjrXoQ@mail.gmail.com>
	<51ACBD68.4070506@lsrfire.ath.cx>
	<CAMP44s09s26Gyvqu___cQg2LsUnMrzZAa0pbUnGp85fDUEeapg@mail.gmail.com>
	<7va9n7gkjq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 22:54:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjblW-0006BW-1M
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 22:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758207Ab3FCUyB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 16:54:01 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:57923 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757435Ab3FCUxr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 16:53:47 -0400
Received: by mail-la0-f44.google.com with SMTP id er20so1841721lab.17
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 13:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KNey2CM4XEGOJpB29q7INzLjeTO7RtCBn/XJLIwmcv8=;
        b=IVa5r/iMmgs2JoJhtK8NVZtMTCKrNalgXJu57SNnXAwOArpk4UjEEjwPTyet1rSOmY
         emE90mme078MUPSkk4/dH6piAxJfyoKRO3zbcocIPw5CJ40oW6prInDeokYHsKdkVtUQ
         HCn1Dq267b4yHiKmG3d4a6IO/6mfMBzAsRTDUvAHCUfh4ps42CXMRqn9WyliiCbKw7Bk
         Sxq10h/y2AKPua2dDKk8XyQy2UT7xYf6YHEikJKOd+iXgwMUEdd9dsBaC56FVXL0Kj8o
         XID6ZBpOR9qtvlcidj0YSy18xEYCis8cfZ9pQtTlc3d5R8h6LKD45Rm76UBSrX6OGZeT
         JeUA==
X-Received: by 10.152.2.233 with SMTP id 9mr11752315lax.34.1370292825974; Mon,
 03 Jun 2013 13:53:45 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Mon, 3 Jun 2013 13:53:45 -0700 (PDT)
In-Reply-To: <7va9n7gkjq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226288>

On Mon, Jun 3, 2013 at 12:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> I don't see that, and I don't like adding a check that I don't expect to be
>>> ever needed.
>>
>> It's called self-documenting code; by adding a check for the NULL
>> pointer, we are stating that ce can be NULL, if we don't do that,
>> people reading that code would need to figure that out themselves.
>
> People following the codepath to unpack_nondirectories() already
> have seen enough to know what src[] means and very well know what
> NULL in it means.  The only people possibly confused are those who
> do not know free(NULL) is safe, isn't it?

Wrong. I still do not know what src[] means, and I don't need to know,
I can see from the code that the cached entries there leak.

> Honestly speaking, I do not want such people to be touching this
> part of the system.

So we should make it more obfuscated?

-- 
Felipe Contreras
