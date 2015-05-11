From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 00/18] Improve handling of D/F conflicts
Date: Mon, 11 May 2015 11:10:48 -0700
Message-ID: <CAGZ79kbAq81B-bvCQsn0a6nMbbVKqWFh1TrD2pbNggH34EgKvA@mail.gmail.com>
References: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
	<xmqqwq0fngk9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 11 20:11:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrsAM-0002hj-QM
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 20:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbbEKSKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 14:10:53 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:36188 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754203AbbEKSKt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 14:10:49 -0400
Received: by igbpi8 with SMTP id pi8so77709929igb.1
        for <git@vger.kernel.org>; Mon, 11 May 2015 11:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IZzvG2XlZXG9YT41Ztg7+O+x1AJMhQB7ANm4NbHaygs=;
        b=hGdEajMAHskW8kjQJI8jooaqaJv01SoW2422P6/z7r5LavJO/EeWHzf1WQhWYY9rpa
         lHECAcTwSU4Qr1/pum1vS5hwzuybkoM59hLItC76fXJl1nYAX9s4HCfCdBVSYS04ureh
         yopb9c9OysMWB6pQP4YoLay22UvLLfh1i+G16Kwo1I80vz/Z8D0y2CQkAAIJ+bRuSJ8D
         CojvRMxE6n9zbe6qLpL+EIAOLtejLL6k6PZyo8MzIkM/ovF/kQBIyUDcjOPTPtK5d0yb
         VWFwFonNjHXoYx2M7Chlz/ox8Q62WD6E6Fccr0o3kQwE0wxoTx3zpWItd/Xb6GCFfg1K
         +/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=IZzvG2XlZXG9YT41Ztg7+O+x1AJMhQB7ANm4NbHaygs=;
        b=Lwt7Fyi7ONnPtPG3O3cVzYqbZOnYLMw16VwI3Y11xZIKRl30v0jATsmEo7ypo6RgHy
         aAWRWjlJFpvbM+HG21UjlQLUvlfzEV8Pz8xwJN8E/ShL3qGbA0EOy4j1OjY9i4zB9knW
         ewJPZVjarFbInJYZLKpPbbbG3Kd861EbbOqP/N1YH4s2OhGw+yh1L0G5RDh7tz6Jh+Wr
         7iBEql4JGLgWpEvI8KW9OqjRe0T+DJU9WhKoP8bWa0PNvBtSULlee+QXm2PzkOMxWquT
         qcV/QgQAxSew81OqwCLRpTxoZ6MfTGKVsH62K+/vtCckoz5iXdot8Z/S2cIIN0SpuqEg
         G0zg==
X-Gm-Message-State: ALoCoQknD3OjnPJp1D2jCxv5LEa/8D1JOntpLJ22snsyb0FFJroZ9EWtPAYB63iVHnkBM21FhyDR
X-Received: by 10.42.188.19 with SMTP id cy19mr1727268icb.92.1431367848881;
 Mon, 11 May 2015 11:10:48 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Mon, 11 May 2015 11:10:48 -0700 (PDT)
In-Reply-To: <xmqqwq0fngk9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268811>

On Mon, May 11, 2015 at 10:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> * Rebase to master rather than depending on
>>   mh/ref-lock-avoid-running-out-of-fds, as did v1. There were no
>>   significant dependencies between the two patch series, and now that
>>   mh/ref-lock-avoid-running-out-of-fds (now renamed to
>>   mh/write-refs-sooner.*) has been backported to 2.2, the dependency
>>   makes even less sense.
>
> Thanks, that makes sense.
>

The series is Reviewed-by: Stefan Beller <sbeller@google.com>

Thanks,
Stefan
