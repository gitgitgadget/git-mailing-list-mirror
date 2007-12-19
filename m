From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] HP-UX does not have select.h
Date: Wed, 19 Dec 2007 13:31:58 -0800
Message-ID: <7vzlw6tlpt.fsf@gitster.siamese.dyndns.org>
References: <20071217192306.5da48540@pc09.procura.nl>
	<7v8x3t6nq1.fsf@gitster.siamese.dyndns.org> <4767934F.7070706@op5.se>
	<7vir2w1ghi.fsf@gitster.siamese.dyndns.org>
	<20071218114949.711ba447@pc09.procura.nl>
	<7vr6hiv4ny.fsf@gitster.siamese.dyndns.org>
	<20071219211226.41920430@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed Dec 19 22:32:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J56Ws-00071P-FV
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 22:32:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098AbXLSVcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 16:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753218AbXLSVcP
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 16:32:15 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46192 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042AbXLSVcP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 16:32:15 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 64B2E7DB3;
	Wed, 19 Dec 2007 16:32:07 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 802CA7DAC;
	Wed, 19 Dec 2007 16:32:03 -0500 (EST)
In-Reply-To: <20071219211226.41920430@pc09.procura.nl> (H. Merijn Brand's
	message of "Wed, 19 Dec 2007 21:12:26 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68940>

"H.Merijn Brand" <h.m.brand@xs4all.nl> writes:

> On Wed, 19 Dec 2007 11:57:21 -0800, Junio C Hamano <gitster@pobox.com> wrote:
>
>> "H.Merijn Brand" <h.m.brand@xs4all.nl> writes:
>> 
>> > On Tue, 18 Dec 2007 01:47:53 -0800, Junio C Hamano <gitster@pobox.com> wrote:
>> > ...
>> >> Merijn, discarding the earlier patch I did to configure it out for
>> >> HP-UX, does the following patch based on Andreas's idea work for you?
>> >
>> > Probably not:
>> >
>> > HP-UX 10.20, 11.00, 11.11, 11.23/PA, and 11.23/IPF all have:
>> >
>> > /usr/include 103 > grep -r POSIX_VERSION *
>> > sys/unistd.h:#    define _POSIX_VERSION _POSIX1_VERSION_88
>> > sys/unistd.h:#      define _POSIX_VERSION       _POSIX1_VERSION_90
>> > sys/unistd.h:#      define _POSIX_VERSION       _POSIX1_VERSION_93
>> > sys/unistd.h:#  define _SC_1_VERSION_88    7     /* _POSIX_VERSION: Date of POSIX.1-1988 */
>> > sys/unistd.h:#  define _SC_1_VERSION_90   102 /* _POSIX_VERSION: Date of POSIX.1-1990 */
>> > sys/unistd.h:#  define _SC_1_VERSION_93   103 /* _POSIX_VERSION: Date of POSIX.1b-1993 */
>> > sys/unistd.h:#  if (_POSIX_VERSION == _POSIX1_VERSION_88)
>> > sys/unistd.h:#    if (_POSIX_VERSION == _POSIX1_VERSION_90)
>> >
>> > and the two 11.23 do have select.h
>> 
>> Does that prove anything?  unistd.h seem to define _POSIX_VERSION to
>> various values but we do not see surrounding "#ifdef WE_DO_NOT_KNOW"
>> from the grep output above unfortunately.
>
> What I tried to demonstrate is that I have no clue about the actual value
> of this define, and if values like 88, 90, and 93 (7, 102, and 103)  do
> have any relation with the higher value of 200112L that you use.
>
> Also because these are the *only* _POSIX_VERSION defines in the entire
> include tree, and 11.23 does have a select.h, which makes the patch below
> to be not OK on 11.23. I'm not stating that HP follows the rules in any
> correct way, but if this is to be sure that select.h gets included if the
> OS supports it, it will fail.
>
>> If the folllowing actually works I think that is the cleanest fix for
>> this issue (note that I added defined(_POSIX_VERSION) there just to be
>> safe if it is not defined at all).

But your grep did not catch their definition of _POSIX1_VERSION_$YEAR
which are used to define the actual value of _POSIX_VERSION.
