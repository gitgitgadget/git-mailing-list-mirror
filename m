From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] branch: make --set-upstream saner without an explicit
 starting point
Date: Thu, 05 Jul 2012 10:44:58 -0700
Message-ID: <7vtxxmqezp.fsf@alter.siamese.dyndns.org>
References: <1341480589-1890-1-git-send-email-cmn@elego.de>
 <7vd34arvhu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Jul 05 19:45:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Smq7G-0007Ox-QX
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jul 2012 19:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756696Ab2GERpF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 13:45:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39354 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756580Ab2GERpB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 13:45:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74BBA9293;
	Thu,  5 Jul 2012 13:45:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z5KyjUjKpfjqZmYYShZSkfStSHM=; b=ux7Xib
	2v6rBOlgylLOmXcc4ewLKZWdZiMVgEkiHzLS1chLsX40gurh44oCXxK1f6ghC/VY
	dba+V+sR0Zdezu7tYDz8wv9NoZhIb+Z3x0oxLaIJpHW/5io4fvT3gVfXWrA89DuS
	JiEqMOZmUMzKq0HFBttlF8zOpLQYUDQ6xDB88=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OtO/Yu7kMcAHEP/53eDKeJdM14CT0LjC
	GjLUU8rBivK8bw0BIZUPE7d6z8aSXKIEMW/0wtFXgaMHQD0QhUW7pdIEnGNrR+/3
	yYG51hd4Rw+H4O3otYcuC4OHH+NCaUEoeEm7GiMT1M7mi7FVf8DdSCvYRA+O4o+t
	BmpfunhKs74=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C14A9292;
	Thu,  5 Jul 2012 13:45:00 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D342B9291; Thu,  5 Jul 2012
 13:44:59 -0400 (EDT)
In-Reply-To: <7vd34arvhu.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 05 Jul 2012 10:03:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 245EF640-C6C9-11E1-8D1C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201056>

Junio C Hamano <gitster@pobox.com> writes:

> I think it was a mistake that nobody noticed that it is likely that
> the operation most often will be done for the current branch and the
> usual "give me one branch name to operate on, or I'll operate on the
> current branch" command line convention of "git branch" commannd is
> not a good fit for it, when "set upstream" feature was added, and
> suggested an alternative syntax that avoids the mistake you quoted
> above, perhaps something like:
>
> 	git branch --set-upstream-to=origin/master [HEAD]
>
> which would have been very clear whose upstream is set to what (with
> or without the name of the other branch).  In other words, make the
> name "origin/master" *NOT* the first branch name on the command line
> in the usual sense, but a parameter to the --set-upstream option, so
> that "give me one branch name to operate on, or I'll operate on the
> current branch" convention is still kept.
> 
> You also broke people who corrected another kind of mistake in this
> workflow:
> ...
> Coming from the above observation, while I am sympathetic to your
> cause and agree that we would want to do something about it, I am
> having a hard time to convince myself that your patch is the best
> way to go.
>
> I am not entirely happy with the hypothetical "set-upstream-to"
> myself, either.

Thinking about it a bit more, I am starting to think that something
based on the "set upstream to" could be a sane way forward:

 * add "git branch [--set-upstream-to=<name>]" that does what your
   patch does.  The synopsis must make it clear that <name> is not
   the usual first <name> like other "branch" command line arguments
   that specify the branch being operated on, but is an argument to
   the --set-upstream option [*1*].

 * when "git branch --set-upstream <name>" without <start point>
   is given, you first see if <name> exists and find out the
   upstream of <name>, do what the user told you to do (i.e. reset
   the upstream of the <name>d branch to the current branch), and
   give hints to recover.  Two possibilities:

     $ git checkout frotz
     $ git branch --set-upstream xyzzy
     Branch xyzzy set up to track local branch frotz.
     If you wanted to make frotz track xyzzy, do this:
       $ git branch --set-upstream xyzzy <original>
       $ git branch --set-upstream-to xyzzy

     $ git checkout frotz
     $ git branch --set-upstream origin/xyzzy
     Branch origin/xyzzy set up to track local branch frotz.
     If you wanted to make frotz track xyzzy, do this:
       $ git branch -d origin/xyzzy
       $ git branch --set-upstream-to origin/xyzzy

 * possibly, deprecate --set-upstream as a historical wart that had
   misdesigned UI, and when it is used, give deprecation warning and
   nudge the user to use --set-upstream-to instead.


[Footnote]

*1* The parseopt parser will allow both of:

    $ git branch --set-upstream-to=origin/master
    $ git branch --set-upstream-to origin/master

    but the braket around the option name "--set-upstream-to" and
    its argument <name> should make it clear, i.e.

	git branch [--set-upstream-to <name>] [<branch>]

    or

    	git branch [--set-upstream-to=<name>] [<branch>]
