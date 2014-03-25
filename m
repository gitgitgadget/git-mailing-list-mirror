From: Scott Sandler <scott.m.sandler@gmail.com>
Subject: Re: Git push race condition?
Date: Tue, 25 Mar 2014 10:16:44 -0400
Message-ID: <CAAyEjTOy-DyeU96_DWWydgcpb+x5DMRkf1NHBfn+eNZ-yDrZUw@mail.gmail.com>
References: <CAAyEjTN53+5B9Od9wW698wODNL3hR6Upot8-ZLwEksn3ir_zjA@mail.gmail.com>
	<20140324225434.GB17080@sigill.intra.peff.net>
	<557DE2F7-1024-42A5-8192-ACE910CE6C81@codeaurora.org>
	<CAAyEjTPtaKExJJSc3yrxVNzx0DmOyeUFH-Uxz3dn0iezqc5VKA@mail.gmail.com>
	<vpqvbv2pe8e.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nasser Grainawi <nasser@codeaurora.org>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Mar 25 15:16:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSS9r-0001yo-9h
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 15:16:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbaCYOQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 10:16:47 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:58534 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbaCYOQq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 10:16:46 -0400
Received: by mail-lb0-f180.google.com with SMTP id 10so409944lbg.25
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 07:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mdQpF94YggwbLBFQSvUEo54jgRK6sxM9xy0YLvmfez0=;
        b=cerIsfm8qHIxL/7vIx/oTF7NytmHAZur0GUM089lAr5tU+/759rNMSsb6jIIavyMAp
         sa3upZvONuOoCV8giR7a332iQOxZBFSKCBrRSY2ByjfwMaHwst3GmRBx+jlLaHB+D3Nm
         YBSwONYx/uU+xhUcZELy9m68AP/l0ZA56WvRauxgPxMjxyJ+SIj1k2ib/u8FBLrnYIAH
         otP7abJ2Sb2KQAkRC1X2Ss0eUJV/dxKlUVF1TFF8mnlXEaUP6eHEHdD1C3S9jAQ52i4A
         u0E9WiWg0GBDESjAtmE+UPmAMa2UzvMhF+hSnJsv9OrFILNJ/XV+lR0YitT8Z5eUvdUZ
         IEnw==
X-Received: by 10.152.172.103 with SMTP id bb7mr1152050lac.49.1395757004826;
 Tue, 25 Mar 2014 07:16:44 -0700 (PDT)
Received: by 10.114.64.103 with HTTP; Tue, 25 Mar 2014 07:16:44 -0700 (PDT)
In-Reply-To: <vpqvbv2pe8e.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245039>

I'm definitely open to the possibility there's a problem with my
setup. I've got the reflog on now and will check what that looks like
next time the issue happens. So far it looks like you described:

b2b202d master@{0}: push
7c01312 master@{1}: push
3635312 master@{2}: push
aea29bf master@{3}: push
8bfe464 master@{4}: push
fb35676 master@{5}: push
267114e master@{6}: push
2b5c822 master@{7}: push
9d7206f master@{8}: push
8fbeaf9 master@{9}: push

I'd like to see it happen again under these conditions and get that
information, then enable receive.denyNonFastForwards explicitly just
to be sure it's not force pushes, and see if it still happens. If
anyone has other ideas of things to look into or test, let me know.

Thanks,
Scott

On Tue, Mar 25, 2014 at 10:03 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Scott Sandler <scott.m.sandler@gmail.com> writes:
>
>> Is there a hook or cron job that updates or gcs this repository or any
>> refs? No. No cron jobs touching the repo at all, and all the hooks are
>> read-only.
>
> If you activated the reflog, you can double-check that. Running git
> reflog on the server should give you something like this:
>
> $ git reflog show master
> bf40764 (HEAD, master) master@{0}: push
> 2c4fc6d master@{1}: push
> e72211a master@{2}: push
> ...
>
> It should be possible to check the reflog for non-fast forward. I don't
> find an obvious way, but a script going through the sha1 list and
> checking that each line is an ancestor of the previous should be easy.
>
> I can't exclude the hypothesis of a bug in Git, but my feeling is that
> there's an issue with your setup.
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
