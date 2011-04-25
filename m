From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/2] send-pack: avoid deadlock when pack-object dies early
Date: Mon, 25 Apr 2011 19:41:53 +0200
Message-ID: <4DB5B261.1080804@kdbg.org>
References: <20110331184243.GA12027@sigill.intra.peff.net> <201104142136.25778.j6t@kdbg.org> <20110414202110.GA6525@sigill.intra.peff.net> <201104142243.33522.j6t@kdbg.org> <20110414205113.GA7451@sigill.intra.peff.net> <7vsjtkfs10.fsf@alter.siamese.dyndns.org> <4DB48B2C.2090904@kdbg.org> <4DB48CCD.40304@kdbg.org> <20110425165007.GB1589@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 25 19:42:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEPnO-0008K3-CR
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 19:42:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758738Ab1DYRl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2011 13:41:56 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:52146 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758664Ab1DYRl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2011 13:41:56 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id E118713004E;
	Mon, 25 Apr 2011 19:41:53 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 8527519F340;
	Mon, 25 Apr 2011 19:41:53 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.14) Gecko/20110221 SUSE/3.1.8 Thunderbird/3.1.8
In-Reply-To: <20110425165007.GB1589@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172033>

Am 25.04.2011 18:50, schrieb Jeff King:
> On Sun, Apr 24, 2011 at 10:49:17PM +0200, Johannes Sixt wrote:
> 
>> diff --git a/builtin-send-pack.c b/builtin-send-pack.c
>> index 089058b..b371c79 100644
>> --- a/builtin-send-pack.c
>> +++ b/builtin-send-pack.c
>> @@ -376,6 +376,9 @@ static void print_helper_status(struct ref *ref)
>>  static int sideband_demux(int in, int out, void *data)
>>  {
>>  	int *fd = data;
>> +#ifndef ASYNC_AS_THREAD
>> +	close(fd[1]);
>> +#endif
> 
> In the comments for 1/2, you said this goes directly on 38a81b4e. But in
> that commit, we use #ifndef WIN32 to decide whether or not to fork for
> async code. So shouldn't this use the same test (I don't even see
> ASYNC_AS_THREAD defined anywhere else)?

Oops, you are right. I was looking at f6b60983, the one that the
two-patch series should be merged to; there, we remove ASYNC_AS_THREAD
and replace it by NO_PTHREADS. Therefore, I assumed that we use the
former symbol to decide whether to use threaded async procedures.
Obviously, the symbol was introduced only later. Will resend.

-- Hannes
