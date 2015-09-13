From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 3/8] branch: roll show_detached HEAD into regular ref_list
Date: Sun, 13 Sep 2015 18:54:04 +0530
Message-ID: <CAOLa=ZTx7EpqfdYrq5RQPQOERjJZYZv837NOGZxmoP33oRNPew@mail.gmail.com>
References: <1442129035-31386-1-git-send-email-Karthik.188@gmail.com>
 <1442129035-31386-4-git-send-email-Karthik.188@gmail.com> <vpqa8sqv7p1.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Sep 13 15:24:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zb7Gq-0005HI-4C
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 15:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701AbbIMNYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2015 09:24:35 -0400
Received: from mail-vk0-f41.google.com ([209.85.213.41]:34241 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029AbbIMNYf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2015 09:24:35 -0400
Received: by vkhf67 with SMTP id f67so46215375vkh.1
        for <git@vger.kernel.org>; Sun, 13 Sep 2015 06:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Pg9BSyb1V5WUs2YnX+B0kIJCDL0R4OCTNXE1QCSVWOk=;
        b=ShHRbJDkmA5qYTFBCyvxGqw94nxw1cYbgwZihtG+MY4REffO9y4JF8gUoIPT/3UxID
         EcVKh9sCH5pN2QYlQdC76Hp/ltKW/REG4bxS5thhunvgHp6EasF+pvY588tyTsoY/FkX
         cG0YLwPb9srEJsgCn00xJ5AqCCKhr2ANs12HyUve2nN8S9e0WQQPJ+j82dHlKmlBnsYL
         kk6CTjD3KyqBo1wvbGcoyO0GAOj/bvu3yjZnUXLnbkNPVkoiBaRZxH5vnUJxas7cDgGq
         E4mzX0idKCfHq6wCZN1y6d0O1dfanetrUKHpzgKYAhaxvxDnQenLHazLotKexGwsitNk
         SuRA==
X-Received: by 10.31.142.73 with SMTP id q70mr8634859vkd.13.1442150674349;
 Sun, 13 Sep 2015 06:24:34 -0700 (PDT)
Received: by 10.103.23.66 with HTTP; Sun, 13 Sep 2015 06:24:04 -0700 (PDT)
In-Reply-To: <vpqa8sqv7p1.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277784>

On Sun, Sep 13, 2015 at 5:42 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> @@ -679,15 +682,20 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
>>       if (verbose)
>>               maxwidth = calc_maxwidth(&ref_list, strlen(remote_prefix));
>>
>> -     qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
>> +     index = ref_list.index;
>> +
>> +     /* Print detached HEAD before sorting and printing the rest */
>> +     if (detached && (ref_list.list[index - 1].kind == REF_DETACHED_HEAD) &&
>> +         !strcmp(ref_list.list[index - 1].name, head)) {
>> +             print_ref_item(&ref_list.list[index - 1], maxwidth, verbose, abbrev,
>> +                            1, remote_prefix);
>> +             index -= 1;
>> +     }
>
> I think Eric already mentionned it, but I don't remember the conclusion
> and can't find it in the archives. Wouldn't it be cleaner to actually
> remove the detached head from the array (do "ref_list.index -= 1"
> instead of "index -= 1", and possibly free() what needs to be freed?
>
> If you did so, you wouldn't have any possible confusion between the
> local variable "index" and ref_list.index in the code below:

This is cleared out in [PATCH 6/8].

-- 
Regards,
Karthik Nayak
