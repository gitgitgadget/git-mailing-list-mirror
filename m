From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: Verifiable git archives?
Date: Thu, 9 Jan 2014 14:50:08 -0800
Message-ID: <CALCETrWjHnpZxdsE3z_rZEUsNfdheDjSsZ2=yaxW8Hz4v05dLA@mail.gmail.com>
References: <CALCETrU88evB6VQrE8=8vrc+HYXAX8_Zx7TsYZp6YXeE4dZdvg@mail.gmail.com>
 <xmqqsiswapav.fsf@gitster.dls.corp.google.com> <CALCETrXTbvHQAWm2z13OwyHCmBZZNDSqyWCdiu6maHRp2mi-Pw@mail.gmail.com>
 <xmqq38kwai3v.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 09 23:50:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1OQs-0003pe-OW
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 23:50:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbaAIWub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 17:50:31 -0500
Received: from mail-vb0-f53.google.com ([209.85.212.53]:53599 "EHLO
	mail-vb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbaAIWua (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jan 2014 17:50:30 -0500
Received: by mail-vb0-f53.google.com with SMTP id o19so2633565vbm.40
        for <git@vger.kernel.org>; Thu, 09 Jan 2014 14:50:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Vw5UoTAZ+g49fXTx8UgE7vTrrHvbboU8/U6kW4465Z4=;
        b=OsA7QJQu9/JFtUDmlGuPI3pwv9/UlX+iiKU2vYHybEHmio/bP+ch8VSUaZC+q5zrlS
         plUexI0tOErcEHe1YUjxJmVJK0qu0luWWNflpBFQEieirNMnXH0si2Z/gGlfHkImlvcn
         YJuL/bmBbBpomtXHa9MhqaS7gEgK+GmqH7P1YXhj9lBNF485jF5+y/Gn2P30klNXHOmc
         kF5GiVQ0m5ASvd/etGg+DfFrn7neAbe5F12Q4UgVzxsdRqqS/6jnpm71Yx1W2+bHnvyh
         TRq8b7He3Pf6ofMQueOyFMRzx4CZYUv4pGNUo+we+hUEMbavGQ5IAgox5JqLyeu4pMNf
         dw5g==
X-Gm-Message-State: ALoCoQniU1SogN832WRRn6XFlLYgZpI4U5wndPUugKrt0uYlu4BII0KgflFhu8SBCBLzTCxyghqT
X-Received: by 10.58.57.194 with SMTP id k2mr5126785veq.0.1389307828568; Thu,
 09 Jan 2014 14:50:28 -0800 (PST)
Received: by 10.58.75.131 with HTTP; Thu, 9 Jan 2014 14:50:08 -0800 (PST)
In-Reply-To: <xmqq38kwai3v.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240283>

On Thu, Jan 9, 2014 at 2:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Andy Lutomirski <luto@amacapital.net> writes:
>
>>> You only need the object name of the top-level tree.  After "untar"
>>> the archive into an empty directory, make it a new repository and
>>> "git add . && git write-tree"---the result should match the
>>> top-level tree the archive was supposed to contain.
>>
>> Hmm.  I didn't realize that there was enough metadata in the 'git
>> archive' output to reproduce the final tree.
>
> We do record the commit object name in the extended header when
> writing a tar archive already, but you have to grab the commit
> object from somewhere in order to read the top-level tree object
> name, which we do not record.

This could be changed :)

>
> Also, if you used keyword substitution and such when creating an
> archive, then the filesystem entities resulting from expanding it
> would not match the original.
>

In the simple case, you'd need to have an archive with no prefix or
funny business (or at least a known prefix).  In the fancy case, you
could at least verify that all the file contents really came from git,
but then you'd really need the tree objects.

The use case I have in mind is for projects to distribute archives but
only need to sign the tagged git commit id.  I think this should be
doable without too much pain.  (This assumes that the release doesn't
contain autogen output and such.)

--Andy
