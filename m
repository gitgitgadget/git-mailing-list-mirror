From: David Michael <fedora.dm0@gmail.com>
Subject: Re: [PATCH] compat: convert modes to use portable file type values
Date: Mon, 1 Dec 2014 14:10:36 -0500
Message-ID: <CAEvUa7nsz1UX5+qakPGW=wTR_VRJU3r+VkgVt9qiCDUz30MweA@mail.gmail.com>
References: <87vblxl8ah.fsf@gmail.com>
	<CACsJy8CKEwOVcB_MUaK8mmSmQuKHC6R6K0YymjCrTP3aYFdbPg@mail.gmail.com>
	<CAEvUa7mhjG1xPoJedp4XYrxr39_EuzvGtONLv0B=uBw+vQB5pw@mail.gmail.com>
	<xmqqsigzp81v.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 20:10:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvWMr-0005VL-Aj
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 20:10:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbaLATKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 14:10:37 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34716 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753915AbaLATKg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 14:10:36 -0500
Received: by mail-pa0-f52.google.com with SMTP id eu11so11698041pac.39
        for <git@vger.kernel.org>; Mon, 01 Dec 2014 11:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hStq6qFa+uY+BrYpaLg+OBXDpSHXaTH3UlgZa6sP57Q=;
        b=jxb3IH5A37UBF49RLvVW2BT1aLMgDmyWke61N/Z47+2BOKOMb6VGisS75GBqLq3xrC
         4pdukyzbXLcHAu1YbI7UGwyZndtE4BDo+9VXJh+8juuVyRwnJ6t0t2vnTD0AAQfHXpkG
         tvsEHPct7uvkP+ocWLCxMMLksJQm7WRhZNbek9lahedKKnvIaSTcPv3QP0DqNz9mU9Po
         kzHO1irwOlb0zd9bz8fuDjzceFV/RjiPfAhcNdOklpHBGTJ1fG7zHn/2/sHgCEjOQX9f
         P9x+8C3WuHLb07gVX1v/Ev8RvkEVpeWWZA1yxrOifLBrsCDokC2GqEFUZKOs1hn/FtfD
         BMZQ==
X-Received: by 10.68.202.1 with SMTP id ke1mr103361902pbc.139.1417461036157;
 Mon, 01 Dec 2014 11:10:36 -0800 (PST)
Received: by 10.70.55.36 with HTTP; Mon, 1 Dec 2014 11:10:36 -0800 (PST)
In-Reply-To: <xmqqsigzp81v.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260506>

On Mon, Dec 1, 2014 at 12:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
> David Michael <fedora.dm0@gmail.com> writes:
>
>> On Mon, Dec 1, 2014 at 9:44 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> On Sun, Nov 30, 2014 at 9:41 AM, David Michael <fedora.dm0@gmail.com> wrote:
>>>> +int git_stat(const char *path, struct stat *buf)
>>>> +{
>>>> +       int rc;
>>>> +       rc = stat(path, buf);
>>>> +       if (buf != NULL)
>>>
>>> It's a minor thing, but maybe test "!rc" instead of "buf != NULL"?
>>
>> Okay, it makes sense to only do the conversion for a successful return code.
>>
>> Should it test for both a zero return code and a non-null pointer?  I
>> don't know if there are any cases where passing a null pointer is
>> legal.  The standard doesn't seem to explicitly forbid it.  z/OS
>> returns -1 and sets errno to EFAULT when stat() is given NULL, but
>> this patch should be able to be used on any platform.
>
> Huh?  I am confused.  Since when is it legal to give NULL as statbuf
> to (l)stat(2)?
>
> Wouldn't something like this be sufficient and necessary?
>
>         int rc = stat(path, buf);
>         if (rc)
>                 return rc;
>
> That is, let the underlying stat(2) diagnose any and all problems
> (and leave clues in errno) and parrot its return value to the caller
> to signal the failure?

Alright, it wasn't immediately clear to me from the OpenGroup page on
stat() if that would always be safe.  I will just test the return code
in v2.

Thanks.

David
