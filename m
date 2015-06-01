From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Getting the full path of a conflicting file within a custom merge driver?
Date: Mon, 01 Jun 2015 09:46:23 -0700
Message-ID: <xmqqr3pv74ww.fsf@gitster.dls.corp.google.com>
References: <D8780C527EB1E642B3150E6D705B46D468837861@DWPWHMS531.dwpbank.local>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: "Gondek\, Andreas" <Andreas.Gondek@dwpbank.de>
X-From: git-owner@vger.kernel.org Mon Jun 01 18:46:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzSr9-0006Eo-Jl
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 18:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbbFAQq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 12:46:27 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:35604 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbbFAQqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 12:46:25 -0400
Received: by igbyr2 with SMTP id yr2so66532056igb.0
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 09:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=RhdiYMi4mHUJeeF+suZTwF6rb5Hx6LsWd6UUnXMXZGU=;
        b=cWlRuP39Gdh0vAJUWHk/ABsRYcRCSQTUUMlC1yWoetI2ngqWXcnJRN4xzdn6ysRq0n
         5wWJy7lbg7lpoTlSjcLn50PJ/ssOnmJ43C2/uCZiYVUEIeFyMRoGHyRdJ/l736LsC2Bg
         4nyqPYnGilVJz8FRv45v4h0bd97lmyzFCjEwW7XENDJn65GUdKGStUp4Db/F1mMwvCea
         6ErPX3vwDvdMSYY+p4vsSFWg7EM25JgPzqNjUu0deZpsRmppMilY1OFmeKjhbglwPurk
         eiSHkSaa7okGQFh+ssZrLWu0X/HvdXNR5mVOWSmMGAmtyG9ddBr3GmVfsal3547dTvA/
         oSQA==
X-Received: by 10.43.63.76 with SMTP id xd12mr3825150icb.11.1433177185076;
        Mon, 01 Jun 2015 09:46:25 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b0e6:ec48:f0c0:da4d])
        by mx.google.com with ESMTPSA id d8sm8154428igl.19.2015.06.01.09.46.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 09:46:24 -0700 (PDT)
In-Reply-To: <D8780C527EB1E642B3150E6D705B46D468837861@DWPWHMS531.dwpbank.local>
	(Andreas Gondek's message of "Mon, 1 Jun 2015 15:46:44 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270436>

"Gondek, Andreas" <Andreas.Gondek@dwpbank.de> writes:

> I'm wondering if there is no option to find out the full path of a
> conflicting file from within a custom merge driver? If I understand
> this correctly, Git only provides the name of the 3 temporary local
> files and the size of the limiter. But is there any possibility to get
> the path of the file via a Git command, that I can run from within the
> merge driver? Maybe as part of the repository's status?

Short answer is "no", as the merge driver interface was originally
designed for a backend that can do its job with only the contents of
the three variants without any other information.  Imagine the
interface to things like "merge" from the RCS suite where it takes
three variants as the input---for them, the same three-tuple of
original, mine and theirs contents should merge to identical result
no matter where in the working tree the conflicts happened.

Having said that, I do not think it is unreasonable to feed more
information to external merge driver, perhaps by adding a new
environment variable GIT_MERGE_CONFLICTED_PATH exported when the
driver is run, or something.
