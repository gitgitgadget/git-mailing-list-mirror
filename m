From: Conrad Irwin <conrad.irwin@gmail.com>
Subject: Re: [PATCH] Disallow creating ambiguous branch names by default
Date: Fri, 19 Aug 2011 11:14:11 -0700
Message-ID: <CAOTq_ptU2QmPMMZYQLd2MFQ_=_RnADdBnoN5+v4rXh_nmpOcjw@mail.gmail.com>
References: <1313569298-3879-1-git-send-email-conrad.irwin@gmail.com> <7vhb5fev8a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 20:14:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuTaX-0006xh-7w
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 20:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753895Ab1HSSOc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Aug 2011 14:14:32 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:33417 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819Ab1HSSOc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Aug 2011 14:14:32 -0400
Received: by gwaa12 with SMTP id a12so1825213gwa.19
        for <git@vger.kernel.org>; Fri, 19 Aug 2011 11:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=nK1iix2EwE4na27XF5STNX5g13M23L2OqOUxjIyUHus=;
        b=FNgT4xmpeY15sgFzUzCij89LWg9sd2rSaadpQGCTsIim9/4fYVCiAP6SNl/F9MfkSG
         m9oAvr1CVc62g6AMmT/BanJ7uIcuImKSRPhQdGPzoMUuzXFvRNzCtYs8qvOTYPPhRd0j
         wfVOfSFphKLjYoyGFavCmT4675/GJyOfkVi10=
Received: by 10.236.185.228 with SMTP id u64mr209839yhm.91.1313777671490; Fri,
 19 Aug 2011 11:14:31 -0700 (PDT)
Received: by 10.236.95.131 with HTTP; Fri, 19 Aug 2011 11:14:11 -0700 (PDT)
In-Reply-To: <7vhb5fev8a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179715>

On Wed, Aug 17, 2011 at 11:41 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Conrad Irwin <conrad.irwin@gmail.com> writes:
>
>> Before this change, it was comparatively easy to create a confusingl=
y
>
> Drop everything before the ", ".
>
>> named branch (like "origin/master" or "tag.1"). The former case is
>> particularly biting to newcomers, who suddenly find themselves needi=
ng
>> to handle nuances of the refs namespaces.
>
> If you start forbidding certain names, newcomers will need to be expo=
sed
> the same nuances to understand why what they wanted to do is not allo=
wed,
> so that is not an argument.
>
> My preferences (take them as "the ground rules" if you want) are:
>
> =A0- We don't disallow what we have long allowed, without a good reas=
on;
> =A0- We make sure new people will get a warning with useful advice.
>
> I would be happy to see the end result that warns when the end user
> creates a branch (or a tag) that is ambiguous _when_ it is created (n=
ot
> "much later, when we noticed there are ambiguous refs"), and offers a=
n
> advice message to use "branch -m" to rename it away (control the mess=
age
> with a new "advice.*" configuration and unless explicitly declined wi=
th
> it, always give the advice).
>

In the process of changing things around to do this, I noticed that

git checkout -M <foo> <current-branch>

surprisingly works, and does confusing things, in that you will get a:

$ git rev-parse HEAD@{1}
warning: Log .git/logs/HEAD has gap after Fri, 19 Aug 2011 02:00:09 -07=
00

Presumably this is the reason that git branch -f forbids you from
changing the current branch?

If so is this a reasonable case where the current behaviour should be
forbidden (with the same error message "fatal: Cannot force update the
current branch.") =97 or should I just make it output a warning?

Conrad
