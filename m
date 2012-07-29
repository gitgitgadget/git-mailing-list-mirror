From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: Enhancements to git-protocoll
Date: Sun, 29 Jul 2012 16:24:58 +0200
Message-ID: <20120729142458.GB16223@paksenarrion.iveqy.com>
References: <20120728214116.GA3591@paksenarrion.iveqy.com>
 <7vehnvvyta.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 29 16:24:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvUQT-0001R9-TD
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jul 2012 16:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753173Ab2G2OYx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Jul 2012 10:24:53 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:44537 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753162Ab2G2OYw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jul 2012 10:24:52 -0400
Received: by lahd3 with SMTP id d3so2997774lah.19
        for <git@vger.kernel.org>; Sun, 29 Jul 2012 07:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=JHwDpxVYbU38oTztT8Cjk5UGD6D0Ucq31QpSkDK4NQ0=;
        b=o8D1RovMFDrzEW1ykfV2/1nVfz9ePlI5V3ExE1VfsNwOExt+/igo43Hcuut4pzkkkH
         yk0mQxeZfTQsZUv9EpDbzc/wkRoJnHbRGE8FKFrfjI9ohOdlvpk5T7PMKU9ppC9s001Q
         fecpZ4ZbwEPPJD48r+EFkZWHoV2qID2hLkF0oAugC88l7c7/F6Frdy2BWXAhsH7r0lCa
         iYEPm5CML+Kib/872aGiCzajmRTzh/sP6XYHwmsC1ARubMEUXMITSdxiv5tvdp5jLyBC
         Cjg1JvnCWHBufx0E+o/iEClc/Ot72IykdSrFthHhmaXaQrYsJQ5La2StbnCIm3BgGP5g
         6Z1w==
Received: by 10.152.144.234 with SMTP id sp10mr8427795lab.51.1343571890841;
        Sun, 29 Jul 2012 07:24:50 -0700 (PDT)
Received: from paksenarrion.iveqy.com (h-235-111.a189.priv.bahnhof.se. [81.170.235.111])
        by mx.google.com with ESMTPS id sy1sm7868426lab.13.2012.07.29.07.24.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 Jul 2012 07:24:49 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1SvUQU-0004Gk-2a; Sun, 29 Jul 2012 16:24:58 +0200
Content-Disposition: inline
In-Reply-To: <7vehnvvyta.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202478>

On Sat, Jul 28, 2012 at 11:58:09PM -0700, Junio C Hamano wrote:
> Fredrik Gustafsson <iveqy@iveqy.com> writes:
>=20
> > Sometimes the server wants to communicate directly to the git user.
> > ...
> > For example:
> > gitolite has something called wild repos[1]. The management is
> > cumbersome and if you misspell when you clone a repo you might inst=
ead
> > create a new repo.
> >
> > This could have been avoided with a simply:
> > "Do you want to create a new repo[Yn]"
>=20
> I do not think the automatic repository creation done by gitolite is
> a good use case or example for whatever you seem to be advocating.
>=20
> IIUC, the auto-creation in gitolite-shell::main() is done way before
> gitolite-shell (which is used as a login shell for incoming ssh
> sessions) creates a new git repository, goes into it and spawns the
> git-receive-pack command.  It all happens outside Git.
>=20
>     # auto-create?
>     if ( repo_missing($repo) and access( $repo, $user, '^C', 'any' ) =
!~ /DENIED/ ) {
>         require Gitolite::Conf::Store;
>         Gitolite::Conf::Store->import;
>         new_wild_repo( $repo, $user, $aa );
>         gl_log( 'create', $repo, $user, $aa );
>     }
>=20
> The "access()" we see here is not the Perl builtin access(), but is
> a function defined in src/lib/Gitolite/Conf/Load.pm; that would be
> the place to allow the incoming ssh session to talk back to the end
> user, but at that point there is no Git processing on the server
> end.

That's a feature. It means that the impact on git would be rather small=
,
we don't have to involve server-side git at all. The problem so solve i=
s
how to get client-side git to pass through STDIN and STDOUT (just as is
done with STDERR right now). I see this as a gitolite <-> client-git
interaction case. No server-git should be involved.

All the use casese I can imagine will be done before (or after)
serverside git is executed.

> While I am not fundamentally opposed to adding yet another sideband
> channel to the git protocol, I do not think adding user interaction
> at random places in the protocol exchange is a viable or useful
> approach to implement an enhanced server that works with both
> enhanced and vanilla clients (and the same is true for enhanced
> client that works with both enhanced and vanilla server).

Do we mean the same thing with "git protocol"? I specify the protocol a=
s
everything that happens between the server and the client. Are the
connection divided into multiple protocoll after eachother? (would it b=
e
possible to execute git-user-interaction-protocoll first and the
git-protocoll and then git-user-interaction-protocoll again?).

The vanilla case would be easy to solve if the protocol has git version
in its handshake. The STDERR approach is already used and working. A
vanilla client would have the same functionality as today and en
enhanced client will have enhanced functionality.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
