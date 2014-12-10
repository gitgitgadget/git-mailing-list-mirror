From: Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: Blobs not referenced by file (anymore) are not removed by GC
Date: Wed, 10 Dec 2014 23:41:02 +0000
Message-ID: <CAFY1eda6LyZ3z-Uu2AQpqeeCpc9mn_JXwB1+TRLkyGsG+GQzPQ@mail.gmail.com>
References: <5485D03F.3060008@fu-berlin.de>
	<20141209141457.GA18544@peff.net>
	<CAFY1edaEG040jnfTJA4G9a0bAkFJHc3N5sHjtwOOdXmndsu9YQ@mail.gmail.com>
	<20141209161133.GA17756@peff.net>
	<CAFY1edY=Ren9krK1-yFoxt92AAushUyqnbt=69hdXMeiBFAK=w@mail.gmail.com>
	<20141210071119.GA18104@peff.net>
	<xmqqbnnbjxoy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Martin Scherer <m.scherer@fu-berlin.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 00:41:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyqsX-0004eo-2h
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 00:41:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758341AbaLJXlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 18:41:04 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:57085 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758251AbaLJXlD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 18:41:03 -0500
Received: by mail-ie0-f181.google.com with SMTP id tp5so3764217ieb.12
        for <git@vger.kernel.org>; Wed, 10 Dec 2014 15:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UYHl0NTvJWKphSQ9daLnqcW+ij0qg2e5wcRJX0BqLP0=;
        b=MVvoVEB/zriBBc2Pxc4IJMxlqNDZbvNQ94bHbo3cEvgH77cp6g6hYT67apIMlClSBO
         UwypKdqUpcma65I0YlykQfmZ1f6Tq8ObvZJzaR++hOeUHW0PR1HdyuOWLpMLYHL8Odkt
         swHuoK8vsN6SvVLQPPimu13oRK3jZyEXW7wM43MdT0kimo1e8BNa0xXI5eWbP4OWV0nm
         VoCttvYrWIPIN3EVeX50GAbxBx6bpttXtpZ88jc6ODr2lWAk0l9K+1FYtu+YugrzKzNP
         z8e86QyNqfmm0uQuXiUvDfw0oPZtX+LZulJUbh/Ednf/ggwHzbgcAn4nYlC5vjTfgTSq
         bgDw==
X-Received: by 10.50.124.133 with SMTP id mi5mr11050885igb.13.1418254862354;
 Wed, 10 Dec 2014 15:41:02 -0800 (PST)
Received: by 10.64.240.171 with HTTP; Wed, 10 Dec 2014 15:41:02 -0800 (PST)
In-Reply-To: <xmqqbnnbjxoy.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261258>

On 10 December 2014 at 16:07, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>>> git reflog expire --expire=now --all && git gc --prune=now --aggressive
>>>
>>> Maybe:
>>>
>>> git gc --purge
>>
>> Yeah, that is common enough that it might be worthwhile (you probably
>> want --expire-unreachable in the reflog invocation, though).
>
> Also you would not want an unconditional --aggressive.

After a big rewrite deleting files the re-optimisation of --aggressive
can make a big difference to packsize - for instance 1.2GB to 768MB in
a test I just ran - but of course it is *much* slower, so I suspect
you're right about not including it.

I wasn't aware of the '--expire-unreachable=all' switch, though it
seems like a 'milder' version of the '--expire=now' switch? - in that
it would keep reflog entries if they haven't been changed, which is
fair enough and compatible with the 'purge' goal.
