From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/2] run-command: factor out child_process_clear()
Date: Tue, 27 Oct 2015 14:31:48 -0700
Message-ID: <CAGZ79kbCNnnWQapFjj=sA5+HPK2hpAu4=8LomNnOErM9+_QBjg@mail.gmail.com>
References: <562B756F.1020305@web.de>
	<xmqqziz5h3n5.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYopHL5D_7+bJV2P9GeKDHufPDBTo3a8bRL=4B3OmTGjg@mail.gmail.com>
	<562FECCA.6080703@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Tue Oct 27 22:32:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrBqX-0000ri-Nk
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 22:31:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbbJ0Vbv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Oct 2015 17:31:51 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:33784 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322AbbJ0Vbs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Oct 2015 17:31:48 -0400
Received: by ykft191 with SMTP id t191so50832060ykf.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 14:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=zieGcxJlgqB6iutcrMdg5XW4Qqoyo60fAKJkMsSbGIk=;
        b=m+Hoqe+QtARG6+ZAYpRvkUvwHE4WH9d1YXs5etNLRLcU6UqEORjnP6nTg19QI/4NGj
         1r92SGsKoA6si5pDRcYTURA3on2LFiwAm08lpsSXzj2lW8oxzHwVtY5AoERFMcjNQEov
         C+L92atN0UmtigbFlQVoT/Pc13UuogSn4zvvyhlrVKdapNwfkwgbmgc9UgeTKG/dx/Ha
         7la0kP+jeYyD8GRJOvuD9XqYCz1tdXBOquk1HXnEdwKqsuWzHqrTHR1UwxYL0monZXtY
         EKJiWRaRzx+Guv4BjD0QzTqgOvU6pJbfr3BLOH0ClObW1qTFEACqSt+GGqSsjBjFvXtk
         dgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zieGcxJlgqB6iutcrMdg5XW4Qqoyo60fAKJkMsSbGIk=;
        b=OA2gWXe2K6Q6bmXFYfAqwQxCGat3iE1jQg1QsDpoZjhbos7SOWDoBJJZRZ2zjv8WKD
         dGUv+z3GCFPExQHDb68jDVlqcXp3FIhM47Nio/h8h2z3mTbyatdtW/WnJItxbAbAyRBS
         nRxj10ahkf9hcNKNUE1xICB86E5eJ/yWD0z3Dyl0qWo5bW5PQrH7PsCn3SX7wfRYQBzC
         3uKk+HIwuNJsUj07dWQVZauI+n/LKNhk0lpjrFdEDO8xGiSFDHv7rbqch9/aY9N/BQZ2
         YRUD1J+ltdXkDJKfG4hpfAOSSvsVvjkgWODPN4psIKExqftpu4EJR+Zf2Vt+ngnunld3
         8kKA==
X-Gm-Message-State: ALoCoQmSNDUcVCXNDb5E6KZv+Mz7exgvMC9pbTnrq4m/Giur4mmaIAW0Spuo0INO9kIJX6RYO2m+
X-Received: by 10.129.40.18 with SMTP id o18mr31555804ywo.199.1445981508217;
 Tue, 27 Oct 2015 14:31:48 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Tue, 27 Oct 2015 14:31:48 -0700 (PDT)
In-Reply-To: <562FECCA.6080703@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280304>

On Tue, Oct 27, 2015 at 2:29 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote=
:
> Am 26.10.2015 um 20:23 schrieb Stefan Beller:
>>
>> On Mon, Oct 26, 2015 at 11:43 AM, Junio C Hamano <gitster@pobox.com>
>> wrote:
>>>
>>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>>
>>>> Avoid duplication by moving the code to release allocated memory f=
or
>>>> arguments and environment to its own function, child_process_clear=
().
>>>> Export it to provide a counterpart to child_process_init().
>>>>
>>>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>>>> ---
>>>
>>>
>>> Hmm, is this _deinit() Stefan added to his series recently?
>>
>>
>> Yes. Although you (Junio) take credit for actually using it in these
>> places, too. :)
>
>
> Oh, and it's already in next.  I still like _clear() better (as in
> {argv,object,ref,sha1}_array_clear(), or string_list_clear(), or ...)=
 than
> _deinit(), which seems to have been introduced by vcs-svn and isn't a=
 real
> word.  I'll rebase my patches on top of this series, but probably not=
 before
> the weekend.
>

Thanks for the coming cleanup. :)
As you know naming things is hard.

> Ren=C3=A9
>
