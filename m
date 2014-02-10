From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 01/14] Add data structures and basic functions for
 commit trailers
Date: Mon, 10 Feb 2014 02:27:33 -0500
Message-ID: <CAPig+cQpCSMeZg=vj1Hawu_RuDG3j6uWqj2_wSfhCw8-jsdrcQ@mail.gmail.com>
References: <20140206194123.325.99451.chriscool@tuxfamily.org>
	<20140206202004.325.80557.chriscool@tuxfamily.org>
	<xmqqzjm3x0v3.fsf@gitster.dls.corp.google.com>
	<20140209.144809.1747063529382396154.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Feb 10 08:27:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WClHG-0000mo-Mn
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 08:27:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbaBJH1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Feb 2014 02:27:35 -0500
Received: from mail-yh0-f46.google.com ([209.85.213.46]:43206 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbaBJH1e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Feb 2014 02:27:34 -0500
Received: by mail-yh0-f46.google.com with SMTP id v1so4683781yhn.5
        for <git@vger.kernel.org>; Sun, 09 Feb 2014 23:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=9s1LKSf4r4dQzHzrNmR9H4aDOQDiOEtOXgJrPARcRa8=;
        b=T08z6vWBqi/1amNTWW1jF85HsXdz6Wo+YH3/qazEV1BRIX4A5ysI7CttX53uvOjD6Y
         /ANu3ZJeUpBQdulO26k+Nb1FRztybqfIKNk0pybWznUxXe2cFLVpwS1MYNkHtJ/7fwtQ
         qui9iSMb0n7ID8Dq1Txyk3c3tz3fYi26EFcjckHKdPEUDlsycw3qDGHSJuusZGwxc9eu
         M19hufyiZMlF+dKxL4BUTX+D2MI3oPgf9/awm9XYwoLAr2Far5FbnkCtUoMndGZMkKC0
         BcKz61klfyHZe2KNn29h9VkH2FPmAltk4/3F0IGG/6CG4kFuX5SS6T/Dz9VhxcyDKIQG
         vCsQ==
X-Received: by 10.236.122.99 with SMTP id s63mr16394499yhh.19.1392017253932;
 Sun, 09 Feb 2014 23:27:33 -0800 (PST)
Received: by 10.170.189.143 with HTTP; Sun, 9 Feb 2014 23:27:33 -0800 (PST)
In-Reply-To: <20140209.144809.1747063529382396154.chriscool@tuxfamily.org>
X-Google-Sender-Auth: _6NRAYUrm3GipCV3C9unfCS-8lw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241904>

On Sun, Feb 9, 2014 at 8:48 AM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> From: Junio C Hamano <gitster@pobox.com>
>>
>> Christian Couder <chriscool@tuxfamily.org> writes:
>>
>>> +static inline int same_trailer(struct trailer_item *a, struct trailer_item *b, int alnum_len)
>>> +{
>>> +    return same_token(a, b, alnum_len) && same_value(a, b);
>>> +}
>>
>> All these "inlines" look premature optimization that can be
>> delegated to any decent compiler, don't they?
>
> Yeah, but as Eric suggested to add them like in header files and you
> did not reply to him, I thought you agreed with him.
> I will remove them.

If these functions are used only by trailer.c, then it would make
sense to move them from trailer.h to trailer.c so that they don't get
defined unnecessarily by each .c file which includes trailer.h.

>>> +/* Get the length of buf from its beginning until its last alphanumeric character */
>>> +static inline size_t alnum_len(const char *buf, int len)
>>> +{
>>> +    while (--len >= 0 && !isalnum(buf[len]));
>>> +    return (size_t) len + 1;
>>
>> This is somewhat unfortunate.  if the caller wants to receive
>> size_t, perhaps it should be passing in size_t (or ssize_t) to the
>> function?  Hard to guess without an actual caller, though.
>
> Ok, I will make it return an int.

Why not adjust the loop condition slightly instead so that you can
continue to accept and return size_t?
