From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's not in 'master', and likely not to be in, until 1.5.4
Date: Mon, 21 Jan 2008 09:29:12 +0100
Message-ID: <479457D8.3010909@viscovery.net>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>	<7v1w8o4ws0.fsf@gitster.siamese.dyndns.org>	<30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com>	<7v63xzzszp.fsf@gitster.siamese.dyndns.org>	<478855B5.9070600@gmail.com>	<7vbq7ry405.fsf@gitster.siamese.dyndns.org>	<47885B2C.8020809@gmail.com>	<7v7iify2wm.fsf@gitster.siamese.dyndns.org>	<4788BFA8.2030508@gmail.com>	<7vwsqeubj8.fsf@gitster.siamese.dyndns.org>	<47891658.3090604@gmail.com>	<7vbq7qssd7.fsf@gitster.siamese.dyndns.org>	<47893E1A.5020702@gmail.com>	<7v4pdislrf.fsf@gitster.siamese.dyndns.org>	<alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de>	<7vir1xmazm.fsf@gitster.siamese.dyndns.org>	<7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org>	<7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org>	<7vr6gb3
 nv1.fsf@gitster.siamese.dyndns.org>	<alpine.LFD.1.00.0801202114580.2957@woody.linux-foundation.org>	<7vd4rv3ds5.fsf@gitster.siamese.dyndns.org> <7vtzl71x1c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 09:29:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGs2W-0008Kf-H7
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 09:29:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757978AbYAUI3S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jan 2008 03:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757943AbYAUI3S
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 03:29:18 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:19617 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757867AbYAUI3R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 03:29:17 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JGs1g-0004gG-63; Mon, 21 Jan 2008 09:29:04 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2D934A33B; Mon, 21 Jan 2008 09:29:12 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vtzl71x1c.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71240>

Junio C Hamano schrieb:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
>> It's a Heisenbug.  I actually merged it to 'next' but rewound it
>> before pushing the result out after seeing a breakage.
>>
>> "make clean test" to run everything through sometimes fails and
>> immediately after that when I do "cd t && sh t75??-???.sh -i -v"
>> it happily runs through the end.
>>
>> I'll be back with more details when I have some.
>=20
> In t7501-commit.sh, "partial commit that involves removal (1)"
> test, it _sometimes_ fails.
>=20
>     test_expect_success 'partial commit that involves removal (1)' '
>=20
>         git rm --cached file &&
>         mv file elif &&
>         git add elif &&
>         git diff-index --name-status HEAD >changes &&
>         git commit -m "Partial: add elif" elif &&
>         git diff-tree --name-status HEAD^ HEAD >current &&
>         echo "A     elif" >expected &&
>         diff expected current
>=20
>     '
>=20
> It removes "file" from the index, adds "elif" to the index, and
> tries to commit _only_ the addition of "elif" without recording
> the removal of "file" (I added "diff-index" above to see where
> it fails, its presense or absense does not change the bug, and
> it shows that both addition of elif and removal of file are in
> the index).
>=20
> When the test fails, the resulting commit however does not
> record the addition of elif.  The commit records the same tree
> as its parent instead.  The index that is left has "elif" but
> not "file" (iow, it records the expected state after such a
> partial commit).

D=E9j=E0-vu! We had similar problems on Windows. I was able to solve it=
 this
way when git-commit was still a shell script:

 save_index () {
-	cp -p "$THIS_INDEX" "$NEXT_INDEX"
+	ln "$THIS_INDEX" "$NEXT_INDEX"
 }

because 'cp -p' does not keep the precise timestamp, but 'ln' does (whi=
ch
creates hardlinks on NTFS). This violated the assumptions on which the
racy-git check relies.

-- Hannes
