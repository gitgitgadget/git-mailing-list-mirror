From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: what are the chances of a 'pre-upload' hook?
Date: Sun, 27 Nov 2011 18:46:25 +0530
Message-ID: <CAMK1S_jbofsWyag3Sospz8wYHqD4Z1Fs0p+MJWi02eCq0e+uHQ@mail.gmail.com>
References: <CAMK1S_jaEWV=F6iHKZw_6u5ncDW0bPosNx-03W9bOLOfEEEY1Q@mail.gmail.com>
	<CAMK1S_gh_CsWc-DnbOuUwn+H1i3skm99xzDbWe-wxsKKS0Qw-w@mail.gmail.com>
	<20111125144007.GA4047@sigill.intra.peff.net>
	<7v7h2my0ky.fsf@alter.siamese.dyndns.org>
	<20111126225519.GA29482@sigill.intra.peff.net>
	<7vr50uwk7x.fsf@alter.siamese.dyndns.org>
	<20111126233133.GA31129@sigill.intra.peff.net>
	<CAPc5daXY_4aimugj8Z4BFE8YvBSM1K+evPU69rLGH5ETo6PO=Q@mail.gmail.com>
	<20111126235135.GA7606@sigill.intra.peff.net>
	<CAPc5daUodry_=6pZxA=QOpuRUj9C2ed9Gzp6E1_G93iGfOOvOA@mail.gmail.com>
	<20111127000603.GA7687@sigill.intra.peff.net>
	<7v8vn2vt8p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 27 14:16:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUeb4-00080c-3b
	for gcvg-git-2@lo.gmane.org; Sun, 27 Nov 2011 14:16:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754865Ab1K0NQ1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Nov 2011 08:16:27 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47504 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433Ab1K0NQ0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Nov 2011 08:16:26 -0500
Received: by ywa9 with SMTP id 9so2169850ywa.19
        for <git@vger.kernel.org>; Sun, 27 Nov 2011 05:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=S53mGjNwhyKqxX5EoF5D545Zl3ckOTheX1mnPGrU/0g=;
        b=VGN1/s5SeAejLB2Lu6hHJ9UpvStJCT0xcB9F/1ybT6uCkK6wN2wCajitFoCXOhWFYf
         sJdDWQG9Pa4MphEo57r8mYTaeCQxN+UIWdzwJnSJip6Z79zBAJEmXehcspZOSrNFfQrc
         qjG6eWW9m/A/DiG5jsu2iA3ZLBDVLRvphpJDA=
Received: by 10.182.147.4 with SMTP id tg4mr11671640obb.60.1322399786216; Sun,
 27 Nov 2011 05:16:26 -0800 (PST)
Received: by 10.182.6.41 with HTTP; Sun, 27 Nov 2011 05:16:25 -0800 (PST)
In-Reply-To: <7v8vn2vt8p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185984>

On Sun, Nov 27, 2011 at 2:26 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jeff King <peff@peff.net> writes:
>
>> Just because it is passed through the environment does not mean you =
need
>> to have it set all the time. There is nothing wrong with:
>>
>> =C2=A0 GIT_ALLOW_UNTRUSTED_HOOKS=3Dtrue git fetch ~bob/repo.git
>>
>> We can even spell it:
>>
>> =C2=A0 git --allow-untrusted-hooks fetch ~bob/repo.git
>>
>> but it should probably still end up as an environment variable to ma=
ke
>> it through to the remote side (you could also tack it on to the
>> upload-pack command line; that wouldn't make it across git:// or htt=
p://
>> connections, but those are irrelevant here anyway).
>
> I actually like the idea of allowing pre-upload-pack hook on git:// a=
nd
> possibly http:// only. git-daemon can tell the upload-pack that it is=
 OK
> to run the hook, and the hook can do the things that only the daemon =
can
> do, never touching what the original requestor would but the reposito=
ry
> owner would not have an access to. Normal file:// and ssh:// transfer
> should not be needed for GitHub's stats or Sitaram's proxy usage, and=
 we
> should be able to unconditionally disable the hook when transfer is g=
oing
> over these protocols, no?
>
> One scenario I do not want to see is this. Suppose there is a company=
 that
> runs more than one project, and one of the projects is so secret that=
 only
> engineers working on the project have access to its repository, while=
 all
> people, including the project-A engineers, in the company have access=
 to
> other repositories. Further suppose that people involved in some or m=
any
> of the general repositories want to do something before a fetch from =
them
> happens. They will use the pre-upload-hook to implement it if we make=
 it
> available, and their new-hire training course will tell their enginee=
rs to
> set the GIT_ALLOW_UNTRUSTED_HOOKS. Perhaps the /etc/skel/profile the
> company gives the new-hires already defines it.
>
> And somebody who controls one of the general repositories installs a
> pre-upload-hook that borrows credential of a project-A engineer who
> happens to fetch from it to access repositories of the project-A.
>
> Imagine how the blame game that will ensue goes after materials from
> project-A is exposed. Of course, the owner of the rogue hook will get=
 the
> first blame, but I do not think Git will come unscathed out of it. At
> least we will be blamed for adding an inherently unsafe mechanism.
>

I'm sorry I started this discussion.  I worked around it, though it's
a bit kludgy, so maybe time to drop the debate.

--=20
Sitaram
