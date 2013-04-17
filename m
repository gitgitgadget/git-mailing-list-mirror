From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate $GITDIR
Date: Wed, 17 Apr 2013 16:43:10 +0530
Message-ID: <CALkWK0nLamX1XKcg2t7VWJTPuFhX+ctEGE=4sjSSd7JqMmGzPA@mail.gmail.com>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com>
 <CACsJy8D-5x5HXgpr2hHUHee6jcfj3++b961sJB_aKTZC1ZS+tw@mail.gmail.com>
 <CALkWK0kw69rMveDXpGEvV=fGxiQ7JoT_JE9ZU5cor0xD=BUbFQ@mail.gmail.com> <CACsJy8C9mrJzmg4FjqBMAZis7WQUpyhNH7TMTLbebWQE124YMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 17 13:13:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USQJI-0007pq-1D
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 13:13:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965826Ab3DQLNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 07:13:52 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:64735 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965130Ab3DQLNv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 07:13:51 -0400
Received: by mail-ie0-f176.google.com with SMTP id x14so1731717ief.21
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 04:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=fccd1jsRxu5LLio84/vcXYocsPwzWoizgyrxVuXA+NY=;
        b=oKDvRC5BF3jk8+vCcgwZMRli75AvndsoHy0LoDRqAntxZO8WiAfYvHJxiX6KcM+9IG
         S3Ve0KA/OtwYkLCyOwQ5jpUTyPnwbDsOKd87xLzHUWpfr1DtMAmiq69Uz5wvk6favz1j
         6KMX6IkTjMKNrIMh/s4cXQpndanHlwze+L/KGo15UCsfM9OF8U2YNtZua3v3hOiGrNrq
         z+kTY5p9RqReEYXv8dRlrNocnBoIWFs7udKPATGDtIMuj4sf5K13kjva9oXAqUdw49FY
         wp804UKFFqqIwn1KnWKyRbw6RcsB1ASKqYpMmR/Wug4lPAggFzbUtRfj05EJjt1K6ca2
         gHwg==
X-Received: by 10.50.50.71 with SMTP id a7mr10224240igo.14.1366197231302; Wed,
 17 Apr 2013 04:13:51 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Wed, 17 Apr 2013 04:13:10 -0700 (PDT)
In-Reply-To: <CACsJy8C9mrJzmg4FjqBMAZis7WQUpyhNH7TMTLbebWQE124YMg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221535>

Duy Nguyen wrote:
> No, submodule code does not change "git clone". If I'm not mistaken,
> submodule will not kick in until you type "git submodule something".
> If I turn clone.submoduleGitDir on, how can I undo my mistake in a
> user friendly way?

So, if you currently want to add a submodule, you have to 'git
submodule add', which runs clone internally apart from other things.
How do you undo this mistake?

What I'm essentially proposing is to give the job of cloning back to
clone, and the job of adding back to add, instead of creating an
unnatural abstraction over them using 'git submodule add'.  The point
being: why would you ever _want_ to clone inside a worktree unless you
intend to add a submodule?  In other words, you intent for running a
'git clone' inside a worktree is exactly the same as your intent for
running a 'git submodule add' inside a worktree.  Ofcourse, if you
have a fringe case where that was _not_ your intent, we'll provide a
command-line switch to turn off the relocation for that clone.
