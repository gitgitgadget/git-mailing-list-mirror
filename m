From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Mark trailing whitespace error in del lines of diff
Date: Tue, 26 May 2015 10:33:48 -0700
Message-ID: <xmqqa8wrkzur.fsf@gitster.dls.corp.google.com>
References: <9b8e349e223dc9cd871fc5f7915e590548322932.1432585659.git.cb@256bit.org>
	<xmqq617g9oer.fsf@gitster.dls.corp.google.com>
	<20150526163108.GB24439@256bit.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Christian Brabandt <cblists@256bit.org>
X-From: git-owner@vger.kernel.org Tue May 26 19:34:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxIjn-0004OI-NX
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 19:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754431AbbEZRdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 13:33:55 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:33690 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbbEZRdy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 13:33:54 -0400
Received: by iebgx4 with SMTP id gx4so97572678ieb.0
        for <git@vger.kernel.org>; Tue, 26 May 2015 10:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=TmE0iPxe48aL1OrdN9wPdqZoNyuKga42d6QcNi89s9w=;
        b=FX1Jtqw9S8ncD8gvw7kxl/8FBqnuDp5jEQuj7T620c6Th+h2AZMZHq9rIY1m0OE2kQ
         g0fyMoQifwYic1PyHhPSfzNjS/Wu0rSulpF6mntBn7xAicnPO9Z0Rd82DpCur/V16j++
         4p0mth0ew4r0qkTgp+g2aFKYWAlsrLmuT2GkErlx+grCe7FOmIp1uMJK0CrLOg/Cyi8S
         e25uPWfE/V20mAkPsQdu2QAj9BopFJT0v5ghhT4u6ENuV62NMFe7oTUC6grnEbn51m0W
         jpV3Fof+18qIANTLW3LfXrQQyyZYXW209/a9/91dx4UtmO1R0PfRn59894JV9IfMNBcP
         OD2A==
X-Received: by 10.42.200.8 with SMTP id eu8mr31389524icb.65.1432661633642;
        Tue, 26 May 2015 10:33:53 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f93e:abc0:fe54:4a5a])
        by mx.google.com with ESMTPSA id f15sm3263085iof.36.2015.05.26.10.33.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 May 2015 10:33:52 -0700 (PDT)
In-Reply-To: <20150526163108.GB24439@256bit.org> (Christian Brabandt's message
	of "Tue, 26 May 2015 18:31:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269955>

Christian Brabandt <cblists@256bit.org> writes:

>> But as I said in the other message, I think that the approach this
>> patch takes goes in a wrong direction.  Instead of adding a single
>> "check and highlight this and only kind of breakage on preimage"
>> option as a new kind to existing "what kind of use of whitespaces
>> are errors" set, it would be more sensible to add a single "check
>> and highlight breakages on preimage lines as well" option that is
>> orthogonal to the existing ones that specify "what kind of use of
>> whitespaces are errors".
>
> Oh well, too bad. It sounded like a good idea...

Oh, don't get me wrong.  I do not think it is not a good idea
(i.e. problem and general strategy to solve it).

Problem:

    Sometimes it is desirable to keep existing whitespace breakages
    while working on fixes and other changes of substance.  The user
    however gets whitespace errors painted only on new lines in the
    output from "git diff", and this makes it hard to tell if they
    were introduced by the user's change or came from the original.

Strategy:

    By painting whitespace breakages in the old lines, the user can
    eyeball and find the corresponding old lines when whitespace
    errors on new lines are painted.  If the corresponding old lines
    have the same errors, the user can see they were inherited from
    the original.

These may be a pair of reasonable problem to solve and a general
strategy to solve it.

What I said was *not* good was the particular execution, the
approach that the patch took.
