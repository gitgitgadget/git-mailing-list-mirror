From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2] t4018: introduce test cases for the internal hunk header patterns
Date: Tue, 20 Dec 2011 00:25:57 -0800 (PST)
Message-ID: <m3pqfjfy42.fsf@localhost.localdomain>
References: <7vmxaokv6k.fsf@alter.siamese.dyndns.org>
	<1324348939-27115-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, peff@peff.net,
	j6t@kdbg.org, jrnieder@gmail.com, trast@student.ethz.ch
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 20 09:26:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rcv1S-0002U5-4r
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 09:26:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752276Ab1LTI0B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Dec 2011 03:26:01 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:59494 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914Ab1LTI0A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Dec 2011 03:26:00 -0500
Received: by eekc4 with SMTP id c4so6256590eek.19
        for <git@vger.kernel.org>; Tue, 20 Dec 2011 00:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=MyV4NyUEHJJepfGMlDapPCAbSdrC3/aktdrW5hHcE0A=;
        b=Ahlyo9v1AlSJacDrJaa7amIaXHMcOwlHEX3IQ8NnBEIJi2mtRyS/LVz0JDvtnAWotm
         T9xtx6Y2H4n+FWNllZyk7kPLiJbJ4FHCUJ5UTLctEd4Igt3DfSEyFOcQxyS46m8BZyAL
         AVhLRR39AYSSxXNCFQyEwfHwtHR/6zaDtIuts=
Received: by 10.213.10.143 with SMTP id p15mr304545ebp.95.1324369558885;
        Tue, 20 Dec 2011 00:25:58 -0800 (PST)
Received: from localhost.localdomain (abwl116.neoplus.adsl.tpnet.pl. [83.8.235.116])
        by mx.google.com with ESMTPS id 13sm3939665eeu.1.2011.12.20.00.25.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 20 Dec 2011 00:25:57 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pBK8Pqs1024478;
	Tue, 20 Dec 2011 09:25:53 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pBK8Potw024475;
	Tue, 20 Dec 2011 09:25:50 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1324348939-27115-1-git-send-email-drafnel@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187502>

Brandon Casey <drafnel@gmail.com> writes:

> diff --git a/t/t4018/ignore_global.cpp b/t/t4018/ignore_global.cpp
> new file mode 100644
> index 0000000..95e23bc
> --- /dev/null
> +++ b/t/t4018/ignore_global.cpp
> @@ -0,0 +1,19 @@
> +int WRONG_function_hunk_header_preceding_the_right_one (void)
> +{
> +	return 0;
> +}
> +
> +int RIGHT_function_hunk_header (void)
> +{
> +	printf("Hello, world\n");
> +	return 0;
> +}
> +
> +int WRONG_global_variable;
> +
> +int ChangeMe;
> +
> +int WRONG_function_hunk_header_following_the_right_one (void)
> +{
> +	return 0;
> +}

Shouldn't ChangeMe be inside function?

> diff --git a/t/t4018/simple.cpp b/t/t4018/simple.cpp
> new file mode 100644
> index 0000000..c96ad87
> --- /dev/null
> +++ b/t/t4018/simple.cpp
> @@ -0,0 +1,32 @@
> +/*
> + *  Test file for testing the internal hunk header patterns
> + *
> + *  The "RIGHT" hunk header function, the one that should appear on =
the
> + *  hunk header line, should be named "RIGHT_function_hunk_header" a=
nd
> + *  the body of this function should have an assignment that looks l=
ike
> + *
> + *     answer =3D 0

Shouldn't it be ChangeMe?

> + *
> + *  within it, deep enough so the lines of context do not include th=
e
> + *  function name.
> + *
> + *  If the name of this file begins with "broken_", then it will be
> + *  interpreted as a pattern which does not work, but which should.
> + */

--=20
Jakub Nar=C3=AAbski
