From: Moe <moe@signalbeam.net>
Subject: Re: [PATCH] Introduce the GIT_CONFIG_EXTRA environment variable
Date: Sat, 19 Dec 2009 05:44:10 +0100
Message-ID: <4B2C5A1A.8000201@signalbeam.net>
References: <4B2C0828.4010505@signalbeam.net> <20091219013246.GD25474@genesis.frugalware.org> <7vhbrnodd9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 19 05:44:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLrAw-00049E-EW
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 05:44:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756144AbZLSEoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 23:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755230AbZLSEoO
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 23:44:14 -0500
Received: from s2.mbox.bz ([85.214.91.204]:52508 "EHLO s2.mbox.bz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756138AbZLSEoM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 23:44:12 -0500
Received: from mini.local (unknown [92.206.21.223])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by s2.mbox.bz (Postfix) with ESMTPSA id 12CA1E04B6C;
	Sat, 19 Dec 2009 05:44:11 +0100 (CET)
User-Agent: Postbox 1.1.0 (Macintosh/20091201)
In-Reply-To: <7vhbrnodd9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135460>

Junio C Hamano wrote:
> Miklos Vajna <vmiklos@frugalware.org> writes:
> 
>> This is like GIT_CONFIG but it is not read instead of .git/config, but
>> in addtition to it.
>>
>> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
>> ---
>>
>> On Fri, Dec 18, 2009 at 11:54:32PM +0100, Moe <moe@signalbeam.net> wrote:
>>> $GIT_CONFIG doesn't work for this purpose because when set
>>> git will *only* read the referenced file and ignore the
>>> repository settings.
>> What about this?
> 
> 
> The patch text itself may be fine, in the sense that it makes "we read
> from three" to "we now read from four", but I am not impressed.
> 
> I find the original use case highly moronic.
>
> For people to be sharing an account, hence $HOME, there must be a reason.
> They want to (rather, the administrator wants them to) use a common shared
> set of settings, so $HOME/.gitconfig should be shared among them, just
> like $HOME/.emacs and $HOME/.login are, unless there is some strong reason
> to treat .gitconfig any differently from all the other $HOME/.whatever
> files.  But I don't think there wasn't any argument to defend that.

I'm not arguing to treat .gitconfig differently from other
dot-files, but to treat it differently from .git/config.

The former is user-specific, the latter is repository-specific.

For a contrived analogy: Imagine apache would ignore the contents
of .htaccess files when you start httpd with the "-f" switch to
load a different configuration file.

> That makes the patch doubly suspect and throws it into "because we can",
> not "because we should".
> 
> Wouldn't it be just a matter of giving different HOME after they log-in?
> 
> After all, Moe will be giving _some_ way to his users set different value
> to GIT_CONFIG_EXTRA depending on who they really are, and that same
> mechanism should be usable to set different HOME to them, no?

The individual users are identified by their ssh key. Ssh sets a
distinct environment variable for each, which in turn is used in
.bash_profile to read an additional user-profile.

Yes, we could overwrite $HOME but that would defeat the purpose.

The goal of this setup is to share almost all settings.
Overwriting $HOME would turn this upside down. Instead of diverting
the two bits that we want to customize (git identity and editor
preferences) we would then have to duplicate all other dot-files
for each virtual user - and probably watch out for unforeseen side-effects.

> As $HOME/.gitconfig is relative to the value of that environment variable,
> I don't see a reason for us to fall into this "three is not enough, but
> when we add another, we are fine" attitude, which makes me suspect that
> there is something fundamentally wrong there.

I understand the sentiment.

Without drifting into a discussion about the merit of shared
unix-accounts (they do make a lot of sense in some scenarios)
I hope this can still make it, considering the small size of
the patch and the .git/config vs ~/.gitconfig argument.


-- 
Kind regards, Moe
