From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv2 04/10] remote: Reject remote names containing '/'
Date: Thu, 16 May 2013 13:17:03 +0200
Message-ID: <CALKQrgewHCrkf0kP57Mm+werT9yAWnLZP7CJn-k3g85gfPRspA@mail.gmail.com>
References: <1368289280-30337-1-git-send-email-johan@herland.net>
	<1368289280-30337-5-git-send-email-johan@herland.net>
	<7vtxm7scn5.fsf@alter.siamese.dyndns.org>
	<CALKQrgcry9bwmonaeWA4M7a3k36S_Q3ZQLmv7Ui5r+tdzdMr_A@mail.gmail.com>
	<CALkWK0k=P265MCmvj9C7MFiF=tkhCZ__3oF8FWmWd4sNx3VcTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	jrnieder@gmail.com
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 13:17:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcwBX-0007IA-A6
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 13:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753022Ab3EPLRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 07:17:12 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:53014 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402Ab3EPLRI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 07:17:08 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UcwBG-00004O-Md
	for git@vger.kernel.org; Thu, 16 May 2013 13:17:06 +0200
Received: from mail-oa0-f50.google.com ([209.85.219.50])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Uctpx-000Ptc-U0
	for git@vger.kernel.org; Thu, 16 May 2013 10:46:58 +0200
Received: by mail-oa0-f50.google.com with SMTP id l20so3534434oag.37
        for <git@vger.kernel.org>; Thu, 16 May 2013 04:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=XggADp1GtmJlahvIdP3AdUqt3KslVRmA6AbyVRJ7vjk=;
        b=K3/xlxszHEJ8TMVm6JqB/PtAmjzmhtvSwD5jnJEilDrxwWHOV16JNI0ijaCGDpf5Gc
         wYbqERgmaGJmaxOBrj9D+8A0oChLXaQIrLymY0iwX9ZEy7mvyPBiHHMZPWwlLRKyqXH2
         U7/5E1t6K05NQZUnrY1JRpYUpj7AS4RpNf7IZ0tO7RQw3gYhmCXv4PutQvBugLA0mbpL
         rC41RDt6pi2KbSlRTDLlmW/YJMiM8p4+adbtpgdVTYaudd1GGqtHAOj7eAFopb228QSK
         H+bRXBTbEJ471J3ewLDDNO6FI9JP1Y7HiZVM9gjsVFK/DQeYQ3nMxvked5niDZnau4M1
         avMw==
X-Received: by 10.60.162.70 with SMTP id xy6mr12226227oeb.117.1368703023109;
 Thu, 16 May 2013 04:17:03 -0700 (PDT)
Received: by 10.182.133.66 with HTTP; Thu, 16 May 2013 04:17:03 -0700 (PDT)
In-Reply-To: <CALkWK0k=P265MCmvj9C7MFiF=tkhCZ__3oF8FWmWd4sNx3VcTw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224554>

On Thu, May 16, 2013 at 11:48 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Johan Herland wrote:
>> The disambiguation can probably be resolved, although the resulting
>> code will obviously be somewhat more cumbersome and ugly (and IMHO the
>> current code is plenty of that already...). Combine this with the
>> problems of clobbering of the same remote-tracking ref (describe
>> above), and the fact that AFAIK a multi-level remote name has never
>> been observed "in the wild" (none of the people I asked at the Git
>> Merge conference had ever observed multi-level remote names, nor did
>> they directly oppose banning them), I'm not at all sure it's worth
>> bothering about this at all. Simply disallowing multi-level remote
>> names seems like the simpler and naturally ambiguity-resistant
>> approach.
>
> The problem with multi-level remote names is that we use the same
> delimiter as in the ref namespace: '/'.  So, obviously, there's a lot
> of room for confusion.  I wonder if we should banish multi-level
> remotes altogether though: is it possible that they will be useful to
> someone in the future?

Technically, the problem is that we don't use a different delimiter
between the $remote and $ref parts. If we had used
"multi/level/remote:nested/ref" we would have been OK (on this issue
at least, probably not OK on other issues).

FWIW, I've abandoned this patch, and don't care much about multi-level
remote names anymore. They work in current git, and they will sort-of
work with remote ref namespaces as well, although you will have to use
full refnames when referring to their remote-tracking refs. If
multi-level remote names suddenly become popular, we can change the
code to try to resolve them unambiguously.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
