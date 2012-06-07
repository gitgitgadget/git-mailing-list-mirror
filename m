From: cheng renquan <crquan@gmail.com>
Subject: Re: [PATCH] git fetch one tag only
Date: Thu, 7 Jun 2012 09:11:00 -0700
Message-ID: <CAH5vBdKHOg=PTsFPgcsd3iNEuTTY_dD2gPNXkmzjRmE8NpBrXw@mail.gmail.com>
References: <CAH5vBdK_M+7Hjk=juVeP7Phqvs2+npknFD-=45OVR032k5S-0A@mail.gmail.com>
	<CAPc5daVwOuP_dPiHh5zcjV6kTvdb2FNhzXz_capEDhHgE5ZUKw@mail.gmail.com>
	<CAH5vBdKPH_-cn=r-zxQKCOi5PB5D6vuSXrZxPeZJ+HYg-K9Yqw@mail.gmail.com>
	<7vpq9bk7o5.fsf@alter.siamese.dyndns.org>
	<CAH5vBdKXaOV3hC0E0s=j3Hc2jZ9otxhXLMhCCKiU4=Rn4Y4COA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 18:11:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScfIi-0004Qn-LD
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 18:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798Ab2FGQLD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jun 2012 12:11:03 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:56181 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570Ab2FGQLB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jun 2012 12:11:01 -0400
Received: by weyu7 with SMTP id u7so463087wey.19
        for <git@vger.kernel.org>; Thu, 07 Jun 2012 09:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ZXVGWzpj8A7GKIp+YoOLf3eavxnBGkYFDYiDkbnL0wM=;
        b=X42xv+noICcdL0Cb9WySY3lmTDR28xm3G3g3sdStbAUdDnTwPh+Oy5TKMDBO5DHHQY
         kMCY/sWyyxGpwchOrq+I/E1dRCGk/G2MtwX5gCLw2vLA2H1LEcGbi1VNQFYLaHulsX8r
         atPfTN87kCMEktAisjotCRKv6/hIilN0g0ndk09xxT5V1AxuuU6lFExvMpf1LPIU6jQv
         Ijhzu9e5eAeAId4FguL/Uyd/2bP2SyNvQBa1czvRADYWq1LusYexf5t4g5m9RmmXG1yU
         hofY6tRYEXzGxamoVhesqoYKcUbOaLnMmmFjWq5xcj1ZTp5+TZlwAAq9EnAMrGuBo6OX
         mvNg==
Received: by 10.216.196.218 with SMTP id r68mr1225878wen.122.1339085460148;
 Thu, 07 Jun 2012 09:11:00 -0700 (PDT)
Received: by 10.216.136.80 with HTTP; Thu, 7 Jun 2012 09:11:00 -0700 (PDT)
In-Reply-To: <CAH5vBdKXaOV3hC0E0s=j3Hc2jZ9otxhXLMhCCKiU4=Rn4Y4COA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199411>

On Wed, Jun 6, 2012 at 10:47 PM, cheng renquan <crquan@gmail.com> wrote=
:
> ok, got it:
>
> $ git fetch -v --no-tags linux-stable tag v3.4.1
> From git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e
> =C2=A0=3D [up to date] =C2=A0 =C2=A0 =C2=A0v3.4.1 =C2=A0 =C2=A0 -> v3=
=2E4.1

Here I still think the logic is wrong:

$ git fetch linux-stable tag
fatal: You need to specify a tag name.

$ git fetch linux-stable tag v3.4.1
[this would actually fetch all tags]


from `git help fetch`:

           Some short-cut notations are also supported.

           =C2=B7    tag <tag> means the same as
refs/tags/<tag>:refs/tags/<tag>; it requests fetching everything up to
the given tag.


Here the documentation is saying "everything up to the given tag.",
but other tags can never be all belonging to that path, for above
example, in the path up to given tag v3.4.1, I'm sure other tags like
v3.3.1 are not in the path;

So the `git fetch linux-stable tag v3.4.1` fetched other tags is a
WRONG behavior,
and why can't we fix that by disabling auto-following automatically if
use tag syntax? Why to the user "--no-tags" is explicitly required?
