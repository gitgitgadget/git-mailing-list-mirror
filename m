From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 2/2] completion: Use parse-options raw output for
	simple long options
Date: Tue, 17 Apr 2012 12:44:48 +0200
Message-ID: <20120417104448.GE2299@goldbirke>
References: <1334140165-24958-1-git-send-email-bebarino@gmail.com>
	<1334140165-24958-3-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, spearce@spearce.org,
	felipe.contreras@gmail.com, jrnieder@gmail.com
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 12:45:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SK5u3-00084K-J8
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 12:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753794Ab2DQKov convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Apr 2012 06:44:51 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:63414 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753580Ab2DQKou (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 06:44:50 -0400
Received: from localhost6.localdomain6 (p5B1306D0.dip0.t-ipconnect.de [91.19.6.208])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0McLz9-1SanyR1Zqh-00J5zw; Tue, 17 Apr 2012 12:44:49 +0200
Content-Disposition: inline
In-Reply-To: <1334140165-24958-3-git-send-email-bebarino@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:Znwqt+IustDWNWXvgr0QfE+DQd7LGSCXuYwwp57AtZY
 bsvB5UBXxmOnQU0AZsIlQJPG2rWYxrPWTlSRzgL0psGkv/HfMf
 f7pH9e787Q8alqeoW5obRoj/Gh3FI9xPZFSu8Yo5wCofC2BiEs
 BrIYB1xShn/GjCnZFq3xdpZ55dABAl72873vBmJ4riYNR4mPIs
 eDRIgmgVwrZTdYmSpBgwR0KEv1vZPOpUJPcQkJP0fg4aAqdxy+
 30fbCwY13U5fS+K8n22a0ALIRws2BFaqC1r8z6QsJT8QS6CbL/
 9U9qR9KPSMXhER8FS3VodSCH90EPX0GHOGo1U1xuWT0AOftT5b
 yEuxqcvs12h4L5mpIOm4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195753>

Hi Stephen,

On Wed, Apr 11, 2012 at 03:29:25AM -0700, Stephen Boyd wrote:
> Now that parse-options supports generating lists of long options for =
any
> parse-optified git program we can remove the hand-coded lists in the
> completion script. Replace these lists with code to generate the list=
s
> lazily when a user tab completes that specific command.

> +__git_list_command_options ()
> +{
> +	git $@ --dump-raw-long-options
> +}

Attempting option completion for the first time for commands requiring
a repository to work (e.g. 'add', 'branch', 'checkout', etc.) outside
of a git repository produces a 'fatal: not a git repository' error.
These commands require a repository for '--dump-raw-long-options',
too, otherwise they error out in __git_list_command_options().  So at
least we'll need

  git $@ --dump-raw-long-options 2> /dev/null

to silence that error, but even then the user won't get any options.
Now, I don't think that getting a list of options is that useful at
that point, because the command will error out anyway (except when the
user explicitly specifies the paths to the repo and work tree), but
it's a side effect nonetheless, because it worked before.

Computing the long options for commands not requiring a repository
(e.g. 'clone', 'archive', 'help', etc.) works properly even for the
first time and outside of a repository.


Best,
G=E1bor
