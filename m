From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log fails to show all changes for a file
Date: Wed, 15 Jul 2015 09:29:25 -0700
Message-ID: <xmqq8uahxu3e.fsf@gitster.dls.corp.google.com>
References: <20150714073035.GA22707@aepfle.de>
	<20150714074508.GE1451@serenity.lan>
	<20150714075955.GA24577@aepfle.de>
	<CA+55aFzPvwAghGtA-WH8i1PcNe55XORokaXF9hNu7OUXBx++6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Olaf Hering <olaf@aepfle.de>, John Keeping <john@keeping.me.uk>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jul 15 18:29:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFPYq-0008R2-GG
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jul 2015 18:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081AbbGOQ32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2015 12:29:28 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:35406 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbbGOQ31 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2015 12:29:27 -0400
Received: by iecuq6 with SMTP id uq6so37485701iec.2
        for <git@vger.kernel.org>; Wed, 15 Jul 2015 09:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=7HPQxGXq7s1882PQe/XGPEd/TexHatwMvrdyFkXz8Vc=;
        b=YymHFjC3negQ+5Wz62V0E8naJeclN+tWJkpy0KkgmioD8kBhv5hPm9VkT1l4n13YOr
         6pt9FtnagLdPkO4FzZYNv3/41ztVOotKpK2LlwoDZwjo06cE8aXAHRDgYnyT9v6t0MS/
         cD2e6l1YjrZ0XMyrjPqXNdNWoNUVtZgsE80AO3aNiC8PjYEKYeZ4X1bdWQ9Uq3mTqIPm
         FgOjf0vpRmP1w6vYRC4xe8ejIF6X6d0EFAXsM+Zm7XN5rsIB3dD7T2AU1vin1FWj5nw8
         J34o74cpJuZTajTd0N7CBgj6sDav3yGAoAajDgh2byzGQ8POUDmgO13qkz7Ad+xmjm3u
         h+rg==
X-Received: by 10.50.28.78 with SMTP id z14mr27583423igg.61.1436977766984;
        Wed, 15 Jul 2015 09:29:26 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:91d4:b530:378d:909b])
        by smtp.gmail.com with ESMTPSA id i66sm3097867ioe.0.2015.07.15.09.29.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 15 Jul 2015 09:29:26 -0700 (PDT)
In-Reply-To: <CA+55aFzPvwAghGtA-WH8i1PcNe55XORokaXF9hNu7OUXBx++6Q@mail.gmail.com>
	(Linus Torvalds's message of "Tue, 14 Jul 2015 12:16:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273987>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> That said, I do wonder if we should just make "-p" imply "--cc". Right
> now we have the kind of odd situation that "git log -p" doesn't show
> merge patches, but "git show <cmit>" does show them. And you kind of
> have to know a lot about git to know the "--cc" option.
>
> In fact, that "git show" behavior really is very subtle, but very
> useful. It comes from show_rev_tweak_rev(), which is a magic git-show
> thing.

I would think "git log -p" that implies "--cc" would be a good
change, as long as there is an easy escape hatch to let us do what
we have to do with a rather lengthy "git log -p --first-parent -m"
(i.e. show the change relative to its first parent while traversing
the first parent chain) today.  Perhaps only when there is no
explicit "-m" but "-p" is given, automatically enable "--cc", or
something like that.
