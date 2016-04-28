From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv4 1/2] http.c: implement the GIT_TRACE_CURL environment variable
Date: Thu, 28 Apr 2016 10:48:38 -0700
Message-ID: <CAGZ79kaqDa5Bo2EQ-1VO6H5UpLun7emWPTmgoBAEeNaWJBaEnw@mail.gmail.com>
References: <20160428115748.37177-1-gitter.spiros@gmail.com>
	<20160428115748.37177-2-gitter.spiros@gmail.com>
	<CAGZ79kYe-WsAJj3xkr9YkHZbHqQ9rhKV80+K0Bx3SZsB85+tHA@mail.gmail.com>
	<20160428174423.GA32486@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Elia Pinto <gitter.spiros@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 28 19:48:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avq3S-0006XC-TG
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 19:48:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752438AbcD1Rsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 13:48:43 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:33898 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbcD1Rsl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 13:48:41 -0400
Received: by mail-ig0-f170.google.com with SMTP id u5so4584718igk.1
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 10:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=HTOnTOVyqfjzZ3ckb6bE5AUKPD9+1q8V//WmANK4FXg=;
        b=SPAny4IzVHOkqQLerC2ftTjxnuUNPbyLZ7edfbcEF58emqag+8Cm265TccsP9rPhYI
         pERLSYjPOQgHlOP456ZpwkJI/0ZGZW1TpaHQ5apq/teKAo6kELm3V77+25wTXOTGkgS5
         ZWZWZ7s/g7bMuQJ5LcBZUoWaAN3CyJWlbqP8pO2sevHZKGsSkUQ9TtC+jCNOj4b4fR+b
         jVsXWN2mp6XO6Jv8ifhMNc3UUJz2agruqe3IQjEa6gf+9x0EpTc+K1UYWbb+NE8R49do
         84rI6lbxrdz6XJpxquQj1xcrQ5uCKCudq3KDpIdTZplLCGqWnSrB5O8dIKA554o5py2B
         Jq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=HTOnTOVyqfjzZ3ckb6bE5AUKPD9+1q8V//WmANK4FXg=;
        b=Z/Brs5h+MfZ+uMjvA1kOiKd05D5R54NRQ4GkFZe4LejHgQVlku66TWaXxk+ELx2hkl
         VUu+IHfZfphGNbXMGPe+EokrzFB6VDklI8OkLg1iK339I1RKoQcwgf8aH+fMMJmLAvKh
         AjkYpJf1sZLAXecTgb3sI5dzwvcDrfd1mGpyB3K/YNSLDL5m1ytu59zUa5EuQWqmsyVN
         pvfaBNoCvSUaNhzbszRdjLU4q5sD8+yhGBnkOilKj1PZYmmWFv9Y60UTjC2oSgeo5aZ4
         Y4Sze+7qmTTjhBLlBLgSRx1g5NLJSTrlFdQWKmjI+63uAYYHm/FKdy/z8lXsiC6b5cW1
         4IbQ==
X-Gm-Message-State: AOPr4FUckQVlZkD3DaR7Q4nb+I1dBmG4k1BeuVaefkpXIVdmZwrbUL0d2TuBz2qJ1sJOjdJjk/iSU9bAzbioVQBF
X-Received: by 10.50.111.15 with SMTP id ie15mr20467904igb.94.1461865718999;
 Thu, 28 Apr 2016 10:48:38 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 28 Apr 2016 10:48:38 -0700 (PDT)
In-Reply-To: <20160428174423.GA32486@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292930>

On Thu, Apr 28, 2016 at 10:44 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Apr 28, 2016 at 10:26:06AM -0700, Stefan Beller wrote:
>
>> > +'GIT_TRACE_CURL'::
>> > +       Enables a curl full trace dump of all incoming and outgoing data,
>> > +       including descriptive information, of the git transport protocol.
>> > +       This is similar to doing curl --trace-ascii on the command line.
>> > +       This option overrides setting the GIT_CURL_VERBOSE environment
>> > +       variable.
>>
>> How does it overwrite the GIT_CURL_VERBOSE variable?
>
> You can't use both, as they are both triggered using the CURLOPT_VERBOSE
> option of curl. The main difference is that with GIT_CURL_VERBOSE, we
> rely on curl to print the information to stderr. With GIT_CURL_TRACE, we
> do the printing ourselves (so we can tweak the output format, send it to
> places other than stderr, etc).

Well that's the information I'd rather find in the documentation
than in a mailing list archive ;)

>
>> After a quick `grep -r GIT_CURL_VERBOSE`, I notice 2 things:
>>
>> * apparently GIT_CURL_VERBOSE is used as a boolean,
>>   so I presume we assume True for GIT_CURL_VERBOSE, but
>>   extend it?
>
> It's not a boolean. If the variable exists at all, we turn on verbose
> output (so I guess you can consider it a boolean, but we do not parse
> its contents as boolean; GIT_CURL_VERBOSE=false does not do what you
> might think).
>
>> * GIT_CURL_VERBOSE is not documented at all. (It is mentioned in
>>   the release notes for 2.3.0, not sure if that counts as documentation)
>>   As you know the area, care to send a documentation patch for
>>   GIT_CURL_VERBOSE?
>
> I think there is no need for GIT_CURL_VERBOSE once we have
> GIT_TRACE_CURL. The latter is more flexible and matches the GIT_TRACE_*
> interface we use elsewhere.
>
> So I think we should consider GIT_CURL_VERBOSE deprecated (though I do
> not mind keeping it for old-timers since it is literally one line of
> code).

I see, so by this patch there is no need to document
GIT_CURL_VERBOSE any more?

>
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
