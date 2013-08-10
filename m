From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: How can I automatically create a GIT branch that represents a
 sequence of tags?
Date: Sun, 11 Aug 2013 01:20:26 +0200
Message-ID: <20130810232026.GF25779@paksenarrion.iveqy.com>
References: <CAFw3YtRLgUGGn9JV5K3P9XtMBcBeO7=VSM7PekSxtW6xCsfZ1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Kristian Freed <kristian.freed@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 11 01:17:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8IPT-0007BE-8V
	for gcvg-git-2@plane.gmane.org; Sun, 11 Aug 2013 01:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897Ab3HJXQy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Aug 2013 19:16:54 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:44968 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796Ab3HJXQx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 19:16:53 -0400
Received: by mail-lb0-f174.google.com with SMTP id w20so3178515lbh.33
        for <git@vger.kernel.org>; Sat, 10 Aug 2013 16:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hPi9BYk60P10XWZJwAhRgdJERNl8t0F39s4kROuPwrU=;
        b=ZdXkg3Z2E2D0mRBZHwjIfeAt/+TRcoBKV1Rx0MVM/q7nzhU8suGU5iwTopVsKQKfYN
         NdK3DYGlDD38d7JgEl9uqwsh51GewaOjQGtyRycWqqwjhc1TptHWgXtd5fgG7fzaT40W
         y4Rr7IfX/5DKxgd/KHp8U4+0EqOkuw+HuM4PfrRBnIX8p7s/ivevkYoimBmP7qbjulaG
         TJSpM8YeU0PoD4bU1VwsvuOP7UAJbC8M/QzSU7aBmHWWyT9nrMYn0Si4lXEWi1tkyiQ9
         3NFPIWIxVx/Lzmiy8Y1hpDVUaa//b2nSbBR7HSvNZrOtT+S7Pym9eEPVNCQJaIS/KOMf
         Yluw==
X-Received: by 10.152.37.232 with SMTP id b8mr8312813lak.80.1376176610893;
        Sat, 10 Aug 2013 16:16:50 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id xr1sm4140156lbb.14.2013.08.10.16.16.49
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 10 Aug 2013 16:16:49 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1V8ISQ-0001NN-4a; Sun, 11 Aug 2013 01:20:26 +0200
Content-Disposition: inline
In-Reply-To: <CAFw3YtRLgUGGn9JV5K3P9XtMBcBeO7=VSM7PekSxtW6xCsfZ1Q@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232115>

On Sat, Aug 10, 2013 at 11:29:45PM +0100, Kristian Freed wrote:
> In our current setup, we have automatic tagging in git of all
> successful release builds. This makes it easy to go back to stable
> points in history and compare functionality, check when bugs were
> introduced etc.
>=20
> To help with this process further, it would be useful to be able to
> use git bisect, but as these are just a sequence of tags, not commits
> on a branch, git bisect will not work as is.
>=20
> Is there any tooling for automatically recreating a branch from a
> sequence of tags, where each generated commit is the calculated delta
> between each two neighbouring tags?

I don't understand, why is it better to find between which tags a error
was found and not in what commit. It's much easier to find a bug
introduced in a commit than in a tag/release. It sounds like you're
doing the bug hunting harder. Could you explain this further?

It would be very hard to do a tool such as you describe, the reason is
that there's no sane way to order your tags. Git today show tags
alphabetically, all versions does not have a alphabtic order. You could
argue that it should be in the order of the tagged commits commit date,
however the commits are not ordered by date, an older commit can have a
younger commit as a parent. You could say that the tag order is the
order you find the tags if you go from a branch and backwards in the
history, however how do you then choose which path to take when you fin=
d
a merge?

My suggestion if you want to do this, is to have your buildtool to
checkout a special branch (let's call it tag_branch) do a git reset
to get the worktree from the newly tagged commit and commit on that
branch once for each tag it's creating, when it creates the tag.

It would be quite easy to make a script that create such branch for you=
,
if you only can sort the tags somehow.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
