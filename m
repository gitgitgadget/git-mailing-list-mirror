From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/4] bisect--helper: `bisect_clean_state` shell function
 in C
Date: Wed, 8 Jun 2016 13:59:09 -0400
Message-ID: <CAPig+cQ5z+-59BCjPXNaSQWkSyTt56yAnRo49Lba6_wjkWRp-w@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <CAPig+cTqk0d60Omsm12RXF2uzoxoPjbqHj7V8Y=6Uu+fH5b43Q@mail.gmail.com>
 <CAFZEwPMJbKAOdffWs7QedB+4j32LaBZeV1iGpUuGntMjXeN3hg@mail.gmail.com>
 <CAPig+cTiqRAnhBx6eCifdOmES1uD3piPYgsRHNMVFCO07W1nTg@mail.gmail.com> <CAP8UFD0Q7WnKpoY76w5Lqr4P6fCo4KboiwfrZ-L+q+h5Lhysjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:10:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAhl7-0004xm-QW
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 19:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755504AbcFHR7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 13:59:13 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36062 "EHLO
	mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225AbcFHR7M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 13:59:12 -0400
Received: by mail-it0-f68.google.com with SMTP id h190so2231727ith.3
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 10:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=LjLYqlv2vMMb53XuGBO8yfhwBYul46zj7LzAKMDH2NI=;
        b=QL/KeIqUnb440I2JlyYQrheEKrch3MmO/z0FiXTKRCATcss3PDddQwMMdGZhptG1EC
         TSi8hh3nVwDGTc3q7+zo4a/S0MfM2aloMLtf5ufQ0VKRi/kongKpPud0RMW+VBZT/tmX
         h5MCvgPRB8b08AltTLicTBulQCsJrPJPv9juFUbi74w2yy4PXUjTxhNIJJYVRw9XPGgY
         E7/n5QLj9Xq2t5EEwOnfeHYJXDd9RMkcUsfvZYWZqcXCQARMFXK+D26ThwOrXs6LCkLM
         rgKt3c0xdcHYx+dCLqE9OMNChpexJbfD9wudm39bX8A4MmIpC3Eb5dc3aT3ajTnYALjM
         iFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=LjLYqlv2vMMb53XuGBO8yfhwBYul46zj7LzAKMDH2NI=;
        b=A7WTaVJyvuUqTa4kerUIgDUy6dcZ9mrMb9h3EdPy5xGXQxSGru8k1kQxjp+t1j8Nw1
         RniXXmy3xkji08BpkqPI9g2/guVJ7RjVEP1MJS07wEODPNsqHQITPXYC4bQClFWmHZm9
         X23ycCaBvIpbrcsSq5iFAt1/LyN/OHS2xkQr0bIKTb99pShGgy0jslhEltk6tcGEGRDh
         CenikqDYzkFAlKmb+D/fIbpLv3t4hDBMSQR+hsKGlj81NQhTYU56MBB+zEXtDAavIhP3
         etxHYBW0CXivUj5AicsOpqaCLGL+Y1YiYfyveisN0GQqDME92G9GHk9Ac6qXJ/9BEI7H
         Hnqw==
X-Gm-Message-State: ALyK8tI5gVXXEXpOcAkmijGswapdSIrslrK9ROM6ohowrcTJqgm2qD2avmj3ZXQKpfTBGCJhlq7uUSyqnUliiA==
X-Received: by 10.36.55.138 with SMTP id r132mr15249209itr.73.1465408749868;
 Wed, 08 Jun 2016 10:59:09 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Wed, 8 Jun 2016 10:59:09 -0700 (PDT)
In-Reply-To: <CAP8UFD0Q7WnKpoY76w5Lqr4P6fCo4KboiwfrZ-L+q+h5Lhysjw@mail.gmail.com>
X-Google-Sender-Auth: uBQ_d8CikAGqeyNhqL0z1j_YNgY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296821>

On Wed, Jun 8, 2016 at 5:41 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Wed, Jun 8, 2016 at 10:02 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Wed, Jun 8, 2016 at 3:46 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>> On Wed, Jun 8, 2016 at 4:01 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>> On Tue, Jun 7, 2016 at 4:54 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>>>>> +       struct string_list *refs = cb_data;
>>>>> +       char *ref = xstrfmt("refs/bisect/%s", refname);
>>>>
>>>> Here you're allocating a string...
>>>>
>>>>> +       string_list_append(refs, ref);
>>>>> +       return 0;
>>>>> +}
>>>>> +
>>>>> +int bisect_clean_state(void)
>>>>> +{
>>>>> +       int result = 0;
>>>>> +       struct string_list refs_for_removal = STRING_LIST_INIT_DUP;
>>>>> +       for_each_ref_in("refs/bisect/", mark_for_removal, (void *) &refs_for_removal);
>>>>
>>>> ...and the allocated string gets inserted into a string_list which
>>>> itself duplicates the string (STRING_LIST_INIT_DUP), so this is
>>>> leaking the string you created with xstrfmt(), isn't it?
>>>
>>> Yes nice catch. I would prefer using the string_list with
>>> STRING_LIST_INIT_DUP and free the ref.
>>
>> That's unnecessarily wasteful. Better would be to to use STRING_LIST_INIT_NODUP.
>
> In this case it is not possible to append "BISECT_HEAD" to
> 'refs_for_removal' before calling delete_refs() like this:
>
> +       for_each_ref_in("refs/bisect/", mark_for_removal, (void *)
> &refs_for_removal);
> +       string_list_append(&refs_for_removal, "BISECT_HEAD");
> +       result = delete_refs(&refs_for_removal);
> +       string_list_clear(&refs_for_removal, 0);
>
> And I think it's better to delete all the refs in the same call to
> delete_refs().

string_list_append(&..., xstrdup("BISECT_HEAD"));

perhaps?
