From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Probable bug in file run-command.c function clear_child_for_cleanup
Date: Mon, 10 Sep 2012 15:58:40 +0200
Message-ID: <CABPQNSaufY9vUAFp9VL2i=6bNmO5_2+anzX6+omfq+UgP03kXg@mail.gmail.com>
References: <504CAB66.1050003@optimisefitness.com> <20120910134406.GA7496@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Gould <david@optimisefitness.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 10 15:59:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB4WQ-0001Jf-8G
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 15:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756884Ab2IJN7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 09:59:22 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:61481 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755849Ab2IJN7W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 09:59:22 -0400
Received: by vcbfy27 with SMTP id fy27so1303251vcb.19
        for <git@vger.kernel.org>; Mon, 10 Sep 2012 06:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=KVd8VQ0R572aqA8Kp3mrxQkuua2uiHBIZTG2Q8hSe4Y=;
        b=YzbNVgutlCkKDhyboKbcdiCZuMI/Lm4xifyp4K5LOr9jRy/VO0Ns215Fwu3Jynh3wE
         BBP93YHrWkKMt6NV2cLi4W0OyjZSvnCsL3vFyPs4FAZBPqIW00PVwis/Atng1ZiGCuCe
         LhrjxHJmbkGmeo6dBKe5TS2abV4FMxEgu4eQ2g5j2hiO5mRsf4qpiVxp2x+r/pVWlpYG
         gHSE03NiPP52C2Pd7r9h4Q0PimKn5uoeGu5kjOWMaLv+2v7xeCMTlNSrQWSkr8yiAd3X
         4N5fqsxG/WHynIy7wvsAklZZvzUdxk0n6xR9fY5vsBky9po2UWECFD+2bFT+YyVYur8z
         RaIw==
Received: by 10.220.150.15 with SMTP id w15mr19853579vcv.68.1347285561074;
 Mon, 10 Sep 2012 06:59:21 -0700 (PDT)
Received: by 10.58.196.232 with HTTP; Mon, 10 Sep 2012 06:58:40 -0700 (PDT)
In-Reply-To: <20120910134406.GA7496@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205125>

On Mon, Sep 10, 2012 at 3:44 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Sep 09, 2012 at 03:44:54PM +0100, David Gould wrote:
>> You want something like:
>>
>> for (... {
>>       if (... {
>>               ...
>>       }
>>       last = &p->next;
>> }
>>
>> or (probably clearer, but I haven't read your coding style guide, if
>> there is one, and some people don't like this approach)
>
> Yes, that's the correct fix. Care to submit a patch?
>
>> for (p = children_to_clean; p; last = &p->next, p = p->next) {
>>       ...
>
> That is OK, too, but I think I prefer the first one.
>

I feel like bikeshedding a bit today!

I tend to either prefer either the latter or something like this:

while (p) {
	...

	last = p;
	p = p->next;
}

because those approaches put all the iteration logic in the same
place. The in-body traversal approach is a bit more explicit about the
traversal details.

And to conclude my bikeshedding for the day: Shouldn't "last" ideally
be called something like "prev" instead? It's the previously visited
element, not the last element in the list.
