From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix set_work_tree on cygwin
Date: Thu, 02 Aug 2007 14:14:43 -0700
Message-ID: <7vwswdtz98.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0708020825q4b64c47r3fa1d67858271b1e@mail.gmail.com>
	<Pine.LNX.4.64.0708021636470.14781@racer.site>
	<20070802204909.GA2829@steel.home>
	<Pine.LNX.4.64.0708022204170.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 02 23:14:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGi0P-0001Dg-9U
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 23:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752967AbXHBVOq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 17:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752604AbXHBVOq
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 17:14:46 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:35797 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967AbXHBVOp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 17:14:45 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070802211444.TOAU1349.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Thu, 2 Aug 2007 17:14:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id X9Ei1X00b1kojtg0000000; Thu, 02 Aug 2007 17:14:44 -0400
In-Reply-To: <Pine.LNX.4.64.0708022204170.14781@racer.site> (Johannes
	Schindelin's message of "Thu, 2 Aug 2007 22:04:56 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54613>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Thu, 2 Aug 2007, Alex Riesen wrote:
>
>> Johannes Schindelin, Thu, Aug 02, 2007 17:38:37 +0200:
>> 
>> > On Thu, 2 Aug 2007, Alex Riesen wrote:
>> > 
>> > >@@ -209,7 +209,8 @@ const char *set_work_tree(const char *dir)
>> > >        len = strlen(dir);
>> > >        if (len > postfix_len && !strcmp(dir + len - postfix_len,
>> > >                                "/" DEFAULT_GIT_DIR_ENVIRONMENT)) {
>> > >-                       strncpy(dir_buffer, dir, len - postfix_len);
>> > >+               strncpy(dir_buffer, dir, len - postfix_len);
>> > >+               dir_buffer[len - postfix_len] = '\0';
>> > >
>> > >                /* are we inside the default work tree? */
>> > >                rel = get_relative_cwd(buffer, sizeof(buffer), dir_buffer);
>> > 
>> > Darn, darn, darn.  strncpy does _not_ NUL terminate.  I keep forgetting 
>> > that.
>> > 
>> > Better use strlcpy()?
>> 
>> Of course, but it just should not be needed at all: static supposed to
>> be zeroed.
>
> Certainly.  But reality outweighs theory, and so I Ack either your patch 
> or replacing it by strlcpy().

Static is supposed to be zeroed and also is supposed to retain
the value from the previous call.  I am guessing from the change
to make "rel" to non-static that this function is called twice
perhaps?
