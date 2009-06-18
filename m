From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add: allow configurations to be overriden by command line
Date: Thu, 18 Jun 2009 09:40:15 -0700
Message-ID: <7vfxdxxzps.fsf@alter.siamese.dyndns.org>
References: <1245316674-32377-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 18:40:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHKf4-0001BC-H6
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 18:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623AbZFRQkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 12:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751957AbZFRQkP
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 12:40:15 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:62419 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbZFRQkO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 12:40:14 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090618164016.CCLA18948.fed1rmmtao107.cox.net@fed1rmimpo03.cox.net>;
          Thu, 18 Jun 2009 12:40:16 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 5UgG1c0024aMwMQ04UgGob; Thu, 18 Jun 2009 12:40:16 -0400
X-VR-Score: -30.00
X-Authority-Analysis: v=1.0 c=1 a=_eZ_frdmPJ4A:10 a=pGLkceISAAAA:8
 a=0I4ZeSsbm_S0jIcfdf4A:9 a=QUZ0eEVPNyKtY1NckXAA:7
 a=61U53n5fU_fT87auXDgz1hbc5FIA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <1245316674-32377-1-git-send-email-bebarino@gmail.com> (Stephen Boyd's message of "Thu\, 18 Jun 2009 02\:17\:54 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121855>

Stephen Boyd <bebarino@gmail.com> writes:

> Don't call git_config after parsing the command line options, otherwise
> the config settings will override any settings made by the command line.

Amusing.

This dates back to the original 0d78153 (Do "git add" as a builtin,
2006-05-17).  It had two git_config() calls (one before command line
parsing, and then another).

Then 11be42a (Make git-mv a builtin, 2006-07-26) noticed this duplicate
calls, and removed the wrong one.

The calling sequence has been the same ever since; parse-opt-ification
5c46f75 (Port builtin-add.c to use the new option parser., 2007-10-03) 
did not affect it either.

Perhaps this deserves a test.  It is an ancient breakage nobody noticed so
far.

Thanks
