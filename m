From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git-rebase fails when a commit message contains a diff
Date: Thu, 08 Nov 2007 18:37:37 -0800
Message-ID: <7v1wb0xhxq.fsf@gitster.siamese.dyndns.org>
References: <20071109011214.GA5903@diku.dk>
	<7vlk98xkm3.fsf@gitster.siamese.dyndns.org>
	<7vhcjwxk1s.fsf@gitster.siamese.dyndns.org>
	<7v640cxitc.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711090225110.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 09 03:38:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqJl3-00009r-Gi
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 03:38:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758716AbXKIChy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 21:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751747AbXKIChy
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 21:37:54 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:52555 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbXKIChx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 21:37:53 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 963622FA;
	Thu,  8 Nov 2007 21:38:14 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 1765F92AE5;
	Thu,  8 Nov 2007 21:38:10 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711090225110.4362@racer.site> (Johannes
	Schindelin's message of "Fri, 9 Nov 2007 02:28:15 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64118>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 8 Nov 2007, Junio C Hamano wrote:
>
>> I wonder if this is a sensible thing to do, regardless of the issue of 
>> commit log message that contains anything.
>> 
>> The patch replaces git-rebase with git-rebase--interactive.  The only 
>> difference from the existing "git-rebase -i" is if the command is called 
>> without "-i" the initial "here is the to-do list. please rearrange the 
>> lines, modify 'pick' to 'edit' or whatever as appropriate" step is done 
>> without letting the user edit the list.
>
> Hmm.  I don't know, really.  I had the impression that the "git 
> format-patch | git am" pipeline would be faster.

Heh, I did not read rebase--interactive carefully enough.

Unless told to use merge with "rebase -m", rebase replays the
change by extracting and applying patches, and speed comparison
was about that vs merge based replaying; I thought make_patch
was done in order to avoid using cherry-pick (which is based on
merge-recursive) and doing patch application with three-way
fallback.  Apparently that is not what "interactive" does.

Perhaps pick_one () could be taught to perform the 3-way
fallback dance git-am plays correctly.  The patch I sent to make
git-rebase--interactive take over git-rebase would then become
quite reasonable, I would think.
