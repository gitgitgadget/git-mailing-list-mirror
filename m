From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: What's cooking in git.git (Dec 2008, #04; Mon, 29)
Date: Sat, 3 Jan 2009 06:40:36 +0100
Message-ID: <200901030640.36426.chriscool@tuxfamily.org>
References: <7vocyt1is2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 03 07:11:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIzjC-0006tf-I1
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 07:11:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbZACGJF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Jan 2009 01:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbZACGJE
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jan 2009 01:09:04 -0500
Received: from postfix2-g20.free.fr ([212.27.60.43]:60669 "EHLO
	postfix2-g20.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbZACGJD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jan 2009 01:09:03 -0500
X-Greylist: delayed 1692 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Jan 2009 01:09:02 EST
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by postfix2-g20.free.fr (Postfix) with ESMTP id D64252E82EA7
	for <git@vger.kernel.org>; Sat,  3 Jan 2009 04:40:34 +0100 (CET)
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id C99934B0028;
	Sat,  3 Jan 2009 06:39:34 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g21.free.fr (Postfix) with ESMTP id B30144B003B;
	Sat,  3 Jan 2009 06:39:31 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7vocyt1is2.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104455>

Le mardi 30 d=E9cembre 2008, Junio C Hamano a =E9crit :
>
> * cc/bisect-replace (Mon Nov 24 22:20:30 2008 +0100) 9 commits
>  - bisect: add "--no-replace" option to bisect without using replace
>    refs
>  - rev-list: make it possible to disable replacing using "--no-
>    bisect-replace"
>  - bisect: use "--bisect-replace" options when checking merge bases
>  - merge-base: add "--bisect-replace" option to use fixed up revs
>  - commit: add "bisect_replace_all" prototype to "commit.h"
>  - rev-list: add "--bisect-replace" to list revisions with fixed up
>    history
>  - Documentation: add "git bisect replace" documentation
>  - bisect: add test cases for "git bisect replace"
>  - bisect: add "git bisect replace" subcommand
>
> I think a mechanism like this should be added to replace grafts,=20

The problem with replacing grafts is that a graft can specify many pare=
nts=20
for one commit while a ref associates only one object to a name.

One way to overcome this could be to use many refs for each graft, for=20
example (in the packed ref format):

<1st parent sha1> refs/replace/grafts/<commit sha1>-<1st parent sha1>
<2nd parent sha1> refs/replace/grafts/<commit sha1>-<2nd parent sha1>
=2E..

Another way would be to put all the parents in the ref name, for exampl=
e:

<1st parent sha1> /refs/replace/grafts/<commit sha1>-<1st parent sha1>-=
<2nd=20
parent sha1>-<3rd parent sha1>

There is the same kind of problem to mark many "good" (and "skip") comm=
its=20
when bisecting and we use something like the first solution above:

<1st good commit sha1> refs/bisect/good-<1st good commit sha1>
<2nd good commit sha1> refs/bisect/good-<2nd good commit sha1>
=2E..

But I think the above solutions are not very clean and it might be bett=
er in=20
the long run to make it possible to associate more than one object to a=
=20
ref.

Am I missing something? Do you see another way?

Thanks and happy new year everybody,
Christian.
