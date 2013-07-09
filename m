From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC] blame: accept multiple -L ranges
Date: Tue, 9 Jul 2013 14:23:55 -0400
Message-ID: <CAPig+cT9U7L-03Fe5YLft=WS2EZY1B_BhLzkM_sT_3wQQ1g1MQ@mail.gmail.com>
References: <1373186706-19284-1-git-send-email-sunshine@sunshineco.com>
	<7vk3l26695.fsf@alter.siamese.dyndns.org>
	<CAPig+cQ9sfV+PRqn5vrL0=xOZrKDDmsKdAPiB4PsCFb=jnk4kQ@mail.gmail.com>
	<7v38rnwuvb.fsf@alter.siamese.dyndns.org>
	<87ehb7d3za.fsf@hexa.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jul 09 20:24:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwcaJ-0007Bv-PH
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 20:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980Ab3GISX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 14:23:57 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:60961 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761Ab3GISX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 14:23:57 -0400
Received: by mail-la0-f53.google.com with SMTP id fs12so5056567lab.12
        for <git@vger.kernel.org>; Tue, 09 Jul 2013 11:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=j/wjOs7WVrsqxlDrfmdemrrOqBiqG7JD3FE9nLf0YP8=;
        b=l+oG6kS8BPo2EFkREFQ/xGIPuFaKaTVXeAZ7qIO/+bBa210cmwd42cQReBSPTSo/S3
         Qu74F+8MbpEOwiJiT9/54916JarSasGqcVFmbfSo5YpLVpVYo05CsNbORTxTB8W9kU1W
         DDIpPTcMDDmLfOe2G8tAxQwPLxAz7hqwpG71Vo6bSJDYnoKd7CuJKPN4yMVRfy13rQRR
         vE5JQY93K3a9wwtQ8eJWhda/CyYG9DHHrYsa0N+NuECvqF2DzCRn7sqt15mULXXNVwg1
         nyhBh2bq9NY3EAcbqsMFY/HZvxY0eZlji21Nk7EMiN5crz7cNv4gtu8iABVapVc6WzoM
         GFPw==
X-Received: by 10.112.19.162 with SMTP id g2mr13524508lbe.9.1373394235444;
 Tue, 09 Jul 2013 11:23:55 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Tue, 9 Jul 2013 11:23:55 -0700 (PDT)
In-Reply-To: <87ehb7d3za.fsf@hexa.v.cablecom.net>
X-Google-Sender-Auth: U-nzVPJWm0QhwjclO3QiueUsUUc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229974>

On Tue, Jul 9, 2013 at 1:42 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>  (2) In the ranges "-L <anything>,/B/ -L /C/,<anything>", the
>>      beginning of the second range is found by choosing C that comes
>>      _after_ the end of the previous range (/B/ may choose either
>>      the second or the 4th line, and the only C that comes after
>>      either of them is the 5th line and that is where the second
>>      range should begin, not at the beginning of the file).  The
>>      same for "-L 1,3 -L /C/" (only C that comes after 3 is eligible
>>      to be the beginning of the second range).
>
> So passing several -L arguments does not blame the union of what each
> argument would blame individually?  Doesn't that make it rather harder
> to explain?

I don't think Junio meant to imply that. Collecting the blame ranges
can/should be a distinct step from coalescing them. Junio is saying
that an -L /re/ range search should start after the maximum line
number already specified by any preceding range. Once all input ranges
are collected, they can be coalesced. (If a -L /re/ range happens to
be coalesced with or into some other range, that's fine: you're still
seeing blame output for the requested lines.)

-- ES
