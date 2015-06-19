From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH] format-patch: introduce format.outputDirectory configuration
Date: Fri, 19 Jun 2015 23:27:20 +0600
Message-ID: <CANCZXo7Lyo_Sb=bxF9EgZHV35JfrQZ-CFsM9T4yUjkDBndcp8A@mail.gmail.com>
References: <1434626280-4610-1-git-send-email-kuleshovmail@gmail.com>
	<xmqq616ley7y.fsf@gitster.dls.corp.google.com>
	<20150618195751.GA14550@peff.net>
	<xmqqoakceq8s.fsf@gitster.dls.corp.google.com>
	<xmqqk2v0eq75.fsf@gitster.dls.corp.google.com>
	<20150618201323.GB14550@peff.net>
	<20150618202205.GA16517@peff.net>
	<xmqqd20sd70j.fsf@gitster.dls.corp.google.com>
	<CANCZXo72BscpXKGAtVPt_1QuffcOpTz6nGB+__q0JLisuTaKsQ@mail.gmail.com>
	<xmqq616jbse8.fsf@gitster.dls.corp.google.com>
	<CANCZXo5Nyt+JePQP=kvFsjTaV=xKXduoBqAwp5E0CrEf13QK7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 19:27:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z604d-0003f3-TG
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 19:27:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753306AbbFSR1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 13:27:22 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:34440 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686AbbFSR1W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 13:27:22 -0400
Received: by lbbti3 with SMTP id ti3so76200433lbb.1
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 10:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yWP7hz5DMtEBsJ64j2H8O3Ac0pWnHF/Jr2GJ8oPt+6k=;
        b=QsCZrc8v5Qyk7ADa8PjkRe3IHUa/EItklV6Go3cEjP6aexdYaKJgSTBkViy0OYMyqM
         Vhi8f7jobIXmA9a4qHRGUyfAbjLXpvUPgfx/UDso/VzAg7zbzjzx7IohEE5uXdVLJQSx
         ue4metnZNWy9SDPl+Cmq3jwWBpiGAFaSakH3xz0QZWMCEEO6V2Ffj929ClU+BTjH3vu5
         jQuUuZwwNS2LEYJQ2O/zSqI8r5lvzSll2078tOdKc4PO2MEwopMM+PaPOOJLmoWQpCuR
         DSh7D9C/03jzpzgiqWsh57pUiYl4DIhqfKh2t/SWAd2TuM+LFpVxGpJSLEhPFxHeRpBB
         J0uQ==
X-Received: by 10.152.45.9 with SMTP id i9mr18438447lam.87.1434734840794; Fri,
 19 Jun 2015 10:27:20 -0700 (PDT)
Received: by 10.25.62.150 with HTTP; Fri, 19 Jun 2015 10:27:20 -0700 (PDT)
In-Reply-To: <CANCZXo5Nyt+JePQP=kvFsjTaV=xKXduoBqAwp5E0CrEf13QK7g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272170>

Ah, you mean to put this check before. Just tested it and
many tests are broken. Will look on it now

2015-06-19 23:19 GMT+06:00 Alexander Kuleshov <kuleshovmail@gmail.com>:
>> I thought I made that "if we did not see '-o dir' on the command
>> line, initialize output_directory to what we read from the config"
>> before we make a call to set_outdir().
>>
>> What I am missing?
>>
>> Puzzled...  FWIW, IIRC, the patch you are responding to passed the
>> test you added.
>
> Ok, Now we have:
>
> if (!use_stdout)
>         output_directory = set_outdir(prefix, output_directory);
> else
>         setup_pager();
>
> and
>
> if (output_directory) {
>     // test that we did not pass use_stdout and mkdir than
> }
>
> If we didn't pass --stdout and -o the set_outdir will be called
> and there is
>
> static const char *set_outdir(const char *prefix, const char *output_directory)
> {
>     //printf("is_absoulte_path %d\n", is_absolute_path(output_directory));
>     if (output_directory && is_absolute_path(output_directory))
>         return output_directory;
>
>     if (!prefix || !*prefix) {
>         if (output_directory)
>             return output_directory;
>         return "./";
>     }
> ....
> }
>
> So it returns "./", output_directory will not be null. After this
>
>>> +       if (!output_directory && !use_stdout)
>>> +               output_directory = config_output_directory;
>
> clause will not be executed never. Or I've missed something?
>
> Thank you.
