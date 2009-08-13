From: Eric Wong <normalperson@yhbt.net>
Subject: Re: GCC Git mirror no longer updating
Date: Wed, 12 Aug 2009 20:37:39 -0700
Message-ID: <20090813033738.GA7950@dcvr.yhbt.net>
References: <20090811163049.GA4578@redhat.com> <1250010535.8074.366.camel@giskard> <20090811173006.GB4578@redhat.com> <1250017013.8074.376.camel@giskard> <20090811191642.GA5806@redhat.com> <4aca3dc20908111333i49195ec5h9b91ab5f6445f701@mail.gmail.com> <4A822440.40207@redhat.com> <1250074569.8074.671.camel@giskard> <4A82C786.5060602@redhat.com> <1250123299.8074.1593.camel@giskard>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jason Merrill <jason@redhat.com>,
	Daniel Berlin <dberlin@dberlin.org>,
	"Frank Ch. Eigler" <fche@redhat.com>, overseers@gcc.gnu.org,
	git@vger.kernel.org
To: Bernie Innocenti <bernie@codewiz.org>
X-From: git-owner@vger.kernel.org Thu Aug 13 05:37:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbR8P-0002cj-3z
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 05:37:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653AbZHMDhj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Aug 2009 23:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752637AbZHMDhj
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 23:37:39 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:37751 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752302AbZHMDhi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 23:37:38 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB4441F7E2;
	Thu, 13 Aug 2009 03:37:39 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1250123299.8074.1593.camel@giskard>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125772>

Bernie Innocenti <bernie@codewiz.org> wrote:
> El Wed, 12-08-2009 a las 09:45 -0400, Jason Merrill escribi=F3:
> > On 08/12/2009 06:56 AM, Bernie Innocenti wrote:
> > > The git repository format should support concurrent access, but p=
erhaps
> > > it only applies to git-receive-pack, not fancy operations such as
> > > repacking.
> >=20
> > The git repository format, yes, but maybe not the stuff in .git/svn=
=2E  It=20
> > seems like a temporary index file was referring to an object that g=
ot=20
> > garbage collected away.  Or maybe the index file was left over from=
 the=20
> > initial import, and not there due to a collision; there don't seem =
to be=20
> > index files there normally.
>=20
> git-svn might be keeping extra information in files that the other gi=
t
> tools don't know about.  This would explain why some objects looked
> like orphans and were thus culled.  [cc'ing the git list to catch the
> attention of the git-svn maintainer(s)].

Hi,

As far as I can remember, no version of git svn has ever relied on
orphanable objects.

Of course there are unavoidable race conditions that happen while git
svn is running.  It is never safe to run repack concurrently while git
svn is running (I wouldn't repack/gc simultaneously with _any_ write
activity on the repo).   git svn itself can/will run "git gc" in-betwee=
n
revisions if needed.  You can safely repack manually whenever git svn i=
s
not running.

--=20
Eric Wong
