From: Junio C Hamano <junkio@cox.net>
Subject: Re: problem installing latest cogito
Date: Sat, 21 Jan 2006 12:12:28 -0800
Message-ID: <7vmzhpl4r7.fsf@assigned-by-dhcp.cox.net>
References: <fof4t15q95qkakgk6b7fbfuqh3r6q7ei17@4ax.com>
	<20060121194826.GK28365@pasky.or.cz>
	<BAYC1-PASMTP061F43C7F760A9FB73B616AE1E0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: morgad@eclipse.co.uk, git@vger.kernel.org,
	sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Sat Jan 21 21:12:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0P6A-0003S9-Id
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 21:12:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWAUUMc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 15:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWAUUMb
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 15:12:31 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:34023 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932313AbWAUUMb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2006 15:12:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060121200949.SLBH17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 Jan 2006 15:09:49 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <BAYC1-PASMTP061F43C7F760A9FB73B616AE1E0@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Sat, 21 Jan 2006 14:49:01 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15016>

sean <seanlkml@sympatico.ca> writes:

> On Sat, 21 Jan 2006 20:48:26 +0100
> Petr Baudis <pasky@suse.cz> wrote:
>
>> >                 sed -e
>> > 's/\${COGITO_LIB}/\${COGITO_LIB:-\/home\/david\/lib\/cogito\/}/g; \
>> > 
>> > s/\${COGITO_SHARE}/\${COGITO_SHARE:-\/home\/david\/share\/cogito\/}/g'
>> > \
>> >                        $file > $file.new; \
>> >                 cat $file.new > $file; rm $file.new; \
>> >         done
>> > sed: -e expression #1, char 145: unterminated address regex
>
> The problem seems to go away if you remove the quoted end-of-line:

That is not "the quoted end-of-line".  Backslashes do not have
any special meaning inside a single quote pair for bourne shell
quoting.  The script is passing the backslash to sed.

IIRC, make seems to do different things for the backslash at the
end of line depending on vintage, so if this scriptlet appears
in a Makefile you may have another version dependency.  I
usually cop out of this problem by having a separate shell
script and run it from the Makefile, instead of spelling out the
sed commandline in the Makefile.

I got a complaint or two that some version of sed does not like
';' to concatenate more than one commands, and have been trying
to train myself to do either multiple -e options or multi-line
scripts.  E.g when I am tempted to say:

	sed -e 's/foo/bar/;s/baz/boa/' froboz

Instead, I say either

	sed -e 's/foo/bar/' -e 's/baz/boa/' froboz

or

	sed -e '
        	s/foo/bar
                s/baz/boa/
	' froboz

I do not know how much of the above applies to your immediate
problem, but I hope some of it helps.
