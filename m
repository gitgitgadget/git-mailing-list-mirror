From: Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>
Subject: Re: GIT get corrupted on lustre
Date: Tue, 22 Jan 2013 16:31:09 -0500
Message-ID: <50FF051D.5090804@giref.ulaval.ca>
References: <50D861EE.6020105@giref.ulaval.ca> <50D870A0.90205@interlinx.bc.ca> <50EC453A.2060306@giref.ulaval.ca> <50EDDF12.3080800@giref.ulaval.ca> <50F7F793.80507@giref.ulaval.ca> <CAGK7Mr4R=OwfWt4Kat75C8YDi3iLTavMLxeoLxkf1-gKhxrucg@mail.gmail.com> <50F8273E.5050803@giref.ulaval.ca> <871B6C10EBEFE342A772D1159D1320853A042AD7@umechphj.easf.csd.disa.mil> <50F829A9.7090606@calculquebec.ca> <871B6C10EBEFE342A772D1159D1320853A044B42@umechphj.easf.csd.disa.mil> <50F98B53.9080109@giref.ulaval.ca> <CABPQNSbJr4dR9mq+kCwGe-RKb9PA7q=SKzbFW+=md_PLzZh=nQ@mail.gmail.com> <87a9s2o6ri.fsf@pctrast.inf.ethz.ch> <kdk2ss$498$1@ger.gmane.org> <87r4lejpx8.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Brian J. Murrell" <brian@interlinx.bc.ca>, git@vger.kernel.org,
	kusmabite@gmail.com,
	"Pyeron, Jason J CTR (US)" <jason.j.pyeron.ctr@mail.mil>,
	Maxime Boissonneault <maxime.boissonneault@calculquebec.ca>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	=?ISO-8859-1?Q?S=E9bastien_Boisvert?= 
	<sebastien.boisvert@calculquebec.ca>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jan 22 22:31:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxlRU-0006Ir-Ci
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 22:31:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752827Ab3AVVbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 16:31:19 -0500
Received: from serveur.giref.ulaval.ca ([132.203.7.102]:52416 "EHLO
	mailhost.giref.ulaval.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267Ab3AVVbS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 16:31:18 -0500
Received: from localhost (localhost [127.0.0.1])
	by mailhost.giref.ulaval.ca (Postfix) with ESMTP id AC778101961;
	Tue, 22 Jan 2013 16:31:13 -0500 (EST)
X-Virus-Scanned: amavisd-new at giref.ulaval.ca
Received: from mailhost.giref.ulaval.ca ([127.0.0.1])
	by localhost (mailhost.giref.ulaval.ca [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pjiz6HBu8NBP; Tue, 22 Jan 2013 16:31:10 -0500 (EST)
Received: from [132.203.7.22] (melkor.giref.ulaval.ca [132.203.7.22])
	by mailhost.giref.ulaval.ca (Postfix) with ESMTP id F2C18101106;
	Tue, 22 Jan 2013 16:31:09 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130105 Thunderbird/17.0.2
In-Reply-To: <87r4lejpx8.fsf@pctrast.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214252>

So, hum, do we have some sort of conclusion?

Shall it be a fix for git to get around that lustre "behavior"?

If something can be done in git it would be great: it is a *lot* easier 
to change git than the lustre filesystem software for a cluster in 
running in production mode... (words from cluster team) :-/

I hope this subject will not die in the list... :-/

Thanks,

Eric



On 01/21/2013 02:29 PM, Thomas Rast wrote:
> Please don't drop the Cc list!
>
> "Brian J. Murrell" <brian@interlinx.bc.ca> writes:
>
>>> What's odd is that while I cannot reproduce the original problem, there
>>> seems to be another issue/bug with utime():
>>
>> I wonder if this is related to http://jira.whamcloud.com/browse/LU-305.
>>   That was reported as fixed in Lustre 2.0.0 and 2.1.0 but I thought I
>> saw it on 2.1.1 and added a comment to the above ticket about that.
>
> Aha, that's a very interesting bug report.  My observations support
> yours: I managed to get EINTR during utime().
>
>>> In the absence of it, wouldn't we in theory have to write a simple
>>> loop-on-EINTR wrapper for *all* syscalls?
>>
>> IIUC, that's what SA_RESTART is all about.
>
> Yes, but there's precious little clear language on when SA_RESTART is
> supposed to act.  In all cases?
>
> The wording on
>
>    http://www.delorie.com/gnu/docs/glibc/libc_485.html
>    http://www.delorie.com/gnu/docs/glibc/libc_498.html
>
> leads me to believe that SA_RESTART is actually used on the glibc side
> of things, so that any glibc syscall wrapper not specifically equipped
> with the restarting behavior would return EINTR unmodified.  This might
> explain why utime() doesn't restart like it should (assuming we work on
> the theory that POSIX doesn't allow an EINTR from utime() to begin
> with).
>
