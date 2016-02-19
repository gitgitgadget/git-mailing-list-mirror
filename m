From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv13 5/7] git submodule update: have a dedicated helper for cloning
Date: Fri, 19 Feb 2016 11:10:37 -0800
Message-ID: <CAGZ79kY_qYdCgJ=8oQKdj4TF2gSaYwhE1c8KjnLwOiUFa9YjPg@mail.gmail.com>
References: <1455838398-12379-1-git-send-email-sbeller@google.com>
	<1455838398-12379-6-git-send-email-sbeller@google.com>
	<20160219120310.GB10204@sigill.intra.peff.net>
	<CAGZ79kbp+A1J4isLGftMiA2UZM16NO6nUycraj4U==2Zv6kHVQ@mail.gmail.com>
	<CAPig+cR6SKwM7x=n6fdZDscm2GLTNQq-ZNvB-ELqAk6dk1jGFw@mail.gmail.com>
	<20160219190821.GA777@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 19 20:10:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWqRv-0007tO-Ke
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 20:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1427896AbcBSTKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 14:10:39 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:34095 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030273AbcBSTKi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 14:10:38 -0500
Received: by mail-ig0-f182.google.com with SMTP id g6so45869468igt.1
        for <git@vger.kernel.org>; Fri, 19 Feb 2016 11:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dT25D7I7qUoqKRjye0cmo4ECRe1l0Xcye5hCiMkHw4Q=;
        b=k09wUhx7dJKPemYxEGSoSMAKJ1nzkQDZYu15Q+8rdTB7tGHScE0lSpV200bUmA9AlB
         LtNk2bAAc2Ir88dXlPkHFQ8DTV17cpQOR+8t+tCOaXSul6N+F41Y3ZYwRtzv8qcaE4zM
         fJUu4Jldx9zpCWXPkP+oYo9xXHKiLpsLAPVh84CBOCzzG1sEJd3ikCVXC3G009CXT+t1
         ubRtxzsgQDzuhNlojO7Lsnst5QqUieDwkQ5/cC/EU3kehQSwqokivgqMxdlcG64G9KWW
         m1TQSEf/J2vBkprhnYORdkk3fznhI7gmvcHcX3rONdkG875XCUYnm0y1oUupk1gnO6DO
         BOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=dT25D7I7qUoqKRjye0cmo4ECRe1l0Xcye5hCiMkHw4Q=;
        b=aKN4+rxA9Do0qcOla4/AfEMkRG6hS3jbKHGYulEBn5oGDG1AAMFvCABMfjJPxnCFTj
         AqTd7q5NpAMTOH2uyOP/m5N/ZRnc8Lg/lo7yjqZUs46mpHaf4ZVeY5cRhJ95T1o9Zjf9
         g0JOrIMBcw50szvktxlSl+QCJVgJcGbIRNOEHodKTKJiGrAKZOBcqudllsEQJIHTcyGH
         lownVi8+JrG1w+EhsvOIuP5WAtnBM+CZ4SSi4x8idDkKFidst6bO+jwVF/SDFiITlfZB
         KJ1oTLvhz2jOV239h1Rf7b5zUB/Mqji7i7SNRNMyAq/qVfaxC4dSxYqsImDqWNVtwZAE
         TGKw==
X-Gm-Message-State: AG10YOS0Ivl1h6zmwsFKc8OSNpzP0a+QCOzgaxRm+xSOGT2k6RryW1O2IKoMVNUv5tbZHTbm4XK8nl6ZX0fW0Mm0
X-Received: by 10.50.85.105 with SMTP id g9mr8599907igz.85.1455909037997; Fri,
 19 Feb 2016 11:10:37 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Fri, 19 Feb 2016 11:10:37 -0800 (PST)
In-Reply-To: <20160219190821.GA777@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286741>

On Fri, Feb 19, 2016 at 11:08 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Feb 19, 2016 at 12:20:48PM -0500, Eric Sunshine wrote:
>
>> >>> +             argv_array_pushl(&cp->args, "--path", sub->path, NULL);
>> >>> +             argv_array_pushl(&cp->args, "--name", sub->name, NULL);
>> >>> +             argv_array_pushl(&cp->args, "--url", strdup(url), NULL);
>> >>
>> >> No need to strdup() here; argv_array handles its own memory, so this
>> >> just leaks (and if we were keeping it, it should be xstrdup(), of
>> >> course).
>> >
>> > We cannot remove the strdup as the url is a local variable we read in from
>> > git_config_get_string and the local variable is going out of scope before the
>> > child process ends?
>> >
>> > I'll change it to xstrdup then.
>>
>> When Peff said "argv_array handles its own memory", he meant that it
>> does xstrdup() itself, so there's no need for you to do so a second
>> time manually (leaking a string as a consequence).
>
> Exactly. :) Sorry for not being clear the first time around.

Sorry for being confused to easily. I should have just read the code of
argv_array_pushl before answering. In the resend I removed the strdup.

Thanks,
Stefan

>
> -Peff
