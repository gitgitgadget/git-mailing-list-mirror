From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Allow git_author|committer_info be called in the same expression
Date: Wed, 1 Aug 2007 11:35:45 +0200
Message-ID: <81b0412b0708010235j3c731b38v32b5a717ae9f1f0b@mail.gmail.com>
References: <81b0412b0707310957x62ac9d28j60104bffb46a80b7@mail.gmail.com>
	 <7vhcnj7gkt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "=?UTF-8?Q?Kristian_H=C3=B8gsberg?=" <krh@redhat.com>,
	git@vger.kernel.org, "Paul Mackerras" <paulus@samba.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 11:35:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGAcR-0003aw-Gw
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 11:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759968AbXHAJfs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 05:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759423AbXHAJfs
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 05:35:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:26547 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759955AbXHAJfr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 05:35:47 -0400
Received: by nf-out-0910.google.com with SMTP id g13so42704nfb
        for <git@vger.kernel.org>; Wed, 01 Aug 2007 02:35:45 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aNOmqojevC8RcyJbRL4DDsyBl35gcxS/hEjJCaNvj6cue+1KEnqeIHCwHkU4f6YN1/JQDay0FfsNCxhuPIw4sGxlfAekS8ZPn+okRCzviWKXSSXcYoVZY6yOa32Eynmv5MHib8fODztdZkbKxIVT5OAg9uknNc0P8GOn1POx+00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Gw4QaVGTKafXdLYhiK/7QZZwPJ31kVRcNsYRlwM/A12xsrc7cPhUZmO4IOAT5b9hqzTu0rlOjVVNGhlTWRUkJpsY8Kx0uUDMiE/FnQjeifzSBH7dQZlG9BBx8799WJHKmU+jeQJW9NF3KhK96tT6jGjRU/OtbtasN68wtJmJrz0=
Received: by 10.78.132.2 with SMTP id f2mr123432hud.1185960945501;
        Wed, 01 Aug 2007 02:35:45 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Wed, 1 Aug 2007 02:35:45 -0700 (PDT)
In-Reply-To: <7vhcnj7gkt.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54424>

On 8/1/07, Junio C Hamano <gitster@pobox.com> wrote:
> "Alex Riesen" <raa.lkml@gmail.com> writes:
>
> >  const char *git_committer_info(int error_on_no_name)
> >  {
> > -     return fmt_ident(getenv("GIT_COMMITTER_NAME"),
> > -                      getenv("GIT_COMMITTER_EMAIL"),
> > -                      getenv("GIT_COMMITTER_DATE"),
> > -                      error_on_no_name);
> > +     static char *buffer;
> > +     if (!buffer)
> > +             buffer = xmalloc(FMT_IDENT_BUFSIZE);
>
> It is not like we are aiming to run on embedded devices, I think

Actually, I am planning to run it on Neo1973 (Openmoko),
which is quite embedded with its 128mb.

> trying to save static memory when the function is not called
> by doing things like this is not worth it.  Why not just:
>
>         static char buffer[FMT_IDENT_BUFSIZE];
>
> instead?

Just a custom. This is a big bugger, err... buffer.

> As to parts of the system that other people are primarily in
> charge of, git-gui 0.8.0 is already in as promised, updates to
> gitk were merged, and we've had a nice set of improvements from

BTW, gitk. Have you seen the gitk patches regarding errors in non-GIT
and not-yet-GIT directory?
