From: Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH 5/5] Use kwset in grep
Date: Sun, 14 Feb 2010 17:51:19 +0100
Message-ID: <4c8ef71002140851hff65a2bj7cc31c634ce5bab3@mail.gmail.com>
References: <20100213141558.22851.13660.stgit@fredrik-laptop>
	 <20100213142110.GF9543@fredrik-laptop> <4B76E384.2070602@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Sun Feb 14 17:51:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nghgt-00068j-PM
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 17:51:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904Ab0BNQvX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Feb 2010 11:51:23 -0500
Received: from mail-fx0-f227.google.com ([209.85.220.227]:56298 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678Ab0BNQvW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Feb 2010 11:51:22 -0500
Received: by fxm27 with SMTP id 27so391627fxm.25
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 08:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GCBirZUCobLA9XU49paD+zPhlLsYtiDeknaBB75qWik=;
        b=tFyO5bzBksMqN5VcQyslaeh/bQRIBlOoCeRNEE2kob+UKCUCz0a0bGItHFgFbOkkt9
         f+dcVP7ZsYOlQffyjIkjXP8P5sVxwFnZ/sPd//JXk2yGkvOkalLEq7yvFjx7bw6yi3rh
         LVjUmAgYHIgt1hNeGSNG05I78kty4M/Rq4h1w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UKYMtpkDNs/OwcmlR8Zoeo2B+5/Q0mylTxWurWJ9wpiApTxDXY7KtvPQ/075RC8opj
         cJlkFHi760gOli8+wPqu+vCsA5Yn065zdfMxB9/GWkqVIZ7vgbiRDdAg+YJvR61cgSWc
         aXYfDMVtEtnbooNgSkYzT8wSv/1rWP4GofMRk=
Received: by 10.239.189.140 with SMTP id t12mr441373hbh.146.1266166279753; 
	Sun, 14 Feb 2010 08:51:19 -0800 (PST)
In-Reply-To: <4B76E384.2070602@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139926>

On Sat, Feb 13, 2010 at 18:38, Paolo Bonzini <bonzini@gnu.org> wrote:
> On 02/13/2010 03:21 PM, Fredrik Kuivinen wrote:
>>
>> Best of five runs in the linux repository:
>>
>> before:
>>
>> $ time git grep qwerty
>> drivers/char/keyboard.c: =A0 =A0 =A0 =A0"qwertyuiop[]\r\000as"
>> =A0 =A0 =A0/* 0x10 - 0x1f */
>>
>> real =A0 =A00m1.065s
>> user =A0 =A00m1.400s
>> sys =A0 =A0 0m0.536s
>>
>>
>> after:
>>
>> $ time git grep qwerty
>> drivers/char/keyboard.c: =A0 =A0 =A0 =A0"qwertyuiop[]\r\000as"
>> =A0 =A0 =A0/* 0x10 - 0x1f */
>>
>> real =A0 =A00m0.621s
>> user =A0 =A00m0.560s
>> sys =A0 =A0 0m0.564s
>>
>> So we gain about 40% by using the kwset code.
>
> Hmm, on a more accurate review for
>
> =A0 =A0git grep -e foo -e bar
>
> you're creating two kwsets, so a Boyer-Moore search be much simpler--=
-the
> performance would be the same since that's what kwset degrades to for=
 a
> single string, but you'd probably save around 600 lines of code...

Another approach is to just create a single kwset for this case as
well. I will try that in the next iteration.

- Fredrik
