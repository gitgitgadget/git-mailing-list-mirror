From: Fabian Ruch <bafain@gmail.com>
Subject: Re: [PATCH v2 23/23] rebase -i: enable options --signoff, --reset-author
 for pick, reword
Date: Thu, 14 Aug 2014 19:24:15 +0200
Message-ID: <53ECF0BF.5070200@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1407368621.git.bafain@gmail.com> <ed19a079924e11edac0163837500c2e8caa2a555.1407368621.git.bafain@gmail.com> <53EB5E77.8010005@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 14 19:24:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHylG-0003fL-Aj
	for gcvg-git-2@plane.gmane.org; Thu, 14 Aug 2014 19:24:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbaHNRYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2014 13:24:22 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:49675 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932172AbaHNRYU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2014 13:24:20 -0400
Received: by mail-la0-f53.google.com with SMTP id gl10so1417226lab.26
        for <git@vger.kernel.org>; Thu, 14 Aug 2014 10:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=vrig4mikYBNYE2zn0wSQRggH7H4kbOPHcA5WY2buk+U=;
        b=A/U8d1GmxtgGV2sXW+J9dZg9O+1fcZPBTIqLI72OElqHcgkottltToZFoTTCugX9Rr
         yToNT7mQquVo2mSfKjha4Su1v2ZknLAk+rQf9j3cVo9b1r6mPGNTqOg0XjQVgtALmM40
         pHxS2WGoo/sGlyPefhNWYArEe5CUi3N0XSqbetLgRRHJzJ2E/pM2mKKWCc+CdZtmLNUp
         5gB2xY+bdAB6IQUQBe0qjk4kKR42sF3ez1PX+5Dxx5AXyU0HjhAm9s9MZRDT5ePSsAe8
         FJ0r0yitKVDnMAaRxQhtjA1kY3WSdwVeBMHE+sgwS9knY3Vs8MzzedCiQvYEckq2Wk1R
         1iBA==
X-Received: by 10.152.45.42 with SMTP id j10mr6733948lam.13.1408037058108;
        Thu, 14 Aug 2014 10:24:18 -0700 (PDT)
Received: from client.googlemail.com (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id e4sm8724977lbc.29.2014.08.14.10.24.15
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Aug 2014 10:24:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53EB5E77.8010005@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255269>

Hi,

Michael Haggerty writes:
> On 08/07/2014 01:59 AM, Fabian Ruch wrote:
>> Lift the general unknown option blockade for the pick and reword
>> commands. If `do_cmd` comes across one of the options `--signoff` and
>> `--reset-author` while parsing a to-do entry and the scheduled
>> command is either `pick` or `reword`, relay the option to `do_pick`.
> 
> The new user-exposed options should be documented in the git-rebase(1)
> manpage and probably also in the help text that is appended to every
> "rebase -i" todo list.

The next reroll will add the following paragraph to the git-rebase man
page right after the introduction of the 'reword' command in the section
"INTERACTIVE MODE":

> The commands "pick" and "reword" understand some well-known options.
> To add a Signed-off-by line at the end of the commit message, pass
> the `--signoff` option. The authorship can be renewed by specifying
> the `--reset-author` option. For instance, before you decide to
> publish a heavily edited commit you might want to reset the
> authorship and add your signature. You can do so on a per line basis:
> 
> -------------------------------------------
> pick deadbee The oneline of this commit
> pick --reset-author --signoff fa1afe1 The oneline of the next commit
> ...
> -------------------------------------------

By saying "heavily edited commit" I tried to describe a commit that has
been amended, reworded and reordered in such a way that the actual
author information has become meaningless.

The help text at the end of every to-do list would look like this:

> Commands:
>  p, pick = use commit
>  r, reword = use commit, but edit the commit message
>  e, edit = use commit, but stop for amending
>  s, squash = use commit, but meld into previous commit
>  f, fixup = like "squash", but discard this commit's log message
>  x, exec = run command (the rest of the line) using shell
> 
> Options:
>  [pick | reword] --signoff = add a Signed-off-by line
>  [pick | reword] --reset-author = renew authorship
> 
> These lines can be re-ordered; they are executed from top to bottom.
> 
> If you remove a line here THAT COMMIT WILL BE LOST.

New about this is the "Options" headline.

   Fabian
