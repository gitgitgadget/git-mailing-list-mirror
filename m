From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCH] git-send-email: add ~/.authinfo parsing
Date: Wed, 06 Feb 2013 10:58:13 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87sj59mo2y.fsf@lifelogs.com>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
	<7vvcafojf4.fsf@alter.siamese.dyndns.org>
	<20130130074306.GA17868@sigill.intra.peff.net>
	<7v6226pdb7.fsf@alter.siamese.dyndns.org>
	<vpqa9rhaml6.fsf@grenoble-inp.fr> <876225o5mj.fsf@lifelogs.com>
	<vpqmwvhxyuj.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michal Nazarewicz <mpn@google.com>, git@vger.kernel.org,
	Krzysztof Mazur <krzysiek@podlesie.net>,
	Michal Nazarewicz <mina86@mina86.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 06 16:58:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U37OV-0004wG-OJ
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 16:58:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757557Ab3BFP6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 10:58:18 -0500
Received: from z.lifelogs.com ([173.255.230.239]:45807 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757517Ab3BFP6P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 10:58:15 -0500
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id ACA69DE0E3;
	Wed,  6 Feb 2013 15:58:14 +0000 (UTC)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
In-Reply-To: <vpqmwvhxyuj.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Wed, 06 Feb 2013 16:10:12 +0100")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215594>

On Wed, 06 Feb 2013 16:10:12 +0100 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote: 

MM> Ted Zlatanov <tzz@lifelogs.com> writes:
MM> [...] so the way to go for send-email is probably to libify the
MM> credential support in git-remote-mediawiki, and to use it in send-email.
>> 
>> I looked and that's indeed very useful.  If it's put in a library, I'd
>> use credential_read() and credential_write() in my netrc credential
>> helper.  But I would formalize it a little more about the token names
>> and output,

MM> Can you elaborate on this? The idea of the Perl code was to mimick a
MM> call to the C API, keeping essentially the same names.

None of these are a big deal, and Michal said he's working on libifying
this anyhow:

- making 'fill' a special operation is weird
- anchor the key regex to beginning of line (not strictly necessary)
- sort the output tokens (after 'url' is extracted) so the output is consistent and testable

>> and I wouldn't necessarily die() on error. 

MM> Sure, die()ing in a library is bad.

>> Maybe this can be merged with the netrc credential helper's
>> read_credential_data_from_stdin() and print_credential_data()?

MM> I don't know about the netrc credential helper, but I guess that's
MM> another layer. The git-remote-mediawiki code is the code to call the
MM> credential C API, that in turn may (or may not) call a credential
MM> helper.

Yup.  But what you call "read" and "write" are, to the credential
helper, "write" and "read" but it's the same protocol :)  So maybe the
names should be changed to reflect that, e.g. "query" and "response."

MM> One thing to be careful about: git-remote-mediawiki is currently a
MM> standalone script, so it can be installed with a plain "cp
MM> git-remote-mediawiki $somewhere/".  One consequence of libification
MM> is that it adds a dependency on the library (e.g. Git.pm). We should
MM> be carefull to keep it easy for the user to install it (e.g. some
MM> kind of "make install", or update the doc).

I don't know--it's up to the `git-remote-mediawiki' maintainers...  But
I think anywhere you have Git, you also have Git.pm, right?  Maybe?  But
then you also have to look at whether Git.pm has the functionality you
need... so I better go quiet :)

Ted
