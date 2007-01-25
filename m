From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Hash name is SHA-1
Date: Thu, 25 Jan 2007 15:44:23 -0800
Message-ID: <7vr6ti659k.fsf@assigned-by-dhcp.cox.net>
References: <11697294071178-git-send-email-vonbrand@inf.utfsm.cl>
	<1169729410294-git-send-email-vonbrand@inf.utfsm.cl>
	<20070125230302.GB13677@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Matthias Lederhofer <matled@gmx.net>
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Fri Jan 26 00:44:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAEGb-0004va-ML
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 00:44:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965321AbXAYXo0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 18:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965579AbXAYXo0
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 18:44:26 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:44151 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965321AbXAYXoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 18:44:25 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070125234424.UTKK29122.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Thu, 25 Jan 2007 18:44:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id FbjT1W0011kojtg0000000; Thu, 25 Jan 2007 18:43:27 -0500
In-Reply-To: <20070125230302.GB13677@moooo.ath.cx> (Matthias Lederhofer's
	message of "Fri, 26 Jan 2007 00:03:02 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37781>

Matthias Lederhofer <matled@gmx.net> writes:

> The patch should probably only change sha1 to SHA-1 and not reformat
> the initialisation of _usage arrays or the comments (new line before
> first line of comment).  If the reformatting is desired it should be a
> separate patch imho.

I do agree the original patch conflates many different things,
and it would be nicer to do this clean-up as separate pieces.

* Code and comment reformatting.

  I agree that multi-line comment should begin with "/*\n",
  the comment sentences should begin with an indent and "* ",
  and the comment block should end with an indent and "*/\n".

  But this obviously belongs to a separate clean-up.

* The official name of these 40-hexdigit thingy we use to name
  objects is "object name" (see Documentation/glossary.txt).

  Taking an example from this hunk from 'update' hook
  documentation:

    @@ -30,12 +30,12 @@ and executable, it is called with three parameters:

            $GIT_DIR/hooks/update refname sha1-old sha1-new

    +The refname parameter is relative to $GIT_DIR; e.g. for the master
    +head this is "refs/heads/master".  The two sha1 are the object names
    +for the refname before and after the update.  Note that the hook is
    +called before the refname is updated, so either sha1-old is 0{40}
    +(meaning there is no such ref yet), or it should match what is
    +recorded in refname.

  I would prefer "the two object names are for the refname before...".

* Some commands take any object name, while some others only
  take committish.  For example, this hunk for show-branch:

    @@ -29,7 +29,7 @@ no <rev> nor <glob> is given on the command line.
     OPTIONS
     -------
     <rev>::
    -	Arbitrary extended SHA1 expression (see `git-rev-parse`)
    +	Arbitrary extended SHA-1 expression (see `git-rev-parse`)
            that typically names a branch HEAD or a tag.

     <glob>::

  is not Horst's fault but this needs to name a committish, so
  rephrasing it to "an arbitrary object name" is not even correct
  (let alone spellfixing SHA-1).

* The name of the hash function we currently happen to use, in
  order to come up with an "object name", is SHA-1 not SHA1.

  Currently we say sha1 and sha-1 interchangeably, but if we aim
  for consistency we should use the latter thoughout.  For example:

    @@ -59,7 +59,7 @@ OPTIONS
            one.

     --symbolic::
    -	Usually the object names are output in SHA1 form (with
    +	Usually the object names are output in SHA-1 form (with
            possible '{caret}' prefix); this option makes them output in a
            form as close to the original input as possible.

  is a good change.  But at the same time we might want to say
  just "are output as their hexadecimal values".
