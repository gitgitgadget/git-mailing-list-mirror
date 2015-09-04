From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 0/2] contrib/subtree: make it respect spaces in a repository path
Date: Fri, 04 Sep 2015 16:08:06 -0700
Message-ID: <xmqqoahheqax.fsf@gitster.mtv.corp.google.com>
References: <cover.1441404851.git.Alex.Crezoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 01:08:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZY05c-0006wj-OT
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 01:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934090AbbIDXIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 19:08:09 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36738 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933994AbbIDXII (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 19:08:08 -0400
Received: by pacwi10 with SMTP id wi10so36873656pac.3
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 16:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=zX8QA8haycPL1Gnr5jCpwRhGIKFIbWvlhX6hx6/9ETs=;
        b=I/mC02g2QNEDYMbZtVZ0TB/1xyLar8372xC8r0W3XmI6OM7ceYloJqtqJfO3s0mORO
         VlT+7teHbp45D58XKnL8mr/JkF6CLl5NU3rKwV48pZOk1PAdcD3wxvMHGWLACh5OmNz0
         RL7tpLHIldoiQkKuutDJWnHykBXaxgkW3GNHwoEBHcuYHZVQVv3lLIAvbZB6MZKeJpeb
         NPUfFjW4UIuzNk8xswpRMHTgQNGbk8bbOwbaf4JxImoWHyJ6nkUa3xfntAsTpx0UpAKb
         74OOXCEiwmMAAFAlRO8Tky9V7kRK1nmr1gJHv2hA4NraxWlq9Upbwu3yw2cU7BkzWVH3
         otlA==
X-Received: by 10.66.122.207 with SMTP id lu15mr13387324pab.146.1441408087780;
        Fri, 04 Sep 2015 16:08:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2198:98f:3bb3:46bb])
        by smtp.gmail.com with ESMTPSA id un2sm3727130pac.28.2015.09.04.16.08.07
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 04 Sep 2015 16:08:07 -0700 (PDT)
In-Reply-To: <cover.1441404851.git.Alex.Crezoff@gmail.com> (Alexey Shumkin's
	message of "Sat, 5 Sep 2015 01:24:09 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277347>

Alexey Shumkin <alex.crezoff@gmail.com> writes:

> Some repositories may have spaces in their paths. Currently `git-subtree`
> raises an error in such cases.
> Also, `git-subtree` currently does not have tests for its 'push' command.
> Following patches are to fix these statements.
>
> Alexey Shumkin (2):
>   t7900-subtree: test the "space in a subdirectory name" case
>   contrib/subtree: respect spaces in a repository path

Doesn't this order break bisection?  It seems that you turn "subdir"
to "sub dir" in existing tests, and I understand that the whole
point of this series is that such a change will expose that the tool
is broken, making tests fail.

Also, if you feel up to it, it might be a good idea to clean t7900
test up to the current best practice before doing any other changes
as a pure preparatory clean-up patch.

Namely, using cd outside a subshell of the tests to move around is a
bad thing to do, and you are adding more instance of it in this
series.  If one test with such a cd to go down fails before it has a
chance to come back up (or go up and then fail to come back down),
the later tests will be left in an unexpected place.

>  contrib/subtree/git-subtree.sh     |   4 +-
>  contrib/subtree/t/t7900-subtree.sh | 194 +++++++++++++++++++++++--------------
>  2 files changed, 124 insertions(+), 74 deletions(-)

Thanks.
