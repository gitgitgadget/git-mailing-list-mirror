From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git commit --interactive creates empty commits
Date: Mon, 14 Apr 2008 00:01:45 -0700
Message-ID: <7vk5j0apie.fsf@gitster.siamese.dyndns.org>
References: <slrng059n3.nd8.joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Mon Apr 14 09:02:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlIi8-0007DT-Kz
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 09:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755303AbYDNHB5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Apr 2008 03:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755068AbYDNHB5
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 03:01:57 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37128 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755232AbYDNHB4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2008 03:01:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4FE6337FC;
	Mon, 14 Apr 2008 03:01:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B3F7937F6; Mon, 14 Apr 2008 03:01:52 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79472>

J=C3=B6rg Sommer <joerg@alea.gnuu.de> writes:

> is it expected that this test fails?

I think you spotted a bug ;-)  -i should only affect the way how you bu=
ild
the index.  Unless the user does not ask for --allow-empty this should =
be
prevented, I think.

> diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
> index c0288f3..2c21428 100755
> --- a/t/t7501-commit.sh
> +++ b/t/t7501-commit.sh
> @@ -123,6 +123,18 @@ test_expect_success \
>  	"interactive add" \
>  	"echo 7 | git-commit --interactive | grep 'What now'"
> =20
> +cat >editor <<\EOF
> +#!/bin/sh
> +echo invalid commit > $1
> +EOF
> +chmod 755 editor
> +
> +test_expect_success \
> +	"interactive fails on empty index" \
> +	"export VISUAL=3D./editor &&=20
> +	test_must_fail git commit --interactive < /dev/null &&
> +	unset VISUAL"
> +
