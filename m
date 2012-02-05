From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 0/3] On compresing large index
Date: Sun, 5 Feb 2012 22:22:49 +0100
Message-ID: <87ehu9ug9i.fsf@thomas.inf.ethz.ch>
References: <1328430605-4566-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, Joshua Redstone <joshua.redstone@fb.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 05 22:23:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ru9Y2-0006ES-1d
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 22:22:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129Ab2BEVWx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Feb 2012 16:22:53 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:27721 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751851Ab2BEVWx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Feb 2012 16:22:53 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Sun, 5 Feb
 2012 22:22:50 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (84.73.49.17) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Sun, 5 Feb
 2012 22:22:50 +0100
In-Reply-To: <1328430605-4566-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 5 Feb
 2012 15:30:02 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [84.73.49.17]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189966>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> $ time ~/w/git/git ls-files | head >/dev/null
> real    0m4.635s
> user    0m4.258s
> sys     0m0.329s
>
> $ time ~/w/git/git update-index level-0-0000/foo
> real    0m4.593s
> user    0m4.264s
> sys     0m0.323s
[...]
> We need to figure out what git uses 4s user time for.

When I worked on the cache-tree stuff, my observation (based on
profiling, so I had actual data :-) was that computing SHA1s absolutely
dominates everything in such operations.  It does that when writing the
index to write the trailing checksum, and also when loading it to verif=
y
that the index is valid.

ls-files shouldn't be so slow though.  A quick run with callgrind in a
linux-2.6.git tells me it spends about 45% of its time on SHA1s and a
whopping 25% in quote_c_style().  I wonder what's so hard about
quoting...

> This series may be useful on OSes that do not cache heavily. Though
> I'm not sure if there is any out there nowadays.

I think you could make a case that they should not be called "OS" ;-)

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
