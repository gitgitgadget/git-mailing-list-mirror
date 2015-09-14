From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] fetch submodules in parallel
Date: Mon, 14 Sep 2015 15:06:22 -0700
Message-ID: <xmqqmvwoveox.fsf@gitster.mtv.corp.google.com>
References: <20150914180759.GA11920@sigill.intra.peff.net>
	<1442267451-2527-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: peff@peff.net, git@vger.kernel.org, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Sep 15 00:06:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zbbtd-0000eJ-H1
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 00:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010AbbINWGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 18:06:41 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36561 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986AbbINWGk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 18:06:40 -0400
Received: by padhk3 with SMTP id hk3so154905247pad.3
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 15:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=95hU16ZUSoG8UowNTolpG53GFkmpnVEVob9rX0s75hs=;
        b=f08OVvhfOWnmqQwq4eWAAo0Ok8CeS6+vv62815poQAkMPt67K9NFQQkgtjA7ZxqMcX
         +D2HEZRA19qNnWdUq4rRvajdMDk7SQKfMqGQqyXlMJPGqWz60bLDPXuy3sTaeDhMEwLx
         WFPod3O9B4w/6kIgN+YIFomPfAHJPgYe2QoR22ltXvcvybxJGnz2pkVC5VGD5EqTgn/v
         XAKUhtB9rFye/l1xTUZQ9oltDYsZ/RiptlMnoHGdT+bfiVw7Ee2Z0btPFF6r0G6MgKG3
         kulT6329zS1eN47fDb303pOINzGjdq9a5z9tjXHtUnpNh+vZ6FlJgIpJquBY3Qtc9yU5
         5/iA==
X-Received: by 10.68.218.104 with SMTP id pf8mr39602160pbc.31.1442268400185;
        Mon, 14 Sep 2015 15:06:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:611e:bac9:b978:992c])
        by smtp.gmail.com with ESMTPSA id bt5sm5842245pbd.57.2015.09.14.15.06.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 14 Sep 2015 15:06:39 -0700 (PDT)
In-Reply-To: <1442267451-2527-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 14 Sep 2015 14:50:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277868>

Stefan Beller <sbeller@google.com> writes:

> This replaces the last patch of the "Parallel git submodule fetching"
> series. Changes:
>
> * have correct return code in submodule fetching when one submodule fails
> * use poll instead of select now
> * broke down into more smaller functions instead of one giant.
>   (I think it is an improvement, but I wouldn't be surprised if someone objects)
> * closed memory leaks
> * document the need for stdout_to_stderr
>
> I don't deem it RFC-ish any more but good to go.

I didn't say this in the previous round because it smelled like an
RFC, but for a real submission, 2/2 may be doing too many things at
once.  I suspect this is more or less "taste" thing, so I won't mind
too much as long as the reviewers are OK with it.
