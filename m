From: Fabian Ruch <bafain@gmail.com>
Subject: Re: [PATCH RFC v2 01/19] rebase -i: Failed reword prints redundant
 error message
Date: Thu, 10 Jul 2014 18:35:08 +0200
Message-ID: <53BEC0BC.6030600@gmail.com>
References: <53A258D2.7080806@gmail.com>	<cover.1404323078.git.bafain@gmail.com>	<10d7fae199e4d8adec537aa377177de652badc07.1404323078.git.bafain@gmail.com>	<xmqqtx6r8uem.fsf@gitster.dls.corp.google.com> <CADgNjakNQKbA8fYJqz7n-C9aPoZdfxX+N9Xuq1irJ_ajB8Yt_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: Andrew Wong <andrew.kw.w@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 18:35:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5HJb-0002T6-Vy
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 18:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbaGJQfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 12:35:17 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:58758 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbaGJQfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 12:35:16 -0400
Received: by mail-wi0-f180.google.com with SMTP id hi2so4873676wib.13
        for <git@vger.kernel.org>; Thu, 10 Jul 2014 09:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=u33Sf3bJbR4nG60Gyq1/y0TdT2rDJQ1RicukYN/MSP4=;
        b=BpikW7qP1AB+fmMHeaQ3f6ZnBbR4aX3eMiM7vO3lTeFWlGcHWqe0oUqZpUM1QfmFf4
         Myy6eak97C+FCtOg0kiRlvu06izErQNkYqOe6ma0A0LtfSnEVliV+FKrcvd5zpL3WSYq
         GlWO34MRoTFNWA/14pqM/WUNuR+Y38oms9xNIKlOq4szu29jE7TTDcoWEeh4qj1Vqyy6
         fQAfFhcxWl9+/bMAeGUpVBDsarEuvzLPHctPUIz+RUX1xUqn83rqcqphTR9mOxeTe0Qx
         HIberhnYk1zLO2/uiLgOAz116f7ZSGHZTil+jvcFt7ll9UaULFkApiaYxHbsmbtz81Np
         aWKw==
X-Received: by 10.194.243.70 with SMTP id ww6mr56953446wjc.76.1405010111361;
        Thu, 10 Jul 2014 09:35:11 -0700 (PDT)
Received: from client.googlemail.com (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id x13sm11390725wib.23.2014.07.10.09.35.09
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 10 Jul 2014 09:35:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CADgNjakNQKbA8fYJqz7n-C9aPoZdfxX+N9Xuq1irJ_ajB8Yt_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253188>

Hi Andrew,

thanks for your review and sorry that I forgot to cc the bug fix to you.

Andrew Wong writes:
> On Tue, Jul 8, 2014 at 4:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Fabian Ruch <bafain@gmail.com> writes:
>>> It is true that a failed hook script might not output any diagnosis...
>>
>> I think the message originally came from 0becb3e4 (rebase -i:
>> interrupt rebase when "commit --amend" failed during "reword",
>> 2011-11-30); it seems that the primary point of the change was to
>> make sure it exits and the warning message may not have been well
>> thought out, but before discarding the result of somebody else's
>> work, it may not be a bad idea to ask just in case you may have
>> overlooked something (Andrew Wong Cc'ed).
>>
>>> but then the generic message is not of much help either. Since this
>>> lack of information affects the built-in git commands for commit,
>>> merge and cherry-pick first, the solution would be to keep track of
>>> the failed hooks in their output so that the user knows which of her
>>> hooks require improvement.
> 
> Since "git commit" already prints out error messages for failing due
> to empty commit message, the third message is really about giving
> hints in the case where pre-commit fails. We could probably assume
> that pre-commit would also print out error messages. So I'd be fine
> with removing the third message. But I wonder if we need to explain
> that the user needs to run "git rebase --continue" to resume the
> rebase?

That is still taken care of by exit_with_patch here. When called in the
error case, it prints

    You can amend the commit now, with

    	git commit --amend

    Once you are satisfied with your changes, run

    	git rebase --continue

to standard error. I might have overlooked this in one of the later
patches though.

   Fabian
