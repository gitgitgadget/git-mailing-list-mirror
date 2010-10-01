From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] git-am: fix detection of absolute paths for windows
Date: Fri, 1 Oct 2010 19:46:12 +0200
Message-ID: <201010011946.12481.j6t@kdbg.org>
References: <87ocbitd33.fsf@fox.patthoyts.tk> <201009282252.25688.j6t@kdbg.org> <87tyl6hnu2.fsf_-_@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Oct 01 19:46:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1jgc-00080y-HD
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 19:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753798Ab0JARqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Oct 2010 13:46:17 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:47691 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753711Ab0JARqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 13:46:16 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 0C0381001A;
	Fri,  1 Oct 2010 19:46:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id BD29719F5AF;
	Fri,  1 Oct 2010 19:46:12 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <87tyl6hnu2.fsf_-_@fox.patthoyts.tk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157766>

On Donnerstag, 30. September 2010, Pat Thoyts wrote:
> Add an is_absolute_path function to abstract out platform differences
> in checking for an absolute or relative path.
> Specifically fixes t4150-am on Windows.

Thanks for tackling this!

> @@ -209,5 +209,20 @@ case $(uname -s) in
>  	find () {
>  		/usr/bin/find "$@"
>  	}
> +	is_absolute_path () {
> +		case "$1" in
> +		/* | ?:* | \\\\*)

Absolute paths can also start with a backslash, and UNC paths can start with 
double-slash. Therefore, this should be:

		[/\\]* | [A-Za-z]:*)

> +			return 0 ;;
> +		esac
> +		return 1
> +	}

-- Hannes
