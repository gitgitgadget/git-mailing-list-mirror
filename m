From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [1.8.0] Remote tag namespace
Date: Tue, 1 Feb 2011 22:35:46 +0700
Message-ID: <AANLkTim4qOiF=3GMixZuWJs=cqcAtawtgkKzLiVdBhuZ@mail.gmail.com>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com> <4D48219D.8060603@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 16:36:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkIHo-0001Gu-6s
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 16:36:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703Ab1BAPgs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Feb 2011 10:36:48 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:51755 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab1BAPgr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Feb 2011 10:36:47 -0500
Received: by eye27 with SMTP id 27so3184096eye.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 07:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=w4xDdQZy0UKUWQkcsNAtjHE1gku0AZ1UjbvYIDV1hY8=;
        b=QlHJxXXiobNG+EQddM/TM5LD/W9vAh3hHLehlnlninkVhfc5NrsCzwstp9X91PFVzN
         UeSdYv7y1PI8pgn7G4Ver67OMkGBdzbzYYJMzJzNCgDCfixemBlSi/hZTY+LaOvhsegC
         Ec/0j/bb9uQkwz0YCDY669ir1TUYZDrqnlDSk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=l0ATlSZmD7Ut8xPshbwc8AUQTMHpfOSc85RlOb2HM1sE0sghksv6lFXzJhnWkIopMG
         LqQ8u6NobTVeiRtbYW104tvy9MeSifVXNpaIkUSRmV8TjDQBlENJU3iz0s8Govi/sokA
         webneAPa0eMSZIin38alTZFR0UWN2Oyb8817A=
Received: by 10.216.162.70 with SMTP id x48mr804573wek.4.1296574576415; Tue,
 01 Feb 2011 07:36:16 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Tue, 1 Feb 2011 07:35:46 -0800 (PST)
In-Reply-To: <4D48219D.8060603@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165818>

On Tue, Feb 1, 2011 at 10:07 PM, Marc Branchaud <marcnarc@xiplink.com> =
wrote:
>> Config branch.*.globalTags (perhaps takes a pattern?) may be defined
>> to create refs/tags/* in addition to refs/remote-tags/<remote>/* whe=
n
>> fetching tags.
>
> I may be getting into the weeds prematurely here, but why put the con=
fig item
> under branch.* ? =C2=A0Or did you mean remote.*.globalTags? =C2=A0Per=
sonally, I don't
> see a need for this. =C2=A0I'd rather have the rev-parse machinery se=
arch in
> remote tag namespaces if it can't find anything local.

Ahh.. yeah it's remote.*.globalTags. I don't know, some people might
find current behavior useful. So instead of dropping it entirely, I'd
limit it to certain remotes.

>
>> Migration plan:
>>
>> refs/remote-tags will be used to store new tags unconditionally, whi=
ch
>> means there will be duplicates with the already-fetched tags in glob=
al
>> namespace. Perhaps we can check if they point to the same sha-1, the=
n
>> choose not to annoy users with ambiguous tag messages?
>
> (Again with the weeds...) =C2=A0I don't think we could do that. =C2=A0=
I'd want to be
> able to have my own (local) tags that refer to the same commits as on=
e or
> more remote tags, and I'd want to see them all.

=46or listing tags (I forgot this) I think we just follow how git-branc=
h
does it: show only local tags unless -r (or some other option) is
given. What I meant in the above paragraph is "some-ref" can refer to
refs/tags/some-ref or refs/remotes/foo/tags/some-ref, but I was wrong
on this. The latter can only be referred by foo/some-ref or with
migration support in your proposal.

>
> Better for "git tag" to learn scoping options like "git branch": -a a=
nd -r.
> (Hmm, maybe git-tag's current -a could become -A...)

When tags are put in remote namespace (wherever it actually is),
git-tag must learn -r like git-branch. I think option name change for
-a is too late though. When "git-ng" rewrite project comes (that is
after libgit2 replaces git core), we may have everything consistent
again.

PS. I bet git-ng would start after Wine 2.0 is released.
--=20
Duy
