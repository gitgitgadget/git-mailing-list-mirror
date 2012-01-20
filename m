From: David Aguilar <davvid@gmail.com>
Subject: Re: difftool / mergetool waiting
Date: Thu, 19 Jan 2012 23:25:31 -0800
Message-ID: <CAJDDKr4WWfui5micnDQ97fJQC_5UxXoAB062vhHEPBVa070Bvw@mail.gmail.com>
References: <CAG=s6FnG=3hO5jykc8s40SrCPfvJSvtEMVNBSihX5Y7T3b9SMg@mail.gmail.com>
	<m239biadb5.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Jonathan Seng <nekenyu@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 20 08:25:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ro8qu-0004KH-JZ
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 08:25:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977Ab2ATHZc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Jan 2012 02:25:32 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:64876 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591Ab2ATHZb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jan 2012 02:25:31 -0500
Received: by yenm6 with SMTP id m6so125471yen.19
        for <git@vger.kernel.org>; Thu, 19 Jan 2012 23:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=mleErSBJNq95Nn9Dr4+BzRWp8qaBZ4ffGoTBQDfqaC0=;
        b=HqFbhYK9do5cjXmGGdXNzrb3lRcuc1U9sLOBYI5epdVWVLlmEQOOQDSoHAAgauVZwR
         d8/upFl1IBZxSF7iYK7qeypQPVO2Ao3FOyolueSiNgiz2keD1ZVkE1pD2gJ3tve0l+bc
         n3oZdOarSe040T7+lqGOnk3m60zTUVZhJ/6FE=
Received: by 10.236.116.129 with SMTP id g1mr42600874yhh.107.1327044331236;
 Thu, 19 Jan 2012 23:25:31 -0800 (PST)
Received: by 10.146.151.11 with HTTP; Thu, 19 Jan 2012 23:25:31 -0800 (PST)
In-Reply-To: <m239biadb5.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188862>

On Sat, Jan 14, 2012 at 12:38 AM, Andreas Schwab <schwab@linux-m68k.org=
> wrote:
> Jonathan Seng <nekenyu@gmail.com> writes:
>
>> If wait is false, git would fire off the tool command and proceed to
>> the next then exit cleanly.
>
> That doesn't work for git mergetool, it wouldn't be able to postproce=
ss
> the result of calling the tool command.

The difficulty on the difftool side is that the git-difftool--helper
scriptlet is being driven by git diff (as a $GIT_EXTERNAL_DIFF) and
depends on git diff to do the temp file cleanup.  Not blocking would
return control immediately to git diff.  This is unwanted because the
temp files would likely be removed before the tools have a chance to
open them.

You could write a script that simply forks off multiple difftool
commands.  The difftool stuff in git-cola does exactly that, for
example.
--=20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 David
