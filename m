From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: use decode_utf8 directly
Date: Fri, 27 Apr 2007 02:07:58 -0700
Message-ID: <7v1wi6p4lt.fsf@assigned-by-dhcp.cox.net>
References: <200704241705.19661.ismail@pardus.org.tr>
	<200704271155.24304.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ismail =?utf-8?Q?D=C3=B6nmez?= <ismail@pardus.org.tr>
X-From: git-owner@vger.kernel.org Fri Apr 27 11:08:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhMQy-0001mr-In
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 11:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755502AbXD0JIE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 27 Apr 2007 05:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755503AbXD0JIE
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 05:08:04 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:58378 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755502AbXD0JIA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Apr 2007 05:08:00 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070427090759.MKZD1268.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Fri, 27 Apr 2007 05:07:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id s97y1W00F1kojtg0000000; Fri, 27 Apr 2007 05:07:59 -0400
In-Reply-To: <200704271155.24304.ismail@pardus.org.tr> (Ismail =?utf-8?Q?D?=
 =?utf-8?Q?=C3=B6nmez's?=
	message of "Fri, 27 Apr 2007 11:55:16 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45707>

Ismail D=C3=B6nmez <ismail@pardus.org.tr> writes:

>> I Google'd a bit but the relevant information seems to be missing ab=
out
>> this error. Anyhow there is no need for a wrapper at all as Encode c=
lass
>> has a decode_utf8 function which fixes the problem I am experiencing=
 too
>> and chops off the unneeded wrapper.
>>
>> Patch against git 1.5.1.2 is attached. Comments welcome.
>>
>> P.S: I am using Encode 2.20 from CPAN which is the latest stable ver=
sion
>> available.
>
> Ping? This patch should be harmless and it fixes a real error, can it=
 be=20
> applied please?

I cannot tell if it is harmless.  The original used

	decode("utf8", $str, Encode::FB_DEFAULT);

and you made them to:

	decode_utf8($str);

According to the documentation, decode_utf8($octets [,CHECK])
should be equivalent to decode("utf8", $octets [,CHECK]), and
the documentation further says that without CHECK, these
functions assume Encode::FB_DEFAULT; in other words, these two
should be equivalent.

Which means that there is something else going on.  Your change
may fix what you observed (I do not doubt that it fixed what you
observed for you), but without understanding what really is
going on (iow, why it is a fix, when the documentation clearly
indicates they should be equivalent and it should not fix
anything), we cannot tell what *ELSE* we are breaking with this
change.
