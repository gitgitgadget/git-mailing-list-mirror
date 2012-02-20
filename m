From: Johan Herland <johan@herland.net>
Subject: Re: [RFC] pre-rebase: Refuse to rewrite commits that are reachable
 from upstream
Date: Mon, 20 Feb 2012 22:21:12 +0100
Message-ID: <CALKQrgcY1dVNP0U0NsmDTuZwb6MLNKzmdHxuAb05UmnUcAXf4A@mail.gmail.com>
References: <201202111445.33260.jnareb@gmail.com>
	<1329772071-11301-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johan Herland <johan@herland.net>, gitster@pobox.com,
	jnareb@gmail.com, philipoakley@iee.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 20 22:21:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rzafj-0002Y5-0a
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 22:21:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061Ab2BTVVS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Feb 2012 16:21:18 -0500
Received: from locusts.copyleft.no ([178.255.144.241]:64059 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753875Ab2BTVVS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Feb 2012 16:21:18 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Rzafc-000DYC-Ha
	for git@vger.kernel.org; Mon, 20 Feb 2012 22:21:16 +0100
Received: by iacb35 with SMTP id b35so7988940iac.19
        for <git@vger.kernel.org>; Mon, 20 Feb 2012 13:21:13 -0800 (PST)
Received-SPF: pass (google.com: domain of johan@herland.net designates 10.42.176.200 as permitted sender) client-ip=10.42.176.200;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of johan@herland.net designates 10.42.176.200 as permitted sender) smtp.mail=johan@herland.net
Received: from mr.google.com ([10.42.176.200])
        by 10.42.176.200 with SMTP id bf8mr22198308icb.1.1329772873057 (num_hops = 1);
        Mon, 20 Feb 2012 13:21:13 -0800 (PST)
Received: by 10.42.176.200 with SMTP id bf8mr17779196icb.1.1329772872999; Mon,
 20 Feb 2012 13:21:12 -0800 (PST)
Received: by 10.42.170.3 with HTTP; Mon, 20 Feb 2012 13:21:12 -0800 (PST)
In-Reply-To: <1329772071-11301-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191107>

On Mon, Feb 20, 2012 at 22:07, Johan Herland <johan@herland.net> wrote:
> Teach the pre-rebase sample hook to refuse rewriting commits on a bra=
nch
> that are present in that branch's @{upstream}. This is to prevent use=
rs
> from rewriting commits that have already been published.
>
> If the branch has no @{upstream}, or the commits-to-be-rebased are no=
t
> reachable from the upstream (hence assumed to be unpublished), the re=
base
> is not refused.
>
> This patch is not an ideal solution to the problem, for at least the
> following reasons:
>
> =C2=A0- There is no way for the user to override this check, except s=
kipping
> =C2=A0 the pre-rebase hook entirely with --no-verify.
>
> =C2=A0- The check only works for branches with a configured upstream.=
 If the
> =C2=A0 user's workflow does not rely on upstream branches, or uses so=
me other
> =C2=A0 method of publishing commits, the check will produce false neg=
atives
> =C2=A0 (i.e. allow rebases that should have been refused).
>
> =C2=A0- The check only applies to rebase. I wanted to add the same ch=
eck
> =C2=A0 on 'commit --amend', but there's no obvious way to detect --am=
end
> =C2=A0 from within the pre-commit hook.
>
> =C2=A0- There may be other rewrite scenarios where we want to do this=
 check,
> =C2=A0 such as 'git reset'. Maybe a pre-rewrite hook should be added?
>
> =C2=A0- Some (including myself) want this check to be performed by de=
fault,
> =C2=A0 since it's mostly targeted at newbies that are less likely to =
enable
> =C2=A0 the pre-rebase (pre-rewrite) hook, so maybe the check should b=
e added
> =C2=A0 to core git instead.
>
> Discussed-with: Jakub Narebski <jnareb@gmail.com>
> Signed-off-by: Johan Herland <johan@herland.net>
> ---

I forgot to explain that this patch is not really submitted for
inclusion, but rather to continue the discussion of getting rewrite
safety properly implemented in git. As such, the problems noted in the
above commit message are probably more important than the patch
itself...

Also, this implements only a small subset of what has been discussed
regarding 'public' and 'secret' properties of commits in the preceding
thread. However, I believe solving this part of the problem
(preventing upstreamed commits from being rewritten) will make 90% of
users happy, and that it's worth fixing on its own merits.


Have fun! :)

=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
