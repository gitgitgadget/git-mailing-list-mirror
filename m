From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] test-lib: write test results to
	test-results/<basename>-<pid>
Date: Sat, 14 Mar 2009 14:59:04 +0100
Message-ID: <20090314135904.GL6808@neumann>
References: <cover.1236961524u.git.johannes.schindelin@gmx.de>
	<3728317206182c4d4539f3d20b8441cb160e72e3.1236961524u.git.johannes.schindelin@gmx.de>
	<alpine.DEB.1.00.0903131735110.6288@intel-tinevez-2-302>
	<20090313172002.GA16232@neumann>
	<alpine.DEB.1.00.0903141250450.10279@pacific.mpi-cbg.de>
	<20090314121617.GJ6808@neumann>
	<alpine.DEB.1.00.0903141321550.10279@pacific.mpi-cbg.de>
	<20090314122833.GK6808@neumann>
	<fabb9a1e0903140616q3770f89axff84755abb1f47c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 15:01:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiUQR-0003dp-Av
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 15:01:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753356AbZCNN7O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Mar 2009 09:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753264AbZCNN7O
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 09:59:14 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:51629 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060AbZCNN7N (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2009 09:59:13 -0400
Received: from [127.0.1.1] (p5B130307.dip0.t-ipconnect.de [91.19.3.7])
	by mrelayeu.kundenserver.de (node=mrelayeu6) with ESMTP (Nemesis)
	id 0ML29c-1LiUOG1dAL-0001tX; Sat, 14 Mar 2009 14:59:05 +0100
Content-Disposition: inline
In-Reply-To: <fabb9a1e0903140616q3770f89axff84755abb1f47c7@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Provags-ID: V01U2FsdGVkX18XzPSS3/balwGNgf/qIJoLGbD2h/i376ZY+RE
 TDzg+HbkqIfIvz0Ddls4n3eK/28Q/AlfdcmvkvtsH+t+0U+202
 tjEN2GaTYIXcqOqujXAOA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113252>

Hi,

On Sat, Mar 14, 2009 at 02:16:57PM +0100, Sverre Rabbelier wrote:
> On Sat, Mar 14, 2009 at 13:28, SZEDER G=E1bor <szeder@ira.uka.de> wro=
te:
> > With my proposed change there would be no need to clean 'test-resul=
ts'
> > before running the tests, because test-lib.sh would take care of th=
at
> > (not by removing and recreating 'test-results/', but by overwriting
> > (IOW: removing and recreating, but in one step) individual test res=
ult
> > files).
>=20
> Wouldn't that result in possible stale files being counted in the
> result (e.g., if those tests were not run this time, but they were ru=
n
> previously)?

It depends.

If you run only a few tests, then you do it with a command like 'make
t1234-foo.sh t5678-bar.sh'.

Currently this doesn't run the 'pre-clean' target, therefore if you
run different tests (e.g. 'make t1234-foo.sh ; make t5678-bar.sh'),
then a 'make aggregate-results' will include the result of both of
those tests.  The same happens with my proposal, too, because the test
of the last run will not overwrite the results of the test in the
first run.

Now suppose that you want to run the same set of tests twice (or more;
e.g. 'make t1234-foo.sh ; make t1234-foo.sh ; make
aggregate-results').  Since currently the pid of the test is included
in the test result file name, there will be two files (t1234-<pid1>
and t1234-<pid2>) created under 'test-results/', and _both_ will be
counted by 'aggregate-results'.  In this case my proposal is better,
because the last round will overwrite the result of the previous runs,
therefore no stale files will be counted.


Best,
G=E1bor
