From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/PATCH] pathspec: allow escaped query values
Date: Wed, 1 Jun 2016 19:20:39 -0700
Message-ID: <CAGZ79kZSB-r-GzS1WVtLk-sX068PDXQ1h-1FV-8YZFGGsr3hWQ@mail.gmail.com>
References: <20160601235233.21040-1-sbeller@google.com> <574F800D.6070107@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 04:21:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8IFq-0006VF-Qx
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 04:21:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368AbcFBCUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 22:20:43 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:34716 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbcFBCUl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 22:20:41 -0400
Received: by mail-qg0-f41.google.com with SMTP id p34so47576355qgp.1
        for <git@vger.kernel.org>; Wed, 01 Jun 2016 19:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2+EZrKNhDWtNU1cVcen4aYSNOUVKv6K1Rw1lLU/1RoM=;
        b=Fpb3snwIOVXk4N1NIegzapzugmRPJK7bF3ChE9w+0QoJXDuSAizJ84jBoWx2PIoAyC
         xOB3b7DE8Q886MLz608dxhXNlThmXqeTOLjLMRheurs4MmiX8s6Jk1po3B0u+f8u3l5v
         OS3/bdqJaHgsXb+yX00LokCO1RiXgp1oJ8j5iRsBIl3nePQdvkAGpw2874F338D6lPev
         Wp8zXdFncgMsKqFVXO5In/yr9aJ0b1412HkaGPvaoFFK3aWf5s6DwUgagRD1d16pBu6r
         GVaU6jAUWRKlfHpmUPeqyw7ztW7mJyrfoGUMaBmVfA1TcP0zi6t/VnVxWj97u6E2Fwb5
         envQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2+EZrKNhDWtNU1cVcen4aYSNOUVKv6K1Rw1lLU/1RoM=;
        b=JLflHJM4OZz2e/FrBHbBCG735IqrXw/2liO9vJZECcJ/uNFjHYZCTffWb83gZH0CI6
         Kc5u2vLNYuJyTifML8WmY6SNODzESnGIGijdyjHHwEJEe3WB+8RpMEYFAkZYfJSOUFN/
         T+x4Yh72mSnVlFRs/K5Sg0E2q1CRBB0zLofCVdaOIoWEfwMcFX4pLToi/2hFlhWYEyqV
         Rh/O4GLQoWdFkocQOZXk931NihTyKYS5Bm4c6rhcnqJDIBHfEH6YO2n8Xrfr5Jjw/qIh
         3SbetCh8X3dL/6dq2upZzzWB62CFMZr2tbF6D6dw1jvpTJcP3bY4b4+J3rKCM8ek82VX
         TLcQ==
X-Gm-Message-State: ALyK8tL1EpysSinYHcUW0XEZtoIrRXnGUj+0Eniaan0n7DYTHnliSMvHnYW10t9HW3undDwHFRUFRoDchpBGwquF
X-Received: by 10.140.238.66 with SMTP id j63mr39944511qhc.48.1464834039957;
 Wed, 01 Jun 2016 19:20:39 -0700 (PDT)
Received: by 10.200.55.212 with HTTP; Wed, 1 Jun 2016 19:20:39 -0700 (PDT)
In-Reply-To: <574F800D.6070107@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296184>

On Wed, Jun 1, 2016 at 5:38 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
> On 02/06/16 00:52, Stefan Beller wrote:
>> In our own .gitattributes file we have attributes such as:
>>
>>     *.[ch] whitespace=indent,trail,space
>>
>> When querying for attributes we want to be able to ask for the exact
>> value, i.e.
>>
>>     git ls-files :(attr:whitespace=indent,trail,space)
>>
>> should work, but the commas are used in the attr magic to introduce
>> the next attr, such that this query currently fails with
>>
>> fatal: Invalid pathspec magic 'trail' in ':(attr:whitespace=indent,trail,space)'
>>
>> This change allows escaping characters by a backslash, such that the query
>>
>>     git ls-files :(attr:whitespace=indent\,trail\,space)
>
> Not having given this much thought at all, but the question which comes
> to mind is: can you use some other separator for the <attr>-s rather than
> a comma? That way you don't need to quote them in the <value> part of the
> <attr>-spec.
>
> (I dunno, maybe use ; or : instead?)

That was essentially my proposal as well (just that I said "white
spaces" instead if ':' or ';'),
but it is not a good idea according to Junio as we don't want to need
knowledge of the attr
syntax here in the pathspec matching IIUC. We rather want "I want to
transport this exact
string for the match, but to go through the pathspec magic, we need to
apply escaping of
the exact string. That way we can change the attr system later without
having to worry
about the syntax replacements done in the pathspecs.



>
> ATB,
> Ramsay Jones
>
>
>
