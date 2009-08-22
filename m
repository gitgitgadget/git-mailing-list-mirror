From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH v4 04/19] Teach Git to respect skip-worktree bit 
	(reading part)
Date: Sat, 22 Aug 2009 18:56:32 +0700
Message-ID: <fcaeb9bf0908220456q7adc5c38h9567ad1f8ca16deb@mail.gmail.com>
References: <1250776033-12395-1-git-send-email-pclouds@gmail.com> 
	<1250776033-12395-2-git-send-email-pclouds@gmail.com> <1250776033-12395-3-git-send-email-pclouds@gmail.com> 
	<1250776033-12395-4-git-send-email-pclouds@gmail.com> <1250776033-12395-5-git-send-email-pclouds@gmail.com> 
	<fcaeb9bf0908210219h1c2a4702i81661ced00f39232@mail.gmail.com> 
	<7vd46pf4yw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 22 13:57:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MepDR-0006LM-7r
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 13:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755796AbZHVL4w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Aug 2009 07:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755779AbZHVL4v
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 07:56:51 -0400
Received: from mail-yw0-f173.google.com ([209.85.211.173]:44681 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755777AbZHVL4u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Aug 2009 07:56:50 -0400
Received: by ywh3 with SMTP id 3so1789740ywh.22
        for <git@vger.kernel.org>; Sat, 22 Aug 2009 04:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=xU/Z+SfTDAVV2WA9CCvlrTKjWwdSVh34iCDEwQSf5oY=;
        b=hzoRcThzzuNS//N4ouva1yNYdQ7ifLVf26UnjOOwOMXY7/228X22/vfPaACcw20fXw
         CJX1MdDAOa+FWX5gc/pLHe+xhfp7salP5qDnZJJrlgS9RrVYeXYho+lbmpG9Yi4HsXOu
         15EDrd8cHBjcQzDGDr/JuQajfJOQ3a6b1uSUo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=sDy37kiVaXWHMqWnWsM7sHngjRX8fz1/1pPDAQpOcZvukRnrx+8RkpuGd+WKWOka9F
         cbjT/RLurIoGsCCxdqzEIm2U9rsO7J48+cc/8FwKxzyLYH++q28OxJf8Axms+zLBLKsS
         hH8z/0g5WXj1xJGR+L/YuQfcFap7dKZUZ7tCY=
Received: by 10.100.74.13 with SMTP id w13mr2336975ana.168.1250942212163; Sat, 
	22 Aug 2009 04:56:52 -0700 (PDT)
In-Reply-To: <7vd46pf4yw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126809>

On Sat, Aug 22, 2009 at 12:32 AM, Junio C Hamano<gitster@pobox.com> wro=
te:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> 2009/8/20 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>:
>>> grep: turn on --cached for files that is marked skip-worktree
>>> ls-files: do not check for deleted file that is marked skip-worktre=
e
>>> update-index: ignore update request if it's skip-worktree, while st=
ill allows removing
>>> diff*: skip worktree version
>>
>> I kept reminding myself and still managed to miss it. skip-worktree
>> bit is not completely independent from assume-unchanged. It shares
>> CE_MATCH_IGNORE_VALID flag in ie_match_stat(). Should have mentioned
>> that in commit log.

I should have just renamed it to CE_MATCH_PARANOID. That would fit
both assume-unchanged and skip-worktree bits.

> Yeah, that is why I feel uneasy reading your response to my other mes=
sage:
>
> =C2=A0This series does not fix assume-unchanged bit. I'd like to focu=
s on
> =C2=A0skip-worktree bit now. ... I don't know if I understand assume-=
unchanged
> =C2=A0semantics correctly anymore :-)

The thing is there are grey areas where assume-unchanged is used. If
worktree version is there and really uptodate, nothing to worry about.
We seemed to care of local changes in assume-unchanged files, but
that's not written in stone. So I started off with a new bit, clearer
semantics. Perhaps new changes could be applied back to
assume-unchanged bit, but I'd stay away from that for now.
--=20
Duy
