From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] sha1_file: do not add own object directory as alternate
Date: Tue, 15 Jul 2014 07:44:39 +0200
Message-ID: <53C4BFC7.2000507@kdbg.org>
References: <53BFB055.206@gmail.com> <xmqqy4vz51gb.fsf@gitster.dls.corp.google.com> <53C26309.5040401@gmail.com> <53C39CB0.6040909@gmail.com> <CACsJy8B-QFu4SU6HHZukAmmjLrgb+L8KsHPn3GgQhcX6-LGXLg@mail.gmail.com> <53C3D2AD.9050204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Ephrim Khong <dr.khong@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 15 07:44:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6vXl-0004xM-Ck
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jul 2014 07:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757676AbaGOFop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 01:44:45 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:22269 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757665AbaGOFoo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 01:44:44 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id F2ED010020;
	Tue, 15 Jul 2014 07:44:40 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id ED26119F3F1;
	Tue, 15 Jul 2014 07:44:39 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53C3D2AD.9050204@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253548>

Am 14.07.2014 14:53, schrieb Ephrim Khong:
> diff --git a/t/t7702-repack-cyclic-alternate.sh b/t/t7702-repack-cyclic-alternate.sh
> new file mode 100755
> index 0000000..3771613
> --- /dev/null
> +++ b/t/t7702-repack-cyclic-alternate.sh
> @@ -0,0 +1,24 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2014 Ephrim Khong
> +#
> +
> +test_description='repack involving cyclic alternate'
> +. ./test-lib.sh
> +
> +test_expect_success setup '
> +	GIT_OBJECT_DIRECTORY=.git//../.git/objects &&
> +	export GIT_OBJECT_DIRECTORY &&
> +	touch a &&
> +	git add a &&
> +	git commit -m 1 &&
> +	git repack -adl &&
> +	echo $PWD/.git/objects/../objects > .git/objects/info/alternates

We need a Windows-style path in the file, double-quotes to protect
special characters, and a small style fix. Therefore:

	echo "$(pwd)"/.git/objects/../objects >.git/objects/info/alternates

> +'
> +
> +test_expect_success 're-packing repository with itsself as alternate' '
> +	git repack -adl &&
> +	git fsck
> +'
> +
> +test_done
> 
