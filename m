From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 4/4] worktree: add 'list' command
Date: Wed, 23 Sep 2015 22:00:49 -0700
Message-ID: <xmqqvbb0v2bi.fsf@gitster.mtv.corp.google.com>
References: <1442583027-47653-1-git-send-email-rappazzo@gmail.com>
	<1442583027-47653-5-git-send-email-rappazzo@gmail.com>
	<xmqq37y644x7.fsf@gitster.mtv.corp.google.com>
	<CANoM8SX28TPt_U8v9HO4yo=M46-JKn5S11DrhZ0-EdrjkDT3EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>
To: Mike Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 24 07:00:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeyeQ-0007tQ-Ae
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 07:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbbIXFAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 01:00:53 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:32813 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbbIXFAw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 01:00:52 -0400
Received: by pacex6 with SMTP id ex6so61517079pac.0
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 22:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=S6cp/Dkm2CCbh5jJ2no+Dt5jTUXUaolamh6izY244WQ=;
        b=Icy9u5Jawv+2CZ0d1aPkU13Ln9hs5iGnxGSIimn6/iJ2GHXepxrTvWo25Qqe5YZv+j
         I1iY/ALHeKKwbNfdfX5f2IHdXu41DQnEmtVIjhXb5+jQbwN0BkzooKPRmyXuEckstDx9
         3QYHbkUklxvH7oSz/pwivU16j2gn6ULINCavTKjgc886q6LBgL1OEb8xSB4DEw3M7DQ3
         Iwbf3qmn5RgFOAlrgtGTfIZMPgXAucs0e4IMB4v0pvUj+e1p4PNtEMIdhCpwtNj4e8Oh
         TEnDMJzThY69MPzkd8D98i8P28irhCBLyF11Ve2gwPCyVjFKHE7D4R272UXT0rsltFMK
         QWmA==
X-Received: by 10.66.248.10 with SMTP id yi10mr42814976pac.6.1443070852423;
        Wed, 23 Sep 2015 22:00:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:a07c:76d3:22e9:4d3d])
        by smtp.gmail.com with ESMTPSA id hn1sm10997327pbb.44.2015.09.23.22.00.49
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 23 Sep 2015 22:00:50 -0700 (PDT)
In-Reply-To: <CANoM8SX28TPt_U8v9HO4yo=M46-JKn5S11DrhZ0-EdrjkDT3EQ@mail.gmail.com>
	(Mike Rappazzo's message of "Wed, 23 Sep 2015 22:58:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278530>

Mike Rappazzo <rappazzo@gmail.com> writes:

> ...  Does the porcelain
> format restrict additive changes?  That is, is it OK for a future
> patch to add another field in the format, as long as it doesn't alter
> the other values?  Is the format that I have used here acceptable
> (assuming the changes proposed below are made)?

It for you, as the designer of the format, to decide what to put in
the proposed specification, but I'm sure that we would want it to be
extensible.  I guess your design is essentially a series of records,
each of which begins with a "worktree <path>" line, followed by
various attributes, one per line, about that worktree, and each
attribute line begins with some fixed keyword so that the reader can
tell what attribute the line is talking about (or if the line
describes an attribute that the reader does not yet know about), and
I think that is an acceptable format.

You need to decide and describe if the value for some attribute can
span multiple lines (and define the quoting mechanism if that is the
case), what the set of keywords currently defined and what each of
these keywords means, and document that the readers are expected to
skip a line that begins with an unknown keyword.

>> Are the number of SPs here significant and if so in what way?  Does
>> it depend on your environment or will there always be six of them?
>> Either way feels like an indication of a problem.
>
> The number of spaces is significant in this case, but it should not be
> platform dependent.  It is just the padding for the different worktree
> paths.

By environment, I didn't just mean 'platform'.  For example, the
output from --show-toplevel will be different for me and you as it
is likely that the absolute path where I have my repository and you
have yours would be different, so the contents of "expect" would
also be.  I was wondering where that SIX comes from.

The reason why I said it feels like an indication of a problem is
because it invites this question: If it is uniformly SIX no matter
what the user's environment is, why does it have to be SIX and not
other value, say, ONE, for example?
