From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] doc: core.ignoreStat clarify the --assume-unchanged
 effect
Date: Fri, 12 Dec 2014 11:56:28 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412121149040.13845@s15462909.onlinehome-server.info>
References: <1418341733-1656-1-git-send-email-philipoakley@iee.org> <1418341733-1656-2-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	?utf-8?Q?S=C3=A9rgio?= Basto <sergio@serjux.com>,
	Duy Nguyen <pclouds@gmail.com>, Johannes Sixt <j6t@kdbg.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Dec 12 11:56:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzNtz-0001Rh-GL
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 11:56:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934839AbaLLK4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 05:56:48 -0500
Received: from mout.gmx.net ([212.227.15.15]:58635 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933987AbaLLK4q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 05:56:46 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0MGjfl-1YCuQW2L3p-00DW9W;
 Fri, 12 Dec 2014 11:56:29 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <1418341733-1656-2-git-send-email-philipoakley@iee.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:l+1wtGjNB/beWi5Rw9kShKNWgzLMHwvKq9VuB5Fj/ocndC7liUn
 h8bYxbEw13XGhnmz9ZTXmaAsgVJDaoKeqDxpvO7CFFJaHZvFKkq1k+o9uoTsdsT4VjJ8EgX
 T0nU9zc3U0gS4ZuHVFoQfW17G2uNzb4G+rMjxZ31lHZ/DDaWbYj26/8uDX5Ka/TuJ/bJavA
 MjJowMtWOeWJiXx9PUWaQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261348>

Hi Philip,

On Thu, 11 Dec 2014, Philip Oakley wrote:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index c26a7c8..81570b7 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -354,10 +354,11 @@ proxy use, while defaulting to a common proxy for external domains.
>  core.ignoreStat::
>  	If true, commands which modify both the working tree and the index
>  	will mark the updated paths with the "assume unchanged" bit in the
> -	index. These marked files are then assumed to stay unchanged in the
> -	working tree, until you mark them otherwise manually - Git will not
> -	detect the file changes	by lstat() calls. This is useful on systems
> -	where those are very slow, such as Microsoft Windows.
> +	index. These marked files are then expected to stay unchanged in the
> +	working tree. If you change them you should mark their update manually.
> +	Git will normally not detect the file changes by lstat() calls.
> +	This is useful on systems where those calls are very slow, such as
> +	cifs/Microsoft Windows.
>  	See linkgit:git-update-index[1].
>  	False by default.

I think that the new wording is better, but still can be misunderstood.
How about this instead:

-- snip --
core.ignoreStat::
	If true, Git will not try to detect when files were modified.
	When Git commands are used to modify files, Git will know that
	they were modified, but when files are modified outside of Git,
	the user will need to stage the modified files explicitly; they
	will not be reported as changed e.g. by linkgit:git-status[1].
+
This is useful on systems where lstat() calls are very slow, such as
CIFS/Microsoft Windows.
See linkgit:git-update-index[1].
False by default.
-- snap --

In other words, I would try to skip the "assume unchanged" flag
altogether, it is prone to confuse readers unfamiliar with the inner
workings of the index.

Ciao,
Dscho
