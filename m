From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Supplant the "while case ... break ;; esac" idiom
Date: Mon, 24 Sep 2007 09:24:53 -0700
Message-ID: <7vbqbsav56.fsf@gitster.siamese.dyndns.org>
References: <853ax5mb1j.fsf@lola.goethe.zz> <85myvdktb3.fsf@lola.goethe.zz>
	<20070924060521.GB10975@glandium.org> <85k5qgk295.fsf@lola.goethe.zz>
	<ee77f5c20709232330n7b47d9e9v38677678dbf197da@mail.gmail.com>
	<86ejgowl5g.fsf@lola.quinscape.zz>
	<20070924080134.GA9112@artemis.corp>
	<20070924080436.GB9112@artemis.corp>
	<Pine.LNX.4.64.0709241128460.28395@racer.site>
	<87ps08s3zt.fsf@catnip.gol.com>
	<20070924113556.GI8111@void.codelabs.ru>
	<87k5qgrxcu.fsf@catnip.gol.com>
	<Pine.LNX.4.64.0709241502330.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miles Bader <miles@gnu.org>,
	Eygene Ryabinkin <rea-git@codelabs.ru>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 24 18:26:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZql9-0004t0-3z
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 18:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758762AbXIXQZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 12:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760427AbXIXQZG
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 12:25:06 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:52396 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758891AbXIXQZE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 12:25:04 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 933C013B2E9;
	Mon, 24 Sep 2007 12:25:17 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0709241502330.28395@racer.site> (Johannes
	Schindelin's message of "Mon, 24 Sep 2007 15:04:32 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59058>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 24 Sep 2007, Miles Bader wrote:
>> ...
>> In practice that's not an issue though -- every reasonable shell has 
>> test as a builtin these days, so the "works when test is not a builtin" 
>> criteria is really important only for robustness.
>
> AAAAAAAAAAAAAARRRRRGGGHHHHHHHHHHHH!
>
> _Exactly_ the same reasoning can be said about the old code: _every_ 
> reasonable shell can grok the code that used to be there!
>
> <rhetoric-question>
> 	So what exactly was your point again?
> </rhetoric-question>

The points are:

 (1) The code used to be there is known to cause trouble with a
     deployed shell on FreeBSD of some vintage.  It may be true
     that the shell is broken, but it does not matter much to
     the end user on such systems if breakage is in shell or in
     scripts --- the end result is that the user cannot benefit
     from git, and we already happen to know the workaround,
     which does not make the scripts less readable nor less
     portable;

 (2) It's not like people who work on git scripts share the
     exact same style and tradition.  While I do not personally
     think there is much readability improvements between the
     old code and the new code, if more people find the latter
     easier to work with, it's better to switch to the new code
     especially because there is no downside.

     (2-a) Nobody finds the latter less readable nor impossible
           to work with.  Even I am not saying that; I only said
           I do not think it improves.

     (2-b) git is not an educational project. It can be done
           elsewhere in a UNIX history class, not here, to teach
           people that "case ... esac" used to be much more
           preferred over "test" because often the latter was
           not built-in and slower.

Regarding "$# != 0" vs "$# -ne 0", I agree with the patch by
David.  If the variable were "$something_else", then it might
have been better to use the explicitly numeric form, but I think
any seasoned shell people is much more used to see $# and $? (or
$status after an earlier "status=$?") compared with numeric
string with "=" or "!=".
