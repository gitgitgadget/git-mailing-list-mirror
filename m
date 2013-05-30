From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/4] commit: reload cache properly
Date: Thu, 30 May 2013 20:08:01 +0700
Message-ID: <CACsJy8BuSaY=H9Pb6FuTEiQkm18h-kW86ZOVtaaDpMkjFEnqcQ@mail.gmail.com>
References: <1369915136-4248-1-git-send-email-felipe.contreras@gmail.com>
 <1369915136-4248-2-git-send-email-felipe.contreras@gmail.com> <87ehcok6gl.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Adam Spiers <git@adamspiers.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Boyd <sboyd@codeaurora.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu May 30 15:08:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui2at-0002ls-F5
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 15:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754792Ab3E3NId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 09:08:33 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:52461 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754646Ab3E3NIc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 09:08:32 -0400
Received: by mail-ob0-f178.google.com with SMTP id fb19so488709obc.9
        for <git@vger.kernel.org>; Thu, 30 May 2013 06:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=CrXy2AEcrAYbPd81PyfXzyqqo3vk33xogJJWp6o0SLo=;
        b=Mr+n+KSRT5+5zDm3TUATUhAa9DT2cajQFvSnAjQ7q17lkNlFBTWleb6klU+P5hHtgD
         EW7unuwWhiS654quHHOLqGaZ0lfJmAK7/7+0uD/TXyJEoZZLBU2IzllXu1MMSx/EryTA
         0GgxjEkuuivvT5vbWrjh5NIhvpbtIlFnIz5hgazYANmVNDnb1mrU9rNFPY5EWRjOBfOP
         yihyv9E15FJfY/taomLr0uE0k3Qy1sq0UhyzsmTfhDHjebDTho0yNOHh5FLPxAoQAn0s
         R6YIOPuKNn7nibwR4i6ujqrzXXw5X0wskeCnLYv3qkZAjpH/5pGrLULVHU79wDO34WlD
         7WpQ==
X-Received: by 10.182.118.226 with SMTP id kp2mr3986898obb.48.1369919311757;
 Thu, 30 May 2013 06:08:31 -0700 (PDT)
Received: by 10.76.171.199 with HTTP; Thu, 30 May 2013 06:08:01 -0700 (PDT)
In-Reply-To: <87ehcok6gl.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225982>

On Thu, May 30, 2013 at 7:17 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> We are supposedly adding files, to to which cache if 'the_index' is
>> discarded?
> [...]
>>       if (!current_head) {
>>               discard_cache();
>> +             if (read_cache() < 0)
>> +                     die(_("cannot read the index"));
>>               return;
>>       }
>
> It is not obvious to me that this is a correct change.  discard_cache()
> without subsequent reloading could also legitimately be used to empty
> the index.  So if you are fixing a bug, please justify the change and
> provide a testcase to guard against it in the future.

That discard_cache line I think came from fa9dcf8 (Fix performance
regression for partial commits - 2008-01-13). The code flow back then
was

if (initial_commit)
   discard_cache();

add_remove_files();
/* do something more */

A quick look from current code seems to indicate this pattern is still
valid for creating partial commits, where temporary index will be
thrown away afterwards. But I may be wrong.
--
Duy
