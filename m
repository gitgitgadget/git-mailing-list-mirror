From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [Fundamental problem with relative system paths] [PATCH 2/2] run-command (Windows): Run dashless "git <cmd>"
Date: Tue, 29 Jul 2008 07:15:41 +0200
Message-ID: <766FEC61-619E-4A13-A21B-0734D83074C5@zib.de>
References: <1217224228-31303-1-git-send-email-prohaska@zib.de> <1217224228-31303-2-git-send-email-prohaska@zib.de> <1217277453.488e2e0db0f41@webmail.nextra.at>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Tue Jul 29 07:16:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNhZj-0003Uj-S6
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 07:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbYG2FPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 01:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751902AbYG2FPn
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 01:15:43 -0400
Received: from mailer.zib.de ([130.73.108.11]:36933 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751875AbYG2FPn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 01:15:43 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6T5FKKk027057;
	Tue, 29 Jul 2008 07:15:26 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db9068d.pool.einsundeins.de [77.185.6.141])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6T5FJtk024921
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 29 Jul 2008 07:15:19 +0200 (MEST)
In-Reply-To: <1217277453.488e2e0db0f41@webmail.nextra.at>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90567>


On Jul 28, 2008, at 10:37 PM, Johannes Sixt wrote:

> Zitat von Steffen Prohaska <prohaska@zib.de>:
>
>> This might solve a fundamental problem we have with the
>> computation of system directories based on relative paths
>> in combination with the new gitexecpath 'libexec/git-core'.
>> The problem is that the program 'git' is hardlinked to
>> directories with different depth.  It is either used as
>> 'bin/git' (1 directory) or as 'libexec/git-core/git-*'
>> (2 directories).  Thus, using the same relative path
>> in system_path() yields different results when starting from the
>> two locations.  I recognized the problem because /etc/gitconfig
>> is no longer be read.
>>
>> The patch below might fix the problem by always calling 'bin/git'
>> for builtin commands.  The computation in system_path() would
>> always start from 'bin' and thus yields predictable results.  I
>> am not sure however if it fully solves the problem because other
>> code paths might run the dashed forms directly.
>
> This paragraph should go into the commit message.

I'll send an updated patch including a commit message defending
the change more offensively.


>> I think the only way to verify correctness would be to stop
>> installing the dashed forms for builtins.  If they were not
>> installed they could not be called.  The only entry point for all
>> builtins would be 'bin/git'.  I don't think we want to stop
>> installing the dashed forms right away.
>>
>> So what shall we do?
>
> Your patches make a lot of sense.

Unfortunately, I am sure that they do not solve the problem fully, even
if we removed the dashed forms completely.  I'll send a second patch  
that
modifies the Makefile to stop installing the BUILT_INS.  It might be
useful for debugging.

	Steffen
