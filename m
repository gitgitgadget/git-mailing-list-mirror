From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 3/3] bisect--helper: `write_terms` shell function in C
Date: Mon, 16 May 2016 12:59:50 -0400
Message-ID: <CAPig+cRZKpjYBJ9bUG-X3WcpXYvHW-wgMDVYTg7a6_q8N+7qNg@mail.gmail.com>
References: <1462546167-1125-1-git-send-email-pranit.bauva@gmail.com>
	<1463031127-17718-1-git-send-email-pranit.bauva@gmail.com>
	<1463031127-17718-4-git-send-email-pranit.bauva@gmail.com>
	<CAPig+cS=zcSVLwARZ5A8hdiE0wqgYPU2Jwnr0OcjDXZFO--cZw@mail.gmail.com>
	<alpine.DEB.2.20.1605161508230.3303@virtualbox>
	<CAPig+cQ=Gche_uO840wF6qE4WD-ZNZj1HFzNNgaBi_UjG1sjEg@mail.gmail.com>
	<alpine.DEB.2.20.1605161830200.3303@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 16 19:00:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2Ls4-00053K-Je
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 18:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753625AbcEPQ7w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 12:59:52 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34851 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357AbcEPQ7v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 12:59:51 -0400
Received: by mail-io0-f196.google.com with SMTP id i75so16044488ioa.2
        for <git@vger.kernel.org>; Mon, 16 May 2016 09:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=VTgFpabnDMNjWb2qiNOfenrv5ewxCKSSIngZH4IV1ok=;
        b=cdWw4bNTCXNHS0+ZrcFV07M+t6gVRYc7+u0qudF49+ghVlVDCkxahPPF6Py7PN5fju
         E4GI9pXsCl0/EuolzbWx+KMKLSITk1WV+IPc+lQA9VNmVR/1KobDkJL+RR80Il+iOXwc
         krpQ0obmYdm7fbJGNum3doLDPQUdE2SBj50dDUYNp+MjxZX33Dn7YM5Z137KPdVrWu7h
         AYjxy8laUL121HaFK96PebGDxK1SffcmKATt8YJ1yXqfR0dQ/IB7nk9nIX7LyVOF8Gcs
         tTx6FMurFbhFhRURtUYoiK9ofQQWAxjcRieQx22NQjvMhnxKK3QtS7bV/vd0b4usz5JT
         A5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=VTgFpabnDMNjWb2qiNOfenrv5ewxCKSSIngZH4IV1ok=;
        b=AXbetkVWd+YMcSxVhrok6teCTspt6NedsAOA2DaOm9uYA257FVC07hn0SEmeNGq946
         n3jXA936xdDBQyT+8CKPKgZsOTl/L+EublvPDXF50GtmD2b1IbeNzhNoI2Yt8Vx6IxWC
         G+P0E6h4QbDvxq4o6XbC1EOUdz0hvt/wPdISaObYjqXMI2xxEwdBrhDHSa4eo5ntTROh
         RgBCruwaUbtCbF6Zvv+ccaaYQ91M9kKaJ65F1+G1B229oWNmMVs8cUf2Y31NAQNTyKCJ
         E8eXwpYV47/Nt0sDc4lAkl16pOfYlwRPWtLC30IvLBoBDkm8ifVXZ8e9I79kPYIQR2hQ
         ry2w==
X-Gm-Message-State: AOPr4FUqhW6HosDkHLWK0vnrJ9VJRLVMEtb4W2mhthoLIKKrdgKLy3PmHfwjb00GVCmbR5LHaMhzfJIUuRdiYg==
X-Received: by 10.36.31.65 with SMTP id d62mr10749072itd.84.1463417990923;
 Mon, 16 May 2016 09:59:50 -0700 (PDT)
Received: by 10.79.139.135 with HTTP; Mon, 16 May 2016 09:59:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1605161830200.3303@virtualbox>
X-Google-Sender-Auth: 4LTMnhiNQIikFbDdTWsPoKmDDDs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294754>

On Mon, May 16, 2016 at 12:45 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Mon, 16 May 2016, Eric Sunshine wrote:
>> On Mon, May 16, 2016 at 9:16 AM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> > On Mon, 16 May 2016, Eric Sunshine wrote:
>> Agreed. Specific to the "established previously" I wrote above, I was
>> referring to [1] from just a few days ago which explained why 'return
>> -1' was preferable to die() in a similar case that had an odd mix of
>> 'return -1' and die() in the same function.
>>
>> [1]: http://thread.gmane.org/gmane.comp.version-control.git/289476/focus=293556
>
> Yes, this is an excellent link. Maybe we would want something like this,
> too?
>
> -- snipsnap --
> diff --git a/Documentation/CodingGuidelines
> @@ -333,6 +333,10 @@ For C programs:
> + - Use die() only to signal an exceptional conditions which should
> +   abort the program. All other error conditions should instead
> +   return e.g. using "return error(...)".

Hmm, the bit you said earlier about "library" code vs. end-user code
would be important, too, I'd think. Also, I'd expect that this sort of
thing is implicitly understood by most programmers, and as this is
only the first time (in recent memory) that it has needed explanation
on the mailing list, I'm not sure that it deserves explicit mention in
CodingGuidelines (but perhaps I'm not a good judge of these things).
