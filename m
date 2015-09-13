From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 6/8] branch.c: use 'ref-filter' data structures
Date: Sun, 13 Sep 2015 18:49:09 +0530
Message-ID: <CAOLa=ZQVwECZ=0oJdFcCWJwAUf7gYaF5pGweKDAFpfJujw-Q1A@mail.gmail.com>
References: <1442129035-31386-1-git-send-email-Karthik.188@gmail.com>
 <1442129035-31386-7-git-send-email-Karthik.188@gmail.com> <vpqy4gatshr.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Sep 13 15:20:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zb7CN-0007Rz-JI
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 15:20:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbbIMNTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2015 09:19:39 -0400
Received: from mail-vk0-f41.google.com ([209.85.213.41]:33022 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949AbbIMNTj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2015 09:19:39 -0400
Received: by vkgd64 with SMTP id d64so46168229vkg.0
        for <git@vger.kernel.org>; Sun, 13 Sep 2015 06:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=uRPh8wSCjEYEEJEq0KuSALAYbSkvml/2HzxV4jWu594=;
        b=tW/WyMs5ixtKa6acncVtmX/m4CQlgU9+zfJ6Tw4OdQpQP5XS/QPClQf/n49aKemOTS
         f5o0IHVJSloRv/qUGnulutYNf09VJPI0powiWN9aGcHDFFYMn3dmw44bAX7iZJUgaj63
         FlAioYE1bbmFXRTHLz6ljStKyxnEImJ51RMJTuzKhcr+bKQnEB7+bp3kOmleBTemQUN4
         +LtW2Ula7X11idT4HqB6s2trZAJcrelVEx68/wpjma8xWeAIr7dxC0aOAQTsb0yxurJA
         yN3DcEJiisz3Z1C8W6FdCcdvKtOXVs6b4x7ezZBjDMgizL/jzOwSK6fjJpJNVssbrT5m
         47qw==
X-Received: by 10.31.194.73 with SMTP id s70mr8654208vkf.77.1442150378305;
 Sun, 13 Sep 2015 06:19:38 -0700 (PDT)
Received: by 10.103.23.66 with HTTP; Sun, 13 Sep 2015 06:19:09 -0700 (PDT)
In-Reply-To: <vpqy4gatshr.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277782>

On Sun, Sep 13, 2015 at 5:56 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>       /* Print detached HEAD before sorting and printing the rest */
>> -     if (detached) {
>> -             print_ref_item(&ref_list.list[index - 1], maxwidth, verbose, abbrev,
>> -                            detached, remote_prefix);
>> -             index -= 1;
>> +     if (filter->kind & FILTER_REFS_DETACHED_HEAD) {
>> +             print_ref_item(array.items[array.nr - 1], maxwidth, filter, remote_prefix);
>> +             free_array_item(array.items[array.nr - 1]);
>> +             array.nr--;
>
> Ah, this answers my previous remark: indeed, you are removing the
> element from the array completely after this patch. You may want to
> modify the previous patch to start doing it earlier, but I think it's
> not worth the trouble: I agree with the final state, only the
> intermediate state is suboptimal (but still acceptable to me at least).
>

Yes! Eric suggested this. It doesn't make much sense in the previous
patch, cause I'd have to introduce something along the lines of
free_array_item() only to be removed/replaced here.

-- 
Regards,
Karthik Nayak
