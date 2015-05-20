From: Fredrik Medley <fredrik.medley@gmail.com>
Subject: Re: [PATCH 2/3] upload-pack: prepare to extend allow-tip-sha1-in-want
Date: Wed, 20 May 2015 21:31:32 +0200
Message-ID: <CABA5-zm77sbEvBV2LyFh7hweTjKenZvWWYtwEVZ2XAkDdV3WNg@mail.gmail.com>
References: <CAPig+cQe3=Y15+RBZCxry7-78kbNL6H0PfdYs=OV_DMifOWxaA@mail.gmail.com>
 <1432068269-14895-1-git-send-email-fredrik.medley@gmail.com>
 <1432068269-14895-2-git-send-email-fredrik.medley@gmail.com> <xmqqzj505isz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Dan Johnson <computerdruid@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 20 21:31:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv9ig-0007Dx-IO
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 21:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808AbbETTby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 15:31:54 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:34921 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbbETTbx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 15:31:53 -0400
Received: by lbbuc2 with SMTP id uc2so2227221lbb.2
        for <git@vger.kernel.org>; Wed, 20 May 2015 12:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mXAucvOtPBO7DhNfz9d/1jyuPClgrhY9gBzM+Q9oVBM=;
        b=UUASyzW/DBnLQLyev1IbWbWUaTBQTCtNTqj9ZmUhoCbihNve4m1Xv1rIZ+eKkuxf8J
         te4lQAYgUcj0mFVmXZAysu0McfqppxKHSdr246ngIVkRRlPHn1TpQ9HvHihkz5TJBnYc
         XXp3Ju1JxrSQXfr308p1jYQQY6558FRZaCBJtjK/LmgSO8JgriQW491UO5rJJMJ0WZDn
         R+UfuckzT1oIQPtG5/4BP0v+tE5cjzzewAUskuCOm0q5ErFtmU89e0I0J5rUa6rBrJ7U
         032+umk3ut41xjedBSSNwtwsVTcwCr/MnubAXrUn/aX8vtQAIYFYFeDWdady34Vq1JMM
         2hHQ==
X-Received: by 10.112.139.1 with SMTP id qu1mr27136858lbb.8.1432150312537;
 Wed, 20 May 2015 12:31:52 -0700 (PDT)
Received: by 10.114.246.235 with HTTP; Wed, 20 May 2015 12:31:32 -0700 (PDT)
In-Reply-To: <xmqqzj505isz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269504>

2015-05-20 0:00 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
> Fredrik Medley <fredrik.medley@gmail.com> writes:
>
>>  static int upload_pack_config(const char *var, const char *value, void *unused)
>>  {
>> -     if (!strcmp("uploadpack.allowtipsha1inwant", var))
>> -             allow_tip_sha1_in_want = git_config_bool(var, value);
>> -     else if (!strcmp("uploadpack.keepalive", var)) {
>> +     if (!strcmp("uploadpack.allowtipsha1inwant", var)) {
>> +             if (git_config_bool(var, value))
>> +                     allow_unadvertised_object_request |= ALLOW_TIP_SHA1;
>
> Doesn't this change break the behaviour?
>
> Shouldn't you be able to say
>
>         [uploadpack]
>                 allowTipSHA1InWant = false
>
> in a higher-precedence configuration file to override the same
> variable in other files in the configuration chain that may set it
> to true?

Of course, thought it work differently. Should I add tests with
test_config_global
to check that loading the config works as well?

>
>> +     } else if (!strcmp("uploadpack.keepalive", var)) {
>>               keepalive = git_config_int(var, value);
>>               if (!keepalive)
>>                       keepalive = -1;
>
