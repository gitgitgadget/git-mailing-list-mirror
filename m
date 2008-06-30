From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] clone: respect the settings in $HOME/.gitconfig and
 /etc/gitconfig
Date: Sun, 29 Jun 2008 23:20:01 -0700
Message-ID: <7vwsk730mm.fsf@gitster.siamese.dyndns.org>
References: <27C25D70-0BFC-4362-A771-C7CAD89BC198@ai.rug.nl>
 <alpine.DEB.1.00.0806271353350.9925@racer>
 <alpine.LNX.1.00.0806271149580.19665@iabervon.org>
 <7vvdzuo61b.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0806291359330.19665@iabervon.org>
 <alpine.DEB.1.00.0806292248160.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 30 08:21:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDClm-00087Y-QJ
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 08:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752470AbYF3GUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 02:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752670AbYF3GUN
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 02:20:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45600 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470AbYF3GUM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 02:20:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 37ACF115CE;
	Mon, 30 Jun 2008 02:20:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 227DB115CD; Mon, 30 Jun 2008 02:20:04 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0806292248160.9925@racer> (Johannes
 Schindelin's message of "Sun, 29 Jun 2008 22:49:42 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9770A728-466C-11DD-A662-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86880>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 29 Jun 2008, Daniel Barkalow wrote:
>
>> Did we even make a commitment on whether:
>> 
>> GIT_CONFIG=foo git clone bar
>> 
>> must ignore the environment variable, or simply doesn't necessarily obey 
>> it?
>
> I'd rather strongly argue that no matter what is the answer to this 
> question, we _HAVE TO_ unsetenv() GIT_CONFIG at some stage, otherwise no 
> .git/config will be written.
>
> So, this is a NACK on your patch.

True.  We are creating the config file for the new repository, so the
initial setenv() would make sense.  We _could_ save away end user's
GIT_CONFIG and restore it where you unsetenv() in your patch, but I do not
think it would buy us anything other than "be consistent with other
programs that misbehave when end user has GIT_CONFIG".  

Honestly, GIT_CONFIG is purely for scripts like git-svn that muck with
files that are in the config format to have a way to make sure that they
access the file they intend to, and being able to use GIT_CONFIG to keep
git programs from reading from $HOME/.gitconfig is primarily for giving
our test scripts repeatable environment, nothing more.

I think ignoring end-user GIT_CONFIG like this patch does, instead of
doing random nonsense, would be a good bugfix for "git clone".
