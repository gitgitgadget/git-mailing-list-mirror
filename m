From: Bernt Hansen <bernt@norang.ca>
Subject: Re: how to track the history of a line in a file
Date: Tue, 06 Jan 2009 10:48:10 -0500
Organization: Norang Consulting Inc
Message-ID: <87d4f01lmt.fsf@gollum.intra.norang.ca>
References: <alpine.DEB.1.10.0901021405460.21567@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Tue Jan 06 16:49:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKEBa-0001Aq-GO
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 16:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbZAFPsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 10:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750848AbZAFPsS
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 10:48:18 -0500
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:59307 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbZAFPsS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 10:48:18 -0500
Received: from cpe000102d0fe75-cm0012256ecbde.cpe.net.cable.rogers.com ([99.239.148.180] helo=mail.norang.ca)
	by mho-02-bos.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <bernt@norang.ca>)
	id 1LKEAB-0003K7-VX; Tue, 06 Jan 2009 15:48:16 +0000
Received: from gollum.intra.norang.ca (gollum.intra.norang.ca [192.168.1.5])
	by mail.norang.ca (8.13.8/8.13.8/Debian-3) with ESMTP id n06FmD38025669
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 6 Jan 2009 10:48:14 -0500
Received: from gollum.intra.norang.ca (localhost [127.0.0.1])
	by gollum.intra.norang.ca (8.14.3/8.14.3/Debian-5) with ESMTP id n06FmDOF010951;
	Tue, 6 Jan 2009 10:48:13 -0500
Received: (from bernt@localhost)
	by gollum.intra.norang.ca (8.14.3/8.14.3/Submit) id n06FmAfl010950;
	Tue, 6 Jan 2009 10:48:10 -0500
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 99.239.148.180
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/gO8QePxzWuzgX+neGUdAi
In-Reply-To: <alpine.DEB.1.10.0901021405460.21567@asgard.lang.hm> (david@lang.hm's message of "Fri\, 2 Jan 2009 14\:13\:32 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Received-SPF: none (mail.norang.ca: bernt@gollum.intra.norang.ca does not designate permitted sender hosts) receiver=mail.norang.ca; client-ip=192.168.1.5; helo=gollum.intra.norang.ca; envelope-from=bernt@gollum.intra.norang.ca; x-software=spfmilter 0.95 http://www.acme.com/software/spfmilter/ with libspf2;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104695>

david@lang.hm writes:

> I have a need to setup a repository where I'm storing config files,
> and I need to be able to search the history of a particular line, not
> just when the last edit of the line was (which is what I see from git
> blame)
>
> I'm not seeing a obvious way to do this, am I missing something or
> does it need a non-obvious approach?
>
> for example, if I do
>
> git blame -L /SUBLEVEL/,+1 -M Makefile
>
> on the linux kernel it currently shows
>
> 57f8f7b6 (Linus Torvalds 2008-10-23 20:06:52 -0700 3) SUBLEVEL = 28
>
> what I would want it to show would be a list of the commits that have
> changed this line.
>
> It looks like I can write a script to do this
>
> git blame -L /SUBLEVEL/,+1 -M Makefile 57f8f7b6^
> 6e86841d (Linus Torvalds 2008-07-28 19:40:31 -0700 3) SUBLEVEL = 27
> git blame -L /SUBLEVEL/,+1 -M Makefile 6e86841d^
> 2ddcca36 (Linus Torvalds 2008-05-03 11:59:44 -0700 3) SUBLEVEL = 26
>
> etc.
>
> is there a better way to do this?
>
> David Lang

I think you need a script to do what you want.  I think this works...

Save the following script in ~/bin/git-rblame.sh, make it executable,
and then create a global git alias for it as follows:

$ git config --global alias.rblame '!~/bin/git-rblame.sh $*'

Then you can just use

$ git rblame -L /SUBLEVEL/,+1 -M Makefile
6e86841d (Linus Torvalds 2008-07-28 19:40:31 -0700 3) SUBLEVEL = 27
2ddcca36 (Linus Torvalds 2008-05-03 11:59:44 -0700 3) SUBLEVEL = 26
...
4c91aedb (Linus Torvalds 2005-06-28 22:57:29 -0700 3) SUBLEVEL = 13
^1da177e (Linus Torvalds 2005-04-16 15:20:36 -0700 3) SUBLEVEL = 12

------cut here ------ !/bin/git-rblame.sh ---
#!/bin/sh
PARAMS="$*"
LINE=$(git blame $PARAMS)
while test $? == 0
do
    echo $LINE
    COMMIT="${LINE:0:8}^"
    LINE=$(git blame $PARAMS $COMMIT 2>/dev/null)
done
------cut here ------------------------------

Cheers,
Bernt
