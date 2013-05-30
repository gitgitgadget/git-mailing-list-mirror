From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: Poor performance of git describe in big repos
Date: Thu, 30 May 2013 21:01:21 +0200
Message-ID: <CALWbr2xd4k_P6KUQOcRJotWj3=DfJNnhL4rsGSw0yE+53gdyWw@mail.gmail.com>
References: <CAJ-05NPQLVFhtb9KMLNLc5MqguBYM1=gKEVrrtT3kSMiZKma_g@mail.gmail.com>
	<CALkWK0ndKMZRuWgdg6djqPUGxbDAqZPcv2q0qPrv_2b=1NEM5g@mail.gmail.com>
	<CAJ-05NNAeLUfyk8+NU8PmjKqfTcZ1NT_NPAk3M1QROtzsQKJ8g@mail.gmail.com>
	<87ehcoeb3t.fsf@linux-k42r.v.cablecom.net>
	<CAJ-05NOjVhb+3Cab7uQE8K3VE0Q2GhqR3FE=WzJZvSn8Djt6tw@mail.gmail.com>
	<87ip20bfq4.fsf@linux-k42r.v.cablecom.net>
	<87bo7sbeoc.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <kernel-hacker@bennee.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu May 30 21:01:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui86U-0005vX-Ob
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 21:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759250Ab3E3TBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 15:01:24 -0400
Received: from mail-qc0-f180.google.com ([209.85.216.180]:50859 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757678Ab3E3TBW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 15:01:22 -0400
Received: by mail-qc0-f180.google.com with SMTP id a10so337433qcx.11
        for <git@vger.kernel.org>; Thu, 30 May 2013 12:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pzSVFejKtL7PGqZCHwuYEEYVFZYGbCnEiNoHMkvMGuE=;
        b=McTM99HAXTzZ3RIPdMFQzNfRIrOH44sbTlAKOp0S9FFT/uLwknKqHPJmQh0IxiHAvn
         VL/SoKMJ243b0fOHbN93l+UCSTS60iRBuOA4ANa2JZPNBfnaQXZfnK8nxMG4rkcj7dD1
         FT0y2uavpzmrUBdGZymRm+syVm/5GPzGUAaVlhGiKLVPzh/svp2/cwsUGp/RlQUsYZT7
         2Gyv6grP5ZYAut9s5n/lvc6Ni7sCi8p+Cf+Ee346iPaQvt8IGJJ45XuHQ4k/T/dKYpqD
         lriWiyVoaElU2Mrkp0MyUEiliGdTdC5vYllfhwm75fHgPLN8wbEFJ+hkWAjkjLT1NjxW
         IhYQ==
X-Received: by 10.224.37.198 with SMTP id y6mr7452725qad.83.1369940481615;
 Thu, 30 May 2013 12:01:21 -0700 (PDT)
Received: by 10.49.73.8 with HTTP; Thu, 30 May 2013 12:01:21 -0700 (PDT)
In-Reply-To: <87bo7sbeoc.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226028>

> The culprit, according to some callgrind investigation, is
> lookup_commit_reference_gently() [for the unannotated case] or
> deref_tag() [annotated case] calling parse_object().

Using the scenario you described earlier, I think it ends-up spending
most of its time in check_sha1_signature (both deref_tag and
lookup_commit_reference_gently() go there) with 20% inflating, 80% in
SHA1_Update(). Not much we can do about that, can we ?
