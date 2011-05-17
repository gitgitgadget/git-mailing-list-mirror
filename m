From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: ACLs for GIT
Date: Tue, 17 May 2011 17:38:11 +0530
Message-ID: <BANLkTimPbQe7DGmR0VvDkU3=ZNjcAu7axw@mail.gmail.com>
References: <4DD02876.1040404@bbn.com>
	<20110515201608.GX6349@kiwi.flexilis.local>
	<4DD12517.1000308@bbn.com>
	<BANLkTikwEivOiQVV-B=g3pP_StXAa8CVwg@mail.gmail.com>
	<BANLkTi=9vp+ibVa3tQzXbZSeYATKwmF60Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin L Resnick <mresnick@bbn.com>,
	"R. Tyler Croy" <tyler@monkeypox.org>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 17 14:08:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMJ4W-0006ej-1p
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 14:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754209Ab1EQMIN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 May 2011 08:08:13 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56473 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753866Ab1EQMIM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2011 08:08:12 -0400
Received: by vws1 with SMTP id 1so257935vws.19
        for <git@vger.kernel.org>; Tue, 17 May 2011 05:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Pr7KBOgzUck5EOcQftqISImSImho1k+tAw2ChbOMKok=;
        b=SDJK2q/EcviKaILNruhtNIwnaBeafjqzQxrmuHaHEifPX4dxotxZjFpCKnDo2tAeRa
         P50npVH/K30y6B+e7YHv09V3Q5jWLGipr/t/MCGisdpAigWWzY1+dEQ4XTOmIWuBjV+K
         ufZQqSmlJJrEW3QfPyHkBovUIHDkLAODMIwaI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mnfUsW595ogd9oNkx1K5AoWqYUZNwc7AqCOrq1y4zDFzwhe5CkR5dL3sZP4QABG0s3
         Slnjiz6ZDZdJNuE/D5FKbNDLU8t1eRxsr+b/VDCrXuXAEH8YJCiR+dPjlPlK+9Tx071X
         zMlnqIina/DDwRrFKtvOcaX7XfAY41rHgE5ZA=
Received: by 10.52.76.198 with SMTP id m6mr796929vdw.0.1305634091295; Tue, 17
 May 2011 05:08:11 -0700 (PDT)
Received: by 10.52.162.99 with HTTP; Tue, 17 May 2011 05:08:11 -0700 (PDT)
In-Reply-To: <BANLkTi=9vp+ibVa3tQzXbZSeYATKwmF60Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173796>

On Tue, May 17, 2011 at 7:19 AM, Shawn Pearce <spearce@spearce.org> wro=
te:
> On Mon, May 16, 2011 at 18:32, Sitaram Chamarty <sitaramc@gmail.com> =
wrote:

>> PS: Gitolite does have unreleased code to do this but it's a hack wi=
th
>> several limitations. =C2=A0Gitolite makes a temp "clone -l", deletes=
 all
>> refs from it that the user has no access to, then redirects the
>> git-upload-pack to that repo instead ;-)
>
> Cute hack. Doesn't prevent the evil client from making an indirect
> reference to something you shouldn't have. :-)

You mean he constructs a commit that references a SHA he should not be
having, pushes that to the branch he is allowed to read/write, then
pulls it down again to now really get that commit?

Yeah, I started writing a hook that looks at `rev-list
oldsha..newsha`, and for each commit run `git branch --contains SHA`
and make sure it either (a) is totally new to the repo, ie no ref
contains this commit or (b) at least one of the refs that contains
this commit is allowed for this user.

I haven't had time to do that though.  Also, if there has been a
rewind/force-push and the attacker knows the now unreachable SHA, this
would not catch it (it'd look like a totally new commit).  That's a
hard one.

Having two repos is still the best plan ;-)
