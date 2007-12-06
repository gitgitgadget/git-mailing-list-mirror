From: Sergei Organov <osv@javad.com>
Subject: Re: git help error
Date: Thu, 06 Dec 2007 21:36:01 +0300
Message-ID: <87k5nr7jse.fsf@osv.gnss.ru>
References: <cc723f590712040826o7ca36bfg35b8cb4d64ee8d2d@mail.gmail.com>
	<7v1wa25oqc.fsf@gitster.siamese.dyndns.org>
	<874pey9uow.fsf@osv.gnss.ru>
	<7vr6i245b4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Aneesh Kumar" <aneesh.kumar@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 19:37:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0LbU-0007ff-GJ
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 19:37:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161AbXLFSgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 13:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754686AbXLFSgx
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 13:36:53 -0500
Received: from javad.com ([216.122.176.236]:4992 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752113AbXLFSgw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 13:36:52 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lB6Ia7U11660;
	Thu, 6 Dec 2007 18:36:07 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1J0LZp-0000sG-Pm; Thu, 06 Dec 2007 21:36:01 +0300
In-Reply-To: <7vr6i245b4.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Tue\, 04 Dec 2007 11\:40\:15 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67316>

Junio C Hamano <gitster@pobox.com> writes:

> Sergei Organov <osv@javad.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>> "Aneesh Kumar" <aneesh.kumar@gmail.com> writes:
>>>
>>>> git help gives me the below error.
>>>>
>>>> [master@git]$ git help add
>>>> No manual entry for git-add
>>>> See 'man 7 undocumented' for help when manual pages are not available.
>>>> [master@git]$
>>>>
>>>> I have the git binaries installed via --prefix
>>>>
>>>> ./configure --prefix=/home/kvaneesh/bin-local/git/
>>>> and to see the man page i have to say
>>>>
>>>> man -M /home/kvaneesh/bin-local/git/share/man/
>>> ...
>>> When you run "man" from the command line, can you say
>>>
>>>      $ man git-add
>>>
>>> and make it work?  If it fails the same way, then what you are missing
>>> is MANPATH environment variable, isn't it?
>>
>> I think what the OP asked for makes sense. git-help should better find
>> corresponding version of manual pages automatically. This way, if one
>> invokes different versions of git-help, he will get corresponding
>> version of help text.
>
> I do not necessarily agree.  Read what Aneesh wrote originally again,
> and read what he _didn't_ write.
>
> Not only he needs to run his "man" with -M (and my point was that it is
> not the only way, by the way), he needs to futz with his $PATH to
> include $HOME/bin-local/git for _his_ installation to work.

My point is that he doesn't need to tweak his $PATH, because he can
simply say:

$ ~/bin-local/git/bin/git help add

Then, I'd expect that the manual page that is installed along with the
version that

$ ~/bin-local/git/bin/git --version

reports is displayed, not any random version of git-add manual page
found using default 'man' rules.

> I think my suggestion to use $MANPATH is in line with what he is already
> doing.  If you install things in non-standard places, you can use
> environments to adjust to what you did, and that's the reason PATH and
> MANPATH environments are supported by your tools.

Yes, but provided you have more than one version of git installed, it's
inconvenient to tweak both PATH and MANPATH to use one or another. It
would be more convenient and consistent if

$ ~/git.old/bin/git help add
$ ~/git.new/bin/git help add

were render different versions of git-add manual page, each
corresponding to the right version of git.

> Having said that, I do not mind accepting a patch that prepends the
> nonlocal path to MANPATH in help.c::show_man_page().

OK, patch will follow shortly.

-- 
Sergei.
