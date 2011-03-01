From: Chad Joan <chadjoan@gmail.com>
Subject: Re: Git changes permissions on directories when deleting files.
Date: Tue, 1 Mar 2011 15:30:39 -0500
Message-ID: <AANLkTint3PARNNN4cpic8XG6HsM3AAGuX5a+oeXfFNx=@mail.gmail.com>
References: <AANLkTikJcOgBAZS=cCWULFYz4U_Mxx1gFMg51+r9qDo0@mail.gmail.com>
 <AANLkTinCjaGMe3TnheqORe7Y_qWYTAr3p6UEsK3u4VyE@mail.gmail.com>
 <AANLkTikFMg_yLWmanqyHveDMR==bw8kxjZgr4mSOmY-2@mail.gmail.com>
 <AANLkTimw+TLYv3ANf_Gx6G3SaLwRnRf6PF1YUv86rC5J@mail.gmail.com>
 <AANLkTimx7s94wjPasgdY7O9eoyzXXmhWm6f+CB0_2sv3@mail.gmail.com>
 <AANLkTimBrUo_O6sjhSEf2sPKrYhjMcr24hwRe0kH4CgO@mail.gmail.com>
 <20110301194428.GD10082@sigill.intra.peff.net> <AANLkTimCzBwsz4TV=jEGeSEScVtgwmGEiDWOomaeTgWD@mail.gmail.com>
 <20110301200805.GA18587@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Computer Druid <computerdruid@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 01 21:31:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuWDs-0004Yo-8f
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 21:31:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757458Ab1CAUbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 15:31:01 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:46514 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757148Ab1CAUbA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 15:31:00 -0500
Received: by vxi39 with SMTP id 39so4557905vxi.19
        for <git@vger.kernel.org>; Tue, 01 Mar 2011 12:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=mjhvuGumljj4ebQ3rjnpVYBlV/cVBZdXjiQP/KDDBt0=;
        b=M8pgzDkcWjiZd9TrWPtJ+53rPDxKyW6/a8u/hiPb7DiRi6RIvRJdRUsI3eiI7SrLrC
         4dXfFdnqeKneMmPitZ2Pbr15qQhJ0280X7iFiCUZxMCN7jXCihh7yxE76j0dCM4tMbFn
         5Ss/r0Om0BO5KAhgkB2v/rRipFLV1d+l904EM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=pjV7buyPOcWtLDxRiPHWttMVKv/mp1KDrkVRcX79/4fWVi6LB4AVTdcMryDrx3qTOZ
         O31H6t+/RMJ/AM3pQhd0lKfnrnv0T1959o837jdpzZSm6ucXEMEV3LEy2prqajgsqy8N
         y3UcXpx72WDW1DtQiSBQk614ft9yQzDkXMdE4=
Received: by 10.220.178.13 with SMTP id bk13mr1002897vcb.145.1299011459145;
 Tue, 01 Mar 2011 12:30:59 -0800 (PST)
Received: by 10.220.94.136 with HTTP; Tue, 1 Mar 2011 12:30:39 -0800 (PST)
In-Reply-To: <20110301200805.GA18587@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168254>

On Tue, Mar 1, 2011 at 3:08 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 01, 2011 at 02:57:19PM -0500, Chad Joan wrote:
>
>> > Exactly. Rather than spend time figuring out if the directory is
>> > removable (which would not be atomic, anyway), we just rmdir and ignore
>> > the error condition.
>> >
>> > I would argue that your filesystem is broken. Even if we implemented a
>> > workaround to opendir() and check for files, it would still have a race
>> > condition that could cause this situation to occur.
>>
>> Ouch.
>>
>> Would it work to do something like alias rmdir to a script or program
>> that would call /bin/rmdir and then fix up the permissions?
>
> Well, we're using the rmdir system call, so you would need a patch to
> git either way. If that was something we wanted to support (with a
> config option, of course), we could do the permissions check-and-restore
> ourselves.
>
> But it just seems horribly broken to me. This is CIFS to an OpenVMS
> machine you said? Do the broken permissions appear to other clients or
> across a remount (i.e., is it broken state in your CIFS client, or has
> the server actually munged permissions)? If so, have you tried reporting
> the issue to whoever writes CIFS server on OpenVMS (is it just samba)?
>
> -Peff
>

Yep, CIFS to OpenVMS.

I don't know about other clients because there are none (yet).  The
permission change does survive remounting.

I haven't reported it.  I didn't know it existed until now ;)

I'll do that, but it will probably take a long long time for me to see
the patch.  I'm hoping there's some cheap hack I can use to work
around it in the meantime.

- Chad
