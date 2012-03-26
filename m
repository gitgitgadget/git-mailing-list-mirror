From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH v5 2/3] Refactor submodule push check to use string
	list instead of integer
Date: Mon, 26 Mar 2012 21:55:45 +0200
Message-ID: <20120326195535.GA41511@book.hvoigt.net>
References: <20120213092541.GA15585@t1405.greatnet.de> <20120213092900.GC15585@t1405.greatnet.de> <7vbop29jqf.fsf@alter.siamese.dyndns.org> <20120326193317.GB41087@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Fredrik Gustafsson <iveqy@iveqy.com>,
	Jens Lehmann <jens.lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 21:55:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCG1B-0001aq-9S
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 21:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755305Ab2CZTzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 15:55:48 -0400
Received: from darksea.de ([83.133.111.250]:36600 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755111Ab2CZTzr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 15:55:47 -0400
Received: (qmail 23987 invoked from network); 26 Mar 2012 21:55:45 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 26 Mar 2012 21:55:45 +0200
Content-Disposition: inline
In-Reply-To: <20120326193317.GB41087@book.hvoigt.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193966>

On Mon, Mar 26, 2012 at 09:33:17PM +0200, Heiko Voigt wrote:
> On Mon, Feb 13, 2012 at 07:28:24PM -0800, Junio C Hamano wrote:
> > Heiko Voigt <hvoigt@hvoigt.net> writes:
> > > -			*needs_pushing = 1;
> > > -			break;
> > > +			if (!string_list_has_string(needs_pushing, p->two->path))
> > > +				string_list_insert(needs_pushing, p->two->path);
> > 
> > Does string_list API have "look for this and insert if it doesn't exist
> > but otherwise don't do anything"?  Running get_entry_index() to answer
> > has_string() once and then calling it again to find where to insert to
> > respond to insert() looks a bit wasteful.
> > 
> > Just wondering.
> 
> If I see correctly currently it has no such functionality. I can have a
> look at adding another patch implementing this.

It seems my guess was wrong. As far as I read in the code
string_list_insert() already skips inserting existing strings and just
returns the existing items in the list. So it should be fine to remove
the string_list_has_string() call.

Cheers Heiko
