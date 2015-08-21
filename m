From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] format_config: simplify buffer handling
Date: Fri, 21 Aug 2015 10:43:58 -0700
Message-ID: <xmqqr3mw5yg1.fsf@gitster.dls.corp.google.com>
References: <20150820144504.GA22935@sigill.intra.peff.net>
	<20150820144733.GB11913@sigill.intra.peff.net>
	<xmqqvbc85yi3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 21 19:44:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSqMH-0003xj-6e
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 19:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419AbbHURoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 13:44:00 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34706 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121AbbHURoA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 13:44:00 -0400
Received: by padfo6 with SMTP id fo6so11647655pad.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 10:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ljcgPqvs0bf82yw8ovsuiQ3mExxlM8pdzDK4xRPBKcc=;
        b=xeQpwgPoIT9xMQQ27OGgGcJsrXg7NDDdh+228zvlRmR48cp9q7IBjj0QeTneDB9ANs
         FZS7YL8Z3WMfoLN1xqyOsqGBBoolNbRfPPy6zVQtr6JIGvElO6BnEpkwxzG98JDzy0rl
         DWuIvp1b+4M7zrH3tGwjiCyeAY8Jkm6rDn9gri5pMfF7e7im0lN9+xVdsT8UBigAsox4
         7+phir36082SxKFmRRxW6XSqBXmQHOvNn9T8z0KZA0jeykgyRpgTExzuVxNYIefOMH5n
         wBeIGVgyeZQErSBb+TRqkmbXlZzNQwuhhIK5gdAqRBZol3XlwOX/m0mg4hiuyUSTG5NW
         T0aQ==
X-Received: by 10.66.100.168 with SMTP id ez8mr19111573pab.142.1440179039494;
        Fri, 21 Aug 2015 10:43:59 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4c7d:6904:6af7:82e1])
        by smtp.gmail.com with ESMTPSA id r9sm8538993pdp.5.2015.08.21.10.43.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 21 Aug 2015 10:43:58 -0700 (PDT)
In-Reply-To: <xmqqvbc85yi3.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 21 Aug 2015 10:42:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276317>

Junio C Hamano <gitster@pobox.com> writes:

> I wonder if we can do this instead
>
> 	if (!omit_values) {
> -		if (show_keys)
> +		if (show_keys && value_)
> 			strbuf_addch(buf, key_delim);
>
> though.  That would eliminate the need for rolling back.

No we cannot.  "config --bool --get-regexp" could get a NULL value_
and has to turn it to " true".

Sorry for the noise.
