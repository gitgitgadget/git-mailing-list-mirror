From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] http: add support for specifying the SSL version
Date: Thu, 13 Aug 2015 12:37:49 -0400
Message-ID: <CAPig+cQj4-4tnZv1JkUZdGHzgL=x2f6Zg7JeYn5bBgp991WNhg@mail.gmail.com>
References: <1439479731-16018-1-git-send-email-gitter.spiros@gmail.com>
	<CAPig+cTug2Q3v1K5r76fhJ6OQY9V1e6MbiXQBGQJD51TCOGW=A@mail.gmail.com>
	<CA+EOSBkSkvvBQDpxL_ygj+2haMk1U7T00-Xmxn8iyXcnV6RN5Q@mail.gmail.com>
	<CAPig+cSC2a07RYioQ4+sw=pujFW8=sv_d5vv=XiayuSg7FBcHw@mail.gmail.com>
	<CA+EOSBkOGzyOB-NRGTNm0b==OZH7eB=sZaGa0mRa4798_v-EHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?Q?Galan_R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 18:37:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPvVq-0001me-9d
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 18:37:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632AbbHMQhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 12:37:50 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:34515 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122AbbHMQht (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 12:37:49 -0400
Received: by ykdt205 with SMTP id t205so46136718ykd.1
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 09:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=HHHi9/hHvzBAONDlQzcH8xj0dGaqI50Tsvy89dHJngk=;
        b=fCs0cL98/q5ERabYmHLrNxzlX8426eh5YclEwiuOlDhysDCZfZQq0cSapuDkSNPwce
         vcU30Jh9sxsbJEWFgcwTFjMMn3AWIqoRcerx2OPOSTAMKE4fj3dPtIw1snstB7PJ0mOz
         mB9goZEGxRHrzGjDtq9fwl9Vx26n7mryivKA2jrt4oQmh2bISuKOanux7K/PLW0oMh69
         iF2Qef5BoNJfeaYFMBiy2iFhVbXjBgh5t29fh8BPfVP8O8irOzTO/TQS06Z5hlgpSZff
         WCXbjzZaodrt+a89YMZYrIoPErWC2fo+hdrsB7B+4r+nfJ8plzUk8OOFs+TnVKdNe2wU
         xmqA==
X-Received: by 10.13.220.132 with SMTP id f126mr40492215ywe.39.1439483869121;
 Thu, 13 Aug 2015 09:37:49 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Thu, 13 Aug 2015 09:37:49 -0700 (PDT)
In-Reply-To: <CA+EOSBkOGzyOB-NRGTNm0b==OZH7eB=sZaGa0mRa4798_v-EHQ@mail.gmail.com>
X-Google-Sender-Auth: 1AhxWQE1Iz4DkWkxuU20OJ1BUi0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275859>

On Thu, Aug 13, 2015 at 12:15 PM, Elia Pinto <gitter.spiros@gmail.com> wrote:
> 2015-08-13 18:11 GMT+02:00 Eric Sunshine <sunshine@sunshineco.com>:
>> On Thu, Aug 13, 2015 at 11:58 AM, Elia Pinto <gitter.spiros@gmail.com> wrote:
>>> 2015-08-13 17:47 GMT+02:00 Eric Sunshine <sunshine@sunshineco.com>:
>>>>> +       if (ssl_version != NULL && *ssl_version) {
>>>>> +               int i;
>>>>> +               for ( i = 0; i < ARRAY_SIZE(sslversions); i++ ) {
>>>>> +                       if (sslversions[i].name != NULL && *sslversions[i].name && !strcmp(ssl_version,sslversions[i].name)) {
>>>>
>>>> This sort of loop is normally either handled by indexing up to a limit
>>>> (ARRAY_SIZE, in this case) or by iterating until hitting a sentinel
>>>> (NULL, in this case). It is redundant to use both, as this code does.
>>> I do not think. sslversions[i].name can be null, see how the structure
>>> is initialized. No ?
>>
>> The initialization:
>>
>>     static struct {
>>        const char *name;
>>        long ssl_version;
>>        } sslversions[] = {
>>            { "sslv2", CURL_SSLVERSION_SSLv2 },
>>            ...
>>            { "tlsv1.2", CURL_SSLVERSION_TLSv1_2 },
>>            { NULL }
>>     };
>>
>> terminates the list with a NULL sentinel entry, which does indeed set
>> sslversions[i].name to NULL. When you know the item count ahead of
>> time (as you do in this case), this sort of end-of-list sentinel is
>> redundant, and complicates the code unnecessarily. For instance, the
>> 'sslversions[i].name != NULL' expression in the 'if':
>>
>>     if (sslversions[i].name != NULL && *sslversions[i].name ...
>>
>> is an unwanted complication. In fact, the '*sslversions[i].name'
>> expression is also unnecessary.
> I agree. But this is what  suggested me Junio: =). What do I have to do ?
> It becomes difficult to keep everyone happy: =)

You're referring to [1] in which Junio's example table initialization
had the NULL sentinel. That approach is fine, and my earlier comment:

    This sort of loop is normally either handled by indexing up to a
    limit (ARRAY_SIZE, in this case) or by iterating until hitting a
    sentinel (NULL, in this case). It is redundant to use both...

wasn't saying that you shouldn't use the NULL sentinel. It said only
that you should choose one approach rather than complicating the code
unnecessarily by mixing the two.

So, your loop can either look like this, if you use the NULL sentinel:

    struct ssl_map *p = sslversions;
    while (p->name) {
        if (!strcmp(ssl_version, p->name))
            ...
    }

or like this, if you use ARRAY_SIZE:

    for (i = 0; i < ARRAY_SIZE(sslversions); i++) {
        if (!strcmp(ssl_version, sslversions[i].name))
            ...
    }

Each loop form is valid, and (other than the fact that the compiler
knows the array size, thus slightly favoring the ARRAY_SIZE form) the
choice of which of the above two forms to use isn't that important,
and you can choose whichever you like, but please do choose one of the
above two. If you feel that Junio would be happier with the
NULL-sentinel form, then go with that.

[1]: http://article.gmane.org/gmane.comp.version-control.git/275773
