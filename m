From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v15 06/13] ref-filter: add option to filter out tags, branches and remotes
Date: Tue, 01 Sep 2015 21:15:50 -0700
Message-ID: <xmqqoahlpibt.fsf@gitster.mtv.corp.google.com>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
	<1441131994-13508-7-git-send-email-Karthik.188@gmail.com>
	<xmqqa8t5rfng.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZQQia58_9c+KDh9mZ_UdcpUn96yuPOdABYvs1gno04CmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 06:16:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWzT7-0002L3-1G
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 06:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbbIBEPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 00:15:53 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33256 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbbIBEPw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 00:15:52 -0400
Received: by paap5 with SMTP id p5so10764428paa.0
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 21:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=o8dOn8uq+KW0BwvEWHvLN0fLTV2YCFtqhDAJuqk76AU=;
        b=H8CvDHN+DoZeJkoBtdh0lfw8FX9p4Zh/BHS7+TQQNf5iKjteEzSHk9N5Y5eMmkn3/P
         /8ieCESnuC5kCE/6jgtGTM8e+0XoCQr9u3TXKn6Iei1JfFfthmvz72o5dhaUsLMnkkBE
         W1trLQ7w4u/D8K9TxC70GnoCLg8sBzXS84Motq1IHRlDach0SH1ZemxLokdl9Te8nPkp
         b85uydCD5L1LCGgkxASCS6VZ5i1sFROoGMZEqDhgX9agRGlP+qWyQIHAwofbqLiGKd+0
         kPztnaIIIHXLaUS6aXvaUz8iNxCeJaeDnt9kK0vdBosgSNYbQxTx8snnuZdPp2+SCUwZ
         9ChA==
X-Received: by 10.68.57.143 with SMTP id i15mr11862828pbq.104.1441167352154;
        Tue, 01 Sep 2015 21:15:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2414:9e5f:bc96:1638])
        by smtp.gmail.com with ESMTPSA id ri9sm19851147pbc.4.2015.09.01.21.15.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 01 Sep 2015 21:15:50 -0700 (PDT)
In-Reply-To: <CAOLa=ZQQia58_9c+KDh9mZ_UdcpUn96yuPOdABYvs1gno04CmQ@mail.gmail.com>
	(Karthik Nayak's message of "Wed, 2 Sep 2015 06:57:48 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277075>

Karthik Nayak <karthik.188@gmail.com> writes:

>>> +             if (filter->kind == FILTER_REFS_BRANCHES)
>>> + ret = for_each_fullref_in("refs/heads/", ref_filter_handler,
>>> &ref_cbdata, broken);
>>> +             else if (filter->kind == FILTER_REFS_REMOTES)
>>> + ret = for_each_fullref_in("refs/remotes/", ref_filter_handler,
>>> &ref_cbdata, broken);
>>> +             else if (filter->kind == FILTER_REFS_TAGS)
>>> + ret = for_each_fullref_in("refs/tags/", ref_filter_handler,
>>> &ref_cbdata, broken);
>>> +             else if (filter->kind & FILTER_REFS_ALL)
>>> + ret = for_each_fullref_in("", ref_filter_handler, &ref_cbdata,
>>> broken);
>>
>> This if/else if/else if/ cascade and ...
>
> Did you notice the "==" for others and "&" for the ALL?

I didn't.  Thanks for pointing it out.

So the point of the earlier part of the cascade is to optimize for
common cases?  If that is the case, it probably deserves some
commenting.  I also suspect that a table-based control might be
easier to maintain, but that kind of change might fall into the
category of premature optimization.
