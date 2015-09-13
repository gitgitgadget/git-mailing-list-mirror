From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 3/8] branch: roll show_detached HEAD into regular ref_list
Date: Sun, 13 Sep 2015 12:46:48 -0400
Message-ID: <CAPig+cTzEQ=+FKa2j2RbfHv_NP35_vPDq1NZCeek8LX9fJF3aQ@mail.gmail.com>
References: <1442129035-31386-1-git-send-email-Karthik.188@gmail.com>
	<1442129035-31386-4-git-send-email-Karthik.188@gmail.com>
	<vpqa8sqv7p1.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Sep 13 18:46:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbAQX-0003Ai-O9
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 18:46:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753910AbbIMQqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2015 12:46:49 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:32819 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409AbbIMQqs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2015 12:46:48 -0400
Received: by ykei199 with SMTP id i199so133273529yke.0
        for <git@vger.kernel.org>; Sun, 13 Sep 2015 09:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=5ZtymYdhhtVu84nKZEwVGvcGFZ1yquAQzb9RUboFWxU=;
        b=h9qkWGoUH/WuqFCAqCWJfbAgP4cGNruKUTg5Hlb/h7rzpn46wmYpiG7aGUSVDuZQmQ
         g+lahf1RXQZ5+iNGIQZ8ex2Gov+KrsyduWqaBLb3MPj/KNo59yWwBh+pdIKT5zZcMPwJ
         MFqf6e5uu9mPLaqZuDOg4lYlILDN0lSxNUnqe6TP0FqOsE/ZySHV/nkz27pvfhjzMHmM
         M0/Jwfoz3/lFKU2SQ/wWCc/FzTcm3TxDIGsMQAtdsYza4Ut7/gvn7KQlz3BM25kTuuTt
         /2sJXsJRGZ/FO9vhWim55BiJJTodzWC9hP6alG/fDi/uHJcHpHeNQNtkigKI7oHc7UlB
         xvaA==
X-Received: by 10.170.138.214 with SMTP id f205mr9620085ykc.84.1442162808229;
 Sun, 13 Sep 2015 09:46:48 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Sun, 13 Sep 2015 09:46:48 -0700 (PDT)
In-Reply-To: <vpqa8sqv7p1.fsf@anie.imag.fr>
X-Google-Sender-Auth: MvQp28pfRn-BCIxf4j0bUtaV1VI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277786>

On Sun, Sep 13, 2015 at 8:12 AM, Matthieu Moy
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

I think Michael Haggerty mentioned something along those lines...
