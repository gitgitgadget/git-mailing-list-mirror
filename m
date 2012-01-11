From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Regulator updates for 3.3
Date: Tue, 10 Jan 2012 19:14:55 -0800
Message-ID: <CA+55aFzuGtJkQFDooSGWQ2_NiJVHN2E7S5dmOnWTYn8_s8Gg3g@mail.gmail.com>
References: <20120109073727.GF22134@opensource.wolfsonmicro.com>
 <CA+55aFyhoh0rT_ujuE1w3RpuR7kqivYFwPpm66VC-xtq1PiGUQ@mail.gmail.com>
 <20120110184530.GE7164@opensource.wolfsonmicro.com> <CA+55aFxXb7wqfrpozS6iH0k25y-+Uy8_Tavv59JXMhaWrjXLaw@mail.gmail.com>
 <20120110222711.GK7164@opensource.wolfsonmicro.com> <CA+55aFxvQF=Bm4ae6euB_UO8otMCuN9Lv37Zn3TpE-L7JH3Kzw@mail.gmail.com>
 <7vmx9v7z1r.fsf@alter.siamese.dyndns.org> <CA+55aFx5NATrpLnkMiV2vAxSAJPK7wkY2vyHbyeZGgT9+jP06w@mail.gmail.com>
 <7vehv77xeq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 04:15:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkofO-0005ZX-Rm
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 04:15:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231Ab2AKDPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 22:15:19 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39480 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537Ab2AKDPS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 22:15:18 -0500
Received: by yhjj63 with SMTP id j63so128583yhj.19
        for <multiple recipients>; Tue, 10 Jan 2012 19:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=khHgL7imuUGDqAwBBrya/Nj69soFwnEdt3xtjyQFjj4=;
        b=WCktKkhv7k3bdwDMspDlLq9m+Vj1GXuOQekT2tlBujW4FU5pvUFAWhAVdzHYZU33Fd
         iDJUVkvmC+5SZ1BZAvFmpfLHtarA3e/p3yuyT5LFVIj4YM0OZvkxPO6aU2q8NoWAVBTM
         GkXvd2o675z6COX1niB7QcEzLRQbDxnatgkSo=
Received: by 10.236.9.40 with SMTP id 28mr29839510yhs.29.1326251717321; Tue,
 10 Jan 2012 19:15:17 -0800 (PST)
Received: by 10.236.175.170 with HTTP; Tue, 10 Jan 2012 19:14:55 -0800 (PST)
In-Reply-To: <7vehv77xeq.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 3AFCAxNwWu_5bC4iTNF-jnRfmV4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188318>

On Tue, Jan 10, 2012 at 7:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> I really wonder. Because not being default will always lead to really
>> odd ways of saying "it should have been default, so we'll make up
>> these complex and arbitrary special rules" (like the ones you were
>> starting to outline).
>
> Hrm. Lack of any quoted line other than the first line from my message,
> together with (c) above, makes me suspect that you did not read beyond the
> first line before composing this message you are responding to.

No. See again. I did read your suggestion, and that's where the "we'll
make up these complex and arbitrary special rules" comment comes from.
Did I mis-understand it?

I think it's a *horrible* idea to go down the road or some
branch-specific configurations and then, and I quote:

  "depending on the combination of what is being merged into what,
toggle the --edit option by default"

THAT is the kind of design that sounds crazy.

Instead, just make editing the default. No ifs, buts, or maybe. No
configuration, no complexities - just make it act the same way our
pager logic acts (ie redirecting stdin/stdout obviously shuts down the
pager, and equally obviously needs to shut down the editor).

Then, the --edit/--no-edit flags are for future users that want to
make it explicit. But they aren't about rules, they are about just
making very explicit statements of "I don't want the editor".

The (b) thing I suggested was for "work around for people who have
legacy cases that they don't want to make explicit". I guess you could
count that as some rule, but I really think it's more of a "ok, we had
bad legacy behavior, and now we have scripts that depended on that bad
legacy".

But the notion of complex rules? That sounds really really bad. I'd
much rather get *rid* of the one complex rule we have (the "merging a
tag implies --edit"). That rule is already a hack.

                   Linus
