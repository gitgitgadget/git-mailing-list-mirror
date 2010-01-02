From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: User-wide Git config directory (was Re: [PATCH v2] Let core.excludesfile default to ~/.gitexcludes.)
Date: Sat, 02 Jan 2010 13:05:25 +0100
Message-ID: <vpqk4w0lnju.fsf_-_@bauges.imag.fr>
References: <4B06A7EE.2090801@atlas-elektronik.com>
	<1258840832-22130-1-git-send-email-Matthieu.Moy@imag.fr>
	<20091230224135.6117@nanako3.lavabit.com>
	<vpqhbr8ttwv.fsf@bauges.imag.fr>
	<7vk4w4z1h6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 02 13:08:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NR2mm-0002gC-BP
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 13:08:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042Ab0ABMIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 07:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752056Ab0ABMIf
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 07:08:35 -0500
Received: from imag.imag.fr ([129.88.30.1]:47234 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752042Ab0ABMIe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 07:08:34 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o02C5PFQ010147
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 2 Jan 2010 13:05:25 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NR2jV-0006ys-M5; Sat, 02 Jan 2010 13:05:25 +0100
In-Reply-To: <7vk4w4z1h6.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 30 Dec 2009 11\:49\:25 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sat, 02 Jan 2010 13:05:26 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136028>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Nanako Shiraishi <nanako3@lavabit.com> writes:
>>
>>> Junio, could you tell us what happened to this thread?
>>
>> I'm not Junio, but I can try ...
>> ...
>> So, I dropped the patch until we get closer to a consensus on what the
>> default value should be.
>
> Thanks for status updates.  Should we start trying to reach a consensus on
> how to move forward, or is it not your itch?

I wouldn't say it's not my itch. But I'm not sure I'm the best person
to do the job (job = comming close to a consensus, not writting the
code, which shouldn't be hard). Still, I can at least participate ;-).

> It is not _too_ bad to treat ~/.gitconfig specially and support reading
> from ~/.$SOMEGITTTYNAME/{excludes,attributes} files.

Let's throw in some ideas about what ~/$SOMEGITTTYNAME/ could be :

1) ~/.git/ => no, that would clash with people versioning their $HOME.

2) ~/.gitconfig/ => no, there's already a file ~/.gitconfig

3) ~/.gitglobal/ => that's an option.

4) ~/.config/git/ or, if set, $XDG_CONFIG_HOME/git/ (see
   http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html )
   => my prefered one, already discussed in a different context here :
   http://thread.gmane.org/gmane.comp.version-control.git/135447/focus=135559

Then, there's the question of what to put in this directory. I can see
two and a half options:

a) ~/.$SOMEGITTTYNAME/{excludes,attributes} as you propose.

a') ~/.$SOMEGITTTYNAME/{ignore,attributes} => I think "ignore" is the
   advertized vocabulary most of the time in porcelain, and "excludes"
   exists mostly for historical reasons.

b) ~/.$SOMEGITTTYNAME/<same thing as the content of $GIT_DIR>, that
   is:
   ~/.$SOMEGITTTYNAME/info/exclude
   ~/.$SOMEGITTTYNAME/info/attributes
   and perhaps
   ~/.$SOMEGITTTYNAME/config
   we could imagine also
   ~/.$SOMEGITTTYNAME/hooks

If I were really happy with the layout of $GIT_DIR, I'd vote for b)
for consistancy. But I'm not _that_ happy with it: why are exclude and
attributes not in the same directory as config? why is exclude
singular and attributes plural?

So, I dunno.

> We can also add support for ~/.$SOMEGITTYNAME/config and try reading
> from it as well, but even if we did so I don't think we should stop
> reading from ~/.gitconfig.

Yes, people having a ~/.gitconfig around should be able to continue to
use it (for years at least, and most likely forever).

And you're right to present it as a different problem. Perhaps we
should solve the problem above before starting debating about this
one.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
