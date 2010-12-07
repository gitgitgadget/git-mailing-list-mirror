From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] logging branch deletion to help recovering from mistakes
Date: Tue, 7 Dec 2010 23:25:31 +0700
Message-ID: <AANLkTi=7P4AQOyhCMZTKrrK5hYUORqRUW0ec_gdSO-LM@mail.gmail.com>
References: <7vlj42siu5.fsf@alter.siamese.dyndns.org> <AANLkTikbsyFUzZeu8R6yAND6spV6OnvYL08gYZ+ZgJCh@mail.gmail.com>
 <7vmxoiqeoq.fsf@alter.siamese.dyndns.org> <AANLkTinDyix3KEdLLGJEWQ8X+a3zQZOAiTh2mLf5wuvQ@mail.gmail.com>
 <4CFE51FA.3060104@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Dec 07 17:26:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ0Mj-0007Ly-Ed
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 17:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754081Ab0LGQ0E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Dec 2010 11:26:04 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41341 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753645Ab0LGQ0D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Dec 2010 11:26:03 -0500
Received: by wwa36 with SMTP id 36so84429wwa.1
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 08:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=sanKoM1fcCe1zj1XA4vXBp6hPLeJQQRSH/i3MpT36NM=;
        b=FotW5wimTLY7zfIcrl1eXtzjnVoFnHa5cZy9K3uxGm3VoFWre3G7IGmcfbGf2P2rry
         aunyAkPyivZz4et2Unv8IZQtzIVPmy3yl+aSQZR4/LYqtTw3DJ04/S74mBmzyhvjI5IL
         7O2Vu2fVvgdpyV4wandqD3SfKoAByr3BB1hEc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=btL3auKNjKBpv3XwD+SuCc/CjZ0/eBzUd4ePObZ2dGkN0f/ZYi8jozxuLgvbEo4Y0f
         EXlVeBg8zp3B+5q3Waac0RudBB+I5g2zdgaxHu0NpNma6IBhu9XcpofrIXebyIfK9FAz
         6wwKiMQiG6p8h41fQe3CNsP+MswJzFW/mOme8=
Received: by 10.216.179.193 with SMTP id h43mr587321wem.49.1291739161564; Tue,
 07 Dec 2010 08:26:01 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Tue, 7 Dec 2010 08:25:31 -0800 (PST)
In-Reply-To: <4CFE51FA.3060104@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163086>

On Tue, Dec 7, 2010 at 10:25 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Nguyen Thai Ngoc Duy venit, vidit, dixit 07.12.2010 12:37:
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
>
> The problem is the following:
>
> Say, you delete a branch and its reflog is kept (with a "delete" line
> appended).
>
> Then you create a new branch under the same name. What is supposed to
> happen to the reflog? If you simply append, then old (unrelated) entr=
ies
> will not expire through the imagined "expire branch reflogs" mechanis=
m.
>
> Now, you rename that branch. We should really split the reflog in two
> now, keeping the old name for the old parts and moving only the newer
> parts to the reflog with the new name.

I don't see any problems with that. If I happen to create a branch
with the same name, most of the time, there is something related,
unless for very generic names like "tmp". We can always notify users
about the accident resurrection of an old branch at branch creation,
so they can remove the old reflog if they want.
--=20
Duy
