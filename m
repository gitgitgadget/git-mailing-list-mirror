From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] test-lib: write test results to
	test-results/<basename>-<pid>
Date: Sat, 14 Mar 2009 13:16:17 +0100
Message-ID: <20090314121617.GJ6808@neumann>
References: <cover.1236961524u.git.johannes.schindelin@gmx.de>
	<3728317206182c4d4539f3d20b8441cb160e72e3.1236961524u.git.johannes.schindelin@gmx.de>
	<alpine.DEB.1.00.0903131735110.6288@intel-tinevez-2-302>
	<20090313172002.GA16232@neumann>
	<alpine.DEB.1.00.0903141250450.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, gitster@pobox.com,
	Sverre Rabbelier <alturin@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 14 13:19:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiSq3-0000mF-Aj
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 13:19:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbZCNMQn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Mar 2009 08:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbZCNMQn
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 08:16:43 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:61248 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbZCNMQn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2009 08:16:43 -0400
Received: from [127.0.1.1] (p5B130307.dip0.t-ipconnect.de [91.19.3.7])
	by mrelayeu.kundenserver.de (node=mrelayeu8) with ESMTP (Nemesis)
	id 0ML31I-1LiSmn4AOk-0004kZ; Sat, 14 Mar 2009 13:16:20 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0903141250450.10279@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Provags-ID: V01U2FsdGVkX19gVLJF/4VtNJjnszXODrghTF6OqQmXnkZ05R2
 TSfhXUtrWEa7SKULUA65OrWeyUL61bi11pkmQmmMsM8rWGsjmK
 R8OoiciZgF8E0H9zoh2ug==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113247>

Hi,

On Sat, Mar 14, 2009 at 12:53:06PM +0100, Johannes Schindelin wrote:
> Hi,
>=20
> On Fri, 13 Mar 2009, SZEDER G=E1bor wrote:
>=20
> > diff --git a/t/Makefile b/t/Makefile
> > index 0d65ced..2e6e205 100644
> > --- a/t/Makefile
> > +++ b/t/Makefile
> > @@ -14,14 +14,11 @@ SHELL_PATH_SQ =3D $(subst ','\'',$(SHELL_PATH))
> >  T =3D $(wildcard t[0-9][0-9][0-9][0-9]-*.sh)
> >  TSVN =3D $(wildcard t91[0-9][0-9]-*.sh)
> > =20
> > -all: pre-clean $(T) aggregate-results clean
> > +all: $(T) aggregate-results clean

Well, this part is wrong, or at least not up-to-date.  I just digged
up an ancient branch in my tree and sent out the diff, without
realizing that there were some conflicting changes since then.

> > =20
> >  $(T):
> >  	@echo "*** $@ ***"; GIT_CONFIG=3D.git/config '$(SHELL_PATH_SQ)' $=
@ $(GIT_TEST_OPTS)
> > =20
> > -pre-clean:
> > -	$(RM) -r test-results
> > -
> >  clean:
> >  	$(RM) -r 'trash directory' test-results
> > =20
> > @@ -33,5 +30,5 @@ full-svn-test:
> >  	$(MAKE) $(TSVN) GIT_SVN_NO_OPTIMIZE_COMMITS=3D1 LC_ALL=3DC
> >  	$(MAKE) $(TSVN) GIT_SVN_NO_OPTIMIZE_COMMITS=3D0 LC_ALL=3Den_US.UT=
=46-8
> > =20
> > -.PHONY: pre-clean $(T) aggregate-results clean
> > +.PHONY: $(T) aggregate-results clean
> >  .NOTPARALLEL:
>=20
> This is wrong.  If you have failing tests, or if you interrupt the te=
sts,=20
> it will never clean the test results, and after Hannes' patch you _wi=
ll_=20
> have stale files lying around all the time.

If you have failing tests, or if you interrupt the tests, then you
will have stale files lying around _anyway_:  not only test results
are left there, but also trash directories.  To remove the trash
directories, you'll need to run 'make clean' (in t/), but that will
remove the test results, too, so there is no difference.  But even if
you don't run 'make clean' before running the test suite again, test
results cruft from the previous run doesn't matter, because they will
be overwritten.


Best,
G=E1bor
