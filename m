From: Adam Piatyszek <ediap@users.sourceforge.net>
Subject: Re: [PATCH] git-send-email.perl: check for lines longer than 998
 characters
Date: Sun, 20 Jan 2008 23:35:14 +0100
Message-ID: <4793CCA2.4060407@users.sourceforge.net>
References: <20080117153252.GD2816@coredump.intra.peff.net>	<1200642458-3280-1-git-send-email-ediap@users.sourceforge.net>	<47905F70.5090003@viscovery.net>	<4790746D.1000502@users.sourceforge.net>	<47907914.6000105@viscovery.net>	<7v1w8fh2ef.fsf@gitster.siamese.dyndns.org>	<20080118141638.GA14928@coredump.intra.peff.net> <7v8x2mdf7e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 23:46:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGiw9-0003gh-Hu
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 23:46:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755944AbYATWqB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jan 2008 17:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755907AbYATWqB
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 17:46:01 -0500
Received: from pisces.et.put.poznan.pl ([150.254.29.122]:53223 "EHLO
	pisces.et.put.poznan.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755906AbYATWqA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 17:46:00 -0500
Received: from hydrus.et.put.poznan.pl (hydrus.et.put.poznan.pl [150.254.11.145])
	by pisces.et.put.poznan.pl (8.13.8/8.13.8) with ESMTP id m0KMaBgf029882;
	Sun, 20 Jan 2008 23:36:13 +0100 (CET)
	(envelope-from ediap@users.sourceforge.net)
Received: from [192.168.1.3] (etf189.neoplus.adsl.tpnet.pl [83.20.151.189])
	by hydrus.et.put.poznan.pl (8.11.7p1+Sun/8.11.6) with ESMTP id m0KMZI922860;
	Sun, 20 Jan 2008 23:35:19 +0100 (MET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071116)
In-Reply-To: <7v8x2mdf7e.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
OpenPGP: id=1F115CCB
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.313940, Antispam-Data: 2008.1.9.11357
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71199>

Hi,

> Jeff King <peff@peff.net> writes:
>> I think that is sensible. Patch series will follow:
>>
>>   1/3: send-email: detect invocation errors earlier
>>
>>        This is a code cleanup in preparation for 2/3, but has
>>        user-friendly side effects.
>>
>>   2/3: send-email: validate patches before sending anything
>>
>>        The actual up front long-lines check.
>=20
> I wonder what the performance implication of this approach would
> be, though.  I am tempted to say that it would be negligible --
> scanning text in Perl is fast enough.
>=20
>>   3/3: send-email: add no-validate option
>>
>>        A knob for users who know something send-email doesn't.
>>
>> That at least detects the situation and lets the user deal with it (=
by
>> fixing the patch, or by sending it as an attachment with another MUA=
).

Thanks Peff for your patches. I was about to implement your first two,=20
but it would take me much more time to do it in a sane way. ;-)

So:

Acked-by: Adam Pi=C4=85tyszek <ediap@users.sourceforge.net>

* Junio C Hamano [18 I 2008 21:57]:
> I suspect that taking this "Safe against SMTP line length limit"
> topic all the way ("all the way" is post 1.5.4, I am inclined to
> agree that this may be a good fix to an existing bug) would
> require that git-format-patch --attach to learn to apply QP on
> patch text to avoid producing very long lines to root-cause the
> issue [*1*].

I support this idea. "git-format-patch --attach" is a good place to=20
implement such an additional encoding. Of course, git-mailinfo needs to=
=20
be extended with a decoding method as well.

> [Footnote]
>=20
> *1* It's actually second-to-root-cause it, because the real root
> cause is for the source tree to have such an insanely long line.

I can not fully agree with this statement. You should have in mind that=
=20
git is by the definition a "stupid content tracker" and should not=20
assume any particular kind of data being processed.
=46or instance, the reported problem with git-send-email was discovered=
=20
when I tried to send a patch with some reference data of an unformatted=
=20
standard output of a test program.

BR,
/Adam

--=20
=2E:.  Adam Piatyszek (ediap)  .:.....................................:=
=2E
=2E:.  ediap@users.sourceforge.net  .:................................:=
=2E
