From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* git diff/log --check exitcode and PAGER environment variable
Date: Fri, 08 Aug 2008 13:40:02 -0700
Message-ID: <7vsktfb5r1.fsf@gitster.siamese.dyndns.org>
References: <489C145B.5090400@sneakemail.com>
 <7vfxpfet8a.fsf@gitster.siamese.dyndns.org>
 <7v1w0zersg.fsf_-_@gitster.siamese.dyndns.org>
 <489C27DD.90603@sneakemail.com>
 <alpine.DEB.1.00.0808081315060.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Peter_Valdemar_M=C3=B8rch_=28Lists=29?= 
	<4ux6as402@sneakemail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 08 22:41:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRYlv-0001Su-Qv
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 22:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753033AbYHHUkN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Aug 2008 16:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752210AbYHHUkM
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 16:40:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36340 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbYHHUkL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Aug 2008 16:40:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0E5984EED1;
	Fri,  8 Aug 2008 16:40:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4F6414EECE; Fri,  8 Aug 2008 16:40:06 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0808081315060.9611@pacific.mpi-cbg.de.mpi-cbg.de> (Johannes
 Schindelin's message of "Fri, 8 Aug 2008 13:23:03 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 317261EA-658A-11DD-855F-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91710>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 8 Aug 2008, "Peter Valdemar M=C3=B8rch (Lists)" wrote:
>
>> I don't want to be a troll... But in my original post, I write that =
git=20
>> log exits with 0 even when there are --check failures *and* --no-pag=
er=20
>> is used.
>
> You seem to care enough.  That is good.  Because I will give you a fe=
w=20
> pointers to help yourself, and you can in return help us by submittin=
g a=20
> patch:
>
> - the code to be changed lives in log-tree.c.  Look for calls to the=20
>   function log_tree_diff_flush().  You need to check the exit status
>   after that (needs to be done only when DIFF_OPT_TST(opt->diffopt,=20
>   EXIT_WITH_STATUS).
>
> - you can get at the exit status with the call=20
>   diff_result_code(opt->diffopt, 0) (see the implementation in diff.c=
 to=20
>   find out what the 0 means, and why it is correct).
>
> - you need to accumulate the exit status (plural, with a long u) over=
 all=20
>   calls to log_tree_diff(), best thing would be to add a member to th=
e
>   log_info struct.
>
> - you need to test rev->loginfo->exit_code in the end, and return fai=
lure=20
>   if it is non-zero.  I think the place is in cmd_log_walk().
>
> Bon chance,
> Dscho

Dscho, thanks for a nice writeup.

And sorry, Peter, for being dense earlier.

I somehow thought you were talking about "diff" but you are right; "log=
"
has been solely used for "_view_ log with various format of diffs" and
nobody wanted it to pay attention to individual diff's exit status so f=
ar
(I am not saying "everybody wanted it not to pay attention to it" -- it
was just nobody felt the need for log to report the diff exit status).
