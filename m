From: David Kastrup <dak@gnu.org>
Subject: Re: [Untested! proposal] git-mergetool.sh: introduce ediff option
Date: Mon, 30 Jul 2007 01:30:20 +0200
Message-ID: <853az6vldf.fsf@lola.goethe.zz>
References: <7vy7idydqa.fsf@assigned-by-dhcp.pobox.com>
	<7v7ipsz7vr.fsf@assigned-by-dhcp.pobox.com>
	<7vk5tj3bj1.fsf@assigned-by-dhcp.cox.net>
	<7vzm20q1l7.fsf_-_@assigned-by-dhcp.cox.net>
	<7vvec4synj.fsf_-_@assigned-by-dhcp.cox.net>
	<85zm1g3nze.fsf@lola.goethe.zz> <85bqdw27mb.fsf@lola.goethe.zz>
	<20070729031612.GB17204@thunk.org>
	<Pine.LNX.4.64.0707291224460.14781@racer.site>
	<85hcnnwblu.fsf@lola.goethe.zz> <20070729205232.GA10148@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Jul 30 01:30:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFIDy-0003Ym-EO
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 01:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936312AbXG2Xa4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 19:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935237AbXG2Xaz
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 19:30:55 -0400
Received: from mail-in-15.arcor-online.net ([151.189.21.55]:55597 "EHLO
	mail-in-15.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934124AbXG2Xay (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jul 2007 19:30:54 -0400
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mail-in-15.arcor-online.net (Postfix) with ESMTP id 5D9A945A6F;
	Mon, 30 Jul 2007 01:30:53 +0200 (CEST)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net [151.189.21.46])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id 4A6FE12BE98;
	Mon, 30 Jul 2007 01:30:53 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-017-015.pools.arcor-ip.net [84.61.17.15])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 2020A35E5AD;
	Mon, 30 Jul 2007 01:30:53 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id D13461C39595; Mon, 30 Jul 2007 01:30:20 +0200 (CEST)
In-Reply-To: <20070729205232.GA10148@thunk.org> (Theodore Tso's message of "Sun\, 29 Jul 2007 16\:52\:32 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3810/Mon Jul 30 00:00:03 2007 on mail-in-06.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54160>

Theodore Tso <tytso@mit.edu> writes:

> On Sun, Jul 29, 2007 at 03:51:34PM +0200, David Kastrup wrote:
>
> For the past two decades, I have EDITOR set to emacs, but I am not
> an ediff fan.  Yes, that's anecdotal evidence, but so are your
> assertions.

Ok.

>> In ediff mode, success or failure of the merge will be discerned by
>> Emacs either having written or not written the merge buffer; no
>> attempt of interpreting the exit code is made.
>
> Sometimes resolving the merge file results in no changes.  So the fact
> that ediff is buggy in that it doesn't return an exit code is a real
> problem.

Ediff starts out with a changed buffer when merging files.
git-mergetool can check for modification times (which is done on
several backends), so it can catch whether or not the ediff buffer has
been saved.

> We could possibly work around the problem saving and then checking
> the modtime --- but only if ediff actually ends up rewriting the
> file.

See above.

>> In order to bypass things like desktop files being loaded, emerge
>> mode now passes the "-q" option to Emacs.  This will make it work
>> in more situations likely to occur, at the price of excluding
>> possibly harmless user customizations with the rest.
>
> But that screws over users who want their customizations, but who
> don't use the desktop package.  (And I have a news flash for you;
> the desktop package is *not* include as part of emacs21.  It's not
> part of Debian's emacs21 package, version 21.4.)  So do not believe
> your claim that emacs's desktop package is commonly used.

Sigh.

$ dpkg -L emacs21-el|grep desktop
/usr/share/emacs/21.4/lisp/desktop.el

>> +	ediff)
>> +	    case "${EDITOR:-${VISUAL:-emacs}}" in
>> +		*/emacs*|*/gnuclient*|*/xemacs*)
>> +		    emacs_candidate="${EDITOR:-${VISUAL:-emacs}}";;
>> +		*)
>> +		    emacs_candidate=emacs;;
>> +	    esac
>> +	    if base_present ; then
>> +		${emacs_candidate} --eval "(ediff-merge-files-with-ancestor (pop command-line-args-left) (pop command-line-args-left) (pop command-line-args-left) nil (pop-command-line-args-left))" "$LOCAL" "$REMOTE" "$BASE" "$path"
>
> ... and this will blow up if EMACS is set to emacsclient, and emacs
> version is 21.

I am currently working on ironing this out.  It is easy to check
whether emacsclient supports --eval and revert to emacs in that case.
Unfortunately, it turns out that the above also blows up with
emacsclient 22.1 (I hope to get some patches into Emacs so that this
will actually work in 22.2).  So I am currently reworking this, and it
is indeed fragile stuff and quite a nuisance to get right.

> (And BTW, Debian stable and the current Ubuntu, Edgy Eft, are still
> shipping emacs21.  So are a number of current major distro's.  So if
> you think the vast majority of users are using emacs22, you are
> either on drugs, and have a very skewed view of what are "normal"
> emacs users.)

The current Ubuntu happens to be Feisty Fawn, and it includes
emacs-snapshot-gtk (among other options) with a workable emacsclient.
But I certainly will not ask for including a solution that would not
produce the best feasible results for all of emacs21, emacs22, and
xemacs-21.x.  As I said, the patch was just provided as material for
discussion and does not yet work.

> There is a reason why git-mergetool currently hardcodes the use of
> "emacs", instead of just blindly using the value of $EDITOR or
> $VISUAL.

Which is not really nice to XEmacs users, by the way.

> So what you're doing here in your patch is completely busted.  If
> you insist on using emacs_candidate, we need to run emacs --version
> and parse the output, and only using the value of EMACS or VISUAL if
> the major version number of emacs is at least 22.

It is actually more straightforward to check the exit code of
emacsclient --eval t >/dev/null 2>&1
which is basically what I do now.  Even if one wanted to parse the
output of --version, emacsclient --version would be faster.

> (It would probably be a good idea to do this once and cache the
> result, so we don't have to repeatedly for each file that git
> mergetool needs to process.)

My current version of the patch already does this.  However, the
startup/exit behavior is still somewhat broken though marginally
usable (getting both ediff started and the resulting buffer registered
as a server buffer without messing up ediff's window setup is the
challenge), so I am still ironing stuff out.

>> -    if echo "${VISUAL:-$EDITOR}" | grep 'emacs' > /dev/null 2>&1; then
>> -        merge_tool_candidates="$merge_tool_candidates emerge"
>> -    fi
>> +    case "${EDITOR:-${VISUAL}}" in
>> +	*/emacs*|*/gnuclient*|*/xemacs*)
>> +            merge_tool_candidates="$merge_tool_candidates ediff"
>> +    esac
>
> Changing the default from emerge to ediff is a non-starter, sorry.
> If you really want to use ediff, you can set a config parameter to
> explicitly request it.

How would you feel about preferring ediff when EDITOR is emacsclient
or gnuclient, and emerge otherwise?

Of course only once ediff will work satisfactorily with all Emacs and
XEmacs variants out there.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
