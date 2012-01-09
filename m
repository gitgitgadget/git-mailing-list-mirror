From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH][RFC] git on Mac OS and precomposed unicode
Date: Mon, 09 Jan 2012 17:44:27 +0100
Message-ID: <4F0B196B.8010904@web.de>
References: <201201072059.19103.tboegi@web.de> <7vboqehpxm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 09 17:53:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkITY-0002Rn-PE
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 17:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501Ab2AIQuI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Jan 2012 11:50:08 -0500
Received: from smtp-out11.han.skanova.net ([195.67.226.200]:57616 "EHLO
	smtp-out11.han.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932486Ab2AIQuF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jan 2012 11:50:05 -0500
Received: from birne.lan (194.22.188.61) by smtp-out11.han.skanova.net (8.5.133) (authenticated as tboegi@telia.com)
        id 4EFC3D3500314B9C; Mon, 9 Jan 2012 17:44:27 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <7vboqehpxm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188180>

On 08.01.12 03:46, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> Implementation:
>> Two files are added to the "compat" directory, darwin.h and darwin.c=
=2E
>> They implement basically 3 new functions:
>> darwin_opendir(), darwin_readdir() and darwin_closedir().
>=20
> I haven't looked at the patch yet but that sounds exactly the right w=
ay to
> go about this. Nice.
>=20
>> No decomposed file names in a git repository:
>> In order to prevent that ever a file name in decomposed unicode is e=
ntering
>> the index, a "brute force" attempt is taken:
>> all arguments into git (technically argv[1]..argv[n]) are converted =
into
>> precomposed unicode.
>=20
> That also sounds sensible, but...
>=20
>> This is done in git.c by calling argv_precompose() for all commands
>> except "git commit".
>=20
> ... I think it generally is a bad idea to say "all except foo". There=
 may
> be a reason why "foo" happens to be special in today's code, but who =
says
> there won't be another command "bar" that shares the same reason with
> "foo" to be treated specially? Or depending on the options, perhaps s=
ome
> codepath of "foo" may not want the special casing and want to go thro=
ugh
> the argv_precompose(), no?
>=20
> After all, "git commit -- pathspec" will have to get the pathspec fro=
m the
> command line, and match them against the paths in the index, the latt=
er of
> which you are keeping in the canonical form, so you would want the ar=
gv[]
> also be in the same form, and applying your argv_precompose() would b=
e a
> sensible way to do so, no?

Thanks Junio for catching this.
I added a new test case as well as fixed the code.

> I would also suspect that the cleanest way to implement it is to repl=
ace
> the main() entry point (see how compat/mingw.h does this).

We only need to that argv conversion in git.c, (and not in daemon.c), s=
o I sticked
to the old model for V1.
I send a new patch soon
/Torsten
