From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 2/2] submodule::module_clone(): silence die() message from module_name()
Date: Tue, 11 Oct 2011 16:44:34 +0800
Message-ID: <CALUzUxo6YEEpL_MhT=O9sJSUdwcpKBpeM2O8GkbbyxvqmWCFLQ@mail.gmail.com>
References: <1317978295-4796-1-git-send-email-rctay89@gmail.com>
	<1317978295-4796-2-git-send-email-rctay89@gmail.com>
	<4E9348A8.5000500@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Oct 11 10:44:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDXx2-0001za-W7
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 10:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802Ab1JKIog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 04:44:36 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:47759 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231Ab1JKIog (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 04:44:36 -0400
Received: by ggnv2 with SMTP id v2so5422500ggn.19
        for <git@vger.kernel.org>; Tue, 11 Oct 2011 01:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Qhl0qpqR96ClZrLN5yilPDa+1NwCWtsB6ReawyamvPA=;
        b=X23ydUiBC6OWFHThzNugiSWZms1kgCR26iDeS1VHC3UbXCPv3/d2esFSVGGBP7iEDj
         qFdOHZc4XCqT9NDxUJmV9dTnf79Uonf2WpL3npPE+XVmoFUDULtLUdn+cqgp3IgXBWZ/
         SBTYfz9/hjiyG/1AS79PXkP70wFjiEblklTIs=
Received: by 10.223.14.85 with SMTP id f21mr7119817faa.37.1318322674837; Tue,
 11 Oct 2011 01:44:34 -0700 (PDT)
Received: by 10.223.83.2 with HTTP; Tue, 11 Oct 2011 01:44:34 -0700 (PDT)
In-Reply-To: <4E9348A8.5000500@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183287>

On Tue, Oct 11, 2011 at 3:34 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> BTW: this patch applies to next
>
> Am 07.10.2011 11:04, schrieb Tay Ray Chuan:
>> The die() message that may occur in module_name() is not really relevant
>> to the user when called from module_clone(); the latter handles the
>> "failure" (no submodule mapping) anyway.
>
> Makes tons of sense, especially as adding a new submodule currently always
> spews out the "No submodule mapping found in .gitmodules for path 'sub'"
> message right before that mapping is added there. Thanks for noticing that
> and ACK on that change from my side.

Thanks for the review.

>> Leave other callers of module_name() unchanged, as the die() message
>> shown is either relevant for user consumption (such as those that exit()
>> when the call fails), or will not occur at all (when called with paths
>> returned by module_list()).
>
> Hmm, while I agree on the first reasoning I'm not sure about the second.
> module_list() asks the index for the submodule paths while module_name()
> gets it's input from .gitmodules, so they can (and sometimes will)
> disagree.

Oh, you're right. I neglected to see how module_list() actually worked.

> When cmd_foreach() passes an empty "name" variable to the
> spawned command that might still work (and even make sense), but using the
> empty name in cmd_sync() to access the config is looking like an error to
> me. It might make sense to add an "|| exit" at least to the callsite in
> cmd_sync(). Or am I missing something here?

Cc-ed David, who authored cmd_sync().

David, what do you think of Jens' analysis?

In the meantime, I'll probably reword the second paragraph to say that
future work will be needed to analyze non- || exit callsites.

-- 
Cheers,
Ray Chuan
