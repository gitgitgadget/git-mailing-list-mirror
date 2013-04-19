From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: t6200: avoid path mangling issue on Windows
Date: Fri, 19 Apr 2013 07:48:06 +0200
Message-ID: <5170DA96.9000300@viscovery.net>
References: <1365348344-1648-1-git-send-email-ralf.thielow@gmail.com> <1365348344-1648-2-git-send-email-ralf.thielow@gmail.com> <516F95D1.5070209@viscovery.net> <7v38un93br.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 07:48:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UT4BL-0000Fn-Bu
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 07:48:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752775Ab3DSFsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 01:48:19 -0400
Received: from so.liwest.at ([212.33.55.23]:55541 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752625Ab3DSFsS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 01:48:18 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UT4B5-000433-OJ; Fri, 19 Apr 2013 07:48:08 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 50CFD1660F;
	Fri, 19 Apr 2013 07:48:07 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <7v38un93br.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221739>

Am 4/18/2013 19:05, schrieb Junio C Hamano:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> From: Johannes Sixt <j6t@kdbg.org>
>>
>> MSYS bash interprets the slash in the argument core.commentchar="/"
>> as root directory and mangles it into a Windows style path. Use a
>> different core.commentchar to dodge the issue.
>>
>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>> ...
>> -	git -c core.commentchar="/" fmt-merge-msg --log=5 <.git/FETCH_HEAD >actual &&
>> +	git -c core.commentchar="x" fmt-merge-msg --log=5 <.git/FETCH_HEAD >actual &&
> 
> Sigh... Again?
> 
> Are folks working on Msys bash aware that sometimes the users may
> want to say key=value on their command line without the value
> getting molested in any way and giving them some escape hatch would
> help them?  Perhaps they have already decided that it is not
> feasible after thinking about the issue, in which case I do not have
> new ideas to offer.

What is "the issue"? And in which way would an escape hatch help us here?
We would have to apply a patch anyway after a glitch like this shows up,
because disabling path mangling whole-sale (if there were a method --
there is none currently) is a no-go in the context of our test suite, let
a lone in our scripted tool set.

When "foo=/" appears on the command line, the most obvious interpretation
of the slash for a program without mind-reading mode is that it is an
absolute path, and then path mangling must happen (if and only if the
invoked program is a non-MSYS program such as git).

> I'll apply the patch as-is, but this feels really painful to the
> users.

No, generally, path mangling is a service for the user.

-- Hannes
