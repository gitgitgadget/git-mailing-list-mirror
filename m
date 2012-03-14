From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] push: Provide situational hints for non-fast-forward errors
Date: Wed, 14 Mar 2012 10:06:52 +0100
Message-ID: <vpqipi7zh3n.fsf@bauges.imag.fr>
References: <20120313232256.GA49626@democracyinaction.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: gitster@pobox.com, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 14 10:07:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7kAo-0002yC-U1
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 10:07:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414Ab2CNJHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 05:07:06 -0400
Received: from mx2.imag.fr ([129.88.30.17]:43347 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932382Ab2CNJHE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 05:07:04 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q2E92mfk022084
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 14 Mar 2012 10:02:49 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1S7kAX-0002f2-DN; Wed, 14 Mar 2012 10:06:53 +0100
In-Reply-To: <20120313232256.GA49626@democracyinaction.org> (Christopher
	Tiwald's message of "Tue, 13 Mar 2012 19:22:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 14 Mar 2012 10:02:49 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q2E92mfk022084
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1332320570.41029@nfJdWu74hsUxsccArq6Dcg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193089>

Christopher Tiwald <christiwald@gmail.com> writes:

> 2) If you push to a shared repository others push to, and your local
> tracking branches are not kept up to date, the 'matching refs' default
> will generate non-fast-forward errors on outdated branches. If this is
> your workflow, the 'matching refs' default is not for you. Consider
> setting the 'push.default' configuration variable to 'upstream' to
> ensure only your checked-out branch is pushed.

Very good point.

Depending on the outcome of the discussion in the thread about
'push.default', you may want to suggest 'current' instead of upstream:
http://thread.gmane.org/gmane.comp.version-control.git/192547/focus=192694

Actually, if the user has 'push.default=matching', the least surprising
move from this value is 'push.default=current', that will push a subset
of what used to be pushed, and won't change the target branch.

> +static const char *message_advice_pull_before_push[] = {
> +	"To prevent you from losing history, non-fast-forward updates to HEAD",
> +	"were rejected. Merge the remote changes (e.g. 'git pull') before",
> +	"pushing again. See the 'Note about fast-forwards' section of",
> +	"'git push --help' for details."
> +};

Your patch removes the _(...) around the string, which breaks the
internationalization.

> +static const char *message_advice_use_upstream[] = {
> +	"By default, git pushes all branches that have a matching counterpart",
> +	"on the remote. In this case, some of your local branches were stale",
> +	"with respect to their remote counterparts. If you did not intend to",
> +	"push these branches, you may want to set the 'push.default'",
> +	"configuration variable to 'upstream' to push only the current branch."
> +};

I'd give the full cut-and-paste ready command to set the variable, to
help the user who doesn't know what "configuration variable" really
means in the context of Git:

... you may want to run

  git config push.default upstream (or current, if you like my remark above)

to ask Git to push only the current branch from now on.

(I'd advise "git config" without "--global" here, because the user may
want to do something else in other repositories)

> +	for (i = 0; i < ARRAY_SIZE(message_advice_pull_before_push); i++)
> +		advise(message_advice_pull_before_push[i]);

I'm no expert in gettext, but I think the internationalization people
will have a hard time dealing with a single message split accross an
array.

Actually, I prefer the effect of a single advise() call (i.e. say
"hint:" just once, not for each line), but this part is subjective.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
