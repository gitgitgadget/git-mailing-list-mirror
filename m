From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: gitattributes don't work
Date: Mon, 3 Jan 2011 11:34:00 +0700
Message-ID: <AANLkTikbGQkREQAx0p6Q+DrXPP2zWDU7doOO6yg+NGeC@mail.gmail.com>
References: <ifr610$3kl$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Joshua Jensen <jjensen@workspacewhiz.com>
To: =?UTF-8?Q?Marcin_Wi=C5=9Bnicki?= <mwisnicki@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 03 05:34:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZc7z-0004Vk-An
	for gcvg-git-2@lo.gmane.org; Mon, 03 Jan 2011 05:34:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753706Ab1ACEed convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Jan 2011 23:34:33 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61473 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753203Ab1ACEec convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Jan 2011 23:34:32 -0500
Received: by wyb28 with SMTP id 28so13049300wyb.19
        for <git@vger.kernel.org>; Sun, 02 Jan 2011 20:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=9X//8qsg+Y21M/zv2m4DtmheDQPmiYB8Yix/Iq0Aeu4=;
        b=mX9DZvGMwV3qgtKtnbOzFPGl0XQI+BBMNWlMQHkPgW0TtKv4WJJjKOkw9OUzveBhNq
         YAfZhDkEubNF9wkXNwySE+43DkljTjJkw4Kl1FkE9xLkFzpWKgDxRmgTS6FS8MWGyyeg
         QuR9e79RppK9Uq8xNoW0qOmuUdMeacSP7w4zk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=VYbqv1nz56HNpmf5CWMpO2jC+c7DjFl7BqiA6SkqE+ot7BYnDrtkbGtq8PYDdS8uDB
         4Vwb0BAuUW3RpziS5Yc9TBcNYCNAR3eT3gmxDaV0ToGb/jWFc+nYDu8/32VqqLcFfy8O
         7zRHO6F2/V8rWI0QlpML4z9wzpNm1S+9sTm2k=
Received: by 10.216.142.101 with SMTP id h79mr20636034wej.49.1294029271009;
 Sun, 02 Jan 2011 20:34:31 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Sun, 2 Jan 2011 20:34:00 -0800 (PST)
In-Reply-To: <ifr610$3kl$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164442>

2011/1/3 Marcin Wi=C5=9Bnicki <mwisnicki@gmail.com>:
> I'm trying to exclude certain paths (those that contain "xmac/gen/") =
from
> diff output using .git/info/attributes (not .gitattributes).
>
> According to gitattributes(5) it supports patterns from gitignore(5).
>
> Example path that must be excluded:
> src/byucc/jhdl/CSRC/xmac/gen/and2_dp_g.xmac
>
> What I've tried but didn't work:
> xmac/gen/ -diff
>
> Following works but is not what I want:
> *.xmac -diff
>
> It seems I can only get it to work for file names but not for whole p=
aths.
> What am I doing wrong or is this a bug ?

While gitattributes(5) says that, actually gitattributes and gitignore
use different matching implementations. gitattributes one seems
unchanged since its introduction in d0bfd02 (Add basic infrastructure
to assign attributes to paths - 2007-04-12). gitignore on the other
hand learned foo/ pattern later in d6b8fc3 (gitignore(5): Allow "foo/"
in ignore list to match directory "foo" - 2008-01-31).

Yeah, it looks like a bug to me. A better way to solve this once and
for all, is to unify the two implementations (which is good for
gitattr because there have been optimizations added to gitignore). I
tried long ago and gave up. Something to do with the order of matching
(gitignore tries inner directories first, while gitattr starts from
outer ones).

=46or the time being, anyone who changes gitignore should be reminded t=
o
consider whether it's applicable to gitattributes and vice versa.

Which reminds me, Joshua, maybe you should add case-insensitive
support to gitattributes too ;-)
--=20
Duy
