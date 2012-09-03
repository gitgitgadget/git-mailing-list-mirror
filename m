From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch: align new ref summary printout in UTF-8 locales
Date: Mon, 03 Sep 2012 13:30:28 -0700
Message-ID: <7vk3waetnf.fsf@alter.siamese.dyndns.org>
References: <1346670609-19986-1-git-send-email-pclouds@gmail.com>
 <7vwr0aewlf.fsf@alter.siamese.dyndns.org> <50450C8D.7010301@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Sep 03 22:30:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8dI7-0003iz-85
	for gcvg-git-2@plane.gmane.org; Mon, 03 Sep 2012 22:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098Ab2ICUac convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Sep 2012 16:30:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39766 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751578Ab2ICUab convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Sep 2012 16:30:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B88949E93;
	Mon,  3 Sep 2012 16:30:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=O5ldte2Le+Vo
	/nQUDhVrHiUvmWs=; b=gOLJubtE+NnUFTvtZS1oWE8Vkaa3fPrIxZG7U1YdMowx
	My1FVjsn/AHdvN5ifbOTGCaZtrn143xA+jfAwjwhXOlZpz8e+uMLnBmswmI9Oflo
	FZwpSyGag2KkrJK2JM4ipGLav+lsI0O2erlNEpFH3p7Fi7MjvrtAC4uTz9a4NDM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=LMbin9
	/uUhOYeXqYED7aXN5tSU4XDeZVUiA6P9gHLLZkY3L4/oLFeP02vFPUU8GE3kqFVq
	QWJwCCTk1tQdMyityDMLITnaG282NyxRxyFE4VL+Pz6ojnB/QTDXc9+B7bqSEl+2
	bzaqX4uakjCdLajFtzVKT0rw0Fsx9GcVxo7zg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A71819E92;
	Mon,  3 Sep 2012 16:30:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 01F729E91; Mon,  3 Sep 2012
 16:30:29 -0400 (EDT)
In-Reply-To: <50450C8D.7010301@kdbg.org> (Johannes Sixt's message of "Mon, 03
 Sep 2012 22:01:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 33FB369C-F606-11E1-95FF-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204711>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 03.09.2012 21:26, schrieb Junio C Hamano:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> write=
s:
>>=20
>>> fetch does printf("%-*s", width, "foo") where "foo" can be an utf-8
>>> string, but width is bytes, not letters. This results in misaligned
>>> ref summary table.
>>=20
>> "but width is bytes, not letters" is a misleading statement.
>>=20
>> Be careful about three different quantities when talking about
>> aligning on terminal output with monospaced fonts:
>>=20
>>  - How many bytes does the string occupy in memory?
>>  - How many unicode codepoints are in the string?
>>  - How many display columns does the string occupy on terminal?
>>=20
>> Note that some "letters" (e.g. Han) occupy two display columns, and
>> you want to measure the "width" and compensate that for "bytes".
>> Letter count do not come into the picture for the purpose of alignin=
g
>> the terminal output.
>
> If I'm reading POSIX correctly, printf measures the width in %*s in b=
ytes.

Yes, that is the problem.

When we give allocated_width columns to display str, and call

        printf("%.*s", allocated_width, str)

we end up getting (allocated_width - strlen(str)) SPs as filler.  If
the str occupies less than strlen(str) columns (and it often is the
case for a string with non-ascii characters), insufficient number of
filler SPs will be given, and an item on the same line that comes
after this printf() will appear too close to str.  By measuring the
required number of columns to display str, you can compensate. i.e.

        printf("%.*s", allocated_width +
                (strlen(str) - display_width(str)), str)

to give it enough filler.

I think the patch uses utf8_strwidth() which measures the display
columns needed for the string, not number of unicode codepoints in
the string.  I was merely pointing out that the wording of the
proposed log message "bytes, not letters" and the function name
"foo_length" was misleading, when we mean "width".
