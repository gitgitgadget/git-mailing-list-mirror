From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: am fails to apply patches for files with CRLF lineendings
Date: Mon, 14 Dec 2009 16:56:58 -0600
Message-ID: <tCQlJn153g8Oa6Z9HKe6xOUQJdcf2PCIVthlTrLgYE-wJ5jFyXVXWw@cipher.nrlssc.navy.mil>
References: <20091214183337.GA25462@atjola.homenet> <7vvdg9i9mn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?QmrDtnJuIFN0ZWluYnJpbms=?= <B.Steinbrink@gmx.de>,
	jk@silentcow.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 23:57:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKJqv-0003tW-54
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 23:57:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758594AbZLNW5L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 17:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757889AbZLNW5K
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 17:57:10 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:34651 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757803AbZLNW5I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 17:57:08 -0500
Received: by mail.nrlssc.navy.mil id nBEMuxXO017270; Mon, 14 Dec 2009 16:56:59 -0600
In-Reply-To: <7vvdg9i9mn.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 14 Dec 2009 22:56:59.0517 (UTC) FILETIME=[BE1052D0:01CA7D10]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135251>

Junio C Hamano wrote:
> Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:
>=20
>> Commit c2ca1d7 "Allow mailsplit ... to handle mails with CRLF line-e=
ndings"
>> seems to be responsible.
>=20
> Yes, that commit is not only responsible but was deliberate.  For a b=
etter
> backstory, see:
>=20
>   http://thread.gmane.org/gmane.comp.version-control.git/124718/focus=
=3D124721
>=20
> You'd notice that I was one of the people who didn't want to have thi=
s
> change, so you don't need to convince _me_ that this was not a change=
 to
> keep everybody happy, but you'd need to try a better job than I did b=
ack
> then to convince people who thought that "am" should directly work on
> "Thunderbird saved mails" that what they want was a bad idea X-<.

My understanding of the problem is that rfc2822 dictates that CRLF is t=
he
line ending in an email message for _every_ line, and that CR cannot
occur without LF and vice versa.  So there is no reliable way to extrac=
t
patches from the body of an email and expect line endings to be conveye=
d
accurately.  Some email clients save emails with the line-endings of th=
e
platform, some save in what they call "raw" format with rfc2822's CRLF
line endings.  So we have to _assume_ that the patch extracted from the
email has a particular line ending and make-it-so.  For better or worse
(better for me), commit c2ca1d7 chose LF line-endings as the line-endin=
g
of choice.

I agree that git-am should be able to apply everything that
git-format-patch produces.  Perhaps the diff machinery should be modifi=
ed
to treat files containing \r as binary when generating the output for
format-patch.  Then we'd get a binary diff in the email.

-brandon
