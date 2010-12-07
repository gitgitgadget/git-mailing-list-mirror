From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] logging branch deletion to help recovering from mistakes
Date: Tue, 7 Dec 2010 23:26:47 +0700
Message-ID: <AANLkTi=Z1cM1A+z3xVYsNeOyJOXuYzFQoRemSrUDJ=04@mail.gmail.com>
References: <7vlj42siu5.fsf@alter.siamese.dyndns.org> <AANLkTikbsyFUzZeu8R6yAND6spV6OnvYL08gYZ+ZgJCh@mail.gmail.com>
 <7vmxoiqeoq.fsf@alter.siamese.dyndns.org> <AANLkTinDyix3KEdLLGJEWQ8X+a3zQZOAiTh2mLf5wuvQ@mail.gmail.com>
 <m3fwu9365i.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 17:27:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ0Nw-0007zV-2M
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 17:27:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752986Ab0LGQ1T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Dec 2010 11:27:19 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61012 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853Ab0LGQ1S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Dec 2010 11:27:18 -0500
Received: by wwa36 with SMTP id 36so85728wwa.1
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 08:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=uWPcwnUAdm7ERfge2aT9ZF+lZHx8862J8f0XuxVuSdo=;
        b=bF4jLVCaXgVdipvQpgdgbnaQBTT/gAs+9B0E2EE/zLH6IRHOUP7yoZpTNBZDEtBKOL
         snE/tNC+I0OEnZH13B2fplpYZnGGC0VHP9SBACKRXvbXwuJqo0ST56uy80eunUeN9gWE
         krODGciYV3j1rAT1N1G/5yQvxTp4AhV25ymkg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=kGhQ2kdKI/1WeOYGHb2Xgw2zeutX3divKtAqu3cq0imBjeKHqpKQclfbRRTXsXwCeH
         EsqTTrPMa+SZc/pDrgVHsQByc/BOV9buqPEE+sIlP8ZBenN4cJ419qgXpGk2I64yuSC0
         AG7E5AGuKIn4MvL5OMX2plsMAIoIUv1jx+2Dw=
Received: by 10.216.179.193 with SMTP id h43mr588932wem.49.1291739237430; Tue,
 07 Dec 2010 08:27:17 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Tue, 7 Dec 2010 08:26:47 -0800 (PST)
In-Reply-To: <m3fwu9365i.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163087>

On Tue, Dec 7, 2010 at 11:22 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>> On Tue, Dec 7, 2010 at 1:28 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>>> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>>>
>>>> On Tue, Dec 7, 2010 at 4:16 AM, Junio C Hamano <gitster@pobox.com>=
 wrote:
>>>>> +#define BRANCH_DELETION_LOG "DELETED-REFS"
>>>>> +
>>>>
>>>> Should this special log be mentioned in git-update-ref.txt or
>>>> gitrepository-layout.txt?
>>>
>>> Perhaps, but I wasn't sure if this patch itself is a good idea to b=
egin
>>> with. =C2=A0Not the problem it tries to solve, but its approach.
>>>
>>> For example, this cannot be shown with "reflog show" or "log -g" du=
e to
>>> the way these frontends locate the reflog file to read (the logic w=
ants to
>>> have an underlying ref).
>>>
>>
>> I think you have thought of this. What's wrong with keeping reflog
>> when a branch is removed and appending "delete" line to the said
>> reflog? I don't know how reflogs are managed, but those reflogs
>> without associated branch will (or should) be cleaned when they are
>> expired.
>>
>> I stick with this idea because I also want to archive old branches a=
nd
>> am thinking those reflogs ending with "archive" line will be kept
>> forever, or until I feel like digging up them again.
>
> The problem with this idea is deleting branch 'foo' and creating 'foo=
/bar',
> or deleting branch 'foo/bar' and creating branch 'foo'. =C2=A0Old ref=
log with
> "delete" line would block creating reflog for new branch.

Thanks. That makes sense.
--=20
Duy
