From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: use decode_utf8 directly
Date: Tue, 01 May 2007 14:39:34 -0700
Message-ID: <7v8xc85ill.fsf@assigned-by-dhcp.cox.net>
References: <200704241705.19661.ismail@pardus.org.tr>
	<200704271223.03468.ismail@pardus.org.tr>
	<7vhcr1obuo.fsf@assigned-by-dhcp.cox.net>
	<200705020012.13302.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Ismail =?utf-8?Q?D=C3=B6nmez?= <ismail@pardus.org.tr>
X-From: git-owner@vger.kernel.org Tue May 01 23:39:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hj04S-00083N-Qg
	for gcvg-git@gmane.org; Tue, 01 May 2007 23:39:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423615AbXEAVjh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 1 May 2007 17:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423691AbXEAVjh
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 17:39:37 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:39222 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423615AbXEAVjg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 May 2007 17:39:36 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070501213936.KJFE13903.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Tue, 1 May 2007 17:39:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id txfb1W0061kojtg0000000; Tue, 01 May 2007 17:39:35 -0400
In-Reply-To: <200705020012.13302.ismail@pardus.org.tr> (Ismail =?utf-8?Q?D?=
 =?utf-8?Q?=C3=B6nmez's?=
	message of "Wed, 2 May 2007 00:12:13 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45979>

Ismail D=C3=B6nmez <ismail@pardus.org.tr> writes:

> Ok found out the reason. decode() tries to decode data that is alread=
y UTF-8=20
> and borks.
>
> This is from Encode.pm :
>
> sub decode_utf8($;$) {
>     my ( $str, $check ) =3D @_;
>     return $str if is_utf8($str); <--- Checks if the $str is already =
UTF-8
>     if ($check) {
>         return decode( "utf8", $str, $check ); <--- Else do what gitw=
eb does
>     [...]
>
> So my patch is indeed correct.

Ok, I think that makes it an improvement from the current code,
so I'd apply.

But at the same time I wonder why should the callers be feeding
an already decoded string to to_utf8().  It might be that some
callers needs fixing.
