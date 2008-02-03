From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/4] help: make 'git-help--browse' usable outside 'git-help'.
Date: Sun, 3 Feb 2008 06:00:29 +0100
Message-ID: <200802030600.30074.chriscool@tuxfamily.org>
References: <20080202073233.7a656fa8.chriscool@tuxfamily.org> <7vmyqj4xxw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 05:55:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLWsg-0002Tl-L2
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 05:55:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754267AbYBCEyb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Feb 2008 23:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754076AbYBCEyb
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 23:54:31 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:52227 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753886AbYBCEya convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Feb 2008 23:54:30 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 9B1441AB2BB;
	Sun,  3 Feb 2008 05:54:28 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 7768D1AB2AB;
	Sun,  3 Feb 2008 05:54:28 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <7vmyqj4xxw.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72326>

Le samedi 2 f=E9vrier 2008, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > +	struct strbuf page_path; /* it leaks but we exec bellow */
> > +
> > +	get_html_page_path(&page_path, page);
> > +
> > +	execl_git_cmd("help--browse", page_path.buf, NULL);
> >  }
>
> And this part makes the reviewer even more worried. If page
> could be NULL, then get_html_page_path() would be fed a NULL
> pointer, which is given to strbuf_addf()!  Ugh.
>
> Then the reviewer would find out that cmd_to_page() would never
> return NULL, as it has its own NULL-to-"git" fallback logic.
>
> I think the code is good, but the proposed commit log message
> has some room for improvements.

Yeah, I could have explained some parts of the patch more.
I will try to do better.

> Something like...
>
>     [PATCH 1/4] help: make 'git-help--browse' usable outside 'git-hel=
p'
>
>     "git-help--browse" helper is to launch a browser of the
>     user's choice to view the HTML version of git documentation
>     for a given command.  It used to take the name of a command,
>     convert it to the path of the documentation by prefixing the
>     directory name and appending the ".html" suffix, and start
>     the browser on the path.
>
>     This updates the division of labor between the caller in
>     help.c and git-help--browser helper.  The helper is now
>     responsible for launching a browser of the user's choice
>     on given URLs, and it is the caller's responsibility to
>     tell it the paths to documentation files.
>
>     This is in preparation to reuse the logic to choose
>     user's preferred browser in instaweb.
>
>     The helper had a provision for running it without any
>     command name, in which case it showed the toplevel "git(7)"
>     documentation, but the caller in help.c never makes such a
>     call.  The helper now exits with a usage message when no
>     path is given.

Great commit message indeed! Though I fear that such long messages (for=
 a=20
not very long patch) could take precious screen real estate when using =
"git=20
log" or otherwise bother some other readers.

Anyway do you want me to resend the patch or the series with improved c=
ommit=20
messages ?

>     Signed-off-by: ...
>     ---
>
>      * Eric is CC'ed because the ultimate goal of this
>        series is to get rid of the duplicated logic between
>        help--browse and instaweb.
>
>      Makefile            |    2 +-
>      git-help--browse.sh |   24 +++++++++---------------
>     ...
>
> I have given only a cursory look at the remainder of the series
> (I'll hopefully be in a mini vacation mode after the release),

You definitely deserve it. Thanks for your great release and maintainer=
=20
work.

> but I think overall the series makes sense.

Thanks,
Christian.
