From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH v6 1/9] connect: call get_host_and_port() earlier
Date: Sat, 21 May 2016 07:28:31 +0900
Message-ID: <20160520222831.GA7752@glandium.org>
References: <20160517013554.22578-1-mh@glandium.org>
 <20160517013554.22578-2-mh@glandium.org>
 <xmqqfutccuq5.fsf@gitster.mtv.corp.google.com>
 <20160520221430.GA28273@glandium.org>
 <xmqqwpmobcd4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, tboegi@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 21 00:28:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3suQ-00057S-Of
	for gcvg-git-2@plane.gmane.org; Sat, 21 May 2016 00:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbcETW2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 18:28:39 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:56782 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750782AbcETW2i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 18:28:38 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1b3suF-00022Y-33; Sat, 21 May 2016 07:28:31 +0900
Content-Disposition: inline
In-Reply-To: <xmqqwpmobcd4.fsf@gitster.mtv.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295217>

On Fri, May 20, 2016 at 03:20:23PM -0700, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> >> Can never happen because?
> >> 
> >>   !*port means get_host_and_port() made the "port" pointer point at
> >>   a NUL byte.  That does not happen because the only case port is
> >>   moved by that function is to have it point at a byte after we
> >>   found ':', and the "port" string is a decimal integer whose value
> >>   is between 0 and 65535, so there is no way port points at an empty
> >>   string.
> >> 
> >> OK.
> >
> > Do you want me to add this to the commit message in a possible v7?
> 
> No.
> 
> I was merely thinking aloud to see if "in a case that never can
> happen" is sufficient decsription.  I think it is ;-)
> 
> >> This looks strange....
> > v3 of this series did remove this get_port(), and broke the
> > '[host:port]:path' syntax as a consequence. The reason this happens is
> > that get_host_and_port, in that case, is called with [host:port], sees
> > the square brackets, and searches the port *after* the closing bracket,
> > because the usual case where square brackets appear is ipv6 addresses,
> > which contain colons, and the brackets in that case are used to separate
> > the host and the port.
> >
> > In that case, get_host_and_port returns "host:port" and null.
> 
> Doesn't that indicate that this codepath deserves some in-code
> comment?

What would be the usual way you'd do this? separate patch? or just doing
it in one of the patches that touches the surrounding code?

Mike
