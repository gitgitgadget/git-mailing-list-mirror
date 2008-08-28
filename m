From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-commit: '--no-status' Allow suppression of status
 summary in commit msg
Date: Thu, 28 Aug 2008 12:09:35 -0700
Message-ID: <7vd4jtdki8.fsf@gitster.siamese.dyndns.org>
References: <1219949215-10189-1-git-send-email-marcus@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	"Marius Storm-Olsen" <mstormo_git@storm-olsen.com>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Thu Aug 28 21:11:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYmtX-0000ak-IJ
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 21:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080AbYH1TJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 15:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753048AbYH1TJn
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 15:09:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34387 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752913AbYH1TJm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 15:09:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D8AD95527A;
	Thu, 28 Aug 2008 15:09:41 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1383855254; Thu, 28 Aug 2008 15:09:37 -0400 (EDT)
In-Reply-To: <1219949215-10189-1-git-send-email-marcus@griep.us> (Marcus
 Griep's message of "Thu, 28 Aug 2008 14:46:55 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DE443E02-7534-11DD-81FE-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94115>

Marcus Griep <marcus@griep.us> writes:

> Currently, using any editor to edit a commit message for 'git commit'
> kicks of a 'git status' which is then included as comments to give
> the commit author some context. However, in some situations, such as
> having a working tree of many hundred thousand files or on an inefficient
> filesystem,

I am not interested in this particular patch, especially the part that
hoards a short-and-nice -S flag that we could use for something more
useful.  Also calling the configuration variable "nostatus" is backwards;
I'd name it to "showstatus" that defaults to "true" if I were doing this.

You did not mention exactly how the "hundred thousand files on an
inefficient filesystem" is a problem, but if it is about listing untracked
files, I thought Marius Storm-Olsen added a feature to address that with
4bfee30 (Add an optional <mode> argument to commit/status -u|--untracked-files
option, 2008-06-05).

If that is not still enough for your particular use case, I think you can
have a custom wrapper that does:

	#!/bin/sh
	: >.log-message-file &&
        vi .log-message-file &&
        git commit -F .log-message-file "$@" &&
        rm -f .log-message-file 

without touching git at all.
