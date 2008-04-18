From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUGS] test failure in t4014-format-patch.sh with master
Date: Fri, 18 Apr 2008 11:30:48 -0700
Message-ID: <7vskxjj9rb.fsf@gitster.siamese.dyndns.org>
References: <87od88eslq.dlv@maison.homelinux.org>
 <alpine.LFD.1.00.0804170806430.2879@woody.linux-foundation.org>
 <6b8a91420804170844t2776e8a7sf735e3f87a95298b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: =?utf-8?Q?R=C3=A9mi_Vanicat?= <vanicat@debian.org>
X-From: git-owner@vger.kernel.org Sat Apr 19 11:04:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmvNH-000618-G4
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 20:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760100AbYDRSbG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Apr 2008 14:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759883AbYDRSbE
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Apr 2008 14:31:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52143 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759730AbYDRSbD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Apr 2008 14:31:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F3BD03219;
	Fri, 18 Apr 2008 14:31:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 220C73218; Fri, 18 Apr 2008 14:30:56 -0400 (EDT)
In-Reply-To: <6b8a91420804170844t2776e8a7sf735e3f87a95298b@mail.gmail.com>
 (=?utf-8?Q?R=C3=A9mi?= Vanicat's message of "Thu, 17 Apr 2008 17:44:05
 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79877>

"R=C3=A9mi Vanicat" <vanicat@debian.org> writes:

> 2008/4/17, Linus Torvalds <torvalds@linux-foundation.org>:
>>
>>  On Thu, 17 Apr 2008, Remi Vanicat wrote:
> [...]
>>  > $ ./t4014-format-patch.sh
>>  > [....]
>>  > * FAIL 8: replay did not screw up the log message
>>
>>  Hmm. Doesn't fail for me.
>
> [...]
>
>>  I wonder if it is some shell-specific variable expansion issue. Wha=
t's
>>  your /bin/sh? (I assume, from your email address, that you're using
>>  Debian, and I thought Debian used bash, but maybe that's not true).
>
> Debian used bash, but I use dash as /bin/sh
>
>>  What does
>>
>>         a=3D"hello\nhi"
>>         echo $a
>>
>>  result in?

So perhaps this one is the troublemaker?

 git-am.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 646dc45..5b20bbd 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -330,7 +330,7 @@ do
 		SUBJECT=3D"$(sed -n '/^Subject/ s/Subject: //p' "$dotest/info")"
 		case "$keep_subject" in -k)  SUBJECT=3D"[PATCH] $SUBJECT" ;; esac
=20
-		(echo "$SUBJECT" ; echo ; cat "$dotest/msg") |
+		(printf '%s\n' "$SUBJECT" ; echo ; cat "$dotest/msg") |
 			git stripspace > "$dotest/msg-clean"
 		;;
 	esac
