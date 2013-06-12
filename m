From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 2/3] Move copy_note_for_rewrite + friends from
 builtin/notes.c to notes-utils.c
Date: Wed, 12 Jun 2013 09:10:58 +0200
Message-ID: <CALKQrgfxrKz5bB=AAmL1ZtBFRK2Bx6TrRd1AsMEVv8bTAH0KCg@mail.gmail.com>
References: <7vehc8a05n.fsf@alter.siamese.dyndns.org>
	<1370995981-1553-1-git-send-email-johan@herland.net>
	<1370995981-1553-3-git-send-email-johan@herland.net>
	<CAMP44s2pUW_+w6B_R-A=vxOg1Ay6iLmc4MQsA_sfDF+GP-XsWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com, git@vger.kernel.org, jrnieder@gmail.com,
	pclouds@gmail.com, artagnon@gmail.com, john@keeping.me.uk,
	vfr@lyx.org, peff@peff.net, torvalds@linux-foundation.org,
	Thomas Rast <trast@inf.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 12 09:11:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmfD8-0001nm-VT
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 09:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754756Ab3FLHLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 03:11:10 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:57872 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851Ab3FLHLI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 03:11:08 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1UmfCz-0002tK-UU
	for git@vger.kernel.org; Wed, 12 Jun 2013 09:11:06 +0200
Received: from mail-ob0-f174.google.com ([209.85.214.174])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UmeYh-000JGr-Cz
	for git@vger.kernel.org; Wed, 12 Jun 2013 08:29:27 +0200
Received: by mail-ob0-f174.google.com with SMTP id wd20so12862573obb.19
        for <git@vger.kernel.org>; Wed, 12 Jun 2013 00:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GnXmBrxTeN3ggfQmHxmlhoAonkXVx08ftKKpHlXnUEI=;
        b=Str3g4V+eQ2Amm7modcRj1obM4zXF4ghf9JJmhShooLK9GUE/MGlnQohZuPYJrN4wc
         VyuRe8gdPBShSCulbNOd/dG2Hc9fgKs1LDajADq1oLhd0Q4YToo6Eea+ATCvxaokfUD6
         WYVqVO5+epBm8FJKJJ7us2jmpdw/d8V2yardpUonjjwl2P6i0opPHD4/kZ8jspsUvoJo
         zpT9s+E9o7wDXsnVzXS1gTvMmvj119M7498B6IcF0qVbA+NGLJu0TSZI5LYzo4cTvcvN
         DkWTuy8Dq210vvPcOnZpDiKMmBQbxrUtK/BIpjKk88PFKx+pSWE5gyfW64lK8lA7CRol
         yARQ==
X-Received: by 10.60.143.41 with SMTP id sb9mr7212415oeb.102.1371021058797;
 Wed, 12 Jun 2013 00:10:58 -0700 (PDT)
Received: by 10.182.102.5 with HTTP; Wed, 12 Jun 2013 00:10:58 -0700 (PDT)
In-Reply-To: <CAMP44s2pUW_+w6B_R-A=vxOg1Ay6iLmc4MQsA_sfDF+GP-XsWw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227589>

On Wed, Jun 12, 2013 at 2:32 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Tue, Jun 11, 2013 at 7:13 PM, Johan Herland <johan@herland.net> wrote:
>> This is a pure code movement of the machinery for copying notes to
>> rewritten objects. This code was located in builtin/notes.c for
>> historical reasons. In order to make it available to builtin/commit.c
>> it was declared in builtin.h. This was more of an accident of history
>> than a concious design, and we now want to make this machinery more
>> widely available.
>>
>> Hence, this patch moves the code into the new notes-utils.[hc] files
>> which are included into libgit.a. Except for adjusting #includes
>> accordingly, this patch merely moves the relevant functions verbatim
>> into the new files.
>>
>> Cc: Thomas Rast <trast@inf.ethz.ch>
>> Signed-off-by: Johan Herland <johan@herland.net>
>
> I wonder where you got that idea from. Did you come up with that out thin air?

Obviously not. I should add

Suggested-by: Junio C Hamano <gitster@pobox.com>


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
