From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10.1 7/7] bisect: allow any terms set by user
Date: Fri, 26 Jun 2015 15:25:50 -0700
Message-ID: <xmqqa8vmrtsh.fsf@gitster.dls.corp.google.com>
References: <xmqqsi9etjwy.fsf@gitster.dls.corp.google.com>
	<1435351183-27100-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sat Jun 27 00:26:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8c4N-0005Cq-2N
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jun 2015 00:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752488AbbFZWZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 18:25:54 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:32949 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbbFZWZw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 18:25:52 -0400
Received: by igtg8 with SMTP id g8so11212190igt.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 15:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=tO9hGgQQZF9tYLe5agY2PMldG3aPSU/GI8TXHT1RAUg=;
        b=wmaLb++OCRIOlnovE86XGgTQb1BY76bQ52DmcNlq4UgsTH7/2kyq4RSq9V760xrYd3
         c2X3iKpmPIhKs1cabM2IjmJyH6iCPEpWZsF1trh6Z7ywOnFha1Sp+WEkqIYUWJWEC9HH
         KHpo9sAq31FWDgyYIBJaL2v/+jqYESAvz6DzwOJVhjxBEOQBXfOjDG+O4QR6ByvZDjdX
         crZUhb139tBWUGBLo+DO/j05XlMaYSeOyqwa6F5wAv46vHkgiZmCcyp/9oBpBjPosYk/
         EzYO9qH4GkXHnycCneN5jQQ+O/N4Qs0izFIbdyB7XD6vNToUziEZNQeVOlpfC2zmrfBq
         8RUg==
X-Received: by 10.107.12.72 with SMTP id w69mr5474061ioi.10.1435357552090;
        Fri, 26 Jun 2015 15:25:52 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6587:7c7a:db33:ca35])
        by mx.google.com with ESMTPSA id a82sm22442563ioe.22.2015.06.26.15.25.51
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Jun 2015 15:25:51 -0700 (PDT)
In-Reply-To: <1435351183-27100-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Fri, 26 Jun 2015 22:39:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272837>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

>> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>>
>>> + git bisect terms <term-old> <term-new>
>>
>> I think this is the other way around.
>
> Indeed.

I hate to be saying this, but this is a strong indication that
consistency with "start $bad $good..." must be broken.  If the
person who has been working on this topic for a few iterations in
the past few days cannot get it right, no ordinary user can.  With
or without a mnemonic hint "N comes before O, so does B before G".

Of course we cannot just say "git bisect terms old new".  That would
only invite "eh, I do not remember, which between terms and start
take the old one first?" without helping people.

The best I can come up with is to forbid positional arguments to
this subcommand and always require them to be given like so:

	git bisect terms --old=fast --new=slow
	git bisect terms --new=slow --old=fast

We may want to start supporting

	git bisect start --new=master --old=maint

while at it and then gently nudging people to stop using

	git bisect start master maint

by showing depreation notice.
