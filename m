From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] t: Add test for cloning from ref namespace
Date: Fri, 05 Jun 2015 08:33:38 -0700
Message-ID: <xmqqk2vitbjh.fsf@gitster.dls.corp.google.com>
References: <1433193883-11577-1-git-send-email-johannes@kyriasis.com>
	<1433513531-13423-1-git-send-email-johannes@kyriasis.com>
	<1433513531-13423-3-git-send-email-johannes@kyriasis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes =?utf-8?Q?L=C3=B6thberg?= <johannes@kyriasis.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 17:34:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0tcw-0006xr-MR
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 17:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754935AbbFEPdm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2015 11:33:42 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:33701 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692AbbFEPdl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 11:33:41 -0400
Received: by iebgx4 with SMTP id gx4so60210798ieb.0
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 08:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=14dtmFdCzhAEnr8Kray+BtBzLQf3aLDXGn6kdPFzco0=;
        b=QHSXvDrTsCisRk+FOvlt9AOLE7coJSevrvP9j0G7PjRznqabxLd1vxIBZEgPIubuwF
         3iJM9oYmYv2tyk4uiGW0QPDI3b0PfwTyy3PUy5IeEwoampp0T97swT2tV3rwsK6/9RI+
         DcscTVSAu46Y5H3scx+XZn1grNoBjDJsynBHV15CqusqFUlagmdm1fAhbP7iKqjIu2GC
         44G4vg/SXdPHM70td1HQBgi1T0N41vAOH7At+kEMF7/vxXRXwdQiRNNsQPL6+3B2ZIVS
         IjztIxxK8KXMVmnHrFO8t0OJZzQvazmw+9AuE1kVpEtCX2kwu8Cm0Cq17NjY0uZeKZFT
         N92g==
X-Received: by 10.107.12.27 with SMTP id w27mr5362231ioi.10.1433518420796;
        Fri, 05 Jun 2015 08:33:40 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:8c50:e66f:fc40:1825])
        by mx.google.com with ESMTPSA id eg3sm3405637igb.0.2015.06.05.08.33.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jun 2015 08:33:39 -0700 (PDT)
In-Reply-To: <1433513531-13423-3-git-send-email-johannes@kyriasis.com>
	("Johannes =?utf-8?Q?L=C3=B6thberg=22's?= message of "Fri, 5 Jun 2015
 16:12:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270841>

Johannes L=C3=B6thberg <johannes@kyriasis.com> writes:

> Test that the master ref is set up properly when cloning from a ref
> namespace
>
> Signed-off-by: Johannes L=C3=B6thberg <johannes@kyriasis.com>
> ---
>  t/t9904-clone-from-ref-namespace.sh | 33 +++++++++++++++++++++++++++=
++++++

It seems that 5509 already has a few tests for namespaced transfer
in both directions.  Perhaps this new test would fit there better?

Also I think it probably is better to have these as a single patch.

> diff --git a/t/t9904-clone-from-ref-namespace.sh b/t/t9904-clone-from=
-ref-namespace.sh
> new file mode 100755
> index 0000000..60977f8
> --- /dev/null
> +++ b/t/t9904-clone-from-ref-namespace.sh
> @@ -0,0 +1,33 @@
> +#!/bin/sh
> +#
> +
> +test_description=3D'git clone from ref namespace
> +
> +This test checks that cloning from a ref namespace works'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'clone from ref namespace' '
> +	rm -rf initial bare clone &&
> +	git init initial &&
> +	git init --bare bare &&
> +	(
> +		cd initial &&
> +		echo "commit one" >> file &&

minor style: drop SP between redirection and its target, i.e.

		echo "commit one" >file &&

> +		git add file &&
> +		git commit -m "commit one" &&
> +		git push ../bare master &&

You want to make sure not just "push" does not complain, but that it
left ../bare with the right result, i.e. something along the lines
of

		git -C ../bare symbolic-ref HEAD >actual &&
		echo refs/heads/master >expect &&
                test_cmp expect actual &&

		git -C ../bare rev-parse HEAD >actual &&
                git rev-parse HEAD >expect &&
                test_cmp expect actual &&


> +		echo "commit two" >> file &&

Likewise on style.

> +		git add file &&
> +		git commit -m "commit two"

Broken &&-chain.

> +		GIT_NAMESPACE=3Dnew_namespace git push ../bare master

Likewise on checking the result of the push.

> +	) &&
> +	GIT_NAMESPACE=3Dnew_namespace git clone bare clone &&
> +	(
> +		cd clone &&
> +		git show

Likewise on checking the result of the clone; not just it has HEAD
to cause "show" to succeed, you would want it shows the right commit
(i.e. not "one", but "two").  There may be other things you may want
to check, too.

> +	)
> +'
> +
> +test_done
