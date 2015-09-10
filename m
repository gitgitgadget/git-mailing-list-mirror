From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v17 13/14] tag.c: implement '--format' option
Date: Thu, 10 Sep 2015 23:34:42 +0530
Message-ID: <CAOLa=ZQeFSZtLHK_sZMTHpdw_UTL_yk=Nrmu-4vC0vy2_hR7mw@mail.gmail.com>
References: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
 <1441902169-9891-2-git-send-email-Karthik.188@gmail.com> <xmqq8u8e40l2.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 20:05:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za6Dm-0003BO-97
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 20:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955AbbIJSFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 14:05:14 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:33721 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbbIJSFN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 14:05:13 -0400
Received: by obbbh8 with SMTP id bh8so41385719obb.0
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 11:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=evsICZLXpcfo1mOSMMRpAoi8mbgJgcZEaBSaOkEim+k=;
        b=kngM9jHe5n/xr48PYafp+X9DLCu+iQulCFi/QP0ok18+Nyp2NTrVMIhV6QStuzGtHa
         8ItIEJ9VgHlmR4+6vWfupvpvlI1Z5+G3Ly4x0OloFw0HHMSk6EocNBSWHGvJYIpRR9kN
         ghprGH9gIujl8g5eY9lQ9cRLUmZl114xymiuP6yL6jmdmYeeunUTqgDXrJCPw4Lnochn
         oZtKqbszG6TEqSbUXFhfqukt6SoJF5toSikx50A13L8L1UTMMrIKt/9Ct1E08cRjlIOf
         H/3ScCHWgFy3pCWE6vY+kO16uH7ScHFaSGflV5T5e+N3buFTiwZbAfUmcF2EqQbQGfmq
         5CdQ==
X-Received: by 10.182.81.98 with SMTP id z2mr33775417obx.70.1441908312071;
 Thu, 10 Sep 2015 11:05:12 -0700 (PDT)
Received: by 10.182.59.15 with HTTP; Thu, 10 Sep 2015 11:04:42 -0700 (PDT)
In-Reply-To: <xmqq8u8e40l2.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277619>

On Thu, Sep 10, 2015 at 11:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> -static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting)
>> +static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, const char *format)
>>  {
>>       struct ref_array array;
>> -     char *format, *to_free = NULL;
>> +     char *to_free = NULL;
>>       int i;
>
> format is const char * while to_free is non-const char * here.
>
>> @@ -41,12 +41,14 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting)
>>       if (filter->lines == -1)
>>               filter->lines = 0;
>>
>> +     if (!format) {
>> +             if (filter->lines) {
>> +                     format = xstrfmt("%s %%(contents:lines=%d)",
>> +                                      "%(align:15)%%(refname:short)%%(end)", filter->lines);
>
> Hmmm, did this even pass tests and if so how?  What are these double
> %% doing before refname and end?  Perhaps we do not have enough test
> coverage?
>

Seems like I didn't run the tests here, will change this.

>> +                     to_free = format;
>
> This assignment discards constness.
>
> Take the result of xstrfmt() to to_free (which is a non-const
> pointer) and then assigning it to format (which is a const pointer)
> would work it around.

Yeah!

-- 
Regards,
Karthik Nayak
