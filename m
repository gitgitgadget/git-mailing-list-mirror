From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v15 07/13] ref-filter: add support for %(contents:lines=X)
Date: Wed, 2 Sep 2015 19:46:59 +0530
Message-ID: <CAOLa=ZTB_uMvKjU=f9UgmvOmeZD4YtFL_Gv1+VvZAgDV-6WYDA@mail.gmail.com>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
 <1441131994-13508-8-git-send-email-Karthik.188@gmail.com> <vpq8u8ptcjq.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 02 16:17:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZX8qz-0004k3-DK
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 16:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753394AbbIBOR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 10:17:29 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:35670 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbbIBOR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 10:17:29 -0400
Received: by obuk4 with SMTP id k4so8995017obu.2
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 07:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=h7t3ilDpvfENIvl0sUXIRcVAspDDKgVDjizWC77oZXY=;
        b=TYijBbGjnZNHzSH+71ESO5ODP0su/DEVGAy9bP7fZWem5WX3NYvticA6gP+Tl2kSQo
         cIjS2KRBkCMUafz717jBK9/tJpOh/fW+AUKb+4tcDAUbcXQk9+4Fo54VFSXvKZZeSJiE
         2OKbjzQMjrZk7EW//Y7zvyJTtBxSRELynzCY28XSNCy5EIEiTA+9vyFrdp3jKdc+c7eH
         WnB/TmvA+WlKUfE+oOBaaXkMAo/JJAg/CVvVqzcf9Zl75aftuWXRJMUH6SsC4GdIhMTw
         02lSxO+c4FQn4Q6gxZvhruF872CcCUG5XLbvsGsUKjDFjkbeQAo6Vpw+mVniT7yDkOg2
         OcvQ==
X-Received: by 10.60.81.69 with SMTP id y5mr15275273oex.30.1441203448355; Wed,
 02 Sep 2015 07:17:28 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Wed, 2 Sep 2015 07:16:59 -0700 (PDT)
In-Reply-To: <vpq8u8ptcjq.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277090>

On Wed, Sep 2, 2015 at 2:37 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> --- a/builtin/tag.c
>> +++ b/builtin/tag.c
>> @@ -185,6 +185,10 @@ static enum contains_result contains(struct commit *candidate,
>>       return contains_test(candidate, want);
>>  }
>>
>> +/*
>> + * Currently modified and used in ref-filter as append_lines(), will
>> + * eventually be removed as we port tag.c to use ref-filter APIs.
>> + */
>>  static void show_tag_lines(const struct object_id *oid, int lines)
>
> I would rather have one "cut and paste" patch followed by a "modify and
> use" patch for review.
>
> As-is, reading the patch doesn't tell me what change you did.
>
> That said, I did get this information in the interdiff, so I won't
> insist on that.

Its only borrowed slightly, so I don't really see the need for this.
But if you insist, we could do that .

>
>> +static void append_lines(struct strbuf *out, const char *buf, unsigned long size, int lines)
>> +{
>> +     int i;
>> +     const char *sp, *eol;
>> +     size_t len;
>> +
>> +     if ((sp = strstr(buf, "\n\n")) && (sp <= buf + size))
>> +             size += 2;
>
> Why is this "size += 2" needed?
>

We pass size as "sublen + bodylen - siglen" if there exists a "\n\n"
between sublen and bodylen this is not accounted for. hence we
add 2 here.

-- 
Regards,
Karthik Nayak
