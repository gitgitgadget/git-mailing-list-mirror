From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6b 5/8] branch: drop non-commit error reporting
Date: Fri, 25 Sep 2015 09:00:41 -0700
Message-ID: <xmqq4mii5w0m.fsf@gitster.mtv.corp.google.com>
References: <1443031873-25280-1-git-send-email-Karthik.188@gmail.com>
	<1443118148-3470-1-git-send-email-Karthik.188@gmail.com>
	<vpqk2rfm4ag.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Sep 25 18:00:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfVQX-0007tM-9D
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 18:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbbIYQAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2015 12:00:45 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36655 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932218AbbIYQAn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2015 12:00:43 -0400
Received: by pablk4 with SMTP id lk4so12543772pab.3
        for <git@vger.kernel.org>; Fri, 25 Sep 2015 09:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=qnaakOYjo5zNS0VXApmuAi5ilkFJrEVOtWl+q8R5Kjw=;
        b=ntPbUQM7Y6nfKRf8QPcoIek9LMv9cBtTaghG2f8TpvJB1uekqhjMlF8PsbxCtc1ww+
         ZBatbpwm2bNaB6ojaI/OurJx7f5RVkgAsSN/1RKfa+0Mhk76NMmHlBaDd8S7nn9FhfRV
         maV+b43KoMkUfjdwrv2ToggvAnhNaInkp4oyp1xcHQK3YZBJxNXoNUEHLF2A0qzeke4Z
         iNP9jWaNDx/JUcVxcJdCiKFXBBRRGzDjfsjTqpQFY0Rm5XRXz/IiUThGNZGuEGypVoPO
         W3j6G6ntRXFYsgY60MjR9bqGXKybNruuD04z9yeZvahukAMTOd93EMVOG6FaTjEQvRon
         eg1Q==
X-Received: by 10.68.218.137 with SMTP id pg9mr8333358pbc.160.1443196842806;
        Fri, 25 Sep 2015 09:00:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:913:2c8:148a:1d8e])
        by smtp.gmail.com with ESMTPSA id pi9sm4629557pbb.96.2015.09.25.09.00.41
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 25 Sep 2015 09:00:41 -0700 (PDT)
In-Reply-To: <vpqk2rfm4ag.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Fri, 25 Sep 2015 07:55:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278664>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Remove the error "branch '%s' does not point at a commit" in
>> apppend_ref() which reports branch refs which do not point to
>> commits. Also remove the error "some refs could not be read" in
>> print_ref_list() which is triggered as a consequence of the first
>> error.
>>
>> This seems to be the wrong codepath whose purpose is not to diagnose
>> and report a repository corruption. If we care about such a repository
>> corruption, we should report it from fsck instead.
>
> (We actually already report it from fsck indeed)
>
>> This also helps in a smooth port of branch.c to use ref-filter APIs
>> over the following patches. On the other hand, ref-filter ignores refs
>> which do not point at commits silently.
>
> Seems much better. Thanks,

Yes, it seems that I can just replace 5/8 with this and the
remainder can stay as they are.

While I was trying to address your "actually already report", I
spotted a typo and then found that the early part of the second
paragraph is a bit hard, so here is what I ended up with.

    branch: drop non-commit error reporting
    
    Remove the error "branch '%s' does not point at a commit" in
    append_ref(), which reports branch refs which do not point to
    commits.  Also remove the error "some refs could not be read" in
    print_ref_list() which is triggered as a consequence of the first
    error.
    
    The purpose of these codepaths is not to diagnose and report a
    repository corruption.  If we care about such a corruption, we
    should report it from fsck instead, which we already do.
    
    This also helps in a smooth port of branch.c to use ref-filter APIs
    over the following patches. On the other hand, ref-filter ignores refs
    which do not point at commits silently.
    
    Based-on-patch-by: Jeff King <peff@peff.net>
    Helped-by: Junio C Hamano <gitster@pobox.com>
    Mentored-by: Christian Couder <christian.couder@gmail.com>
    Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
    Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks.
