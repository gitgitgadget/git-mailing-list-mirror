From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] refs: support negative transfer.hideRefs
Date: Tue, 28 Jul 2015 13:14:47 -0700
Message-ID: <xmqqwpxkca4o.fsf@gitster.dls.corp.google.com>
References: <20150728195747.GA13596@peff.net>
	<20150728195934.GB13795@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 28 22:14:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKBH3-00078t-BC
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 22:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777AbbG1UOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 16:14:49 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:36654 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbbG1UOs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 16:14:48 -0400
Received: by pdjr16 with SMTP id r16so77408218pdj.3
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 13:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=30PFtZ4zvWz703B3FhnTRue5iZxr8Xgai/8IPvr2zjI=;
        b=Wc6v3r1shHGSNqv7QtV4PbKnWP+1/UnWm4qRT/JKMscLYviB7cSD4CTytZM3uy9o60
         cbI3/3tQjSn02Kli5XMOAMLlvCbC1k7vVzmtiU9TSOvkbupJaKmpflIn7qcSakDLLXpT
         fFvi64gBXWJbX/+d9tN9yXUreytMRbjDesYmz0nLdXU8VI/qPAT/axIfJcuO1u8SYNmn
         dYVFD3VcB5y2n/5NKqcc0tMb+zO+QBDOFnWjkTUin6ONlnp0JFiFrS0Rwzf3nyuMnX0i
         qM3Evq1YhGr79q48O0vxZYmZDR0BTNkk9C3vrdG3c7PDlHut7e215WOp2TPOX5vmMW60
         2Igg==
X-Received: by 10.70.134.163 with SMTP id pl3mr83360739pdb.142.1438114488363;
        Tue, 28 Jul 2015 13:14:48 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e592:68fd:3f1d:35f9])
        by smtp.gmail.com with ESMTPSA id cz1sm36705403pdb.44.2015.07.28.13.14.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 Jul 2015 13:14:47 -0700 (PDT)
In-Reply-To: <20150728195934.GB13795@peff.net> (Jeff King's message of "Tue,
	28 Jul 2015 15:59:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274836>

Jeff King <peff@peff.net> writes:

> If you hide a hierarchy of refs using the transfer.hideRefs
> config, there is no way to later override that config to
> "unhide" it. This patch implements a "negative" hide which
> causes matches to immediately be marked as unhidden, even if
> another match would hide it. We take care to apply the
> matches in reverse-order from how they are fed to us by the
> config machinery, as that lets our usual "last one wins"
> config precedence work (and entries in .git/config, for
> example, will override /etc/gitconfig).
>
> There are two alternatives that were considered and
> rejected:
> ...
>   1. A generic config mechanism for removing an item from a
>      ...
>   2. Adding another variable to override some parts of
>      ...
>      Of course we could internally parse that to a single
>      list, respecting the ordering, which saves us having to
>      invent the new "!" syntax. But using a single name
>      communicates to the user that the ordering _is_
>      important. And "!" is well-known for negation, and
>      should not appear at the beginning of a ref (it is
>      actually valid in a ref-name, but all entries here
>      should be fully-qualified, starting with "refs/").

I notice that the only time you said that you chose '!' prefix as
the way to express this new "negative" is as a side note to the
rejected second variant ;-).  The first paragraph would have been a
good place to say that, because the first thing I wondered after
reading three lines (including the subject) into the log was "ok, it
makes sense and I know what alternatives were considered and
discarded for what reasons without reading the rest, now did he use
prefix '-', prefix '~', prefix '^', or prefix '!' for the new
syntax, or did he use something else?"

It would have been very nice if you chose an invalid ref character
as the negative prefix, and unfortunately '!', which would also have
been my first choice for this prefix, is not an invalid character,
which is a bit sad.

Both patches make sense.  Will queue.

Thanks.
