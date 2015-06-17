From: Junio C Hamano <gitster@pobox.com>
Subject: Re: co-authoring commits
Date: Wed, 17 Jun 2015 14:51:18 -0700
Message-ID: <xmqqegla57hl.fsf@gitster.dls.corp.google.com>
References: <CAOvwQ4i_HL7XGnxZrVu3oSnsbnTyxbg8Vh6vzi4c1isSrrexYQ@mail.gmail.com>
	<xmqq4mm66r99.fsf@gitster.dls.corp.google.com>
	<CAOvwQ4j2bjR1jnLVyZbw1OCE=xQxbCEFGKcK1bpuv1K3s_Y2EQ@mail.gmail.com>
	<20150617205931.GB24079@cloud>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tuncer Ayaz <tuncer.ayaz@gmail.com>, git@vger.kernel.org
To: josh@joshtriplett.org
X-From: git-owner@vger.kernel.org Wed Jun 17 23:51:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5LFJ-000578-RU
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 23:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757309AbbFQVvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 17:51:41 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:34915 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755805AbbFQVvU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 17:51:20 -0400
Received: by iesa3 with SMTP id a3so43200854ies.2
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 14:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=kg1Ij7RR8imQokuGk0eoTs4Oi8xbcp0Yow1ZQEV33CM=;
        b=mzvhbNtE6vj/5WCzztmWIrMjBFKstpKmI11z5tn4oPmURtVpwPwNw/kLrGCJoq+kAY
         uWD1LBhQC82dmIyWX+3lzgtoPcrlskx5wurPdDPdolC+RQIe268R6/SSGBBdyx4/Xaff
         hUDjNbJNCOQB/HqA9VM7GQDcmWx8uSYT4dojcbNUzpsOumfZtgvZ7MKTHre0dO4TufFS
         fUQp9+gSXSdzl6gPeDVpJU9IfXby/uG6rlehbir6SPIqa9Ha/YjetUj/IKsV8MuyWvVB
         KAHR6vwSwlG4UZrcNEcUfM8/AYksDQJ8y4DQy6ertqn5+TZW17NYj/QtHL/SqVTz55yy
         gGJw==
X-Received: by 10.50.43.131 with SMTP id w3mr9574725igl.8.1434577879764;
        Wed, 17 Jun 2015 14:51:19 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a4d4:8fab:953e:ec65])
        by mx.google.com with ESMTPSA id b74sm3438788ioe.6.2015.06.17.14.51.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jun 2015 14:51:19 -0700 (PDT)
In-Reply-To: <20150617205931.GB24079@cloud> (josh@joshtriplett.org's message
	of "Wed, 17 Jun 2015 13:59:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271918>

josh@joshtriplett.org writes:

> Having more than one author field in a commit would likely break things,
> but having a coauthor field seems plausible these days.  Git added
> support for signed commits, and the world didn't end, so it's possible
> to extend the commit format.

Something being possible and something being sensible are two
different things, though.

I agree "coauthor field that is not understood by anybody" would
unlikely break existing implementations, but it is not a useful way
to add this information to commit objects.  For one thing, until you
teach "git log" or its equivalents in everybody's (re)implementation
of Git, the field will not be shown, you cannot easily edit it while
amending or rebasing, "git log --grep=" would not know about it, and
you would need "git cat-file commit" to view it.

A footer Co-authored-by: does not have any such issue.

We left commit headers extensible long before we introduced commit
signing, and we used it to add the "encoding" header.  In general,
we invent new headers only when structurely necessary.  When you
declare that the log message for this indiviaul commit is done in
one encoding, that is not something you would want to _edit_ with
your editor while you are editing your message.  Similarly you would
not want to risk touching the GPG signature of a signed commit or a
signed merge while editing your message.

The _only_ reason I would imagine why somebody may be tempted to
think that "coauthor" as part of the object header makes sense is
because "author" is already there.  You can argue that "author" did
not have to be part of the object header, and that is right.  I
would agree with you 100% that "author" did not have to be there.

But that is too late to change.

And being consistent with a past mistake is not a good reason to
repeat that same mistake.
