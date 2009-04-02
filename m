From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 0/5] Header includes cleanup
Date: Thu, 2 Apr 2009 05:57:24 +0200
Message-ID: <200904020557.25058.chriscool@tuxfamily.org>
References: <1238406925-15907-1-git-send-email-nathaniel.dawson@gmail.com> <200903310859.36035.chriscool@tuxfamily.org> <7vk56565m1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nathaniel P Dawson <nathaniel.dawson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 06:00:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpE6Z-000887-Pt
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 06:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753281AbZDBD6b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Apr 2009 23:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753276AbZDBD6b
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 23:58:31 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:54683 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752216AbZDBD6a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Apr 2009 23:58:30 -0400
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 687D74C802E;
	Thu,  2 Apr 2009 05:58:20 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 321E14C8025;
	Thu,  2 Apr 2009 05:58:18 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vk56565m1.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115433>

Le mardi 31 mars 2009, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > I think it's a good thing that you started working on it even if in=
 the
> > end we decide that we want these cleanup to be done otherwise. At l=
east
> > we will hopefully have clarified our include header policy.
>
> Before seeing a lot of patches to change #include all over the place,=
 I'd
> like to see a simple guiding principle described, not just a subjecti=
ve
> "I think this makes things better" but with "... because of X and Y a=
nd
> Z".
>
> The document Documentation/CodingGuidelines describes the only policy
> that exists currently: git-compat-util.h must be the first thing the
> compiler sees.  The language should probably be stronger than what
> appears there:
>
>  - The first #include in C files, except in platform specific
>    compat/ implementations, should be git-compat-util.h or another
>    well-known header file that includes it at the beginning, namely
>    cache.h or builtin.h.
>
> Even though http.h may include "cache.h" at the very beginning, I'd
> rather not to see http-walker.c lose inclusion of "cache.h".  It will
> force us to remember that http.h is Ok to include as the first file, =
and
> that won't scale.
>
> The reason git-compat-util.h must be the first is because inclusion o=
f
> all the system header files is supposed to happen there, and there ar=
e
> some platforms that have broken system header dependencies we do not =
want
> application writers to care about, and the compat-util header knows a=
bout
> them.

Ok, so I suggest the following simple guiding principles:

- git-compat-util.h or cache.h or builtin.h should always be the first=20
#include in C files,

- header files should include other incude files if and only if the oth=
er=20
includes are needed to compile them,

- a header file should be included in a C file only if it is needed to=20
compile the C file (it is not ok to include it only because it includes=
=20
many other headers that are needed)

- other than the above rules, it is ok to reduce the number of includes=
 as=20
much as possible

What do you think?

By the way, Nathaniel, you should try to give more meaningful titles to=
 the=20
individual patches in your patch series and perhaps make them smaller s=
o=20
that they are easier to review and have less conflicts with other patch=
es.

=46or example your patch "[PATCH 1/5] Header includes cleanup" could be=
=20
splitted and the resulting patches could be renamed like this

"delete includes of 'git-compat-util.h' where 'builtin.h' is included"
"delete includes of 'cache.h' where 'builtin.h' is included"
"delete includes of 'strbuf.h' where 'builtin.h' is included"
"delete includes of 'commit.h' where 'builtin.h' is included"

Or perhaps Junio would prefer that you work on a C file by C file basis=
?=20
Like for example:

"delete useless includes in 'builtin-diff-files.c'"
"delete useless includes in 'builtin-diff-index.c'"
=2E..

Thanks,
Christian.
