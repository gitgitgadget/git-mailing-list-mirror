From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH v6] safecrlf: Add mechanism to warn about irreversible crlf conversions
Date: Sun, 3 Feb 2008 15:36:22 +0100
Message-ID: <4C024D67-9FA5-451D-BB91-CE9464C6F50D@zib.de>
References: <12019685081997-git-send-email-prohaska@zib.de> <7vbq6yuxeh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 15:36:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLfxg-0000ib-JK
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 15:36:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755152AbYBCOgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 09:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760409AbYBCOgJ
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 09:36:09 -0500
Received: from mailer.zib.de ([130.73.108.11]:34104 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754377AbYBCOgI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 09:36:08 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m13EZN9t020267;
	Sun, 3 Feb 2008 15:35:50 +0100 (CET)
Received: from [192.168.178.21] (brln-4db90104.pool.einsundeins.de [77.185.1.4])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m13EZMCS020175
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 3 Feb 2008 15:35:23 +0100 (MET)
In-Reply-To: <7vbq6yuxeh.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72357>


On Feb 3, 2008, at 11:50 AM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> CRLF conversion bears a slight chance of corrupting data.
>> ...
>> thing to do, while for binary file it corrupts data.
>
> The above 25-line or so are well written and deserve to be in
> the end user documentation somewhere, I think, to explain why it
> is a good idea to have these warnings to them..

For now, I propose to add it to the documentation of
core.safecrlf.  In the future a section on cross-platform
projects in the user manual would probably be the right place.
But the manual does not yet have such a section.


>> This commit modifies git apply to fail even if safecrlf=warn,
>> because git apply writes its changes back to the work tree
>> immediately.  The user would not have a chance to backup the old
>> version of the file if only a warning was printed.
>
> I do not get this logic at all.
>
> The whole point of git-apply is to apply the patch.  If you say
> --whitespace=fix and some contents (say one of the testsuite
> files in our t/ directory) needed to keep trailing newline, you
> obviously are left with a broken result, and you would recover
> by checking it out from index or HEAD and reapply.  Why
> shouldn't the same principle hold here?

You are right.  All files should be committed before running
git apply and therefore the original files can be recovered by
git checkout.  Hmm ... so apply should either just warn or be
completely quiet as git blame is?  I think it should warn.

	Steffen
