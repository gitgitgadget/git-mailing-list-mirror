From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: [PATCH] Supplant the "while case ... break ;; esac" idiom
Date: Mon, 24 Sep 2007 15:35:56 +0400
Message-ID: <20070924113556.GI8111@void.codelabs.ru>
References: <853ax5mb1j.fsf@lola.goethe.zz> <85myvdktb3.fsf@lola.goethe.zz> <20070924060521.GB10975@glandium.org> <85k5qgk295.fsf@lola.goethe.zz> <ee77f5c20709232330n7b47d9e9v38677678dbf197da@mail.gmail.com> <86ejgowl5g.fsf@lola.quinscape.zz> <20070924080134.GA9112@artemis.corp> <20070924080436.GB9112@artemis.corp> <Pine.LNX.4.64.0709241128460.28395@racer.site> <87ps08s3zt.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Mon Sep 24 13:36:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZmEc-0003fj-U1
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 13:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754257AbXIXLgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 07:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754533AbXIXLgJ
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 07:36:09 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:56194 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754257AbXIXLgI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 07:36:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender:X-Spam-Status:Subject;
	b=V0ZMDn0i6yFjKRd8bqvDXPWhnRtqH3yLjXXqdHZMOuCVvvLKwCqlSF+osPo9FNfSzo2N/uEp5ddxxDWn1O6VOQ4YGATNgGYBKIoM+j23jj/XyH9szrVJppiphsYv6wRokb3JcYxLjDGwkQPJ5fU08mtbWWgNUw9L1swrsIQ2gKU=;
Received: from void.codelabs.ru (void.codelabs.ru [144.206.177.25])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1IZmEL-000E6w-6j; Mon, 24 Sep 2007 15:36:01 +0400
Content-Disposition: inline
In-Reply-To: <87ps08s3zt.fsf@catnip.gol.com>
X-Spam-Status: No, score=-2.0 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_20
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59041>

Miles,

Mon, Sep 24, 2007 at 08:21:42PM +0900, Miles Bader wrote:
> > The reason we used "case" is that this has always been a builtin (has to 
> > be, because it changes workflow).
> >
> > Therefore I am somewhat uneasy that the patch went in so easily, 
> > especially given a message that flies in the face of our endeavours to 
> > make git less dependent on any given shell (as long as it is not broken to 
> > begin with).
> 
> The comment "... holds only for a shell where [ is a builtin" doesn't
> make any sense to me

The 'while case ...' construct does not invoke any external commands.
The 'while test ...' too, but only when 'test' is builtin.  When
'test' is the external binary you get one additional fork/exec per
each cycle.

I believe that this trick comes from the old days where people were
generally much more eager to save CPU cycles than now ;))  But if
you tried to run Cygwin on the moderately new machines (like PIII),
you still can notice that commands like 'man' are a bit slow just
because they require a bunch of preprocessors (and processes in
pipe) to run.  So, "save the process, kill the fork/exec" ;))

> though:  "-ne" is a standard operator even if "["
> isn't a builtin.  It's useful if you are testing numbers in potentially
> non-canonical form, e.g., with leading zeroes or something, and AFAIK is
> quite portable.

In general -- yes, it is portable and good for leading zeros.  But
in the case of $#, there will hardly be leading zeros or something
else.  And using '!=' typically saves you one atoi() + some other
checks, since it typically translates to a bare strcmp().
-- 
Eygene
