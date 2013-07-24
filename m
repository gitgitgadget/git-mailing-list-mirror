From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 00/16] First class shallow clone
Date: Wed, 24 Jul 2013 17:35:00 +0700
Message-ID: <CACsJy8BouRHZAmCKQ779iAUiEX-rK9_FSrxu9V-bn6MCBTBEzg@mail.gmail.com>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com>
 <1374314290-5976-1-git-send-email-pclouds@gmail.com> <79A9AB6FF00042D1B3E0D26B9855CCAB@PhilipOakley>
 <CACsJy8AJjXMATEPrAgSYOgpZcR_khC=9S28H8LuCvuTuJk0x8w@mail.gmail.com>
 <8BDFF5EEBDC8422681F1AB2C0A153CC6@PhilipOakley> <CACsJy8AzFogspTih4mJoog6MGEWgmuae2KmFysQ0-siCvfH2yA@mail.gmail.com>
 <CAA01CsrHaCGrt37r4bn1OBY-=skJXZBHOaPH=Gsz-8BCmiW6jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philip Oakley <philipoakley@iee.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 24 12:35:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1wPw-000656-UZ
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 12:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051Ab3GXKfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jul 2013 06:35:32 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:41882 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980Ab3GXKfb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jul 2013 06:35:31 -0400
Received: by mail-ob0-f181.google.com with SMTP id 16so12479007obc.40
        for <git@vger.kernel.org>; Wed, 24 Jul 2013 03:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FbU+oa8X0Z3GuTnQlhl4cH5EKmzbFRzaSgb0KwyIW68=;
        b=Uiz7Jo9NkA53xC9ooR6p0ShZ89WpygkAZsTNTB21nBJNbjDtTIcnsHLwK8ZqlkPfIc
         RkVxgfk4IOljFfegp1Xa71zcUf2HZ5lhnDOQp6saqHTld8NI2dNABp8zxIeE83r5QIK9
         iODI3QJZ24MHjVIQj8hgcCFvtzZXmCZW4ID/Rg0/6h1toR9RunfPAknDxabjTr4q4ftr
         oGI14hmb/qrm7NFT7iGhTBQCW74bMKe4pu5zHQStnu/5YBggy2sCaGMMStnYHs72F8l1
         PbjJNFeQ7N1vKuJRyk8VflmqJte3Zbb33/1Zf119gSfwVYDIu1itAcluoo/Zq3oCNBq2
         z1Mw==
X-Received: by 10.182.165.133 with SMTP id yy5mr30001317obb.89.1374662131314;
 Wed, 24 Jul 2013 03:35:31 -0700 (PDT)
Received: by 10.182.240.168 with HTTP; Wed, 24 Jul 2013 03:35:00 -0700 (PDT)
In-Reply-To: <CAA01CsrHaCGrt37r4bn1OBY-=skJXZBHOaPH=Gsz-8BCmiW6jQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231092>

On Wed, Jul 24, 2013 at 3:30 PM, Piotr Krukowiecki
<piotr.krukowiecki@gmail.com> wrote:
> (resending, as my phone mail client decided to send it in html, sorry
> about that)
>
> On Wed, Jul 24, 2013 at 3:57 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Wed, Jul 24, 2013 at 5:33 AM, Philip Oakley <philipoakley@iee.org> wrote:
>>> There have been comments on the git-user list about the
>>> problem of accidental adding of large files which then make the repo's foot
>>> print pretty large as one use case [Git is consuming very much RAM]. The
>>> bigFileThreshold being one way of spotting such files as separate objects,
>>> and 'trimming' them.
>>
>> I think rewriting history to remove those accidents is better than
>> working around it (the same for accidentally committing password). We
>> might be able to spot problems early, maybe warn user at commit time
>> that they have added an exceptionally large blob, maybe before push
>> time..
>
> I can imagine a situation where large files were part of the project
> at some point in history (they were required to build/use it) and
> later were removed because build/project has changed.
>
> It would be useful to have the history for log/blame/etc even if you
> could not build/use old versions. A warning when checking
> out/branching such incomplete tree would be needed.

That's what shallow clone is for. You fetch the latest (not including
old large blobs) and work on top. For archaeology, make a full clone.
Or do you mean log/blame/etc other paths that don't touch big blobs,
and the clone is still incomplete?
--
Duy
