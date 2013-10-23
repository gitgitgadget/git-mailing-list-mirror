From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: RFE: support change-id generation natively
Date: Wed, 23 Oct 2013 13:36:01 +0700
Message-ID: <CACsJy8A7r-gsbru0eLxtJbFk2vgqvBH9akHn6e53k=UJbZ1K7Q@mail.gmail.com>
References: <2127507934.9293293.1382367063640.JavaMail.root@openwide.fr>
 <201310212029.01589.thomas@koch.ro> <1382380858.25852.36711509.53CF173C@webmail.messagingengine.com>
 <201310211249.49568.mfick@codeaurora.org> <xmqqy55lrsoo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Martin Fick <mfick@codeaurora.org>, james.moger@gitblit.com,
	Thomas Koch <thomas@koch.ro>,
	Jeremy Rosen <jeremy.rosen@openwide.fr>,
	Git Mailing List <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 23 08:36:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYs3Y-0002Ju-MP
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 08:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440Ab3JWGgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 02:36:32 -0400
Received: from mail-qc0-f175.google.com ([209.85.216.175]:45945 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051Ab3JWGgc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Oct 2013 02:36:32 -0400
Received: by mail-qc0-f175.google.com with SMTP id v2so242596qcr.20
        for <git@vger.kernel.org>; Tue, 22 Oct 2013 23:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VI2k2R9k29DfzGBPcp6a9bMLr+CrG/bjIwoLdmDiqaI=;
        b=LNCB5MO7CeisaZiMOLxCNjtjruMGhe5dD65fsq21TGKV5XUosqzisJelTVvv0OZqhQ
         pQgnoM8KOSwWu3JBtsONtdzDR+SgqdAznsaBA+of0M7CIgVPNSaFHjDSFyHWgfvLBEIH
         FqExTAIGEodM6jw6OKTshx/RL8r3yrrV7wKlrX8zHEcmcZQE8is5lKbbDXA9nEODPEDq
         33SSQS5GLZ+2f/TRwV9F1Fj92qW6IlDLWXl1dmsH0hN6je4Fj/3qPfmgxdEOYyZFQnDz
         yC7vT0PWYUvTRxZVavgWgCjZ2CJD98CupuctlVPTM1+giDckmB4nZdiZiaKRhjkq9Q2m
         8kcA==
X-Received: by 10.49.96.225 with SMTP id dv1mr14374257qeb.89.1382510191269;
 Tue, 22 Oct 2013 23:36:31 -0700 (PDT)
Received: by 10.96.27.202 with HTTP; Tue, 22 Oct 2013 23:36:01 -0700 (PDT)
In-Reply-To: <xmqqy55lrsoo.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236499>

On Wed, Oct 23, 2013 at 2:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
> It would be just the matter of updating commit_tree_extended() in
> commit.c to:
>
>  - detect the need to add a new Change-Id: trailer;
>
>  - call hash_sha1_file() on the commit object buffer (assuming that
>    a commit object that you can actually "git cat-file commit" using
>    the change Id does not have to exist anywhere for Gerrit to
>    work---otherwise you would need to call write_sha1_file()
>    instead) before adding Change-Id: trailer;
>
>  - add Change-Id: trailer to the buffer; and then finally
>
>  - let the existing write_sha1_file() to write it out.

I'm not objecting special support for Gerrit, but if the change is
just commit_tree_extended() why don't we just ship the commit hook in
a new "Gerrit" template? It's just a matter of "git init
--template=gerrit" (or something) to create a new repo, or reinit the
current repo and you're set. Of it per-repo is bad, perhaps we could
introduce global hooks (if we haven't had them yet)?
-- 
Duy
