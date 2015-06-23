From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC/Pull Request: Refs db backend
Date: Mon, 22 Jun 2015 22:36:18 -0700
Message-ID: <xmqqvbefdm0d.fsf@gitster.dls.corp.google.com>
References: <1435020656.28466.8.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 07:36:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7Gsk-0002pE-CX
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 07:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138AbbFWFgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 01:36:22 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:34339 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbbFWFgV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 01:36:21 -0400
Received: by iebmu5 with SMTP id mu5so4513691ieb.1
        for <git@vger.kernel.org>; Mon, 22 Jun 2015 22:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=vNHvUV1PndPcFC1oY8C1zmKXdg3huHNSd0OWEzrY4Yk=;
        b=Z1CtT8XYDj6UHYort1FTpuqgfgu7PAgVj2YiyNyjBDTynyMIBBBPGynjvUWtrTZxwI
         tDPL63hGDv2yO86X98Fa6rxdmfZBLqBrQXBDwnyEf95w7uwT8W0UQxj5d8FzbBRHKF5r
         ZBmYU8saHleK0R3vZxtUmOR/19sIRqDKrj75Qie1ksqV+LLoAgQmA7a4IXpFLhvq5VO9
         E4lxQk4+4TEYhc8inpS/7S25dMSVO84YgBeqR/ii5cYexb/ISA35JoaNtBnwuTqfL8JX
         KoKzubjkZUlWFOJiWT3oN7yR1Dl4Nkepxmv9TBELtQs2SpPe+Mw/lyHbFo406nkFyGbA
         xpTw==
X-Received: by 10.107.35.203 with SMTP id j194mr44082754ioj.45.1435037780560;
        Mon, 22 Jun 2015 22:36:20 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3c90:65f7:f86b:dfda])
        by mx.google.com with ESMTPSA id p196sm14404974iop.15.2015.06.22.22.36.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Jun 2015 22:36:19 -0700 (PDT)
In-Reply-To: <1435020656.28466.8.camel@twopensource.com> (David Turner's
	message of "Mon, 22 Jun 2015 20:50:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272440>

David Turner <dturner@twopensource.com> writes:

> I've revived and modified Ronnie Sahlberg's work on the refs db
> backend.  
>
> The work is on top of be3c13e5564, Junio's "First batch for 2.5 cycle".
> I recognize that there have been changes to the refs code since then,
> and that there are some further changes in-flight from e.g. Michael
> Haggerty.  If there is interest in this, I can rebase once Michael's
> changes land.
> ...
> The db backend runs git for-each-ref about 30% faster than the files
> backend with fully-packed refs on a repo with ~120k refs.  It's also
> about 4x faster than using fully-unpacked refs.  In addition, and
> perhaps more importantly, it avoids case-conflict issues on OS X.
>
> I chose to use LMDB for the database...
> ...
> Ronnie Sahlberg's original version of this patchset used tdb.  The
> advantage of tdb is that it's smaller (~125k).  The disadvantages are
> that tdb is hard to build on OS X.  It's also not in homebrew.  So lmdb
> seemed simpler.

"If there is interest"?  Shut up and take my money ;-)

More seriously, that's great that you stepped up to resurrect this
topic.  In a sense, the choice of sample database backend does not
matter.  I do not care if it is tdb, lmdb, or even Berkeley DB as
long as it functions. ;-)

As long as the interface between ref-transaction system on the Git
side and the database backend is designed right, your lmdb thing can
serve as a reference implementation for other people to plug other
database backends to the same interface, right?  As one step to
validate the interface to the database backends, it would be nice to
eventually have at least two backends that talk to meaningfully
different systems, but we have to start somewhere, and "for now we
have lmdb" is as good a place to start as any other db backend.

I wonder if we can do a "filesystem" backend on top of the same
backend interface---is that too much impedance mismatch to make it
unpractical?

Thanks.
