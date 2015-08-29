From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git checkout" resets modified files
Date: Sat, 29 Aug 2015 00:15:45 -0700
Message-ID: <xmqqlhcuzhsu.fsf@gitster.mtv.corp.google.com>
References: <CANDob0LdQpoSfsedPK_yhNunXBvNTc9L1zKOM9h8dBUDePs0kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Steve Heyns <notzippy@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 29 09:15:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVaMi-0002st-4f
	for gcvg-git-2@plane.gmane.org; Sat, 29 Aug 2015 09:15:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484AbbH2HPr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2015 03:15:47 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36640 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309AbbH2HPr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Aug 2015 03:15:47 -0400
Received: by padhm10 with SMTP id hm10so29129385pad.3
        for <git@vger.kernel.org>; Sat, 29 Aug 2015 00:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Y7Xj7LroMlc0zyXoztI8v29hI9w6X0winA3REDdfR9Q=;
        b=vQSGi2iF/Trb+ZC0uqqSQRqpa9FneXQOqvnOjxgBJZDESMqbB/a/IKASaZAzciNF4g
         N18cUAoeUN+Cr8xsWQ6joi1pU6sYzDZYs/JJtnjsukIqW1SJhoKGXNUe4XND2EnhszMP
         SQHMy/QjbL38EUP1017+E9LKfJGXNuqTah9AYiDL8Hdp591Sj6bOWdmYbFB1GcDlS1kV
         chqL2SHQud3eFKANKRbyxHBbyZOZ3oZOgB/G6CJPgsxwWKUMNrsJ3TNMax87QMuigeul
         tA82vwgyjjW2ZCVj9ml8Ekw7EfOPK3svxkupJs/N/Lnz39T0emQAJniNFyheW22E86pT
         IM9Q==
X-Received: by 10.66.139.6 with SMTP id qu6mr21042270pab.77.1440832546671;
        Sat, 29 Aug 2015 00:15:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:8d2:f21a:caa6:b0e7])
        by smtp.gmail.com with ESMTPSA id kw3sm7796921pbc.30.2015.08.29.00.15.45
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 29 Aug 2015 00:15:46 -0700 (PDT)
In-Reply-To: <CANDob0LdQpoSfsedPK_yhNunXBvNTc9L1zKOM9h8dBUDePs0kg@mail.gmail.com>
	(Steve Heyns's message of "Fri, 28 Aug 2015 23:15:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276769>

Steve Heyns <notzippy@gmail.com> writes:

> "git checkout" resets modified files
>
> Version git  2.5.0,
>
> Description:
> I was automating a process that would pull and switch to another
> branch when I stumbled across this. I have not been able to emulate
> this from command line but using go (or I imagine other languages are
> similar) if you execute a command like
>
> exec.Command("git","checkout","")
>
> A checkout with the branch parameter but the branch parameter is empty.

It is not feeding an empty branch parameter [*1*].  It is asking Git
to check out all paths that match a pathspec "" out of the index.

Now, arguably, the user who would want to match everything may be
more likely to give "." as the pathspec (or if she is not at the
root of the working tree, ":/"), but "" means the same thing as ".",
and the requested behaviour "check out all that match this pathspec
from the index" would essentially mean "I want to get rid of all the
modification in my working tree relative to the index".

I do not think this behaviour depends on the vintage of Git.  An
empty string as pathspec has always matched "everything in here"
AFAIR.


[Footnote]

*1* Checking out a branch whose name is an empty string can be asked
    explicitly by disambiguating double-dash like this:

    $ git checkout "" --

And it will be answered (correctly) with:

    fatal: invalid reference
