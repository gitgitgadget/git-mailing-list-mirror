From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Extend sample pre-commit hook to check for non ascii filenames
Date: Mon, 18 May 2009 07:42:31 -0700
Message-ID: <7v3ab2ealk.fsf@alter.siamese.dyndns.org>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com>
	<m3r5yukv6g.fsf@localhost.localdomain>
	<20090512214250.GA22974@macbook.lan>
	<200905122356.00659.jnareb@gmail.com>
	<20090514175850.GA26267@macbook.lan>
	<7vbpputewv.fsf@alter.siamese.dyndns.org>
	<419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com>
	<200905122356.00659.jnareb@gmail.com>
	<20090514175850.GA26267@macbook.lan>
	<200905151657.47225.jnareb@gmail.com>
	<20090518095044.GB910@heiko-voigts-macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Esko Luontola <esko.luontola@gmail.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon May 18 16:42:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6439-0000EE-I5
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 16:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752595AbZEROmd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 10:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753606AbZEROmb
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 10:42:31 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:52071 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345AbZEROmb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 10:42:31 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090518144231.MMEN18948.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Mon, 18 May 2009 10:42:31 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id t2iX1b00M4aMwMQ042iX3z; Mon, 18 May 2009 10:42:31 -0400
X-Authority-Analysis: v=1.0 c=1 a=bVMArNY9srkA:10 a=u5xjnL2QJoYA:10
 a=Y7828TS4AAAA:8 a=eQKFwi-JCDgT5XgA53sA:9 a=SKyMuCQXexMWuZlsN4VO_71GaHYA:4
 a=IUdvcfx5MVUA:10
X-CM-Score: 0.00
In-Reply-To: <20090518095044.GB910@heiko-voigts-macbook.local> (Heiko Voigt's message of "Mon\, 18 May 2009 11\:50\:44 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119445>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> +if [ "$allownonascii" != "true" ]
> +then
> +	# until git can handle non-ascii filenames gracefully
> +	# prevent them to be added into the repository

I think you can inline your is_ascii shell function in the pipeline below.
You made it a separate function and I agree that it has a very good
documentation value, but the mention of "non-ascii filenames" in this
comment here is enough clue to let anybody know what is going on.

	Side note: I am not sure "Until ... can ... gracefully" is a good
	description of the general problem.  It probably is more neutral
	to say "Cross platform projects tend to avoid non-ascii filenames;
        prevent them from being added to the repository."

> +	if ! git diff --cached --name-only --diff-filter=A -z \
> +	   | tr "\0" "\n" | is_ascii; then

A standard trick while writing a long pipeline in shell is to change line
after a pipe, like:

	cmd1 |
        cmd2 |
        cmd3

which allows you to lose the BS-before-LF sequence.

I think comments from J6t and others are valuable but clear enough that I
wouldn't have to repeat them.
