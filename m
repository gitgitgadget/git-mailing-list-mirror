From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add ls-files --eol-staged, --eol-worktree
Date: Sun, 18 Oct 2015 12:00:57 -0700
Message-ID: <xmqq4mhoatna.fsf@gitster.mtv.corp.google.com>
References: <D68CC6D0-3FD5-4423-A9E2-905DF18E893F@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Oct 18 21:01:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZntCc-00085P-00
	for gcvg-git-2@plane.gmane.org; Sun, 18 Oct 2015 21:01:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbbJRTBA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Oct 2015 15:01:00 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35891 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbbJRTBA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2015 15:01:00 -0400
Received: by pacfv9 with SMTP id fv9so71275577pac.3
        for <git@vger.kernel.org>; Sun, 18 Oct 2015 12:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=jGD1Jt70hwhcLLjDXW9AJtoQeS5spdiPJ+jvuIJTlvc=;
        b=Q/vRHwVuceAvzcrtrhYmvYfwfz/JUGnB5pwJXMtv062qhwm7cnDq4inVj+77vNUfYn
         3eBrbnYDZ+nWdV57E6gdB5oJYzcb+AymGLZF6KyS1PCZpAeMm3tPUwy/3KlwpPGWSREk
         o6HEhApE4J6OLQbknLW1yntGOQ0+hko+1f4Ki+nM+SCBhZEziChG94sHQnq2Seesn/ub
         j70jE7vYuv1/cMw0rKg9kaXnfEjdWdn3GVW6Ui6Sbjc+QyJON3qsN12a/EV/wslN+e3/
         MSSJLOq7e3avHF6eFmLX7zh5Hb7tkIfF5IAKwUQ4fxH2QRoSbLGNN26c5DvPAr6/ZHEl
         Uq4Q==
X-Received: by 10.68.195.3 with SMTP id ia3mr29657060pbc.106.1445194859592;
        Sun, 18 Oct 2015 12:00:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:305b:5af5:2c51:11cd])
        by smtp.gmail.com with ESMTPSA id z12sm32115546pbt.30.2015.10.18.12.00.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 18 Oct 2015 12:00:57 -0700 (PDT)
In-Reply-To: <D68CC6D0-3FD5-4423-A9E2-905DF18E893F@web.de> ("Torsten
	=?utf-8?Q?B=C3=B6gershausen=22's?= message of "Sat, 17 Oct 2015 22:18:06
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279820>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Make it possible to show the line endings of files.
> Files which are staged and/or files in the working tree:
>
> git ls-files --eol-staged
> git ls-files --eol-worktree

Two unrelated (to the issues raised in other review responses)
issues in the UI:

 - While I can see how the new feature would be useful, I am not
   convinced that it is a good idea to add it to ls-files.  Does the
   option work well with other existing options like -s, -t, etc?
   Does it make sense to combine it with other options like -m, -d,
   etc?  I have this suspicion that "check-attr", "check-ignore",
   etc.  may give a better model that fits this feature better,
   i.e. "git check-eol".

 - When you have an operation that works on contents in the working
   tree, the established command line convention to alter the
   operation to work on contents in the index is with "--cached",
   and the operation by default would work on the contents in the
   working tee without "--worktree".  See gitcli(7).

   If I were doing this as part of "ls-files", I would add a new
   "--get-eol" option that inspects the working tree, and make
   "--get-eol --cached" do the same for the contents in the index,
   for consistency.  If I were doing "git check-eol", then the
   default mode of the operation would read from the working tree,
   and "git check-eol --cached" would read from the index.

   If the operation can work on both the contents in the index and
   in the working tree at the same time, we use "--index" instead of
   "--cached", but I do not think it applies here (only a small
   number of commands work on both to begin with, e.g. "apply").
