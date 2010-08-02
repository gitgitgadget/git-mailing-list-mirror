From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: URL substitution and config file precedence
Date: Mon, 2 Aug 2010 16:05:34 +0000
Message-ID: <AANLkTikdyNjcgZpY=BPjkieacDXHPvp0he77VJZCMLpw@mail.gmail.com>
References: <20100802153720.GA28481@fishbowl.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Mon Aug 02 18:05:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfxWK-00081V-3g
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 18:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754002Ab0HBQFi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 12:05:38 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40717 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753706Ab0HBQFh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Aug 2010 12:05:37 -0400
Received: by ywh1 with SMTP id 1so1291016ywh.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 09:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Zwj46txdE1buND9Y9POzR2y/ojcCGp2Dd/nfmt25oU0=;
        b=GifMEshwpw9wKrQZxO6Sy04YUTyfEvta4uTEwJ6OXWgoQf1DgL+eXaJB40+sPGJSrE
         VI4FxU5Gu8Y9OIwagzpTfDevy+NTiDoLn4MptI34L/WFhfTpo4YjKTI9/+6PQHTonjJn
         uBX/6FHZ8yS/qp0gy8UVFCyJbFgoh0abIXSRA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jR6HNFHVoN3Z9V6Ab94fnLEXPp2mvM05VkDWXvVLb9TucpXXriCMfB/uedPHeRw19B
         8NQBjgSSj6UyDuhSp7EyU47frEzF02VYWRzs6oqU3oH2Y3/8oBEYYhJJj8NyP/w1j0PM
         WOsRmmGQRYxFNv9WICJ35S3D5XHXFU02zFMRk=
Received: by 10.100.124.4 with SMTP id w4mr6516583anc.140.1280765136486; Mon, 
	02 Aug 2010 09:05:36 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Mon, 2 Aug 2010 09:05:34 -0700 (PDT)
In-Reply-To: <20100802153720.GA28481@fishbowl.rw.madduck.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152419>

On Mon, Aug 2, 2010 at 15:37, martin f krafft <madduck@madduck.net> wro=
te:
> Dear Gits,
>
> I expect .git/config to tae precedence over ~/.gitconfig, which in
> turn gets favoured over /etc/gitconfig. This works fine, except for
> the url.=E2=80=A6.insteadOf settings.
>
> Have a look at the following:
>
> =C2=A0% grep madduck: .git/config
> =C2=A0 =C2=A0url =3D madduck:pub/puppet/modules/git
>
> =C2=A0% grep -B1 nsteadOf /etc/gitconfig ~/.gitconfig
> =C2=A0/etc/gitconfig-[url "git://git.madduck.net/madduck/"]
> =C2=A0/etc/gitconfig: insteadOf =3D madduck:
> =C2=A0--
> =C2=A0/home/madduck/.gitconfig-[url "ssh://git.madduck.net/madduck/"]
> =C2=A0/home/madduck/.gitconfig: =C2=A0 =C2=A0 =C2=A0 insteadOf =3D ma=
dduck:
> =C2=A0/home/madduck/.gitconfig: =C2=A0 =C2=A0 =C2=A0 pushInsteadOf =3D=
 git://git.madduck.net/madduck/
>
> =C2=A0% git push -v
> =C2=A0Pushing to git://git.madduck.net/madduck/pub/puppet/modules/git
> =C2=A0fatal: The remote end hung up unexpectedly
>
> There seem to be two problems:
>
> =C2=A01. the value from /etc/gitconfig seems to be preferred over the
> =C2=A0 =C2=A0 one from ~/.gitconfig. I think this is due to the fact =
that the
> =C2=A0 =C2=A0 syntax for URL substitution is a bit whack and the two =
keys
> =C2=A0 =C2=A0 different, so the merge is actually a union-merge, and =
then the
> =C2=A0 =C2=A0 result is probably just the first match (git:// sorts b=
efore
> =C2=A0 =C2=A0 ssh://).

Right, the git-config backend just merges on a key-value basis. It isn'=
t smart.

> Why was the syntax chosen backwards in this way? Why not have
>
> =C2=A0[urlsubst "madduck:"]
> =C2=A0 =C2=A0 =C2=A0replaceWith =3D ssh://git.madduck.net/madduck/
>
> or even better:
>
> =C2=A0[url_regsubst]
> =C2=A0 =C2=A0 =C2=A0somefreelychosenname =3D s|madduck:|ssh://git.mad=
duck.net/madduck/|

I don't know, but it usually helps if you add the person who added the
feature to the CC-list.
