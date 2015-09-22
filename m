From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] format-patch: introduce format.outputDirectory configuration
Date: Mon, 21 Sep 2015 20:05:00 -0400
Message-ID: <CAPig+cQsfTz7UzVcB1D8iu5on0o7E9nOv=WtzrR-GBmm=cdEpw@mail.gmail.com>
References: <1434738519-28093-1-git-send-email-kuleshovmail@gmail.com>
	<CAPig+cTOG7QP25TyJbbm70NBXN6Z0nZPJyjxFp1y147WQmKEDg@mail.gmail.com>
	<xmqqk2rj8kf5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 02:05:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeB52-0005oJ-Bt
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 02:05:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753004AbbIVAFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 20:05:03 -0400
Received: from mail-vk0-f49.google.com ([209.85.213.49]:36323 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782AbbIVAFB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 20:05:01 -0400
Received: by vkfp126 with SMTP id p126so75867480vkf.3
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 17:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=rgUqr7O3jdZ8ZUBEmdnAoPYskY/FMbKQbz3Cs9B8Qls=;
        b=QXM7F2q3kINSBBJeuNJBp0Rj3bIehK9cwqUjlUlUGNFZYyL2uiPZ2t4FEXQSxBhg5t
         Vx8T+xzwfbBt+29AQM7YRCNlMmubrR1FIGEEvJudLLu3I2MiXwyaQ80bm90bNjZEuKp+
         fqDj2XOxtPGtE9hZNRE3ge37QwlqwsvcdE8QlsPUvlDGJCRXEQfj2YrKnpq01e0H3oCN
         pT6TU17lvD9dNi4m/W1lJVJHsZPZE1hW1v+q6q4AsSCBPEpAbNumK0rTnHL/h/Q83nZr
         fkiwynydfRS0GdmqtVkMC51vzH/i3eWRohcFE25sJ76Lb5qrbcJH/tnzrFp7MTEY60L3
         nm1Q==
X-Received: by 10.31.56.193 with SMTP id f184mr15192806vka.115.1442880300340;
 Mon, 21 Sep 2015 17:05:00 -0700 (PDT)
Received: by 10.31.224.68 with HTTP; Mon, 21 Sep 2015 17:05:00 -0700 (PDT)
In-Reply-To: <xmqqk2rj8kf5.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: Kt0o73Qxp1ZCMcD2XB8FOedlmvg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278365>

On Mon, Sep 21, 2015 at 6:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> On Fri, Jun 19, 2015 at 2:28 PM, Alexander Kuleshov
>> <kuleshovmail@gmail.com> wrote:
>>> We can pass -o/--output-directory to the format-patch command to
>>> store patches not in the working directory. This patch introduces
>>> format.outputDirectory configuration option for same purpose.
>>>
>>> The case of usage of this configuration option can be convinience
>>
>> s/convinience/convenience/
>>
>>> to not pass everytime -o/--output-directory if an user has pattern
>>
>> s/everytime/every time/
>>
>>> to store all patches in the /patches directory for example.
>>>
>>> The format.outputDirectory has lower priority than command line
>>> option, so if user will set format.outputDirectory and pass the
>>> command line option, a result will be stored in a directory that
>>> passed to command line option.
>>>
>>> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
>>> ---
>
> Looks like there were mostly editorial niggles and no fundamental
> flaws in the design of the patch; it is somewhat a shame to make all
> the efforts go to waste.  Will we be seeing an update soon?

Looking at the new test a bit more closely...

    test_expect_success "format-patch format.outputDirectory option" '
        git config format.outputDirectory "patches/" &&
        git format-patch master..side &&
        cnt=$(ls | wc -l) &&
        test $cnt = 3 &&
        test_config format.outputDirectory "patches/" &&
        git config --unset format.outputDirectory
    '

I'm wondering what it's really testing. I presume that it wanted to
count the number of files in the 'patches/' directory, however, the
'ls' is being invoked in the test trash directory instead. It turns
out that the trash directory has three entries at this point, so the
test succeeds, but entirely by accident.
