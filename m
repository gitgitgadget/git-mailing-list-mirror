From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: "git checkout foo" is getting confused by folder named "foo"
Date: Wed, 25 Sep 2013 15:09:04 +0200
Message-ID: <vpqzjr1ujyn.fsf@anie.imag.fr>
References: <CAEQewpqLcDJPo2gUWPk-xc3OitdTC4gH2tnyqaURiQ77BApNog@mail.gmail.com>
	<CAJDDKr64ou+gO7WJLFZ4zOSv+VCbkiW7nKuZa9=5_fiSqGUeyQ@mail.gmail.com>
	<CAEQewpqbf-sWSt0GS9eXQNi0yFz5-23NcO2JWKO4OgSFv3SXdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Aguilar <davvid@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jona Christopher Sahnwaldt <jc@sahnwaldt.de>
X-From: git-owner@vger.kernel.org Wed Sep 25 15:09:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOoqD-0004er-G6
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 15:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755159Ab3IYNJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 09:09:13 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56505 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754612Ab3IYNJM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 09:09:12 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r8PD93DO028565
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 25 Sep 2013 15:09:03 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VOoq0-0007Y1-WE; Wed, 25 Sep 2013 15:09:05 +0200
In-Reply-To: <CAEQewpqbf-sWSt0GS9eXQNi0yFz5-23NcO2JWKO4OgSFv3SXdA@mail.gmail.com>
	(Jona Christopher Sahnwaldt's message of "Wed, 25 Sep 2013 10:58:53
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 25 Sep 2013 15:09:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8PD93DO028565
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1380719347.24638@YeA1561XyJwPrR5PbjkK4A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235343>

Jona Christopher Sahnwaldt <jc@sahnwaldt.de> writes:

> On 25 September 2013 04:51, David Aguilar <davvid@gmail.com> wrote:
>> On Tue, Sep 24, 2013 at 2:07 PM, Jona Christopher Sahnwaldt
>> <jc@sahnwaldt.de> wrote:
>>> Hi,
>>>
>>> maybe this has already been reported, but I didn't find it in the mail archive.
>>>
>>> If I understand correctly, after I clone a repo, I should be able to
>>> switch to branch foo just by running
>>>
>>> git checkout foo
>>>
>>> This doesn't seem to work if a folder called "foo" exists in the root
>>> of the repo.
>>
>> git checkout foo --
>
> Thanks for the suggestion, but it doesn't work for me. With both
> 1.7.9.5 and 1.8.3.2, I get this:
>
> $ git checkout wiktionary --
> fatal: invalid reference: wiktionary

OK, what happens is that "git checkout wiktionary" is actually a
shorthand for "git checkout -b wiktionary --track origin/wiktionary".

In other words, it does not only "checkout" the branch, but it creates a
local branch with the right name, and checks it out.

The -- disables this shorthand. I'd consider this as a bug. I've just
sent a patch to try to fix this.

> When I try the full branch name:
>
> $ git checkout origin/wiktionary --
> Note: checking out 'origin/wiktionary'.
> You are in 'detached HEAD' state. You can [...]

This actually checks out the right commit, but does not create a local
branch. That's not a very desirable solution.

In short, this should do the trick:

  git checkout -b wiktionary --track origin/wiktionary

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
