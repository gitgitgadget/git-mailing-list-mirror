From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 2/2] mergetools: add winmerge as a builtin tool
Date: Wed, 20 May 2015 13:13:15 -0700
Message-ID: <xmqqtwv7m2hw.fsf@gitster.dls.corp.google.com>
References: <1432112843-973-1-git-send-email-davvid@gmail.com>
	<1432112843-973-2-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Phil Susi <phillsusi@gmail.com>, git@vger.kernel.org,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 20 22:13:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvAMl-00059o-Hd
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 22:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753817AbbETUNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 16:13:19 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:33643 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882AbbETUNS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 16:13:18 -0400
Received: by iebgx4 with SMTP id gx4so48037145ieb.0
        for <git@vger.kernel.org>; Wed, 20 May 2015 13:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=xv2YOMBLobh1/CATUS2XQYIBtBljVsq0qpyUXoB6M6w=;
        b=XBBHiaQEEyo7KU/ude6qdF2FNtXzPsxxvWfcpai2ooPCjtmLCS3IgoQofCu4ou2Sq+
         rFbbB1dU8ZMKbmF1SDu4Y08Pv3bDFE09+TcNiR4EhZQTcgT8irf2x2WnWXIDy562LoQX
         fHB6PN2UQHSmPp83To1bkMxaW5ZrutAvpJ0dZF09bHUS4mc1t/QeG6W47PVnhwo+11AU
         wztSwvrd4vHVSMRlfHLE9nPdxgSFABljlUitKewE3PZWLiio9gSmtOMUPK/W26jY6BGV
         BZjVWhGcQrfsWnCicXm1ERddCUccA5Ne+4TNb8HtLBN5uE+WN6zFGKl/FnbRM2PXUmqx
         uzhw==
X-Received: by 10.43.152.204 with SMTP id kx12mr25775682icc.51.1432152797498;
        Wed, 20 May 2015 13:13:17 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6ddd:2b37:d23b:a593])
        by mx.google.com with ESMTPSA id g12sm13114729ioe.28.2015.05.20.13.13.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 20 May 2015 13:13:16 -0700 (PDT)
In-Reply-To: <1432112843-973-2-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Wed, 20 May 2015 02:07:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269514>

David Aguilar <davvid@gmail.com> writes:

> +	for directory in $(env | grep -Ei '^PROGRAM(FILES(\(X86\))?|W6432)=' |
> +		cut -d '=' -f 2- | sort -u)

Is the final "sort" really desired?  I am wondering if there are
fixed precedence/preference order among variants of %PROGRAMFILES% 
environment variables that the users on the platform are expected
to stick to, but the "sort" is sorting by the absolute pathnames of
where these things are, which may not reflect that order.

Not that I personally care too deeply, as I would expect that it is
likely any one of them found would just work fine ;-)

> +	do
> +		if test -n "$directory" && test -x "$directory/$winmerge_exe"
> +		then
> +			printf '%s' "$directory/$winmerge_exe"
> +			return
> +		fi
> +	done
> +
> +	printf WinMergeU.exe
> +}
