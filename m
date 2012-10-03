From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: erratic behavior commit --allow-empty
Date: Wed, 3 Oct 2012 09:35:47 +0200
Message-ID: <CAB9Jk9BczA0KjU2oKm=S_Ms6mqBFNHg8RO3xvb+PNEsMxQih+A@mail.gmail.com>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com>
	<506AA51E.9010209@viscovery.net>
	<7vzk449449.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com>
	<7vhaqc7in6.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9D-eJ8goYx7LWqGcWcLgRDS8+qLZVUsvvJ+QOtryP9-zg@mail.gmail.com>
	<506BCF19.7020800@viscovery.net>
	<CAB9Jk9DH4Gx-8oJzb8H=ytohhZnMbA92pwj5P25AehmZ3PMmcg@mail.gmail.com>
	<506BDADE.4010803@viscovery.net>
	<CAB9Jk9AgtNQfWDr31CWbXf2ag=11du-aruu-0+nOZ3KaaG9=og@mail.gmail.com>
	<506BE577.900@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 03 09:36:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJJUw-0006Sk-Ff
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 09:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035Ab2JCHfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 03:35:48 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:34870 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385Ab2JCHfr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 03:35:47 -0400
Received: by vcbfo13 with SMTP id fo13so7901585vcb.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 00:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=X23Z9BzLDBwre8oX0fZfJ5XPQt76LXtz9ZKwsGSADRs=;
        b=rCcTbcnOIgpRUvMR+Uf8AP4JYBu3r4iuupPACJoJeqo+kliFjqRFjjiqJ4dTA4T5TQ
         F8B59vhIhgvuT+eEXLBODFGvk5yAcG8NquP2Ak4SkH3mxT7LO2P25V8qKd7nQXQXUWJt
         hZ2DlZWs1gPdlWQqpt0Tpw6GOVlvdYFjuYhJC/Z9XuBjo50qc4ZtYxRXP411MqEdRcQM
         qiS1a0Geq6DiPq+KRHoBxhhJYQXxbHtDAwPCDBROpEus4y4PPsFDfD3kzgucfE8vs3tk
         hU/NZ8izhT3HQvEZ63u2L3wle32KNRUhHn3l6CDDzcBHCQRHsCUY8bMB7teKOJA3KeyY
         bA8g==
Received: by 10.220.228.131 with SMTP id je3mr614584vcb.73.1349249747054; Wed,
 03 Oct 2012 00:35:47 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Wed, 3 Oct 2012 00:35:47 -0700 (PDT)
In-Reply-To: <506BE577.900@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206864>

Hi Hannes,

>
> Perhaps you are confused by the fact that the commit you made first does
> not have a parent, either. But that is just a "side effect" that it
> happened to be the very first commit that you made after 'git init'.

Well, I know that, and this is why I added --allow-empty. The man page of
git commit ("This option bypasses the safety, ..."). I thought that it
would unconditionally
create a brand new, commit.

> Your case does not demonstrate a bug in git.

The bug is that the git commit --allow-empty does a different action
depending on
whether the system clock has changed its seconds right before the command.
This is a time-dependent behavior, and it is very harmful. Our applications must
never behave differently depending on the time they are run or on the processor
speed. It is an issue of correctness and robustness of software. To
have a predictable
behavior, i.e. to create a brand new commit with git commit
--allow-empty, the command
in a script must ALWAYS be preceded by a sleep 1 so as to make sure
that the date
and time it will use are for sure different from any other commits'.
But then it would be a lot better to embed such a sleep in the command.
If that is not possible, then the users must be warned in the man page
that the command
sometimes may not create a brand new commit, and that if the user
instead wants it s/he
should change something in the commit, like, e.g. the message.

>
> Why don't you use a different commit message to ensure that there is a
> difference between the commits?
>

This is what eventually I did to force the creation of a brand new commit.

-Angelo
