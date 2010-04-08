From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v2 (resend)] ls-remote: fall-back to default remotes when 
	no remote specified
Date: Fri, 9 Apr 2010 01:10:09 +0800
Message-ID: <t2mbe6fef0d1004081010sb6dfd0e1l2e73a36ef1af3870@mail.gmail.com>
References: <1270699083-5424-1-git-send-email-rctay89@gmail.com>
	 <1270710427-6680-1-git-send-email-rctay89@gmail.com>
	 <20100408071639.GJ30473@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 08 19:10:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzvFC-0008Sd-0g
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 19:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932950Ab0DHRKM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Apr 2010 13:10:12 -0400
Received: from mail-pz0-f193.google.com ([209.85.222.193]:50631 "EHLO
	mail-pz0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932833Ab0DHRKL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Apr 2010 13:10:11 -0400
Received: by pzk31 with SMTP id 31so2444534pzk.33
        for <git@vger.kernel.org>; Thu, 08 Apr 2010 10:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gHRlruW1SL0AhMb+YTotD2fzTRi9ADRjIh+qaR77jVg=;
        b=DyMs7NX054fk1qBiEHKldrxUYqraLuoIXSepYlaa+u5hRjJRKKcm49LvHXny5YkvM1
         wQDT9QZz9ofxXm1sfuaTR0cpINQtlrlPkmqZVxNtchLB0PdUMeTAzBsCHQrOjo44R9ip
         gWAsjmJhamVTzqJwtsS5QmMz6Dx7D5/VRMJmI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oH6k7w38+edvrbEb7PoGqogynD1OXQNOaTW0waSF+NyTWkYjuGS4XvKD571a14LWI8
         uXTW767yZAvatDC75KEP08BsHp3eXeSLmsBSzv24qrRkRA32qAWPa1qwZIfYS03WqeUB
         0lmrvTKxo9f/6lKVWNuvBVlVC/S/sAfGs9/5A=
Received: by 10.231.10.65 with HTTP; Thu, 8 Apr 2010 10:10:09 -0700 (PDT)
In-Reply-To: <20100408071639.GJ30473@coredump.intra.peff.net>
Received: by 10.140.179.8 with SMTP id b8mr649690rvf.99.1270746609679; Thu, 08 
	Apr 2010 10:10:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144364>

Hi,

On Thu, Apr 8, 2010 at 3:16 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Apr 08, 2010 at 03:07:07PM +0800, Tay Ray Chuan wrote:
>
>> =A0 =A0 =A0 remote =3D remote_get(dest);
>> + =A0 =A0 if (!remote)
>> + =A0 =A0 =A0 =A0 =A0 =A0 usage(ls_remote_usage);
>
> I don't see an update to ls_remote_usage, but shouldn't it now be:
>
> =A0git ls-remote [--heads] [--tags] =A0[-u <exec> | --upload-pack <ex=
ec>]
> =A0 =A0[repository] [<refs>...]
>
> or something now (while we're at it, maybe we can wrap it better as i=
t's
> larger than 80 characters).

yes. I think

 =A0git ls-remote [--heads] [--tags] =A0[-u <exec> | --upload-pack <exe=
c>]
=A0 =A0             [<repository> [<refs>...]]

would be more accurate.

> But once that is done, shouldn't the (!remote) case say something lik=
e
> "you don't have a default remote". The user didn't invoke ls-remote
> incorrectly (as the usage message shows), but rather there was a
> configuration problem.

Noted.

>> +test_expect_success 'use branch.<name>.remote if possible' '
>> +
>> + =A0 =A0 # Remove "origin" so that we know that ls-remote is not us=
ing it.
>> + =A0 =A0 #
>> + =A0 =A0 # Ideally, we should test that branch.<name>.remote takes =
precedence
>> + =A0 =A0 # over "origin", but that is another matter altogether.
>> + =A0 =A0 #
>> + =A0 =A0 git remote rm origin &&
>> + =A0 =A0 git config branch.master.remote self &&
>> + =A0 =A0 git ls-remote >actual &&
>> + =A0 =A0 test_cmp expected.all actual
>> +
>> +'
>
> Wouldn't your "ideally" just be:
>
> =A0git clone . other-remote &&
> =A0git push other-remote HEAD:unique-ref &&
> =A0git config branch.master.remote other-remote &&
> =A0...
>
> and check for "unique-ref" in the output?

hmm, upon clone, tracking branches are already created, so we can just
treat them as the "unique refs", without having to create a unique
ref.

--=20
Cheers,
Ray Chuan
