From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH] Enable parallelism in git submodule update.
Date: Sat, 3 Nov 2012 14:44:54 -0400
Message-ID: <CABURp0pkv714k_+S2seTtdHMNJFzkgijYuNuWcfNvnF+c21cDg@mail.gmail.com>
References: <5090168f.5e+7ZUFKdYL2Qnw7%szager@google.com> <CAHOQ7J-e=KBOsjoeTWsf1f+LNgaAxN974-FXNMeOy7B-FR0wyg@mail.gmail.com>
 <50953B52.3070107@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stefan Zager <szager@google.com>, git@vger.kernel.org,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Nov 03 19:46:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUijS-0006wI-W3
	for gcvg-git-2@plane.gmane.org; Sat, 03 Nov 2012 19:46:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004Ab2KCSpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2012 14:45:17 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:49357 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973Ab2KCSpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2012 14:45:16 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so3270167lag.19
        for <git@vger.kernel.org>; Sat, 03 Nov 2012 11:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AdEGvmsyfJsg+ps1XaS1ivU0aczjtbK9h3m5gL511HI=;
        b=KTOSjuHsv/P4RnnhR5GLiyx+YSEa4Wkig7WNGOBNypBWNceihOU1w5aGLvYX92ezyt
         WiGC9HIBoLTmnjt0EHVYRtsS3vdTf/PA3jQSpxZkVxKQT12aeysqmWXg3I3h0dHw78rG
         ZyY083D0phnuGn1rM+8MttifKwXyqD3iPkH/FBlMo8Z+rAB1nij0olHI7m08kRzPTO4K
         6flB4gHA21zVknt7pYoYnotw1GAG4kFQliJ+zH6O1W1W2ojza1apTByEpR3hic6Enu8l
         S6uYXePL4fYEsmB8cPBov5GBq6JU/r88ccD+Eoxt5vNkt0a7evj/BbNL+Gj6oHOWPFT5
         Y0hw==
Received: by 10.112.30.163 with SMTP id t3mr2161356lbh.56.1351968314455; Sat,
 03 Nov 2012 11:45:14 -0700 (PDT)
Received: by 10.114.26.166 with HTTP; Sat, 3 Nov 2012 11:44:54 -0700 (PDT)
In-Reply-To: <50953B52.3070107@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208981>

On Sat, Nov 3, 2012 at 11:42 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 30.10.2012 19:11, schrieb Stefan Zager:
>> This is a refresh of a conversation from a couple of months ago.
>>
>> I didn't try to implement all the desired features (e.g., smart logic
>> for passing a -j parameter to recursive submodule invocations), but I
>> did address the one issue that Junio insisted on: the code makes a
>> best effort to detect whether xargs supports parallel execution on the
>> host platform, and if it doesn't, then it prints a warning and falls
>> back to serial execution.
>
> I suspect not passing on --jobs recursively like you do here is the
> right thing to do, as that would give exponential growth of jobs with
> recursion depth, which makes no sense to me.

On the other hand, since $jobs is still defined when the recursive
call to is made to 'eval cmd_update "$orig_flags"', I suspect the
value *is* passed down recursively.  Maybe $jobs should be manually
reset before recursing -- unless it is "0" -- though I expect someone
would feel differently if she had one submodule on level 1 and 10
submodules on level 2.  She would be surprised, then, when  --jobs=10
seemed to have little affect on performance.  So maybe it is best to
leave it as it is, excepting that the apparent attempt not to pass the
switch down is probably misleading.

Phil
