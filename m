From: Ron Garret <ron1@flownet.com>
Subject: Re: git-mv redux: there must be something else going on
Date: Wed, 03 Feb 2010 14:33:28 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-9FA846.14332803022010@news.gmane.org>
References: <ron1-32BD5F.10255403022010@news.gmane.org> <32541b131002031048i26d166d9w3567a60515235c34@mail.gmail.com> <ron1-5F71CB.11234903022010@news.gmane.org> <alpine.LFD.2.00.1002031436490.1681@xanadu.home> <ron1-34F9C6.12273203022010@news.gmane.org> <32541b131002031240p6b67536ame6b69c6d662a7968@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 23:34:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcnnN-0003hH-Jx
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 23:34:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756606Ab0BCWd5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2010 17:33:57 -0500
Received: from lo.gmane.org ([80.91.229.12]:35055 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756539Ab0BCWdz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 17:33:55 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NcnnG-0003eS-Fd
	for git@vger.kernel.org; Wed, 03 Feb 2010 23:33:54 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 23:33:54 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 23:33:54 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138911>

In article=20
<32541b131002031240p6b67536ame6b69c6d662a7968@mail.gmail.com>,
 Avery Pennarun <apenwarr@gmail.com> wrote:

> On Wed, Feb 3, 2010 at 3:27 PM, Ron Garret <ron1@flownet.com> wrote:
> > So I think I'm beginning to understand how this works, but that lea=
ds me
> > to another question: it seems to me that there are potential screw =
cases
> > for this purely content-based system of tracking files. =C2=A0For e=
xample,
> > suppose I have a directory full of sample config files, all of whic=
h are
> > similar to each other. =C2=A0Will that cause diffcore to get confus=
ed?
>=20
> Cases like that are always confusing, even to humans.  Person A
> renames X to Y, but at the same time creates Z which is almost
> identical.  Person B patches X, then merges in person A's changes.
>=20
> What do you expect to happen?  Should Y be changed, because that's th=
e
> file X was moved from?  Or should we change Z, because it's almost th=
e
> same content anyway?  Or maybe we should change both, since a change
> to the old X is probably intended to affect the copied *content* that
> ended up in both Y and Z?
>=20
> Simply storing whether person A has renamed vs. copied vs. added a
> file makes the answer to the "what do you expect to happen" question
> more obvious, but fails to answer the "what *should* happen" question=
=2E
>  Thus it's more of a distraction than a feature.  It took a while for
> me to accept this, but once I did, I realized that git's behaviour ha=
s
> still never caused me a problem in real life, despite repeated file
> renames and complicated merges.
>=20
> In contrast, svn's explicit rename tracking has shot me in the foot
> numerous times.  (svn remembers when I delete file X and then
> subsequently re-add it with the same content.  So if I merge in
> someone's change to the *old* file X, it barfs because omg omg that's
> a totally different file X and it can't possibly figure out what to
> do.  Gee, thanks.  It's also hopelessly incompetent at handling
> "renames" in which a newbie developer didn't know to use svn mv, but
> instead used svn rm, mv, and svn add.)

Here's a realistic case where keeping explicit track of renames could b=
e=20
useful.

A and B start with a file named config.  A and B both make edits.  In=20
addition, B renames config to be config1 and creates a new, very simila=
r=20
file called config2.  B then merges from A with the expectation that B'=
s=20
edits to config would end up in config1 and not config2.  It seems to m=
e=20
that without tracking renames, it would be luck of the draw which file=20
the patch got applied to.

rg
