From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFH] pp_header(): work around possible memory corruption
Date: Fri, 15 Jun 2007 22:31:06 -0700
Message-ID: <7vps3w4g9x.fsf@assigned-by-dhcp.pobox.com>
References: <Pine.LNX.4.64.0706151318210.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 16 07:31:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzQss-0006Hf-Vd
	for gcvg-git@gmane.org; Sat, 16 Jun 2007 07:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566AbXFPFbJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 01:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752325AbXFPFbI
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 01:31:08 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:54423 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540AbXFPFbH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 01:31:07 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070616053105.TQIU17635.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sat, 16 Jun 2007 01:31:05 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id C5X61X0011kojtg0000000; Sat, 16 Jun 2007 01:31:06 -0400
In-Reply-To: <Pine.LNX.4.64.0706151318210.4059@racer.site> (Johannes
	Schindelin's message of "Fri, 15 Jun 2007 13:19:07 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50287>

At least the older humongous pretty_print_commit() got separated
into manageable chunks, and I was happy.  I was just too lazy
when refactoring the code and stopped there.

The right fix is to propagate the "realloc as needed" callchain
into add_user_info(), instead of having "this should be enough"
there.  These two you touched are the only two callsite of that
static function.
