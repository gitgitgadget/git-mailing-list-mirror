From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-apply: keep information about files to be
 deleted
Date: Mon, 13 Apr 2009 14:30:02 -0700
Message-ID: <7v1vrwdyxx.fsf@gitster.siamese.dyndns.org>
References: <1239478260-7420-1-git-send-email-michal.kiedrowicz@gmail.com>
 <7v4owsfktw.fsf@gitster.siamese.dyndns.org>
 <20090413230351.7cbb01f5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 23:32:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtTkm-0005ug-Dx
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 23:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753028AbZDMVaL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Apr 2009 17:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753157AbZDMVaK
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 17:30:10 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47737 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028AbZDMVaI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Apr 2009 17:30:08 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2DD0CEFE2;
	Mon, 13 Apr 2009 17:30:07 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 899C8EFE1; Mon,
 13 Apr 2009 17:30:04 -0400 (EDT)
In-Reply-To: <20090413230351.7cbb01f5@gmail.com> (=?utf-8?Q?Micha=C5=82?=
 Kiedrowicz's message of "Mon, 13 Apr 2009 23:03:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 42527B0C-2872-11DE-BD9D-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116489>

Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> But if you have further patches that do the following (the "file
>> table" mechanism was added to handle concatenated patches that affec=
t
>> the same path more than once), I thing PATH_TO_BE_DELETED logic woul=
d
>> break down:
>>=20
>>      patch #3	renames alpha.c to hello.c
>> 	patch #4	renames hello.c to alpha.c
>>=20
>> When patch #3 is handled, the PATH_TO_BE_DELETED mark is long gone
>> from hello.c, and we will see the same failure you addressed in your
>> patch, won't we?
>
> As far as I understand the code, diffs are applied independently
> (for every file apply_patch() is called) and for every apply_patch()
> call fn_table is cleared. So situation you described in only possible
> in a *single* diff and I don't think it is possible to happen.=20

Yes, one invocation of "git format-patch -1" will not produce such a
situation.

A single diff file that is concatenation of two "git format-patch -1"
output (or just a plain-old "diff -ru" output from outside git, perhaps
managed in quilt) was what introduced fn_table mechanism.  Apparently
people use "git apply" to apply such a patch.
