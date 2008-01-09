From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [PATCH] Simplified the invocation of command action in submodule
Date: Wed, 9 Jan 2008 15:51:50 +0600
Message-ID: <7bfdc29a0801090151k22d3cd5aqedb0d4860868d4d9@mail.gmail.com>
References: <1199851140-31853-1-git-send-email-imyousuf@gmail.com>
	 <47848CDD.7050806@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jan 09 10:52:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCXbk-0003Vj-0X
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 10:52:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755010AbYAIJv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 04:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753555AbYAIJvz
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 04:51:55 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:17480 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753766AbYAIJvx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 04:51:53 -0500
Received: by fg-out-1718.google.com with SMTP id e21so197647fga.17
        for <git@vger.kernel.org>; Wed, 09 Jan 2008 01:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=RKKlJmOqMk/7+FoW4jy/mY233YlJe3RLSYAcANMWDW4=;
        b=BzNh4tDvdgkbfdEXJb7g0EGR1QwL3/hOryNNdCCd4mIXtfy7wCoORfYYGGC1u/hMXMlhSmT85Z9mFyTyJHO2y3GAiQjiMrHCDdlH01O7sLxt8GYxP4tKBGXFZgoJOvEVdo5eLjHqYT9kvidqLJpDGCRyH8nd0bauK9MqBpJfBmA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fYJX43JxgM7zxvqKyYTNrXhRXaJ9tvRQknNeQsixEA7I7cPL3bzNpkyl6mIAWdhZjmUVebFPgp0BjI/lQI5exJINQ2rjZkERdrsNJFtnKEyExB0yBkUJyS23IqYLo+SGesaBgdwQnW/3JztP0hSETBBK7nH3SOV4u9BOifzUTTc=
Received: by 10.78.176.20 with SMTP id y20mr246612hue.36.1199872310546;
        Wed, 09 Jan 2008 01:51:50 -0800 (PST)
Received: by 10.78.50.5 with HTTP; Wed, 9 Jan 2008 01:51:50 -0800 (PST)
In-Reply-To: <47848CDD.7050806@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69974>

On Jan 9, 2008 2:59 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> imyousuf@gmail.com schrieb:
>
> > @@ -16,6 +16,7 @@ update=
> >  status=
> >  quiet=
> >  cached=
> > +command=
> >
> >  #
> >  # print stuff on stdout unless -q was specified
> > @@ -293,20 +294,23 @@ modules_list()
> >       done
> >  }
> >
> > +# command specifies the whole function name since
> > +# one of theirs prefix is module not modules
> >  while test $# != 0
> >  do
> >       case "$1" in
> >       add)
> >               add=1
> > +             command="module_$1"
> >               ;;
> >       init)
> > -             init=1
> > +             command="modules_$1"
> >               ;;
> >       update)
> > -             update=1
> > +             command="modules_$1"
> >               ;;
> >       status)
> > -             status=1
> > +             command="modules_list"
> >               ;;
> >       -q|--quiet)
> >               quiet=1
> > @@ -320,7 +324,7 @@ do
> >               branch="$2"; shift
> >               ;;
> >       --cached)
> > -             cached=1
> > +             command="modules_list"
>
> Don't remove cached=1 because otherwise --cached is effectively ignored.
>
> >               ;;
> >       --)
> >               break
> > @@ -345,20 +349,8 @@ case "$add,$branch" in
> >       ;;
> >  esac
> >
> > -case "$add,$init,$update,$status,$cached" in
> > -1,,,,)
> > -     module_add "$@"
> > -     ;;
> > -,1,,,)
> > -     modules_init "$@"
> > -     ;;
> > -,,1,,)
> > -     modules_update "$@"
> > -     ;;
> > -,,,*,*)
> > -     modules_list "$@"
> > -     ;;
> > -*)
> > +if [ -z $command ]; then
> >       usage
> > -     ;;
> > -esac
> > +else
> > +     "$command" "$@"
> > +fi
>
> - Previously 'git submodule' was equvalent to 'git submodule status', now
> it is an error.

Yes, I forgot to add that status is the default command. Thanks for
pointing it out.

>
> - Previously, passing --cached to add, init, or update was an error, now
> it is not.

The usage statement and this behaviour is rather contradicting. The
usage says that --cached can be used with all commands; so I am not
sure whether using --cached with add should be an error or not. IMHO,
if the previous implementation was right than the USAGE has to be
changed, and if the previous implementation was incorrect, than if the
default command is set to status than current implementation is right.

I would like to get comment on this until I fix the patch and resend it.

>
> -- Hannes
>

Thank you,

-- 
Imran M Yousuf
