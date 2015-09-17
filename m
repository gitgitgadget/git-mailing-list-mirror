From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 01/10] strbuf: Add strbuf_read_noblock
Date: Thu, 17 Sep 2015 09:51:46 -0700
Message-ID: <CAGZ79kb+GgPaHgVze+q3W99cJ+b2SzdX_DfjLSQCvvLjbDXmbA@mail.gmail.com>
References: <1442453948-9885-1-git-send-email-sbeller@google.com>
	<1442453948-9885-2-git-send-email-sbeller@google.com>
	<xmqqtwqtja6j.fsf@gitster.mtv.corp.google.com>
	<20150917163012.GB25837@sigill.intra.peff.net>
	<CAPc5daVY=t27wkX2x7DSfObwxZuv37VYxi1XD-RKiS1mv4=6KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 18:51:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZccPY-0003dD-Tc
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 18:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbbIQQvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 12:51:48 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:33563 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbbIQQvr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 12:51:47 -0400
Received: by ykft14 with SMTP id t14so22756615ykf.0
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 09:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=eXpsMWA9MtWJCLroioE05UyAEL94A+0AWb0cnGNDtuU=;
        b=NmAjQtj4JjC6q3uWBLihNWUnbgC46FOp4DfnHuL49wEQ1ZU4+bL7Lk6IUeoNlhaqqc
         gAecIB3F8e50HhJOVobj1V0mMqqHZIxnGyoP9ozzIvuxrIUN7ZHYQ73wqBO6hUbwVUUt
         C0sXerGEYEagwPPR22/N/2fVWV68kr/SKNQYkxkExBjNl/JGsCIp3X08qW2cL7lXKcGy
         7Cfiiug5eXB6yk7R/MMe6K/XQUo1dH9DMd94SEm/kw2Iy6YH4LViwOEgFS2nGmRorPD1
         UqnrHFAGzLYb9gqzEliaNvULJmNZ5ctH2zK5Lu85lKoa97T/yDhO0rLPH8aKx7tDFMiy
         C2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=eXpsMWA9MtWJCLroioE05UyAEL94A+0AWb0cnGNDtuU=;
        b=mutXnGQzjc8to+xbxTSS9q7k1MyjSUmmBAYraSSN1loZLRWWYEXKxqsl0a7UgqbrLk
         xS99dGVaI03eSIjQ1MJ/mI2Wk8KYe3zlXB3/GH76D+5eDSkGWj9NJt+DX545oK4KWfbj
         iFF0xHRfLb6Ei9XIL8P5UZrUT6ij26IBtoGoS3IqF3PZ4u7GOHiytiIx6UEMB/eDz1mB
         QnxJSVnrjZcwM5vZvGe50G9J6TApQ3TbuRz8VpYI2TiT25Es8N33FHnibfoHQVwlCxJg
         vIaO/+Nr/8EGFiK0uH8E0zzVzWBU0BmPPkHFsW+p3OJMlodc1adCbq6ffwdZf9SLAFKX
         dUzA==
X-Gm-Message-State: ALoCoQk+6yqiKzlbjRuU70MhL3BV1pzZs30MKNFOH1ccxEsptbC+yTJW1G6SypgvdxdWDUzuohe9
X-Received: by 10.129.116.84 with SMTP id p81mr126077ywc.1.1442508707045; Thu,
 17 Sep 2015 09:51:47 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Thu, 17 Sep 2015 09:51:46 -0700 (PDT)
In-Reply-To: <CAPc5daVY=t27wkX2x7DSfObwxZuv37VYxi1XD-RKiS1mv4=6KA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278137>

On Thu, Sep 17, 2015 at 9:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> On Thu, Sep 17, 2015 at 9:30 AM, Jeff King <peff@peff.net> wrote:
>>
>> So I think we would probably want to treat EAGAIN specially: return -1
>> to signal to the caller but _don't_ truncate the strbuf.
>
> Yeah, "don't truncate" is needed.
>
>> Arguably we should actually return the number of bytes we _did_ read,
>> but then caller cannot easily tell the difference between EOF and
>> EAGAIN.
>
> Why can't it check errno==EAGAIN/EWOULDBLOCK?

Grepping through Gits sources, there are no occurrences of
explicitly setting  O_NONBLOCK except for the newly introduced
spot in the followup patch in run-command (yes we do poll there).

So how would I find out if a fd is blocking or not in the 82 cases
of strbuf_read? (Now I naively assume they would all block.)

We could also expose the flags in the API. I think IGNORE_EAGAIN
might not be the best now, but rather a NO_TRUNCATE flag would do.
