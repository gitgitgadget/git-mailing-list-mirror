From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add ls-remote --get-push-url option
Date: Fri, 31 Jul 2015 12:16:46 -0700
Message-ID: <xmqqzj2c3zoh.fsf@gitster.dls.corp.google.com>
References: <1438364321-14646-1-git-send-email-mathstuf@gmail.com>
	<xmqqfv445fxv.fsf@gitster.dls.corp.google.com>
	<20150731185619.GA24622@megas.kitware.com>
	<xmqq4mkk5ex5.fsf@gitster.dls.corp.google.com>
	<20150731190415.GA23674@megas.kitware.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ben Boeckel <mathstuf@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 21:17:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLFni-0006GF-PI
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 21:17:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbbGaTQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 15:16:49 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:32893 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbbGaTQs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 15:16:48 -0400
Received: by pdbnt7 with SMTP id nt7so47114776pdb.0
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 12:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=w187rfVVM4TCQcBb5aV45pZVNneCtdHAwdx2sB6ZLB0=;
        b=N2GPZvE3aCf+BYMsYXUvo+rg3kPh1IqdKrx99I4amLNA+L0fsaYP5L48YguzwixlDo
         VTXiYzzvCreLRmYgpYNT0aaNTAj04V98O9jB3z27it+08R5on851JYPTwbQKktEIO8vG
         0W0C3sa3PHpbbzVkroE+c/yUimHywypBfxPQ0y+1pA+CeMQuW0wRixbJugwe3vNvky2S
         w52+bilCkOmvFlS8qaOn+BNc+H06tcV0C/0/RBBOv/BtbYXmMTRXobgFcphZn/fxy1CW
         c5QyyGb+UDkEbBMF/HEGkvelZcY37dCEXPvbnBFE3hjIzbnruUTcxcbIZBcV5MDDY3Ym
         DG5g==
X-Received: by 10.70.38.231 with SMTP id j7mr10436805pdk.146.1438370207883;
        Fri, 31 Jul 2015 12:16:47 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1b0:46e8:ba02:35e3])
        by smtp.gmail.com with ESMTPSA id ra10sm9101639pab.19.2015.07.31.12.16.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 31 Jul 2015 12:16:47 -0700 (PDT)
In-Reply-To: <20150731190415.GA23674@megas.kitware.com> (Ben Boeckel's message
	of "Fri, 31 Jul 2015 15:04:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275068>

Ben Boeckel <mathstuf@gmail.com> writes:

> On Fri, Jul 31, 2015 at 12:02:14 -0700, Junio C Hamano wrote:
>> Ben Boeckel <mathstuf@gmail.com> writes:
>> 
>> > With some sed, yes, but then so would `git remote show` just as useful
>> > too (and in that case, "why does --get-url exist either?" comes to
>> > mind).
>> 
>> Either carelessness let it slip in, or it came before 'git remote show'.
>
> Would adding `git remote show --url $remote` and `git remote show
> --push-url $remote` be acceptable?

It is not just acceptable; I think "git remote" is a much better
place to have something like that.

Or even "git remote get url [$there]", "git remote get push-url [$there]".

Or to mirror the existing "ls-remote --get-url [$there]", which directly asks
"where does this request go if I run it without '--get-url' option?":

    $ git push --get-url [$there [$refspec...]]
    $ git push --get-refspec [$there [$refspec...]]

might be a better option.  The logic in "push" takes the current
branch and configurations like branch.*.remote and push.default into
account, so it is likely that you will get the exact information
without too much code.

I am not opposed to having a scriptable interface to obtain these
pieces of information.  I was only objecting to teach ls-remote
anything about push, which ls-remote does not have anything to do
with.
