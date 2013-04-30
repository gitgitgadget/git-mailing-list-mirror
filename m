From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v2 0/8] Some object db protection when add_submodule_odb is used
Date: Tue, 30 Apr 2013 10:43:18 +0200
Message-ID: <87ehdsxvbt.fsf@linux-k42r.v.cablecom.net>
References: <1367293372-1958-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 10:43:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX69q-0007TI-KH
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 10:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759453Ab3D3InZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Apr 2013 04:43:25 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:37572 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759146Ab3D3InW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Apr 2013 04:43:22 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 30 Apr
 2013 10:43:16 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS12.d.ethz.ch (172.31.38.212) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 30 Apr 2013 10:43:18 +0200
In-Reply-To: <1367293372-1958-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 30
 Apr 2013 10:42:44 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222920>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> The idea behind this series is, after add_submodule_odb, odb may have
> new temporary objects that only appear after the call. These temporar=
y
> objects may lead to repo corruption (e.g. some new objects are create=
d
> and point to these temporary objects). This series attempts to catch
> those cases. It would make it safer to dig deeper into submodule's od=
b,
> e.g. to implement unified git-diff.
>
> Previous approach [1] is record the odb source, then check if the
> source is from submodule's odb. But that means we rely on the
> lookup order in sha1_file.c. This approach instead allows the caller
> to select what odb sources it wants to look up from.
>
> The checks are also less drastic than before. Checks are now done at
> higher level, e.g. commit_tree(), instead of at write_sha1_file,
> because we do allow to write objects that point to nowhere.
>
> Another new thing from previous round is I completely forbid the use
> of add_submodule_odb in security sensitive commands like index-pack o=
r
> rev-list. We could loosen up later if we need to.
>
> For fun, I set object_database_contaminated to 1 by default and ran
> the test suite. It passed :)

How does this interact with alternates set up by the user?  It's not
immediately obvious from the commit messages (hint hint) or the comment=
s
near ODB_LOCAL etc.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
