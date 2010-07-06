From: Eugene Sajine <euguess@gmail.com>
Subject: Re: global hooks - once again
Date: Tue, 6 Jul 2010 08:20:05 -0400
Message-ID: <AANLkTilb3ah6UNuTeUNjpP39YPwzERJ0Jsvil0YMKXaZ@mail.gmail.com>
References: <AANLkTikXJS5QCXMXgsOfkYn9cMBQV6o23tds5YG3A_OI@mail.gmail.com>
	<7v630x1yl8.fsf@alter.siamese.dyndns.org>
	<AANLkTikMEDUI7d5Mzwm8r43zCYTqefyI06PHOMvT1iLz@mail.gmail.com>
	<A612847CFE53224C91B23E3A5B48BAC744940F6E57@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 14:20:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW78U-0003se-Mb
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 14:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753729Ab0GFMUH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jul 2010 08:20:07 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:44694 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832Ab0GFMUG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jul 2010 08:20:06 -0400
Received: by qyk35 with SMTP id 35so1937035qyk.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 05:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Jd0ukFUnGtaOIhBz0ok87QY1itsXTJo+kxSpnxU6z9c=;
        b=QlBGNDWp6xZ7IqLQNXaPSn0vAFDapl7JmVy8dPMuC2YL/ji1rcNY0NcgrHKcBDSPnJ
         ZGk0yPCoRxaHAtCfoCOycejqUl6em7vcN1OFNtJvW5fHgEeLmrGCpQP8lsbCG7REeXIp
         FxN9zTB5i8O2YPOKC999QY0WXSwJqt6yVyPnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rS70rlY5zdGU9IaxPZIEiLTV7EJVp53xj7cVVIUyCD4GhHqUs154gkmYjeknxK9Lk5
         To6h8XFluz6YkEFTITXwu19ESR5Z4wDB6JNU57Lyjmmj7q5czmPlk3aJzV+Ql24lc5HF
         zabRtNrih2CQgUyKjVhFuKSTimkdVcq36GnAE=
Received: by 10.224.96.144 with SMTP id h16mr2390341qan.356.1278418805222; 
	Tue, 06 Jul 2010 05:20:05 -0700 (PDT)
Received: by 10.229.212.209 with HTTP; Tue, 6 Jul 2010 05:20:05 -0700 (PDT)
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC744940F6E57@xmail3.se.axis.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150346>

> Well, I belong to this secondary category, working for a company
> which is about to switch to git. Once the transition is completed,
> we will have more than 800 git repositories, and they should all
> have a basic set of hooks (e.g., commit message validation,
> permissions checking, mail sending). Making our 100+ developers
> manually set up the hooks for each repository they clone is not an
> option.
>
> So what I have done is setup a template directory with hooks being
> a link to a pre-installed directory, where each hook is linked to a
> single script. This script then reads from a directory called
> hooks.d which is a drop directory for hooks. Each hook then has the
> format '<hook>.<order>.<name>' (e.g., 'post-receive.10.send_mail'),
> somewhat similar to /etc/rcX.d. It will also look in a .githooks.d
> directory in the working directory (this can be disabled with a
> config option). This is used by repository owners who want to add
> extra hooks for their repositories, e.g., to add automatic code
> indentation before commit, or unit testing. It is also possible
> to specify more hook directories with a multi-value config option,
> which the user can use if he/she likes to add some personal hooks.
> All hooks found in all drop directories are sorted by order before
> being executed so that it is possible to add local hooks before or
> after the global ones.
>
> This way it is possible to have system level hooks, repository
> specific hooks and user specific hooks all work together. And even
> though I now have a system which works for us, having something like
> this in the git core would be more efficient, and benefit more users.
>
> Here is what my solution explained above would look like if it was
> added to the git core.
>
> * The .git/hooks directory is replaced by .git/hooks.d (any hooks
> =C2=A0found in .git/hooks could be assumed to have an order of 50 for
> =C2=A0backwards compatibility).
> * If core.repositoryHooks (better name?) is true (default to false)
> =C2=A0then .githooks.d in the working directory is searched for hooks=
=2E
> * It is possible to specify more hook directories using the
> =C2=A0multi-value core.hookDirectory option (directories are relative=
 to
> =C2=A0the .git directory; absolute directories are of course also all=
owed).
>
> //Peter
>
>

To me this is another confirmation that not only --global but also
--system level config variable specifying hooks folder is necessary.
I mean company wide hooks (system) are combined with users global and
repo specific ones. Seems to be obvious.

Thanks,
Eugene
