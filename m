From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: test applying criss-cross rename patch
Date: Mon, 13 Apr 2009 09:47:19 -0700
Message-ID: <7vd4bgh560.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.2.00.0904091147290.4583@localhost.localdomain>
 <1239463584-1427-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 18:50:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtPLB-0007TA-Uy
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 18:49:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104AbZDMQr3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Apr 2009 12:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752059AbZDMQr2
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 12:47:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44313 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987AbZDMQr2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Apr 2009 12:47:28 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5B1B0A97F1;
	Mon, 13 Apr 2009 12:47:25 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 06316A97F0; Mon,
 13 Apr 2009 12:47:21 -0400 (EDT)
In-Reply-To: <1239463584-1427-1-git-send-email-michal.kiedrowicz@gmail.com>
 (=?utf-8?Q?Micha=C5=82?= Kiedrowicz's message of "Sat, 11 Apr 2009 17:26:24
 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C4484A1A-284A-11DE-8949-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116450>

Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:

> Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
> ---
>  t/t4130-apply-criss-cross-rename.sh |   35 +++++++++++++++++++++++++=
++++++++++
>  1 files changed, 35 insertions(+), 0 deletions(-)
>  create mode 100755 t/t4130-apply-criss-cross-rename.sh
>
> diff --git a/t/t4130-apply-criss-cross-rename.sh b/t/t4130-apply-cris=
s-cross-rename.sh
> new file mode 100755
> index 0000000..30187ff
> --- /dev/null
> +++ b/t/t4130-apply-criss-cross-rename.sh
> @@ -0,0 +1,35 @@
> +#!/bin/sh
> +
> +test_description=3D'git apply handling criss-cross rename patch.'
> +. ./test-lib.sh
> +
> +create_file() {
> +	for ((i=3D0; i<100; i++)); do

Please don't; isn't this a bashism?

> +		echo "$2" >> "$1"
> +	done
> +}
> +
> +test_expect_success 'setup' '
> +	create_file file1 "File1 contents" &&
> +	create_file file2 "File2 contents" &&
> +	git add file1 file2 &&
> +	git commit -m 1
> +'
> +
> +test_expect_success 'criss-cross rename' '
> +	mv file1 tmp &&
> +	mv file2 file1 &&
> +	mv tmp file2
> +'
> +
> +test_expect_success 'diff -M -B' '
> +	git diff -M -B > diff &&
> +	git reset --hard
> +
> +'
> +
> +test_expect_failure 'apply' '
> +	git apply diff
> +'
> +
> +test_done
> --=20
> 1.6.0.6
