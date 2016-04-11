From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/4] rebase -i: add ack action
Date: Mon, 11 Apr 2016 13:02:07 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604111239100.2967@virtualbox>
References: <1460296343-17304-1-git-send-email-mst@redhat.com> <1460296343-17304-2-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, bafain@gmail.com, sunshine@sunshineco.com
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 13:02:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apZcD-0006eD-TZ
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 13:02:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802AbcDKLCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2016 07:02:25 -0400
Received: from mout.gmx.net ([212.227.15.19]:64092 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752763AbcDKLCX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2016 07:02:23 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M6zkD-1blXZk46SL-00wmTi; Mon, 11 Apr 2016 13:02:10
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1460296343-17304-2-git-send-email-mst@redhat.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:DVb/bL/uPnwE6oZ2Ck12QqA8GQbJsB21sCxHN9AmPV7aSKjMNoh
 VVkDj9Xhn9FTAM4l8xGpSmJxnW9NxEpArAmNaA3KoBtOH2wvWqzNE17aa49FffMZyypz4Ec
 y+TjuY8n9l5epiGoJ0ozh1N3gqLv/IujwqlPbe0kiMBQ8sk8uXyuHnP0/y8t7HmPuNWZN6R
 6E8ReIaVgQvLoQZ/Zu38w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YvF3t6wUu64=:5uMzQW+0HiZG9/wdyKhYN4
 c28ady48jiUkwpmD5I4FRwVePI7cGpVRcoLxYbCoVJWpXcJyRan9+mu75zZxKxnDTAln6Wx4P
 B21LIo56uOds5+V0M5tyZF0jxS9qobPSLtb9vV01MuGXTfzDKes0V+wOI7Etx+4OYhqiedxG5
 h20L9Vr0zcxA+zALqXz6zJg99wGugLzp06LjkMzHfet4XyJjxah65Jq4/Qym+aAfU2MpJvPKF
 osU/BDPGfhyQPns0Do1X3ex/UZVWz9zT/adzveDXaYLFtP1d0J5qIoKAaoB4P65x4y5LOfh8o
 qfkKlKTE07QjTAeMNfBDVtVYojWPURK3Q1LQk7DUMr4bpaf92clGgewEiIUhlKP7Wn77YntQp
 La6CkVA8h4zHJ36qpdw2w3uSmIMPSYK4P+yeZKO401yiYZCZX4KMOuR4AyarLN1bYh71nEud9
 uJhMHVEldgpNqIazdp0vzU13lI9sDc2hLvbZ9dRj4DLmcxEAkixQVT5tQ91iOrFiNPsy5seDW
 /4OQLj0LwTUcoGAXvDUT5DHXEHRzfhnpeyt8rFyCcxfIM5wSJprEun+qYl+WGCIpdikQPt38l
 ICIw0RxNP2zNMUPptziLJyB7JoDJFtAT/sK4EbwBmatuQfyUnJUiFk1wOwD1snh3CTKfo1F0Z
 g6MTDgUHFOSJlPAUXb/gZRhNbXIpKgrnzQqEWiYbzLc9u2JBgIZhmxWqDnzGNsTa/VFjxs1BR
 WvhcQMzcHQE4bAu3vXHMwUJLqeKhr++n23jUCz1SIgykDvW943Ygtc9VxBZeTWgUCSmyqQHn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291210>

Hi Michael,

On Sun, 10 Apr 2016, Michael S. Tsirkin wrote:

> This implements a new ack! action for git rebase -i
> It is essentially a middle ground between fixup! and squash!:
> - commits are squashed silently without editor being started
> - commit logs are concatenated (with action line being discarded)
> - because of the above, empty commits aren't discarded,
>   their log is also included.
> 
> I am using it as follows:
> 	git am -s < mailbox #creates first commit
> 	hack ...
> 	get mail with Ack
> 	git commit --allow-empty -m `cat <<-EOF
> 	ack! first
> 
> 	Acked-by: maintainer
> 	EOF`
> 	repeat cycle
> 	git rebase --autosquash -i origin/master
> 	before public branch push
> 
> The "cat" command above is actually a script that
> parses the Ack mail to create the empty commit -
> to be submitted separately.

This looks awfully complicated, still, and not very generic.

How about making it easier to use, and much, much more generic, like this?

1. introducing an `--add-footer` flag to `git commit` that you could use
like this:

	git commit --amend --add-footer "Acked-by: Bugs Bunny"

2. introducing an `--exec-after` flag to `git commit` that would be a new
sibling of `--fixup` and `--squash` and would work like this:

	git commit --exec-after HEAD~5 \
		'git commit --amend --add-footer "Acked-by: Bugs Bunny"'

(it should imply `--allow-empty`, of course, and probably even fail if
anything was staged for commit at that point.) The commit message would
then look something like

	exec-after! Fix broken breakage

	git commit --amend --add-footer "Acked-by: Bugs Bunny"

This way would obviously benefit a lot more users. For example, you could
easily say (and alias)

	git commit --amend --add-footer 'Reviewed-by: Arrested Developer"

i.e. support all kind of use cases where developers need to slap on
footers in a quick & easy way.

And the --exec-after option would obviously have *a lot* more use cases
than just squashing in ACKs.

Ciao,
Johannes
