From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Sharing a massive distributed merge
Date: Thu, 17 Mar 2011 09:53:21 +0100
Message-ID: <AANLkTimTKbKWmf80u-kgnvQ2gT8hx2KTm6HGbWejt3eg@mail.gmail.com>
References: <4D8119BE.2090208@workspacewhiz.com> <AANLkTim0TL5X8rKoBceK3nLA4JrtuftqkJDkRi0Lok0A@mail.gmail.com>
 <20110317063816.GD11931@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 17 09:53:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q08xr-0007WS-OW
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 09:53:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568Ab1CQIxr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Mar 2011 04:53:47 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47445 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936Ab1CQIxp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Mar 2011 04:53:45 -0400
Received: by gyf1 with SMTP id 1so1015767gyf.19
        for <git@vger.kernel.org>; Thu, 17 Mar 2011 01:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=xcczzBoJSkqaQtoGTFkU+Yc3VHTyMueQcOiupo/3vh8=;
        b=jtgOjIcE69GW7xF9rt/JZeGP3+WfQqkAD0oBooucy7Qcxc2leU2PM0rkJ4t7vDKQdy
         Opk0FP0GUWpFmLUeqbxYTtnq30aF0rNpXK8jCXLlNYAKB3K5CRNMFJf5FQBQWu7ZmmUT
         WK+GNh1lIA1Po88yS0YrvuVdVzQaw5cm1/eWc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=vV3+hxe7c8c82x9RdsIKvPvc+rCDXm7raLWPLwZgYk4Z8F7G9cHKnU/vFzoPIR1jYd
         ktBSWe196rlQrLNGr7zwMcapA7jDnZmjdDzvppveCNE2Z6+21lpY82droqk3Lmboh7/j
         hcShgCTUY5sDeP36GXZrv77BnuVwDOTHvKnk8=
Received: by 10.90.250.2 with SMTP id x2mr1098867agh.202.1300352024578; Thu,
 17 Mar 2011 01:53:44 -0700 (PDT)
Received: by 10.90.223.11 with HTTP; Thu, 17 Mar 2011 01:53:21 -0700 (PDT)
In-Reply-To: <20110317063816.GD11931@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169226>

On Thu, Mar 17, 2011 at 07:38, Jeff King <peff@peff.net> wrote:
> I don't think you need to do anything so drastic. You can just have
> everybody do the partial merge, commit, and then push their result. =C2=
=A0And
> then as you suggest below, one person does the real merge, uses check=
out
> to install the desired result state from each person's partial tree, =
and
> then everybody throws away their partial merges.
>
> The trick is that each person will resolve some conflicts and commit,
> but you need to know which ones they resolved. They can't leave thing=
s
> unmerged in the final commit. So they would have to provide such a li=
st
> to you; one way is in the commit message[1].
>
> So let's say you have three devs, Alice, Bob, and Charlie, and one
> integrator, Matt, who will do the merge. Each of the developers does:
>
> =C2=A0git checkout -b partial-merge
> =C2=A0git merge old-topic
> =C2=A0git mergetool ;# or manually resolve and git add
>
> Eventually they get tired of the conflicts and give up. So they recor=
d
> the list of resolved paths, either manually or with something like[2]=
:
>
=2E..
>
> And then they stage the rest of it (knowing it will be ignored by Mat=
t)
> and commit:
>

What if they just revert the rest? Reset the files to their states befo=
re
merge. Than Matt can just collect the partial merges with a merge on
his side and take care of the conflicts left, which should be fewer.
