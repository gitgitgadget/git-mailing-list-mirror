From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] Teach git-add--interactive to accept a file path to patch
Date: Thu, 22 Nov 2007 11:29:46 -0800
Message-ID: <7vsl2y3wph.fsf@gitster.siamese.dyndns.org>
References: <1195648601-21736-1-git-send-email-win@wincent.com>
	<1195648601-21736-2-git-send-email-win@wincent.com>
	<1195648601-21736-3-git-send-email-win@wincent.com>
	<20071121152118.GG24108@sigill.intra.peff.net>
	<7vejejfi28.fsf@gitster.siamese.dyndns.org>
	<C6E820C8-91E9-48B2-9219-377CA83163A7@wincent.com>
	<7vk5obb09a.fsf@gitster.siamese.dyndns.org>
	<20071122091356.GD7153@sigill.intra.peff.net>
	<7v8x4q7gns.fsf@gitster.siamese.dyndns.org>
	<887C3CB1-D21B-4143-8D4E-BF37709FA102@wincent.com>
	<7vlk8q5xj4.fsf@gitster.siamese.dyndns.org>
	<FDAFAD8C-8FF5-4DD7-AC5E-BA39790281A4@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 20:30:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvHkZ-0007TU-Ef
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 20:30:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752404AbXKVT3y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Nov 2007 14:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752334AbXKVT3y
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 14:29:54 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:37633 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbXKVT3x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Nov 2007 14:29:53 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 51D322EF;
	Thu, 22 Nov 2007 14:30:14 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id C7E5798948;
	Thu, 22 Nov 2007 14:30:10 -0500 (EST)
In-Reply-To: <FDAFAD8C-8FF5-4DD7-AC5E-BA39790281A4@wincent.com> (Wincent
	Colaiuta's message of "Thu, 22 Nov 2007 14:34:14 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65839>

Wincent Colaiuta <win@wincent.com> writes:

> El 22/11/2007, a las 12:29, Junio C Hamano escribi=C3=B3:
>
>> By the way, the arguments on the command line to git commands
>> after "--" are generally pathspecs, iow, patterns to specify
>> groups of files.  Please do not introduce unnecessary
>> inconsistencies to the UI by requiring them to be exact pathname
>> only in this particular mode of the command and nowhere else.
>
> Well, I it wasn't my intention to introduce any such requirement. The
> path parameters get passed in and eventually handed over unmodified t=
o:
>
> 	git diff-files -p --

What I was referring to was this in your original:

>> +	my @tracked =3D grep {
>> +		defined run_cmd_pipe(qw(git ls-files
>> +			                --exclude-standard --), $_)
>> +	} @ARGV;

It picks elements from @ARGV that ls-files says "Ok" back, not
the expanded result from ls-files, and @tracked elements are
used later as filenames.  Which means you are expecting @ARGV to
contain only concrete filenames, not pathspec.

> Or if we add some kind of "--patch" switch, instead do:
>
> 	git add -i --patch foo

You do not need both "-i" and "--patch", do you?  Plain git-add
does not take --patch anyway so it can pass --patch to the
underlying interactive one.
