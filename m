From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6b 5/8] branch: drop non-commit error reporting
Date: Sat, 26 Sep 2015 00:07:15 +0530
Message-ID: <CAOLa=ZRi+x_GUoETK4fQc57=UnDFbCzZoswAZxoxHo2BYrQXmg@mail.gmail.com>
References: <1443031873-25280-1-git-send-email-Karthik.188@gmail.com>
 <1443118148-3470-1-git-send-email-Karthik.188@gmail.com> <vpqk2rfm4ag.fsf@grenoble-inp.fr>
 <xmqq4mii5w0m.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 20:37:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfXsU-0008MJ-FE
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 20:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932934AbbIYShq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2015 14:37:46 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:34019 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932832AbbIYShp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2015 14:37:45 -0400
Received: by vkhf67 with SMTP id f67so61399457vkh.1
        for <git@vger.kernel.org>; Fri, 25 Sep 2015 11:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6lfrJjbt3uvdfhu2wQdrmI3IVg1lE163A8RHtoh3wHo=;
        b=W2WxDOYw1xJ15zLNuJ1wCcpoibgCPQ9TWpJA4YqnZSCk0OIgl1Ey55tczEVu5b92bG
         xD+HsNIfUI3nyCyT09Yp50JrjXLhe8W4g6amvcaSphSip+ACfsrubOQVKXqRe+xp6iqY
         dSubJjoYOm2l7Ht++wn0uY0+gR5u3zKemxcgHf/nBxftEWYlDLX5jve511dFpPefBA5e
         9IGk6eFD/t56GT3S+25FJxeLB4mMQhTlkJ6uqN+fY6Oa5XcED+pUKcqIXG3xBiQpv2Ez
         5WbYXL6hFSJpgtoniASb0p5YpMJtj9oqh86tbYKHnDSej1opdZFu3kKfzULZTGky5Wic
         gnxA==
X-Received: by 10.31.142.73 with SMTP id q70mr4129166vkd.13.1443206264618;
 Fri, 25 Sep 2015 11:37:44 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Fri, 25 Sep 2015 11:37:15 -0700 (PDT)
In-Reply-To: <xmqq4mii5w0m.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278673>

On Fri, Sep 25, 2015 at 9:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> Remove the error "branch '%s' does not point at a commit" in
>>> apppend_ref() which reports branch refs which do not point to
>>> commits. Also remove the error "some refs could not be read" in
>>> print_ref_list() which is triggered as a consequence of the first
>>> error.
>>>
>>> This seems to be the wrong codepath whose purpose is not to diagnose
>>> and report a repository corruption. If we care about such a repository
>>> corruption, we should report it from fsck instead.
>>
>> (We actually already report it from fsck indeed)
>>
>>> This also helps in a smooth port of branch.c to use ref-filter APIs
>>> over the following patches. On the other hand, ref-filter ignores refs
>>> which do not point at commits silently.
>>
>> Seems much better. Thanks,
>
> Yes, it seems that I can just replace 5/8 with this and the
> remainder can stay as they are.
>
> While I was trying to address your "actually already report", I
> spotted a typo and then found that the early part of the second
> paragraph is a bit hard, so here is what I ended up with.
>
>     branch: drop non-commit error reporting
>
>     Remove the error "branch '%s' does not point at a commit" in
>     append_ref(), which reports branch refs which do not point to
>     commits.  Also remove the error "some refs could not be read" in
>     print_ref_list() which is triggered as a consequence of the first
>     error.
>
>     The purpose of these codepaths is not to diagnose and report a
>     repository corruption.  If we care about such a corruption, we
>     should report it from fsck instead, which we already do.
>
>     This also helps in a smooth port of branch.c to use ref-filter APIs
>     over the following patches. On the other hand, ref-filter ignores refs
>     which do not point at commits silently.
>
>     Based-on-patch-by: Jeff King <peff@peff.net>
>     Helped-by: Junio C Hamano <gitster@pobox.com>
>     Mentored-by: Christian Couder <christian.couder@gmail.com>
>     Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
>     Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> Thanks.

Looks good to me, thanks :)

-- 
Regards,
Karthik Nayak
