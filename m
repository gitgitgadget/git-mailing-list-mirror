From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Interpreting EDITOR/VISUAL environment variables.
Date: Wed, 01 Aug 2007 10:12:13 -0700
Message-ID: <7vd4y75gcy.fsf@assigned-by-dhcp.cox.net>
References: <86abtbnzpr.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Aug 01 19:12:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGHkF-0000xa-0c
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 19:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758009AbXHARMP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 13:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758003AbXHARMP
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 13:12:15 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:38977 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757299AbXHARMO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 13:12:14 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070801171213.TCJZ1428.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Wed, 1 Aug 2007 13:12:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WhCD1X00R1kojtg0000000; Wed, 01 Aug 2007 13:12:14 -0400
In-Reply-To: <86abtbnzpr.fsf@lola.quinscape.zz> (David Kastrup's message of
	"Wed, 01 Aug 2007 15:36:48 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54454>

David Kastrup <dak@gnu.org> writes:

> Actually, splicing $EDITOR into a system command is a nuisance because
> it means having to shell-quote its arguments.  So the current
> interpretation is likely easier to maintain.
>
> Is it the correct one?

I've been torn on this one.  From the point of view of
"specified behaviour in the documentation", which is "EDITOR and
VISUAL name the editor of your choice", not splicing is not
violating the letter (I am not talking about our documentation
here, but many other programs').  Splicing and shell quoting
other parameters, while it is technically not a problem at all
doing that in scripts, feels "dirty".  Maybe it's just me.

Both cvs and svn seems to splice, I suspect they just do a
straight system(3) invocation.

We recently normalized the script callers not to splice at all
(the scripts were hand-rolling "the VISUAL or EDITOR or vi" and
slightly differently).  It obviously has negative (i.e. setting
EDITOR to "emacsclient --alternate-editor vi" does not work) as
well as positive side (i.e. "/home/dak/My Programs/editor" would
work).
