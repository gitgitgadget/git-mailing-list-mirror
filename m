From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: More builtin git-am issues..
Date: Fri, 4 Sep 2015 16:52:42 -0700
Message-ID: <CA+55aFw2bnhSQYk4FaHfp4ED0Y611NWyQs05TMQtFj=2As1=nA@mail.gmail.com>
References: <CA+55aFzN4SnenchxPScn61_apzitGAPtoYEd49iLZPxgK0KQGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 01:52:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZY0mk-000735-KS
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 01:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760790AbbIDXwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 19:52:44 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:34047 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760785AbbIDXwm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 19:52:42 -0400
Received: by iofb144 with SMTP id b144so40665609iof.1
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 16:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/+ly6334nn6Viy53MIxCai5vIUVbFXHg51TqJoMwOz0=;
        b=qy6lLSA32FawHIgyuj4YqC3PkssroZay3dlrt5ac44MEOzEKmtzYqhe1aDkEf2Lk1c
         96lJ2KXM28oOmjZ9lEDVLZRXQUpgsiHzCSPromEce2RcBSXCEnOoTZ5D2j5gHRDOqfFE
         csxpE0qyqSAf2rEBmCG3nMNupVXuN99D6AJ/qnk7drPj75vDXJn6dt5nmda8YjC329ij
         Mtc+oxtKrOWCRNLaEZwCNYgRqWUrPhz4Vps6fWzAWsPvfP1HbtjV67KLZlv6DStmBR2q
         hDpMzQb9q0POmQoLz1++576auHVsXFUSTlikYTqygx6w9gXtJAcSIW97H/cYLiLdKaEK
         JHGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/+ly6334nn6Viy53MIxCai5vIUVbFXHg51TqJoMwOz0=;
        b=CIFsqnLgxEBHxQYzuteEPKzYqkq2VT3u9feBp/DYr2wRUDSQCr/4N7sMnsfNPfhV7v
         6rOm9TBaz5pop9dN+kQc/3LZMsXKUCqOrPA2ryWK1u+M9TB54OvNwC/Ury+zRJT98C/G
         PPMB1QysnwKG0/1IDk6lLX6IZ+Pg7B7rXnCgA=
X-Received: by 10.107.11.223 with SMTP id 92mr11509324iol.186.1441410762376;
 Fri, 04 Sep 2015 16:52:42 -0700 (PDT)
Received: by 10.36.124.195 with HTTP; Fri, 4 Sep 2015 16:52:42 -0700 (PDT)
In-Reply-To: <CA+55aFzN4SnenchxPScn61_apzitGAPtoYEd49iLZPxgK0KQGw@mail.gmail.com>
X-Google-Sender-Auth: GLnS3dxjtcJKsHYiw1nz1qFQlaY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277349>

On Fri, Sep 4, 2015 at 4:47 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I *think* it's this part:
>
>                 if (!(found_rfc2822 ||
>                       is_cherry_picked_from_line(buf + i, k - i - 1)))
>                         return 0;
>
> which basically returns 0 for _any_ line in the footer that doesn't
> match the found_rfc2822 format.

Confirmed. I hacked up a version that just doesn't do that check at
all, and it works fine (but obviously only on well-formatted emails
that really do have a sign-off).

So I think that logic should basically be extended to saying

 - if any line in the last chunk has a "Signed-off-by:", set a flag.

 - at the end of the loop, if that flag wasn't set, return 0.

Instead of that thing that basically returns zero immediately when it
sees a line it doesn't like.

I'm in the middle of my merge window, so I'm not going to get around
to writing a patch until that's over. Hopefully somebody will step up
in the meantime. Hint, hint.

                   Linus
