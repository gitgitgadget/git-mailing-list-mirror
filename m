From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] credential-osxkeychain: load Security framework dynamically
Date: Wed, 14 Sep 2011 19:56:42 -0400
Message-ID: <CAG+J_Dxenu7GDsTzUCCQiYg38Vto8CtD8ODX1J9mA8o1n2_YJA@mail.gmail.com>
References: <1316023117-84755-1-git-send-email-jaysoffian@gmail.com>
	<1316040926-89429-1-git-send-email-jaysoffian@gmail.com>
	<20110914230816.GA5754@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	John Szakmeister <john@szakmeister.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 15 01:56:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3zJw-0001RV-Gn
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 01:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028Ab1INX4o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Sep 2011 19:56:44 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42189 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277Ab1INX4n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2011 19:56:43 -0400
Received: by gyg10 with SMTP id 10so1833947gyg.19
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 16:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=qjIrgEj0s3BJza0ta5GDlkd/iYZLGT8C5oGdEe2IW7w=;
        b=Ro5jPh99H9oJQOXJhvUzaM/NQ3+VHpnlemQB2ORbXM/Mcz53RCU1oMVspZQNQNE3h4
         aX1QAyXZx4EHog1sjrOGSlv8xv4LxCKBAoC/yvOXjxY+xrxIUpxhvc5E5slfkgC+OSAQ
         /fwV1de+0HGh8KSm6CwCMRhs0fTN7DwdOoTM0=
Received: by 10.236.173.129 with SMTP id v1mr2713752yhl.25.1316044602476; Wed,
 14 Sep 2011 16:56:42 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Wed, 14 Sep 2011 16:56:42 -0700 (PDT)
In-Reply-To: <20110914230816.GA5754@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181415>

On Wed, Sep 14, 2011 at 7:08 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Sep 14, 2011 at 06:55:26PM -0400, Jay Soffian wrote:
>
> To be honest, I was surprised to see you linking against git. I had
> always envisioned OS-specific helpers as living outside of the git.gi=
t
> repo. =C2=A0That's why I provided git-credential-getpass; it should b=
e the
> only part of git that helpers really want to reuse.

Okay, I think I was led astray by the fact that
credential-{cache,store}.c (at least the latter of which is meant as
nothing more than an example helper right?) links with git.

> What are you getting from git that is useful? From my skim of your
> patch, it looks like xmalloc/die, parse_options, and credential_getpa=
ss.

Correct.

> The first can be replaced with a few trivial lines of code. The secon=
d
> is overkill, I think. The helper code will always hand you the
> "--option=3Dvalue" form, and I always intended it to stay that way
> (whether that is well documented, I'm not sure). But a simple loop wi=
th
> strncmps would be fine.
>
> The hardest part is credential_getpass. You can call "git
> credential-getpass", but you'll have to read the output yourself (tho=
ugh
> it's quite simple to parse; see read_credential_response).
>
> I'm not a fan of cutting and pasting code, and this will add a number=
 of
> lines to your C program. But I feel like keeping the build completely
> separate from core git is probably a good boundary (especially becaus=
e
> this will not be getting built or tested all the time, as most of the
> core code is).

Okay.

j.
