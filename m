From: Simon Oosthoek <s.oosthoek@xs4all.nl>
Subject: Re: [PATCH] make __git_ps1 accept a third parameter in pcmode
Date: Wed, 26 Dec 2012 22:03:24 +0100
Message-ID: <20121226210324.GA20704@xs4all.nl>
References: <7vvcbpp846.fsf@alter.siamese.dyndns.org>
 <20121226191505.GA29210@simaj.xs4all.nl>
 <7vmwx0oavn.fsf@alter.siamese.dyndns.org>
 <20121226201944.GA15039@xs4all.nl>
 <7vfw2so8q3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: piotr.krukowiecki@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 26 22:08:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TnyCz-0001RO-0w
	for gcvg-git-2@plane.gmane.org; Wed, 26 Dec 2012 22:08:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918Ab2LZVEC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 16:04:02 -0500
Received: from smtp-vbr19.xs4all.nl ([194.109.24.39]:4068 "EHLO
	smtp-vbr19.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851Ab2LZVEA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 16:04:00 -0500
Received: from xs8.xs4all.nl (xs8.xs4all.nl [194.109.21.8])
	by smtp-vbr19.xs4all.nl (8.13.8/8.13.8) with ESMTP id qBQL3QhP091094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 26 Dec 2012 22:03:26 +0100 (CET)
	(envelope-from osimon@xs4all.nl)
Received: from xs8.xs4all.nl (IDENT:1251136@localhost [127.0.0.1])
	by xs8.xs4all.nl (8.14.3/8.14.3/Debian-9.4) with ESMTP id qBQL3PcO021669;
	Wed, 26 Dec 2012 22:03:25 +0100
Received: (from osimon@localhost)
	by xs8.xs4all.nl (8.14.3/8.14.3/Submit) id qBQL3OxU021668;
	Wed, 26 Dec 2012 22:03:24 +0100
Content-Disposition: inline
In-Reply-To: <7vfw2so8q3.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212155>

* Junio C Hamano <gitster@pobox.com> [2012-12-26 12:32:20 -0800]:
> The point of the above two was that __git_ps1 does not have to set
> PS1 as long as the insn says user to use PROMPT_COMMAND that sets
> PS1 himself, exactly as illustrated above.  In other words, replace
> the last PS1=...  in the "prompt command" mode with an echo or
> something and make the user responsible for assigning it to PS1 in
> his PROMPT_COMMAND.
> 
> Or put it in another way, I was hoping that we can do without adding
> the prompt command mode---if there is no two modes, there is no need
> to switch between them.
> 
> But as I said, there probably is a reason why that approach does not
> work, that is why I said...
> 

The only reason to my knowledge is that bash's handling of zero-length strings, like terminal colour commands, is producing a PS1 that outputs less visible characters than bash thinks and thus bash makes mistakes when wrapping the commandline. The way to prevent that is to use \[ and \] around those and that doesn't seem to work from a string produced from command-substitution. (BTW, the colours come through just fine, just the \[ and \] don't)

Another approach could be to split up the functionality and have a few support functions to set various variables (corresponding with the gitstring features, like *%+ characters and colour hints). These variables could then be used by a custom PROMPT_COMMAND function or a command substitution function to produce a gitstring. I suppose that would mean a complete rewrite or very close to it ;-)

/Simon
