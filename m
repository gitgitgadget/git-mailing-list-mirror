From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: test applying criss-cross rename patch
Date: Tue, 21 Apr 2009 00:08:01 -0700
Message-ID: <7viqkya3hq.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.2.00.0904091147290.4583@localhost.localdomain>
 <1239463584-1427-1-git-send-email-michal.kiedrowicz@gmail.com>
 <81b0412b0904200711p66ea2500s7cc5894aba71f641@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 09:09:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwA73-000555-0F
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 09:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbZDUHIO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Apr 2009 03:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbZDUHIO
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 03:08:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42856 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbZDUHIO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Apr 2009 03:08:14 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AB159ACD6C;
	Tue, 21 Apr 2009 03:08:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4F51FACD6A; Tue,
 21 Apr 2009 03:08:07 -0400 (EDT)
In-Reply-To: <81b0412b0904200711p66ea2500s7cc5894aba71f641@mail.gmail.com>
 (Alex Riesen's message of "Mon, 20 Apr 2009 16:11:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2D61ECBA-2E43-11DE-8E85-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117098>

Alex Riesen <raa.lkml@gmail.com> writes:

> 2009/4/11 Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>:
>> +test_expect_success 'criss-cross rename' '
>> + =C2=A0 =C2=A0 =C2=A0 mv file1 tmp &&
>> + =C2=A0 =C2=A0 =C2=A0 mv file2 file1 &&
>> + =C2=A0 =C2=A0 =C2=A0 mv tmp file2
>> +'
>> +
>> +test_expect_success 'diff -M -B' '
>> + =C2=A0 =C2=A0 =C2=A0 git diff -M -B > diff &&
>> + =C2=A0 =C2=A0 =C2=A0 git reset --hard
>> +
>> +'
>
> This cannot work on systems where ctime is not trusted:
> git diff will produce no data, as there are no changes in
> metadata (the files are of the same size). Either make
> the file sizes different or add a "touch file1 file2".

You seem to be saying that we still have a racy-git bug somewhere.  Is
your statement from an actual experience or a speculation?  If the form=
er
we have a bug to kill, not a workaround to avoid the issue in this test=
=2E

>
> diff --git a/t/t4130-apply-criss-cross-rename.sh
> b/t/t4130-apply-criss-cross-rename.sh
> index 8623dbe..1ff049a 100755
> --- a/t/t4130-apply-criss-cross-rename.sh
> +++ b/t/t4130-apply-criss-cross-rename.sh
> @@ -14,7 +14,7 @@ create_file() {
>
>  test_expect_success 'setup' '
>  	create_file file1 "File1 contents" &&
> -	create_file file2 "File2 contents" &&
> +	create_file file2 "Contents of File2" &&
>  	git add file1 file2 &&
>  	git commit -m 1
>  '
