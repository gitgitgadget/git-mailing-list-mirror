From: "BRUNO CESAR RIBAS" <ribas@c3sl.ufpr.br>
Subject: Re: [PATCH] contrib/hooks/post-receive-email: checks for gitweb.description
Date: Mon, 11 Feb 2008 19:49:57 -0200
Message-ID: <20080211214957.GA20469@c3sl.ufpr.br>
References: <1202760138-24227-1-git-send-email-ribas@c3sl.ufpr.br> <m3ejbjdwc6.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 22:50:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOgXt-0003Sq-4L
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 22:50:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754318AbYBKVuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 16:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754460AbYBKVuB
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 16:50:01 -0500
Received: from mx.inf.ufpr.br ([200.17.202.3]:60525 "EHLO urquell.c3sl.ufpr.br"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754221AbYBKVuA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 16:50:00 -0500
Received: from dalmore (dalmore.c3sl.ufpr.br [200.17.202.56])
	by urquell.c3sl.ufpr.br (Postfix) with SMTP id 3FF1C700003D4;
	Mon, 11 Feb 2008 19:49:57 -0200 (BRST)
Received: by dalmore (sSMTP sendmail emulation); Mon, 11 Feb 2008 19:49:57 -0200
Content-Disposition: inline
In-Reply-To: <m3ejbjdwc6.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73591>

On Mon, Feb 11, 2008 at 01:20:21PM -0800, Jakub Narebski wrote:
> Bruno Ribas <ribas@c3sl.ufpr.br> writes:
> 
> Here it would be nice to have longer description, like:
> 
>   Check repository configuration gitweb.description for project
>   description, if $GIT_DIR/description does not exist

Okay, I'll resend =)

> 
> Note that 'description' file is created by default when creating
> repository by git-init by default repo template.

Yep, but when we use the gitweb.description we have do rm description file,
As seen on gitweb.perl it falls back to gitweb.description only when we can't
open description file.

hmm... With this patch i am not assuming someone set description file to mode
000, i think is better not to imaginade someone would do this, or not?

> 
> > Signed-off-by: Bruno Ribas <ribas@c3sl.ufpr.br>
> > ---
> >  contrib/hooks/post-receive-email |    6 +++++-
> >  1 files changed, 5 insertions(+), 1 deletions(-)
> > 
> > diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
> > index 77c88eb..bdd21fa 100644
> > --- a/contrib/hooks/post-receive-email
> > +++ b/contrib/hooks/post-receive-email
> > @@ -614,7 +614,11 @@ if [ -z "$GIT_DIR" ]; then
> >  	exit 1
> >  fi
> >  
> > -projectdesc=$(sed -ne '1p' "$GIT_DIR/description")
> > +if [ -f "$GIT_DIR/description" ]; then
> > +	projectdesc=$(sed -ne '1p' "$GIT_DIR/description")
> > +else
> > +	projectdesc=$(git-config gitweb.description)
> 
> The rest of this hook use "git cmd". Preferred way to call git
> commands is "git cmd". So I would use
> 
>   "git config gitweb.description"
> 
> > +fi
> >  # Check if the description is unchanged from it's default, and shorten it to
> >  # a more manageable length if it is
> >  if expr "$projectdesc" : "Unnamed repository.*$" >/dev/null
> > -- 
> > 1.5.4.24.gce08d
> > 
> 
> -- 
> Jakub Narebski
> Poland
> ShadeHawk on #git
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
