From: John Koleszar <jkoleszar@google.com>
Subject: Re: [PATCH] http-backend: respect GIT_NAMESPACE with dumb clients
Date: Thu, 4 Apr 2013 08:34:34 -0700
Message-ID: <CAAvHm8PCQx18Gk2S7dicG+_GksjFqVLfPNCbism1sHnPUMDNzg@mail.gmail.com>
References: <CAAvHm8N8Sm-EuA5ofPp1qNJrZGqcRbzA3LFX5s0-g8oCnB8bhw@mail.gmail.com>
	<1365004329-15264-1-git-send-email-jkoleszar@google.com>
	<20130403161038.GB16885@sigill.intra.peff.net>
	<20130403161600.GC16885@sigill.intra.peff.net>
	<7vbo9v5w2w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Josh Triplett <josh@joshtriplett.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 17:35:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNmBx-0006YY-Ck
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 17:35:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760047Ab3DDPeh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 11:34:37 -0400
Received: from mail-we0-f169.google.com ([74.125.82.169]:38696 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754722Ab3DDPeg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 11:34:36 -0400
Received: by mail-we0-f169.google.com with SMTP id x43so2251800wey.28
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 08:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=q/STMRrD3j9BGQzHjuPm1ibCYgBlR57o4VuyahLMfcY=;
        b=eGmOYw43gD0eXcYfY9MIhAcx7PlKRSjAVstLA/t5GpuQ11Xwnt3KSRNLMNSchZRmiN
         KJC4aSCdvouAgH9/McnwPLfG+M08eZyuE6oSxYuakmhQvXLoTM4tWa1Ov26ikXenCzF2
         Yim1nhyNmVwr2y+rPHjY6fQFeefldE0rzZI5fQdI7a82XqrQI47lsVtsCIenRCpeDaFv
         KyHuJ63SVpBArgNkqhK+dGq8tXAzQ9zItCWIboBSvfFdBvI8IHISE6NSAJ82lSYV4R57
         PkUJnxhh/if59a6tGcOVRVSY/grwdrlQLibzcG3lTb5SCxtlv61TmqrR2++WuUyHCYZu
         ZnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:x-gm-message-state;
        bh=q/STMRrD3j9BGQzHjuPm1ibCYgBlR57o4VuyahLMfcY=;
        b=ftgWfjzAGwIaBzfjBrBiuyBFOtbquXH3Q92hTg/DHOsvzwvpKKk/NsOQFzMbpLmsnn
         Gzp19YSbHyRVOuwBQFeKIDMN0MdPyEm5tDkBjptfDsKIVYxVmbIIJYCzot6eIdmjougB
         8TLcQTKnqvmAgFeF3Uip6wTlxPVqcrRI4jjSerryivjY54z3oPLxYmSA7D1s2mY3WlKE
         ddN2RuzmJMOuG/4OyyD6CRlOmX3lkKKWPI2bo0oPvDYLEUkYGvGEgcVl0JEz9vkTPud7
         PEZQVBEhPEvREUtkEasfJH9lOGxN0YUL3eT0U9sQBvMQPWjJO7TCt4j1rx/kzXPuaj43
         Pk3Q==
X-Received: by 10.194.122.131 with SMTP id ls3mr10416262wjb.55.1365089674737;
 Thu, 04 Apr 2013 08:34:34 -0700 (PDT)
Received: by 10.194.62.165 with HTTP; Thu, 4 Apr 2013 08:34:34 -0700 (PDT)
In-Reply-To: <7vbo9v5w2w.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQn5NR5E8iF14CmMaGRGDGqE1npoW/gxW+vdAiFG84ERLDrEJ5LlkmHIS8w7rvvCyeh9bzMKamenuPmn7DQhdpwBIr2MYtsB7JZR4rWWja/rEv2qwigMVf12eRGEBa2rG7HxhRBk5tNaxnXtiKrgUGpaK/uOZUNVRN/+99qtkWAxGgJjp5eFcTocQSpe2u5agr/Ndx/G
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220017>

On Wed, Apr 3, 2013 at 11:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Wed, Apr 03, 2013 at 12:10:38PM -0400, Jeff King wrote:
>>
>>> Hmm. This is testing just the ref advertisement. It would be nice to see
>>> a complete transaction tested with namespaces turned on. Something like
>>> this (squashed into your patch) seems to work for me:
>>
>> Actually, I guess the point of your patch was to fix the
>> dumb-via-http-backend transport. So this would be more complete:
>
> Yeah, sounds sensible to me.
>

Agreed, this is much more thorough. Thanks!

I'll fold this in with Junio's comments and have another patch ready in a bit.

John
