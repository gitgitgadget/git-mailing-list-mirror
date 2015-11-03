From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: git.git as of tonight
Date: Tue, 3 Nov 2015 07:34:47 +0100
Message-ID: <56385587.1010601@kdbg.org>
References: <xmqqpoztf6ok.fsf@gitster.mtv.corp.google.com>
 <5637D266.4060904@kdbg.org>
 <CAGZ79kbx7UJOOkhiXiUJfUS25gMGx5BUq=Qxa9205H0Z78ijbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 07:39:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtVFE-0002qY-Tm
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 07:39:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754762AbbKCGev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 01:34:51 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:5051 "EHLO bsmtp4.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754133AbbKCGeu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 01:34:50 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp4.bon.at (Postfix) with ESMTPSA id 3nqhDR5fpPz5tl9;
	Tue,  3 Nov 2015 07:34:47 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 3D8DE538A;
	Tue,  3 Nov 2015 07:34:47 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <CAGZ79kbx7UJOOkhiXiUJfUS25gMGx5BUq=Qxa9205H0Z78ijbQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280750>

Am 03.11.2015 um 00:06 schrieb Stefan Beller:
> On Mon, Nov 2, 2015 at 1:15 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> run-command.c: In function 'set_nonblocking':
>> run-command.c:1011: error: 'F_GETFL' undeclared (first use in this function)
>> run-command.c:1011: error: (Each undeclared identifier is reported only once
>> run-command.c:1011: error: for each function it appears in.)
>> run-command.c:1015: error: 'F_SETFL' undeclared (first use in this function)
>> run-command.c:1015: error: 'O_NONBLOCK' undeclared (first use in this function)
>> make: *** [run-command.o] Error 1
>
> Going by a quick search http://stackoverflow.com/a/22756664
> I'd hope we only need to modify the set_nonblocking function using #ifdefs ?

Unfortunately, the solutions outlined in that post do not work for us. 
On Windows, the FIONBIO option is only available for sockets. 
"Overlapped IO" can be used only when the file descriptor is set in this 
mode right from the beginning (by open/CreateFile), and if it were so, 
it would have to be used in a totally different way than in Posix code.

My findings so far are negative. The only short-term and mid-term 
solution I see so far is to opt-out from the framework during build-time.

-- Hannes
