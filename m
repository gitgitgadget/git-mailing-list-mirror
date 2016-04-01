From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 09/16] ref-filter: make "%(symref)" atom work with the
 ':short' modifier
Date: Fri, 1 Apr 2016 23:43:41 +0530
Message-ID: <CAOLa=ZSCFt-HMR6B9S5-ci=79_uDXu92+k_Nd+6zrSW11KTXCw@mail.gmail.com>
References: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
 <1459330800-12525-10-git-send-email-Karthik.188@gmail.com> <xmqqtwjnr4od.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 20:14:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am3aK-0003eo-Vy
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 20:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbcDASON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 14:14:13 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:34442 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbcDASOM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 14:14:12 -0400
Received: by mail-qk0-f170.google.com with SMTP id r184so6772334qkc.1
        for <git@vger.kernel.org>; Fri, 01 Apr 2016 11:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=u4/WZ8uFesrBtk/pDEUJ23FpfT1KEX8nNcTaToJ5NDg=;
        b=o4Ih0euPy60J7tyvuKMFlX5SP6Wj4tNkrgV3ha4BltK03AjbSOuyK9l8n6yg2EbCdA
         9Yr+72Xch8AQqiZs4Sp0H5SXnHoIeZMMPgn5A++BcidZX7fPCs90GYkIbbLAZzqaGEwD
         G5ARV4Sy+n3dXMQf2++E4k9EQ7mjsSvVFIb7AbVfpZQhOW2+lDl1ngwP3/EMAtkXWnde
         bo+WTfrKf68A/JmpXWFK5+GE5xcsbNV2leoDaZok4niI85HLRbscVix+Gm9alGK5uEUC
         ARm49I2MwBcPrhC23/Nb9/ySvNMJmWFfgelrMMVRNwCkvbBh9Z29JKmW96GS4BqBEN3z
         yxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=u4/WZ8uFesrBtk/pDEUJ23FpfT1KEX8nNcTaToJ5NDg=;
        b=BXWklQQSBnb9nPqIRLcvZAhLue/b/aqsS3G63yQf0Ni5zmuidbnpgyW7RXzD0dvCwH
         tG0kPP5bJZckstONwxpdFAvtOjZ0DV+eOvpg2TeVPb2AR8z9Nfuq36R8u4/5/FZGCPi9
         a0rGNajSaGgoWAUDrRqBPalVXvBoyUOdHa4v6oFG+ombVn3/CTf09avhn/Qc0pfF+JsA
         l14gfBfw9v2VtcwyotRF36mPUqh+pqUeFKH6rXAgCd/yntaLezKsxcdZH7SbyQ6Mb4b8
         o9X1oZcOCGd/mP7QUcRy7xvi7SEIIDK+iL3BcwE3hBSqH9swSBKrUM0ZfnR3M6HiVtwr
         JbZw==
X-Gm-Message-State: AD7BkJIepALtr1rw88BPEfTmg9SD9ebHoNVm8wSGKJx2H1dzFZe7KiqpQa1DXWV9I19L8Eb3wYliPYIrE74cjA==
X-Received: by 10.55.21.149 with SMTP id 21mr20488931qkv.95.1459534451458;
 Fri, 01 Apr 2016 11:14:11 -0700 (PDT)
Received: by 10.140.18.85 with HTTP; Fri, 1 Apr 2016 11:13:41 -0700 (PDT)
In-Reply-To: <xmqqtwjnr4od.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290571>

On Thu, Mar 31, 2016 at 3:47 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The "%(symref)" atom doesn't work when used with the ':short' modifier
>> because we strictly match only 'symref' for setting the 'need_symref'
>> indicator. Fix this by using comparing with valid_atom rather than used_atom.
>>
>> Add tests for %(symref) and %(symref:short) while we're here.
>>
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>> ---
>>  ref-filter.c            |  2 +-
>>  t/t6300-for-each-ref.sh | 24 ++++++++++++++++++++++++
>>  2 files changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/ref-filter.c b/ref-filter.c
>> index 8c97cdb..5c59b17 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -338,7 +338,7 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
>>               valid_atom[i].parser(&used_atom[at], arg);
>>       if (*atom == '*')
>>               need_tagged = 1;
>> -     if (!strcmp(used_atom[at].name, "symref"))
>> +     if (!strcmp(valid_atom[i].name, "symref"))
>>               need_symref = 1;
>>       return at;
>>  }
>
> Makes perfect sense.
>
>> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
>> index 2c5f177..b06ea1c 100755
>> --- a/t/t6300-for-each-ref.sh
>> +++ b/t/t6300-for-each-ref.sh
>> @@ -38,6 +38,7 @@ test_atom() {
>>       case "$1" in
>>               head) ref=refs/heads/master ;;
>>                tag) ref=refs/tags/testtag ;;
>> +              sym) ref=refs/heads/sym ;;
>>                  *) ref=$1 ;;
>>       esac
>
> An earlier review may have missed this, but I just noticed that the
> body of this case/esac is over-indented.  Something we can fix later
> after the dust settles.
>

Since I'll be re-rolling, I'll fix it :)

-- 
Regards,
Karthik Nayak
