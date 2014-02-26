From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: [RFC 3/3] reset: Change the default behavior to use "--merge"
 during a merge
Date: Wed, 26 Feb 2014 15:15:30 -0500
Message-ID: <CADgNjanavxZfuXgvEAOMzPAJr9YqAvF4+ZDq9KW9aeR_PcVo-Q@mail.gmail.com>
References: <1393437985-31401-1-git-send-email-andrew.kw.w@gmail.com>
	<1393437985-31401-4-git-send-email-andrew.kw.w@gmail.com>
	<vpq8usxenul.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 26 21:15:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIktJ-0007av-KS
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 21:15:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753653AbaBZUPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 15:15:34 -0500
Received: from mail-wg0-f50.google.com ([74.125.82.50]:37901 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730AbaBZUPc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 15:15:32 -0500
Received: by mail-wg0-f50.google.com with SMTP id l18so2076436wgh.21
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 12:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=D0AJio4CN/9itGnYl3JvvLuCh7mZAyIQS40Yd7Dj0HI=;
        b=S+O6loeBSHPV7nCbYUIeDv/pOHkHzBiDbsCwkeDtffgf3zZb4AbmUHiXGEWYZ9BVSp
         tTQjeUHDuRWH4BpXCDB6Xi97PHg9FVuSvw8Ns1BgWOqKpRIlZAgNB/rQ0fH+gCejP/JD
         zQVcPFJFlilQ6fxO4SBVNflN/xbqqyHyTW90WwDm1hM51t6U4xj/vP3yMqshuqha7YMb
         TGO2qE8DekZscX3ClrYKPS0P9+PwLHF7lfJl2el6TPqkeyPP9eKRsB2mCtH5DDvIOJhY
         P/dkvvkuIuV4pPuo2Ttsfpg1gEkl42ka54ICj6otR6QmPOYsMW9CYPJST28QCU5x9/Eh
         zfGw==
X-Received: by 10.180.106.168 with SMTP id gv8mr1767901wib.19.1393445730890;
 Wed, 26 Feb 2014 12:15:30 -0800 (PST)
Received: by 10.194.81.65 with HTTP; Wed, 26 Feb 2014 12:15:30 -0800 (PST)
In-Reply-To: <vpq8usxenul.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242756>

On Wed, Feb 26, 2014 at 1:21 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> But this breaks backward compatibility.
>
> I sometimes run "git reset" during a merge to only reset the index and
> then examine the changes introduced by the merge. With your changes,
> someone doing so would abort the merge and discard the merge resolution.
> I very rarely do this, but even rarely, I wouldn't like Git to start
> droping data silently for me ;-).

I don't think it's actually dropping data though, because your changes just
come from "git merge". So you can also do the merge again.

To examine the changes, you're saying you'd do "git reset && git diff". But
without doing "git reset", couldn't you do "git diff HEAD" to get the diff?
This also has the advantage of keeping git in the merging state, so you can
decide to continue/abort the merge later on.

> I'm not really convinced that this is such a good change, and if we go
> this way, there should be a transition to let users stop using
> argumentless "git reset" to reset the index during a merge.

Yeah, this breaks compatibility, but like I said, during a merge, I don't
see a good reason to do "git reset --mixed", and not "git reset --merge".
Especially when there are local changes, "--mixed" would actually cause
more headaches than "git reset --merge", because you would lose the
distinction between merge changes and unstaged changes.

Andrew
