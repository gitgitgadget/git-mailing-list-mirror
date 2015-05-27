From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/WIP PATCH 04/11] upload-pack-2: Implement the version 2 of upload-pack
Date: Wed, 27 May 2015 13:30:28 -0400
Message-ID: <CAPig+cSFEN+V0668FPDM1jY2KdW_nVaEn7+AOWJj_KwUU_UVPw@mail.gmail.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
	<1432677675-5118-5-git-send-email-sbeller@google.com>
	<20150527063558.GB885@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 27 19:30:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxfA1-00053Q-Vm
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 19:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946AbbE0Ra3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 13:30:29 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:38629 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726AbbE0Ra3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 13:30:29 -0400
Received: by igbjd9 with SMTP id jd9so4438921igb.1
        for <git@vger.kernel.org>; Wed, 27 May 2015 10:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=qJckbIof6fmfnpXRq3PPP9zzp7yoXBJB3qGIcYgtVUU=;
        b=qZdWQtW5DMTt7OhWdBDaQcCOmmx/SY/FXpsALiYQxrcfvjlYjqy/oosVZe6lupIDxM
         vRdZ85R9i+VBrMLCM3yZhtocoURH8/m+/uaBtM5NveuU+tkurSnSX+PRkcbky7GafX3k
         AC3fUHE4L6ChdAgZSBLxtifqiUR5QpRnBiYZPtb4QKGuRTczohZ/NyUGur56hdPJEzmW
         k+DA0NoCtQgR49lcETqFBY4C+uv3U5Nopml1uomElYhmdL7ARnybnJ1TZqOKmaeGy+yS
         JL1fknKNLj1LlOU4uP7MpTRqY3GeZJdXvgdaQDCxddOeUU9A2KvaCY/DpuA6YpDs3LDy
         RO8A==
X-Received: by 10.107.31.134 with SMTP id f128mr43668065iof.19.1432747828292;
 Wed, 27 May 2015 10:30:28 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Wed, 27 May 2015 10:30:28 -0700 (PDT)
In-Reply-To: <20150527063558.GB885@peff.net>
X-Google-Sender-Auth: ceMYyktFY7lJWISUICdVb_w3jec
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270060>

On Wed, May 27, 2015 at 2:35 AM, Jeff King <peff@peff.net> wrote:
> On Tue, May 26, 2015 at 03:01:08PM -0700, Stefan Beller wrote:
>> +static void send_capabilities(void)
>> +{
>> +     char buf[100];
>> +
>> +     while (next_capability(buf))
>> +             packet_write(1, "capability:%s\n", buf);
>
> Like Eric, I find the whole next_capability thing a little ugly. His
> suggestion to pass in the parsing state is an improvement, but I wonder
> why we need to parse at all. Can we keep the capabilities as:
>
>   const char *capabilities[] = {
>         "multi_ack",
>         "thin-pack",
>         ... etc ...
>   };
>
> and then loop over the array?

Yes, that would be much nicer. I also had this in mind but didn't know
if there was a strong reason for the capabilities to be shoehorned
into a single string as they are currently.
