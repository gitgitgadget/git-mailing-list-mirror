From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 1/4] bisect--helper: `bisect_clean_state` shell function
 in C
Date: Wed, 8 Jun 2016 11:41:15 +0200
Message-ID: <CAP8UFD0Q7WnKpoY76w5Lqr4P6fCo4KboiwfrZ-L+q+h5Lhysjw@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <CAPig+cTqk0d60Omsm12RXF2uzoxoPjbqHj7V8Y=6Uu+fH5b43Q@mail.gmail.com>
 <CAFZEwPMJbKAOdffWs7QedB+4j32LaBZeV1iGpUuGntMjXeN3hg@mail.gmail.com> <CAPig+cTiqRAnhBx6eCifdOmES1uD3piPYgsRHNMVFCO07W1nTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 11:42:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAZzv-0003va-8P
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 11:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424106AbcFHJlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 05:41:25 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34437 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423858AbcFHJlR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 05:41:17 -0400
Received: by mail-wm0-f65.google.com with SMTP id n184so1498710wmn.1
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 02:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AuNZz0/BakmP7+NX533DC882PTeIJyolzvnQoTbl5Eg=;
        b=LKK6nVYM/2Y21v4038VhVsgLPjPGIOmWnj29+Dk1D12YjfWiVjuPjZxGK3a5VFrqiN
         hxWoH0w87kCBzWTqVo66XKJO9nai056Z0wQWt/c0f5eiOjpFKjxDw7awIplD6jqbGXXs
         TlTWRJMTjcla2a9T3lm7ixOJKn1o7P3jwJik6He9p0Vom37avp84KFHBy8WdKvSvZ9Nm
         3K2OmJkd0WAK+wq17Rb9f0Z6NOuqiWVllPTbP14kD2xs70HxIzjwUqTt6NLvaoXYzwA7
         JBTZDhy+17Cct9fhFvMSB/Ad87cy9LkaqYaqe1cjAo7O0tlv/Y+nxid4376idOzjYf/n
         L6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AuNZz0/BakmP7+NX533DC882PTeIJyolzvnQoTbl5Eg=;
        b=i2XhYbjUpcw+VslD7Lyb6oTvf/WyTn73UOwtfpnsINi3WdoIzbTFjJ/rn1fT8Pae45
         IfbaVL/pGA+BjtnJKrSA/MmrlP9IHkmDjsdVVXTJlXpexw9TV4ovRN+ivJZvYHdAEc/k
         woM7kao/B1Jvwpdto58N7XwN8/033UaCwPWNUnaEFAY1yTTyVjMZDtJ6D6Oxouc0ifvR
         fkkY9aodcLGcDWyBz37Q10RdTWiYPSN7ZND+n+sm2JC6Jwi/NwcGCQzFasjnfGCJw8iy
         bmUZN6FY4kFR5Ye62Cz7FztDs+pofz2OaPI76oMGdo3lUSL6yXtWRrk3Z7cPOc941ch4
         UERQ==
X-Gm-Message-State: ALyK8tKKnk6g66eTuqJhzGQ+6BJi2USepy8fKzz7Qwvq4ayhM+ylfpB0TIKhyF2232bRYiy/BsqhZk8fqtIqFg==
X-Received: by 10.28.94.194 with SMTP id s185mr4134574wmb.62.1465378876241;
 Wed, 08 Jun 2016 02:41:16 -0700 (PDT)
Received: by 10.194.148.146 with HTTP; Wed, 8 Jun 2016 02:41:15 -0700 (PDT)
In-Reply-To: <CAPig+cTiqRAnhBx6eCifdOmES1uD3piPYgsRHNMVFCO07W1nTg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296776>

On Wed, Jun 8, 2016 at 10:02 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Jun 8, 2016 at 3:46 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> On Wed, Jun 8, 2016 at 4:01 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Tue, Jun 7, 2016 at 4:54 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>>> +       struct string_list *refs = cb_data;
>>>> +       char *ref = xstrfmt("refs/bisect/%s", refname);
>>>
>>> Here you're allocating a string...
>>>
>>>> +       string_list_append(refs, ref);
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +int bisect_clean_state(void)
>>>> +{
>>>> +       int result = 0;
>>>> +       struct string_list refs_for_removal = STRING_LIST_INIT_DUP;
>>>> +       for_each_ref_in("refs/bisect/", mark_for_removal, (void *) &refs_for_removal);
>>>
>>> ...and the allocated string gets inserted into a string_list which
>>> itself duplicates the string (STRING_LIST_INIT_DUP), so this is
>>> leaking the string you created with xstrfmt(), isn't it?
>>
>> Yes nice catch. I would prefer using the string_list with
>> STRING_LIST_INIT_DUP and free the ref.
>
> That's unnecessarily wasteful. Better would be to to use STRING_LIST_INIT_NODUP.

In this case it is not possible to append "BISECT_HEAD" to
'refs_for_removal' before calling delete_refs() like this:

+       for_each_ref_in("refs/bisect/", mark_for_removal, (void *)
&refs_for_removal);
+       string_list_append(&refs_for_removal, "BISECT_HEAD");
+       result = delete_refs(&refs_for_removal);
+       string_list_clear(&refs_for_removal, 0);

And I think it's better to delete all the refs in the same call to
delete_refs().
