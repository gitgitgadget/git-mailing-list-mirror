From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 1.8.3 - gitignore not being parsed correctly on OS X; regex support is broken?
Date: Tue, 28 May 2013 14:59:57 -0700
Message-ID: <7vhahmydcy.fsf@alter.siamese.dyndns.org>
References: <CAGLuM14_MQffwQWrB2YCQXzhkGaxdaYBuY74y7=pfb-hB6LskA@mail.gmail.com>
	<loom.20130528T232459-307@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
To: Karsten Blees <karsten.blees@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 00:00:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhRwC-000218-Nd
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 00:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758833Ab3E1WAF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 May 2013 18:00:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53422 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758274Ab3E1WAA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 May 2013 18:00:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DEB8723E75;
	Tue, 28 May 2013 21:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+Wtbkol0EVC7
	fPda3TJm6B21aa4=; b=JsLmZenyGCwRCnBc6SBj0PgpsfB1Yn6xwmUsaql5Ybw5
	06gZ2V0bCIG6GBFE1NEBDQEXqnub73gb2Pog+/Ldcw7JrOVE7OwhRTd5izalbZts
	yqe1Gnhihdhjb3nV0LtluDIuCN5AidLqLo+7dVYSomWkqTkBd3VVnUGSsfUmCLI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Z31VkL
	w6Ixu9AhRKuIFHIbGTxfDVbhVejmtyCZ6IMOdMYrKt0FICtaKN/x9bbnD01Mz2e3
	zKEceJsJL8hToU2FdXOw1DB/jRBhd49zcQnoyOkH/qJN64/TMtTjvbDkX5ev5yZg
	O5Q4rd8Ja9ixZglO9zA43K0yrRg74n6ibkG5k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D55B823E74;
	Tue, 28 May 2013 21:59:59 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 30BD823E73;
	Tue, 28 May 2013 21:59:59 +0000 (UTC)
In-Reply-To: <loom.20130528T232459-307@post.gmane.org> (=?utf-8?Q?=22?=
 =?utf-8?Q?=C3=98ystein?= Walle"'s
	message of "Tue, 28 May 2013 21:35:01 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F09074CC-C7E1-11E2-8A38-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225690>

=C3=98ystein Walle <oystwa@gmail.com> writes:

> Misty De Meo <misty <at> brew.sh> writes:
>
>>=20
>> Hi,
>>=20
>> Gitignore parsing no longer seems to work properly in git 1.8.3.
>>=20
>> One of my repositories has the following gitignore:
>>=20
>> /*
>> !/.gitignore
>> !/Library/
>> !/CONTRIBUTING.md
>> !/README.md
>> !/SUPPORTERS.md
>> !/bin
>> /bin/*
>> !/bin/brew
>> !/share/man/man1/brew.1
>> .DS_Store
>> /Library/LinkedKegs
>> /Library/PinnedKegs
>> /Library/Taps
>> /Library/Formula/.gitignore
>>=20
>> In 1.8.2.3 and earlier, this works as expected. However, in 1.8.3 I'=
m
>> seeing every file in /bin/ being marked as an untracked file.
>>=20
>> I asked about this in #git, and was told that the culprit was the
>> regex support; apparently recompiling without regex support fixes th=
e
>> specific gitignore issue. However, this doesn't seem to have been
>> reported anywhere on the mailing list that I can see. I was also tol=
d
>> that the issue is OS X-specific, and doesn't happen on other
>> platforms.
>>=20
>> Thanks,
>> Misty De Meo
>>=20
>
> I see a similar problem using e.g. the following .gitignore to exclud=
e
> everything except C source files and header files:
>
>     *
>     !*/
>     !*.c
>     !*.h
>
> In Git 1.8.3 'git status' will show other files as untracked while in
> Git 1.8.2.3 I don't have that problem. I bisected to find that the
> offending commit is v1.8.2.1-402-g95c6f27.=20
>
> I am not on OSX, however, but on Linux (Ubuntu 12.04 and RHEL 5.8) so
> this may be a separate issue. I've also gotten the impression that th=
is
> is intentional. In any case I cannot create a .gitignore that achieve=
s
> the same for both older and newer versions of Git.

Thanks; 95c6f27 is from Karsten and I think Duy is the most clueful
one in this area in the discussion that had this change; I am
forwarding this message to them.

Cf. http://thread.gmane.org/gmane.comp.version-control.git/218440/focus=
=3D221289
