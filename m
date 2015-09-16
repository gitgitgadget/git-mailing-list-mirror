From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 15/67] convert trivial sprintf / strcpy calls to xsnprintf
Date: Tue, 15 Sep 2015 18:34:12 -0700
Message-ID: <xmqqd1xjtaej.fsf@gitster.mtv.corp.google.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915153637.GO29753@sigill.intra.peff.net>
	<55F8643D.6040800@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 03:34:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zc1c2-0001qs-7p
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 03:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbbIPBeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 21:34:14 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35813 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbbIPBeO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 21:34:14 -0400
Received: by pacfv12 with SMTP id fv12so196217040pac.2
        for <git@vger.kernel.org>; Tue, 15 Sep 2015 18:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=sGInSvdSwhPJAHYZjZsqgnYkSIeF5NC+DaaR/8sp99E=;
        b=Yf8gz6eg2IlRd2J8vt/9kyAF2GSCIj6wBFz3RiU5s2QLOTQ3anzaoHH07kU1fs4Nf7
         qA/hBSAq7C956B8y3pbKVvLt2m0E9NjZJSkqrAezZ4NliSI1pTAt2ZA3dCdZIdNVNJ8o
         CUzo2i5EgypzIyk1OTamY53audhmbil852iI2gmIuy3tlqH8LFiazAZyVmytBimJM7Nh
         se2B4YabPJV03p2kkbpVOsw4NRMHriWzzhjtDi67eJ9diPF4byuR/2IHTQcSDl6yAjyN
         h27uiQokb9v1izT/SbLTg8ZGXTINaTFzTB8njOWVMmEw0S3xhxSxoN2TsipdfGurzvAf
         1D7Q==
X-Received: by 10.68.98.34 with SMTP id ef2mr53515433pbb.45.1442367253606;
        Tue, 15 Sep 2015 18:34:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:150c:7d53:9693:493e])
        by smtp.gmail.com with ESMTPSA id gw3sm24370921pbc.46.2015.09.15.18.34.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 15 Sep 2015 18:34:13 -0700 (PDT)
In-Reply-To: <55F8643D.6040800@ramsayjones.plus.com> (Ramsay Jones's message
	of "Tue, 15 Sep 2015 19:32:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277994>

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> How about using strlcpy() instead? Thus:
>
> -	strcpy(header.name, "pax_global_header");
> +	strlcpy(header.name, "pax_global_header", sizeof(header.name));
>
> Ditto for other similar (strcpy->xsnprintf) hunks below.

Please do not advocate use of strlcpy(), which substitutes
overwriting beyond the end of the buffer (which is a bug) with a
silent truncation (which is almost always another bug, unless in a
very narrow case of producing a non-essential string result where
loss of information does not matter).
