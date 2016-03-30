From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/6] abbrev_sha1_in_line: don't leak memory
Date: Tue, 29 Mar 2016 21:30:38 -0400
Message-ID: <CAPig+cR=Zc2QAQTPAqTt4M-nJRw4StCoqT2hYtmHOvi6LseN_A@mail.gmail.com>
References: <1459298333-21899-1-git-send-email-sbeller@google.com>
	<1459298333-21899-5-git-send-email-sbeller@google.com>
	<20160330011111.GB2237@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 30 03:30:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al4y4-0004t0-Cg
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 03:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbcC3Bak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 21:30:40 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:34123 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbcC3Baj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 21:30:39 -0400
Received: by mail-vk0-f67.google.com with SMTP id e6so4615503vkh.1
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 18:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=VDyzsoTWfSpHmeX8cnL0e1PMgbuyGNdog8UrYngU5NQ=;
        b=OfVMVkzHOPLWWaCHi8N/1VPUEKWCBdEnm+8VcxTx7I51tCdP/YKJpkrMVUa7cpqTIe
         DuVoo73rZBDNIy757EHGrLZuQ5g2L1TNSDJXnoIaAJYFtSLAkUrqV6CENPXKFSnAaY0F
         iBraP7L9drra6K2f/UnXTuACM0Ck4qbBG+QzzO1WuLa/XM+chG9TmWaHQop+4RVBRIco
         ftswhFGmvO2h+z7vB0ITU63Ym/JebYxCvehNvpg68UgYItcK1xiGZgfVUYOPVfXxchos
         IZzDdMf9+eE+kPRaU2CTGjwTSC+SLY4GYL+jfYE8RxrJxNjDPDbiL5w71wA8KKCTyYTZ
         TKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=VDyzsoTWfSpHmeX8cnL0e1PMgbuyGNdog8UrYngU5NQ=;
        b=BCvM+llkqntc3JO3gIBRE4jkiPjS+jm4IvEckPRtbPgGWOSY8e8B0Nm0aLM0UlQQv2
         b6CAdSIfhdpjnirq3T8E2eZQE+25pOjVhy9+FbkYbC3nTk/jPtYxtV94FKSvk2Ez/Je3
         mAUROSzKVy3Q7kDN+bYXg8KiHrVcCywB8YlYoqOoFmtyriQY3pNJ1jAZtXl7a7oB3lR7
         R7BpcBaf4j4jhISYuZjs2kJGSKlg/PUpq0NN1aNCivSqePKKek+t4KSFELJLN0qlEj/T
         +89Q5tmVB2W46FxGhTpO/yYAT7ZnQ6PVmB/o+B33UWOTSFRnjaHwqSkWObI4nkv7/EL8
         sPeQ==
X-Gm-Message-State: AD7BkJLwx+ByEclxyIwDjP4EQShfxO8TfeDl1vvtJv4V1ewG8NFFXk3+HivLul0294Bbrq5YIGeK8sd/ii97rQ==
X-Received: by 10.31.150.76 with SMTP id y73mr3515669vkd.84.1459301438315;
 Tue, 29 Mar 2016 18:30:38 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Tue, 29 Mar 2016 18:30:38 -0700 (PDT)
In-Reply-To: <20160330011111.GB2237@sigill.intra.peff.net>
X-Google-Sender-Auth: cJqv9cQ-hHfOLCfFMWn4hCx0aDU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290258>

On Tue, Mar 29, 2016 at 9:11 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 29, 2016 at 05:38:51PM -0700, Stefan Beller wrote:
>> `split` is of type `struct strbuf **` and just before the new free,
>> we release the inner strbufs. Make sure to also release the memory
>> containing the pointers to the individual strbufs.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>> diff --git a/wt-status.c b/wt-status.c
>> @@ -1065,7 +1065,7 @@ static void abbrev_sha1_in_line(struct strbuf *line)
>>       }
>>       for (i = 0; split[i]; i++)
>>               strbuf_release(split[i]);
>> -
>> +     free(split);
>>  }
>
> I think this can just combine with the for-loop above to become
> strbuf_list_free().

The implementation of strbuf_list_free() is this:

    struct strbuf **s = sbs;
    while (*s) {
        strbuf_release(*s);
        free(*s++);
    }
    free(sbs);

which means that wt-status.c is leaking not only 'split', but also
each element of split[], right?
