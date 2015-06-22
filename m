From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fast enumeration of objects
Date: Mon, 22 Jun 2015 12:44:24 -0700
Message-ID: <xmqq381jh6jr.fsf@gitster.dls.corp.google.com>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org>
	<1434914431-7745-1-git-send-email-charles@hashpling.org>
	<20150622083543.GA12259@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Charles Bailey <charles@hashpling.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 22 21:44:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z77dy-0001Ym-6I
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 21:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843AbbFVTo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 15:44:28 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:33816 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbbFVTo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 15:44:26 -0400
Received: by iebmu5 with SMTP id mu5so122436783ieb.1
        for <git@vger.kernel.org>; Mon, 22 Jun 2015 12:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=IeFFB6M2hRdGWieldAkSOS2982gSS6Jtgi3Nd5OJ+nk=;
        b=Pzw06jn//RyZQW9GfqoD+181Dj+GI6UQUBp1Ql4U8iaumnuSQespYe19iPVX2JE+a/
         5HR1WsSPTc2BTX1hq6ftwKYBseNy6af5nD/7XTcUfkaj0BQ5Ikj+UFqm8yPAB9tunMBf
         MVFObBJNQo3h5rQNinxqyq43b7ZSudWIt1t+iDx75/1EzPdiDFErtQvt8usYhZQoVtqX
         p3WSLro9rf+TqwCzYrqnwf/V2dNU2Bl+RvPdsa78DqIpdIR9JPBPwJJMmofIoGKRLRqR
         TvN0fwUt13P1+jIuHLcKr9f16treWbW2OFXNQsfPH1o0CG3uuDmhmNF2++cYF6orpTD1
         dnXw==
X-Received: by 10.107.128.72 with SMTP id b69mr24070287iod.84.1435002266147;
        Mon, 22 Jun 2015 12:44:26 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b0be:ae3d:b206:8e25])
        by mx.google.com with ESMTPSA id o200sm13426908ioo.43.2015.06.22.12.44.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Jun 2015 12:44:25 -0700 (PDT)
In-Reply-To: <20150622083543.GA12259@peff.net> (Jeff King's message of "Mon,
	22 Jun 2015 04:35:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272407>

Jeff King <peff@peff.net> writes:

> ...
> So my conclusions are:
>
>   1. Yes, the pipe/parsing overhead of a separate processor really is
>      measurable. That's hidden in the wall-clock time if you have
>      multiple cores, but you may care more about CPU time. I still think
>      the flexibility is worth it.
>
>   2. Cutting out the pipe to cat-file is worth doing, as it saves a few
>      seconds. Cutting out "%(objecttype)" saves a lot, too, and is worth
>      doing. We should teach "list-all-objects -v" to use cat-file's
>      custom formatters (alternatively, we could just teach cat-file a
>      "--batch-all-objects" option rather than add a new command).
>
>   3. We should teach cat-file a "--buffer" option to use fwrite. Even if
>      we end up with "list-all-objects --format='%(objectsize)'" for this
>      task, it would help all the other uses of cat-file.

All sounds very sensible.
