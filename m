From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [PATCH/RFC 0/2] Teach receive-pack not to run update hook for
 corrupt/non existent ref
Date: Sun, 25 Sep 2011 13:28:31 +0530
Message-ID: <CAMK1S_hadzaqixaW3Fx81pf=hVsvAMpVvVGqVtZ8ncfUsie_9w@mail.gmail.com>
References: <1316927182-14212-1-git-send-email-pangyanhan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Pang Yan Han <pangyanhan@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 25 10:05:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7jiQ-0001JU-Py
	for gcvg-git-2@lo.gmane.org; Sun, 25 Sep 2011 10:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432Ab1IYH6d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Sep 2011 03:58:33 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49064 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390Ab1IYH6c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Sep 2011 03:58:32 -0400
Received: by vws1 with SMTP id 1so5043223vws.19
        for <git@vger.kernel.org>; Sun, 25 Sep 2011 00:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=pJjaX6O5sNdepNCOzVB0fXfEeAOFlGzOwb1+NPStro8=;
        b=RZIIly0OVIdkVjIujBQYqx0+J4CmBu3PrVDIk+kqAem7rD0hvAc4sWtkvldxQot6a4
         aDSYrVjuXFhToivBbPD9TqLvtjVct0vNzLDZgsZkEWHFt410Kfq5er8OFF0sCMCmRdHl
         2xwXu3w/Mzph0uAL/9Lrws+Xpcv7ZNzH2jcds=
Received: by 10.52.19.229 with SMTP id i5mr4891160vde.335.1316937511772; Sun,
 25 Sep 2011 00:58:31 -0700 (PDT)
Received: by 10.52.160.161 with HTTP; Sun, 25 Sep 2011 00:58:31 -0700 (PDT)
In-Reply-To: <1316927182-14212-1-git-send-email-pangyanhan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182061>

On Sun, Sep 25, 2011 at 10:36 AM, Pang Yan Han <pangyanhan@gmail.com> w=
rote:
> Hi list,
>
> Currently, receive-pack runs the pre-receive, update, post-receive an=
d
> post-update hooks during a push to delete corrupt or non-existent ref=
s, eg:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git push origin :refs/heads/foo
>
> where refs/heads/foo is missing from the remote origin.
>
> The issue is reported here [1]

I did not report an issue.  I asked if this was expected and could be
relied upon.  I'm actually happy with the current behaviour because it
solves a problem very neatly for me, but before documenting it I
wanted to make sure it would not one day disappear.

> This is a patch series which teaches receive-pack not to run update h=
ook for
> corrupt or non existent refs during a push.
>
> Patch 1/2 isn't really relevant to the topic. It's just something I s=
tumbled
> across while reading the code. It removes a redundant assignment in t=
he is_url
> function.
>
> Patch 2/2 teaches receive-pack not to run update hook for corrupt or =
non
> existent refs. In summary, I reordered the statements in the update f=
unction
> so that the update hook is not run for corrupt / non existent refs.
>
> Perhaps this isn't a good enough solution since the pre-receive, post=
-receive
> and post-update hooks are still run. Also the tests aren't exactly go=
od looking.

It doesn't make sense to disable only the update hook.  And although I
did not come right out and say it, it is the post-update that I care
about.  If that still runs, my "issue" still exists.

> Any advice is highly appreciated. Thanks!
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/181942
>
> Pang Yan Han (2):
> =C2=A0is_url: Remove redundant assignment
> =C2=A0receive-pack: Don't run update hook for corrupt or nonexistent =
ref
>
> =C2=A0builtin/receive-pack.c | =C2=A0 50 +++++++++++++++++++++++++++-=
-------------------
> =C2=A0t/t5516-fetch-push.sh =C2=A0| =C2=A0 33 +++++++++++++++++++++++=
++++++++
> =C2=A0url.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A0 =C2=A01 -
> =C2=A03 files changed, 62 insertions(+), 22 deletions(-)
>
> --
> 1.7.7.rc3.2.g29f2e6
>
>



--=20
Sitaram
