From: J Smith <dark.panda@gmail.com>
Subject: Re: [PATCH/RFC] grep: add a grep.patternType configuration setting
Date: Wed, 1 Aug 2012 18:49:02 -0400
Message-ID: <CADFUPgdX44pCFhytPj-hHSCPH9UHNBKk5pYkpses86M1ntxvyA@mail.gmail.com>
References: <1343845781-69246-1-git-send-email-dark.panda@gmail.com> <7vpq7ae0pj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 00:49:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwhjN-0005jW-1C
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 00:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756170Ab2HAWtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Aug 2012 18:49:24 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:56390 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753749Ab2HAWtX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2012 18:49:23 -0400
Received: by obbuo13 with SMTP id uo13so12868563obb.19
        for <git@vger.kernel.org>; Wed, 01 Aug 2012 15:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lZkBSAZtevew3CgM2zAkMBjxYjeceKUflavkc+ZnqqY=;
        b=zg2vJcukwTRCOCKc2Z2a9Of/o4TGXVGvwHFIZYi8bv95gZdQNv5uCSnUvLM+B/t69U
         bIwWH2/rAOraVX6nxHgVBYQ6xtLzsHzWZmIGse5DiiqMIgRsllSD0CzMCIFYEqbbCrQ1
         PUlnzYXbxqecAtqT62F9QjNZi0mrXOMYcEM2R04fWpDw4siS0eXHMG92/voGwY1ggj0Q
         URiCce+Cokn17RtJW4OQkaHWB0LaQunfZ8Bf23LHTSSZIwwuyIh0CVny7smF05DqxX5g
         GERtD72ibti0k3BUesMPajI/74aSKo4evZpnlknK0S3pYf0Qy72MS1JhBg7di2OWjJfa
         irag==
Received: by 10.60.2.193 with SMTP id 1mr32143410oew.29.1343861362485; Wed, 01
 Aug 2012 15:49:22 -0700 (PDT)
Received: by 10.76.168.200 with HTTP; Wed, 1 Aug 2012 15:49:02 -0700 (PDT)
In-Reply-To: <7vpq7ae0pj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202738>

On Wed, Aug 1, 2012 at 5:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> As the basic structure and the direction looks good, let's start
> nitpicking ;-)

Sounds good.

> We tend to write the commit log message in imperative mood, as if
> you are giving an order to the codebase to "behave this way!".  Also
> we tend to give the justification behind the change first and then
> present the solution.

Sounds good to me. I'll re-word the commit messages in future
revisions of the patch.

> With this round, we are not updating an existing a bool variable,
> but are introducing a brand new one; does it still make sense to
> support the boolean values for this new variable?

Yeah, I thought about that, having noticed in your edited patch that
the boolean options were still in there for patternType. I do think it
would be useful to have a way to get back to the default settings, say
on a per-repo basis to override a global setting. I was thinking that
a "false" value could provide that, but perhaps a value of "default"
would make more sense?

> You want a test that runs "git -c grep.patternType=basic grep -P" or
> something, guarded with LIBPCRE prerequisite, to make sure pcre
> patterns are used because command line -P trumps over configured
> default, too.

Will add.

> Besides, I do not think you are testing the right thing in them
> anyway (notice the lack of "grep." prefix).

Ah geez. Yeah, that's just stupidity.

> What does this test?  The last one wins?
>
> For the command line flags, people can do "alias g 'git grep -E'"
> and then countermand the flags in the alias by appending a
> contradicting flag when using it, e.g. "g -G", last one wins is a
> defined and useful semantics, but for configuration variables that
> are meant to take a single value, I do not think we give such a
> strong guarantee on ordering (it may happen to work by accident,
> though).
>
> I would _not_ strongly suggest removing this test, but instead wait
> until we hear from others, as they may disagree.

I'll wait for others and we'll see. I'm not overly attached to them or anything.

> As you are expecting the "last one wins" behaviour among
> configuration variables, running a test with -P option would not let
> you catch bugs coming from potentially screwed-up precedence between
> the configuration and command line flags, would it?  At least, leave
> the "-c grep.patterntype=perl" out from here to make sure what the
> variable and the flag tell the command conflict with each other.  I
> would also prefer to see only one "-c grep.patterntype=<foo>" used.

Ah, yes, that was how the test was supposed to be written. That was an
oversight.

> What does this test?  patterntype trumps extendedregexp?
>
> That may sit better next to the earlier "patterntype says basic but
> extendedregexp says true" test, if you can move this test easily
> there.

Yep, I'll move it around.

Cheers
