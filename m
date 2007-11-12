From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: Re: [PATCH] status&commit: Teach them to show submodule commit
	summary
Date: Mon, 12 Nov 2007 15:46:05 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071112144605.GA16791@ins.uni-bonn.de>
References: <47382506.1090106@viscovery.net> <1194877277-31777-1-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 15:46:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IraYT-0006TB-VP
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 15:46:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbXKLOqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 09:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbXKLOqJ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 09:46:09 -0500
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:37158 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044AbXKLOqI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 09:46:08 -0500
Received: from ins.uni-bonn.de (gibraltar [192.168.193.254])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 5885C40000099;
	Mon, 12 Nov 2007 15:46:06 +0100 (CET)
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Ping Yin <pkufranky@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1194877277-31777-1-git-send-email-pkufranky@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-08)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64629>

Hello,

A couple of portability nits:

* Ping Yin wrote on Mon, Nov 12, 2007 at 03:21:17PM CET:
[...]
> +
> +	# TODO: quote module names containing space or tab
> +	test -n "$modules" && echo -e "# Submodules modifiled: "$modules"\n#"

Typo: s/modifiled/modified/

Then, "echo -e" is not portable (and not used elsewhere in git), but you
can just use this instead:
  test ... && { echo "# ..."; echo "#"; }

Also, it so happens you leave $modules outside quotes which will drop
multiple adjacent white spaces.  Did you mean to use
  echo "# Submodules modified: \"$modules\""
?

> +	OLDIFS=$IFS
> +	IFS=$'\n\r'	# '\r' for mac os

$' is not portable (and not POSIX either).  For example pdksh, OpenBSD
/bin/sh (which are both similar) will add "$" to the list of sepators
here, compare this: 

  $ foo=$'\n'; echo ".$foo."
  .$
  .

And at least some ash/dash versions will not interpret this as a newline
at all:
  .$\n.

You can instead just use a literal newline:
  IFS='
  '

(minus the indentation).  And add a literal carriage return if need be
(is that really needed on Mac OS?), though you may want to enclose that
in another pair of quotes to avoid it being "optimized" away by some
editor.

Cheers,
Ralf
