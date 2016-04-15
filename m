From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC PATCH, WAS: "weird diff output?" 2/2] xdiff: implement empty
 line chunk heuristic
Date: Fri, 15 Apr 2016 13:17:59 -0700
Message-ID: <CA+P7+xoWbrSaONH5xq=w5W190Jknk0Qsc5brS4UKFAs2_dTceg@mail.gmail.com>
References: <20160415165141.4712-1-jacob.e.keller@intel.com>
 <20160415165141.4712-3-jacob.e.keller@intel.com> <CAGZ79ka7h25=rHun_hPv1qjqeghXt1UwUU3Q6xT0aj4+OW87fg@mail.gmail.com>
 <xmqq8u0ebpru.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
	Davide Libenzi <davidel@xmailserver.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 22:18:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arAC9-0007J2-Pp
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 22:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbcDOUSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 16:18:21 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:38460 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbcDOUSU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 16:18:20 -0400
Received: by mail-ig0-f173.google.com with SMTP id ui10so33095793igc.1
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 13:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pNVG5b3UdyvX8Uhot3jwAYerRzvZzEuPJeuCWRDypgg=;
        b=ljnWkayEAVUQWQRJarMPe0odSC4V+M7yfeZDahFBG4jWF1CkXCSzmR644Dx8miPSYR
         zm+/+M6tbL66c7dEthcqos4MygmBwPDC7vLnSut7aUisUG8LgSGRh+sBeH21S8n8t4j9
         FfxVeX7iAf4U7ffEgplWnF2vSt3UqnA0097OMbchKLywFDZlj9M17ScuOM3i8R5LprzW
         4gd0rt6egq/3JB/ioTWExGaEysHbEq6O6VU3oDUplua4ig0nVqJWhjWcv0UXAtgt/DqO
         KYBlbwvt7H5hKg6nSt0DLFZj+62FrJCp172FbsDheHzpfuebDFOP3elO+YWLTOQTzsQm
         KLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pNVG5b3UdyvX8Uhot3jwAYerRzvZzEuPJeuCWRDypgg=;
        b=LlmTXoGBmkVdey1k7HDuM/lXyKps75gRk6b87wI1pXfNhD+a8TDKkjtj44zHvcNoeR
         IRskVKQhyvrp1JsrLeH6U2oXSs5riB93/aIIAqACRslRaR9SR9FRa+rTrjUdQv8p0O5F
         c1wkDvALJqWhgaF3AZmgvfcYxBuqD2NB5scTE8OHj2sBbtGsrL5CbFPjVApQGzNvDd+v
         NYL3fvIGpvrIXzh+a91Pisn228dJTr7cSwNlMWMvBUvFhgZtFEkN+K7Z6HjBBI++SuO6
         +F3uwzgk0Cvvi9C2hT/6QBAgxJhVSWpNs6ysrh/7MTKnerCxb/FDUsWHi0Ix8WDkeA1e
         rLQg==
X-Gm-Message-State: AOPr4FWuVv6vG4VCIgfxu8xWCO7VfCdn8g0WIIcs4EKwSNTDvk9iJ8Zd169oiEHr3o2qhUVVsnjOAV2NYTnkSg==
X-Received: by 10.50.123.132 with SMTP id ma4mr7224392igb.92.1460751499336;
 Fri, 15 Apr 2016 13:18:19 -0700 (PDT)
Received: by 10.107.59.78 with HTTP; Fri, 15 Apr 2016 13:17:59 -0700 (PDT)
In-Reply-To: <xmqq8u0ebpru.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291653>

On Fri, Apr 15, 2016 at 1:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> +diff.emptyLineHeuristic::
>>
>> I was looking at the TODO here and thought about the name:
>> It should not encode the `emptyLine` into the config option as
>> it is only one of many heuristics.
>>
>> It should be something like `diff.heuristic=lastEmptyLine`
>> The we could add firstEmptyLine, aggressiveUp, aggressiveDown,
>> breakAtShortestLineLength or other styles as well later on.
>>
>> I do not quite understand the difference between diff.algorithm
>> and the newly proposed heuristic as the heuristic is part of
>> the algorithm? So I guess we'd need to have some documentation
>> saying how these differ. (fundamental algorithm vs last minute
>> style fixup?)
>
> I actually do not think these knobs should exist when the code is
> mature enough to be shipped to the end users.
>
> Use "diff.compactionHeuristics = <uint>" as an opaque set of bits to
> help the developers while they compare notes and reach consensus on
> a single tweak that they can agree on being good enough, and then
> remove that variable before the code hits 'next'.
>
> Thanks.

I was under the impression that we would want a longer lived
configuration until we had enough data to say whether it was helpful
to make it default. I guess i had thought it would need to be longer
lived since there may be cases where it's not optimal and being able
to turn it off would be good?

I'd rather keep it semi-human readable vs a uint since it would help
keep me sane when looking at it in the interim.

Thanks,
Jake
