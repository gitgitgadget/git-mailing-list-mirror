From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 1/2] rebase -i: optimize the creation of the todo file
Date: Thu, 8 Mar 2012 12:55:08 +0100
Message-ID: <87haxzl337.fsf@thomas.inf.ethz.ch>
References: <1331203358-28277-1-git-send-email-domq@google.com>
	<87boo7pdvc.fsf@thomas.inf.ethz.ch>
	<CAJh6GrGWfyKguhgf9dJR4yG3qYjh2jJz7OzzN8wao0rWLcohoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <gitster@pobox.com>, <git@vger.kernel.org>
To: Dominique Quatravaux <domq@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 12:55:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5bwD-0003Ci-8J
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 12:55:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757145Ab2CHLzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 06:55:13 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:3922 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756764Ab2CHLzM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 06:55:12 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 8 Mar
 2012 12:55:09 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 8 Mar
 2012 12:55:09 +0100
In-Reply-To: <CAJh6GrGWfyKguhgf9dJR4yG3qYjh2jJz7OzzN8wao0rWLcohoA@mail.gmail.com>
	(Dominique Quatravaux's message of "Thu, 8 Mar 2012 12:48:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192576>

Dominique Quatravaux <domq@google.com> writes:

> On Thu, Mar 8, 2012 at 11:48 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
>> Dominique Quatravaux <domq@google.com> writes:
>>
>>> Instead of obtaining short SHA1's from "git rev-list" and hitting the repository
>>> once more with "git rev-parse" for the full-size SHA1's, obtain long SHA1's from
>>> "git rev-list" and truncate them with "cut".
>>
>> That doesn't work if there are 7-digit SHA1 collisions in the repo.
>
> I don't see how my patch changes the picture wrt SHA1 collisions. In
> the current state, the rebase todo already uses short SHA1s.

But it gets them from --abbrev-commit, which makes sure that the
abbreviation is unique.  The 7 is just a request for the minimal number.

You can easily verify this in git.git with e.g.

  git show --abbrev-commit --abbrev=7 \
      2539a7b64dbc7e214704f6b879749a94685fb99e

Note how the output uses an 8-digit SHA1 in the first line.  The 7-digit
colliding commit is 2539a7bdb81dcc920c97837a9bfb9d4c4e1ac280.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
