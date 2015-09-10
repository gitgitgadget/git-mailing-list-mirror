From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v17 08/14] ref-filter: add support for %(contents:lines=X)
Date: Thu, 10 Sep 2015 23:07:35 +0530
Message-ID: <CAOLa=ZQ2e-U+=-qS71MwwtnpQyYnc1Ls3t=JdMi_UvxGBG5_3A@mail.gmail.com>
References: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
 <1441900110-4015-9-git-send-email-Karthik.188@gmail.com> <xmqqtwr242of.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 19:38:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za5nX-00036r-9a
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 19:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752894AbbIJRiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 13:38:07 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:36447 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbbIJRiG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 13:38:06 -0400
Received: by oibi136 with SMTP id i136so28945003oib.3
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 10:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=c6JHfKdqpBGav5nuB2m5EcYPPaxqyAjXRiwNOLUcDpA=;
        b=az4vjXeonXAYsAciG9EaSy9pvnqpnHzffQlDf1NzcbhGEjCtD4H9Aza6AGkDWx2Bxq
         nR3oGhWuVJ361gPSvxNeBN+V6oAXd5p785g7L+7EYULDvZUK2HhJtw2cbA901w/r0UXn
         N4iNfT2J4LFy8fAVMgUBQEmVwky2NjpGvMk5C4jlfSKmqunkjzGfHdwskRW30CJaHAcC
         NVVyePyLqcum5fzW/zkbdZnKZ2BrdCafaDnq8E/l95jnJdd7JnglB1Dc5uEKTSe9rvFv
         8LANS1xfT8EZcDziwyRj4DeR+HuEzX1rtT+Q+QtflwEqO+zmZ0YkWmsXRjxqYKmFkUIt
         cFsg==
X-Received: by 10.202.203.194 with SMTP id b185mr32177565oig.104.1441906684523;
 Thu, 10 Sep 2015 10:38:04 -0700 (PDT)
Received: by 10.182.59.15 with HTTP; Thu, 10 Sep 2015 10:37:35 -0700 (PDT)
In-Reply-To: <xmqqtwr242of.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277613>

On Thu, Sep 10, 2015 at 10:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> diff --git a/ref-filter.c b/ref-filter.c
>> index 7d2732a..b098b16 100644
>> --- a/ref-filter.c
>> +++ b/ref-filter.c
>> @@ -56,6 +56,7 @@ static struct {
>>       { "color" },
>>       { "align" },
>>       { "end" },
>> +     { "contents:lines" },
>
> Do we even need "contents:lines" and existing other "contents:blah"
> in this list in the first place?  If they are needed, group them
> together, not append at the end.
>
> I wonder how this code sensibly can parse "%(contents:lines=6)".
> After splitting the format string at %( and closing ), the code
> calls parse_ref_filter_atom() and the rule that helper function uses
> to figure out the atom-name proper (which is to be checked against
> the valid_atom[] array) is to find the first colon, so
>
>     %(contents:lines=6)
>
> would cause "contents:lines=6" to be fed parse_ref_filter_atom(),
> it cheks if "contents" is in the valid_atom[] array (it is), and
> stores the whole thing in used_atom[].
>
> So in that sense, match_atom_name() would do the right thing, but
> that would make any reader of this code realize that she never saw
> "contents:lines" entry in valid_atom[] array being used during this
> process.

True.
We could remove all the contents:<subvalue> atoms from this list.

-- 
Regards,
Karthik Nayak
