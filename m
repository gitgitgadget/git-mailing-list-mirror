From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] git-submodule.sh: Don't use $path variable in eval_gettext
 string
Date: Tue, 24 Apr 2012 18:32:35 +0100
Message-ID: <4F96E3B3.2080408@ramsay1.demon.co.uk>
References: <4F8DAFDA.1020108@ramsay1.demon.co.uk> <7v4nsgk3os.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: bwalton@artsci.utoronto.ca, Johannes Sixt <j6t@kdbg.org>,
	Jens.Lehmann@web.de, avarab@gmail.com,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 19:34:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMjcm-0007N7-AX
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 19:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756871Ab2DXRdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 13:33:53 -0400
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:44542 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756864Ab2DXRdw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Apr 2012 13:33:52 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1SMjcc-0004BT-ef; Tue, 24 Apr 2012 17:33:51 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7v4nsgk3os.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196228>

Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
>> As an alternative, we finesse the problem by renaming the $path
>> variable to $sm_path (submodule path). This fixes the problem on
>> MinGW along with all test failures on cygwin (t7400.{7,32,34},
>> t7406.3 and t7407.{2,6}). We note that the foreach subcommand
>> provides $path to user scripts (ie it is part of the API), so we
>> can't simply rename it to $sm_path.
> 
> Which might mean that foreach is unusable on systems whose environment
> variables are case insensitive, as whatever command spawned by foreach
> has its $PATH clobberred.  

[sorry for the late reply; I've been away from email for nearly a week.]

No, the foreach command is (mostly) fine; given the fact that the user
script is eval-ed in a context in which $path is not exported. The reason
for the 'mostly' is simply that the user could shoot himself in the
foot by export-ing $path in their script, so that something like:

    $ git submodule foreach 'export path; echo $path `git rev-parse HEAD`'

will indeed fail (ie git rev-parse will not execute).

How likely is this to happen? I suspect it would be somewhat rare.

Hmm, does it deserve a note in the docs?

>                            It is not a regression to them, so it is not
> urgent to address it, but going forward, perhaps we can encourage users
> of _all_ platforms to use $sm_path for portability?

Maybe, but I don't have strong feelings either way. Using $sm_path rather
than $path would, of course, eliminate even the above (very unlikely)
problem ...

ATB,
Ramsay Jones
