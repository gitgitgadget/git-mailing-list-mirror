From: Bruce Stephens <bruce.stephens@isode.com>
Subject: Re: Emacs git-mode feature request: support fill-paragraph
         correctly
Date: Mon, 26 Jan 2009 19:11:59 +0000
Message-ID: <8063k1zxts.fsf@tiny.isode.net>
References: <87tz7mth3g.fsf@write-only.cryp.to>
            <808woyz2k7.fsf@tiny.isode.net>
            <87mydet0yg.fsf@write-only.cryp.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Simons <simons@cryp.to>
X-From: git-owner@vger.kernel.org Mon Jan 26 20:16:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRWtr-0000pI-R1
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 20:13:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbZAZTMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 14:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbZAZTMF
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 14:12:05 -0500
Received: from rufus.isode.com ([62.3.217.251]:45765 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751957AbZAZTME (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 14:12:04 -0500
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (smtp internal) via TCP with SMTP 
          id <SX4K=wB0lFaa@rufus.isode.com>; Mon, 26 Jan 2009 19:11:59 +0000
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Mon, 26 Jan 2009 19:11:59 +0000
X-Hashcash: 1:20:090126:simons@cryp.to::P0gh1gmDb19qBJHk:0002XGm
X-Hashcash: 1:20:090126:git@vger.kernel.org::ot6gC/mkqEudW5sh:0000000000000000000000000000000000000000000nEv
In-Reply-To: <87mydet0yg.fsf@write-only.cryp.to> (Peter Simons's message of "Mon\, 26 Jan 2009 18\:46\:15 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107252>

Peter Simons <simons@cryp.to> writes:

[...]

> The buffer is in "log-edit" mode.

Ah, OK.  That makes sense.

>  > In that case you could stick this in your .emacs if you wanted to
>  > use message-mode:
>  >
>  > (setq auto-mode-alist (cons '("COMMIT_EDITMSG" . message-mode) auto-mode-alist))
>
> Unfortunately, it's not that easy.

True.  I don't use git-mode (well, not much).  I use git commit from
the command line, which runs emacsclient as its editor.

> I'm not an Emacs expert, but I'd assume that switching into a
> different mode would change the meaning of C-c C-c.

Yep.  Quite likely other things, too.

OK, something like this:

(add-hook 'log-edit-mode-hook (lambda ()
		(let ((regexp "--text follows this line--$\\|[  ]*$\\|-- $\\|---+$\\|^\f$\\|.*wrote:$\\|\\(\\([         ]*[-_.[:word:]]+>+\\|[  ]*[]>|}+]\\)+\\)[  ]*$\\|<#!*/?\\(multipart\\|part\\|external\\|mml\\|secure\\)"))
                   (setq paragraph-start regexp
                         paragraph-separate regexp)))

I copied the regexp from the value in message-mode.  (In a junk buffer
use M-x message-mode, then C-h v paragraph-start and copy & paste.)

I imagine large parts of the regexp aren't relevant for your purposes
so you could remove them if you wanted.  You might also define a
function rather than using lambda---that would make it a bit easier to
test.
