From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] Add --create-cache to repack
Date: Fri, 28 Jan 2011 10:22:17 -0800
Message-ID: <AANLkTi=Mu+tP7V2wWq9Fr3RVmdWhG7gGhj=LWLSqerZ_@mail.gmail.com>
References: <1296201984-24426-1-git-send-email-spearce@spearce.org>
 <4D42878E.2020502@viscovery.net> <AANLkTim+AUY9SdeAFfkny2_a3qQ9SCDLUHR3s9Q3M98u@mail.gmail.com>
 <4D42E1E3.4060808@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Hawley <warthog19@eaglescrag.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jan 28 19:22:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pisy6-0005vg-7V
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 19:22:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755309Ab1A1SWj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jan 2011 13:22:39 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50606 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755232Ab1A1SWj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jan 2011 13:22:39 -0500
Received: by fxm20 with SMTP id 20so3629355fxm.19
        for <git@vger.kernel.org>; Fri, 28 Jan 2011 10:22:38 -0800 (PST)
Received: by 10.223.98.197 with SMTP id r5mr2674512fan.68.1296238958025; Fri,
 28 Jan 2011 10:22:38 -0800 (PST)
Received: by 10.223.70.205 with HTTP; Fri, 28 Jan 2011 10:22:17 -0800 (PST)
In-Reply-To: <4D42E1E3.4060808@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165631>

On Fri, Jan 28, 2011 at 07:33, Johannes Sixt <j.sixt@viscovery.net> wro=
te:
> Am 1/28/2011 15:37, schrieb Shawn Pearce:
>> A simple fix is to use --heads --tags by default like I do here, but
>> make the actual parameters we feed to rev-list configurable. =A0A
>> repository owner could select only the master branch as input to
>> rev-list, making it less likely the topic branches would be
>> considered. =A0Unfortunately that requires direct access to the
>> repository. =A0It fails for a site like GitHub, where you don't mana=
ge
>> the repository at all.
>
> Let's define a ref hierarchy, refs/cache-pack, that names the cache p=
ack
> tips. A cache pack would be generated for each ref found in that
> hierarchy. Then these commits are under user control even on github,
> because you can just push the refs. Junio would perhaps choose a rele=
ase
> tag, and corresponding commits in the man and html histories. The cho=
ice
> would not be completely automatic, though.

This is a good idea.  Perhaps we go slightly further and say:

  refs/cache-pack/name-without-slash

    This packs into its own pack file, as a single tip.

  refs/cache-pack/group/a
  refs/cache-pack/group/b

   These pack into a pack file together.

If you have direct repository access, you can also just make one of
these a symbolic reference to a branch, e.g. refs/heads/master, and
then periodic `git repack --create-cache` invocations would pick up
the latest point.

--=20
Shawn.
