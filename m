From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 10/94] builtin/apply: move 'unidiff_zero' global into
 'struct apply_state'
Date: Thu, 12 May 2016 22:18:57 +0200
Message-ID: <CAP8UFD02iZ6fszG-T2xjajyjHwOSXbwtV07n7s2hVW2o-LVusg@mail.gmail.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
	<20160511131745.2914-11-chriscool@tuxfamily.org>
	<xmqq1t57f54n.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 12 22:19:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0x4a-0002lT-Px
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 22:19:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbcELUS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 16:18:59 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35142 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbcELUS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 16:18:59 -0400
Received: by mail-wm0-f67.google.com with SMTP id e201so17888328wme.2
        for <git@vger.kernel.org>; Thu, 12 May 2016 13:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=GswMCRcPZzMK9PDMdifgwZ9b7ixJ+ctD4wZZB0lJmd0=;
        b=bdClKtg5eMsKBvz3ShBpoFnZKUZXWA5nc1SiP5zH+YgB/N2/0VtLeVTLhccjwNFd8s
         gKwzL+/ja/OhoXyQOFKhV/loWFdh6YWA7njsX07+ltRKOSM/TEUtf/9lLXb5WrEcX+Lk
         FqRtVVWvip/XST9t86Oa/bIe9I16wrC82IWCsLTfVj8rHyj7SLPgVs08gV0QRUKfZJTw
         QVB0CyfJY+xnT+KJrBcwbij0wrMW7rbCM7wlfGjdCZdPkV6fd0nsasnONlzFGqwnyxeR
         zaDF5oRqf9yW1TnsEZHiOp5Zs3RkLw+SFHTfxZRyh4lvH2NiEJO5UHAcTmMO6801YTpk
         /2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=GswMCRcPZzMK9PDMdifgwZ9b7ixJ+ctD4wZZB0lJmd0=;
        b=Qss91S3aV4+pBhh8QrKtJQkOQr87D0tvG+NIQzPfciMbcoLJxqEWQJT9qg16XYSMud
         wqtWxhsq1bAzuhzE9/sz05UIzNCz7j37/J8RpP4x7m2JxAkQujY3CjQ36Lm33pqPtFEr
         Ytf57OuG6fkLLsFD13Qx7ueptSfuESEy7zAG0784TyeZ7yjgkul6Fm+D495gyu/YLe95
         4d6Tsma+8M6IwCcmqTsq72D9rATjHoc1HyVp/uP1AynV1DvmhAv6cmUI6Eo+cu/mEpVm
         y4VlKwrs3p6+H8hvjZePtkwbJj+QP4PETUJGMD7E9Ou7h2zq6zsszKupIEGtHHoyF1sB
         ETlw==
X-Gm-Message-State: AOPr4FVTep0IusEJnen+t02jVwXVXdeMQY2qqZh82qAHTzLVTAVPgScxsfKuWwWtEOLK1u9GjKNYhhRjMxTrWg==
X-Received: by 10.194.117.70 with SMTP id kc6mr12984015wjb.94.1463084337674;
 Thu, 12 May 2016 13:18:57 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Thu, 12 May 2016 13:18:57 -0700 (PDT)
In-Reply-To: <xmqq1t57f54n.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294450>

On Thu, May 12, 2016 at 9:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> To libify the apply functionality the 'unidiff_zero' variable should
>> not be static and global to the file. Let's move it into
>> 'struct apply_state'.
>>
>> Reviewed-by: Stefan Beller <sbeller@google.com>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>
> Looks correct; I would have expected from the flow of thought in the
> series that p_value and linenr that were already mentioned would be
> the first two to be put in this, but that would have to wait until
> more functions are taught to pass the state around, so this ordering
> would probably be fine.

Yeah, if the patches that put p_value and linenr into 'struct
apply_state' were earlier in the series, they would have to pass the
state around to a lot more functions, so they would have been very
big.
