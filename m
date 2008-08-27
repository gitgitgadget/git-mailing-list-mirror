From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-shortlog hangs on bare repo without --bare option
Date: Wed, 27 Aug 2008 15:41:26 -0700
Message-ID: <7vod3em67d.fsf@gitster.siamese.dyndns.org>
References: <20080827195233.GA2477@garry-thinkpad.arpnetworks.com>
 <48B5C9E4.4030807@lsrfire.ath.cx> <7vvdxmm78o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Garry Dolley <gdolley@arpnetworks.com>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Aug 28 00:42:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYTiq-000372-Ku
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 00:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755976AbYH0Wlf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Aug 2008 18:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755973AbYH0Wlf
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 18:41:35 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44306 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439AbYH0Wle convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Aug 2008 18:41:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2F7D16485F;
	Wed, 27 Aug 2008 18:41:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 69A0B6485E; Wed, 27 Aug 2008 18:41:29 -0400 (EDT)
In-Reply-To: <7vvdxmm78o.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 27 Aug 2008 15:19:03 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4C621A14-7489-11DD-A957-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93974>

Junio C Hamano <gitster@pobox.com> writes:

> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>
>> Garry Dolley schrieb:
>>> I didn't see this happen with git 1.5.x, but if you do git-shortlog=
 on a bare=20
>>> repo, without specifying --bare, the command will seemingly hang in=
definitely.
>>
>> FWIW, I tried git 1.5.0 and it hangs, too.  Which exact version did =
work
>> for you?  Could you, based on it, bisect the commit that introduced =
this
>> behaviour?
>>
>> As a workaround, you can use "git log | git shortlog".
>
> It is not a workaround.  Shortlog can work as a filter to "git log", =
but
> if you give revs to work on, e.g. "git shortlog -s -n v1.5.6.5.." or =
"git
> shortlog HEAD", it can generate the log and feed to itself.
>
> Somehow it (perhaps incorrectly, I did not look at the command line i=
nput)
> judging that your command line is telling it not to do the log genera=
tion
> itself but instead you will feed the log from its standard input, whi=
ch
> happens to be your terminal.  So another workaround would be to type =
the
> series of log messages ;-)

And I think this is related to the complexity that snuck in when worktr=
ee
feature was added to the setup sequence.

Untested, but I think this would help.

 setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git c/setup.c w/setup.c
index 6cf9094..296f712 100644
--- c/setup.c
+++ w/setup.c
@@ -461,7 +461,7 @@ const char *setup_git_directory_gently(int *nongit_=
ok)
 			inside_git_dir =3D 1;
 			if (!work_tree_env)
 				inside_work_tree =3D 0;
-			setenv(GIT_DIR_ENVIRONMENT, ".", 1);
+			set_git_dir(".");
 			check_repository_format_gently(nongit_ok);
 			return NULL;
 		}
