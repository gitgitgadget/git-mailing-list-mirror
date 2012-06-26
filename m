From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH] t9010: Open backflow FIFO once to work around kernel
	race condition
Date: Wed, 27 Jun 2012 01:08:44 +0200
Message-ID: <4FEA40FC.2080604@gmail.com>
References: <1340749806-22734-1-git-send-email-andersk@mit.edu>
	<20120626224053.GA7155@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: David Barr <david.barr@cordelta.com>,
	"bug-autoconf@gnu.org" <bug-autoconf@gnu.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Anders Kaseorg <andersk@MIT.EDU>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: bug-autoconf-bounces+gnu-bug-autoconf=m.gmane.org@gnu.org Wed Jun 27 01:08:57 2012
Return-path: <bug-autoconf-bounces+gnu-bug-autoconf=m.gmane.org@gnu.org>
Envelope-to: gnu-bug-autoconf@m.gmane.org
Received: from lists.gnu.org ([208.118.235.17])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <bug-autoconf-bounces+gnu-bug-autoconf=m.gmane.org@gnu.org>)
	id 1SjesS-0002O3-UC
	for gnu-bug-autoconf@m.gmane.org; Wed, 27 Jun 2012 01:08:57 +0200
Received: from localhost ([::1]:45415 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bug-autoconf-bounces+gnu-bug-autoconf=m.gmane.org@gnu.org>)
	id 1SjesS-00010k-RO
	for gnu-bug-autoconf@m.gmane.org; Tue, 26 Jun 2012 19:08:56 -0400
Received: from eggs.gnu.org ([208.118.235.92]:50731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefano.lattarini@gmail.com>) id 1SjesO-000106-Sk
	for bug-autoconf@gnu.org; Tue, 26 Jun 2012 19:08:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefano.lattarini@gmail.com>) id 1SjesN-0006DV-8W
	for bug-autoconf@gnu.org; Tue, 26 Jun 2012 19:08:52 -0400
Received: from mail-bk0-f41.google.com ([209.85.214.41]:34510)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefano.lattarini@gmail.com>) id 1SjesM-0006Cv-Vu
	for bug-autoconf@gnu.org; Tue, 26 Jun 2012 19:08:51 -0400
Received: by bkcjm19 with SMTP id jm19so548333bkc.0
	for <bug-autoconf@gnu.org>; Tue, 26 Jun 2012 16:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding;
	bh=T14l3GDXESz41GI09dXFNTxvHLXs/R7B6Sv+Sbq3hwk=;
	b=FJP+OnqQufp9HXh/HTRidz8t1tbv3A+c3Mw27BsBwVvZCfYyC08U3XsmSCg+j5v4/m
	XaM+l/BKFgv38ms98GvG2MmL6vdtyBFbq156ZrHQu6bMUEts3ZijFzuDV2R1t0pqhyAP
	WwF/peQ4wWrk6d3dbp2LJtI03DtiXPpuDSpx+rSZJ51az+/IF8xvJX/sdTz0m4zTybSU
	bwlsfEpgUZ7nqqhUj7+T+iOrkcpJIi5lv1tlyqJmiXcBYqNW6k/3qQmsbAt4qpLw07fs
	yjpqlWIpk/w5dR1ClPuDQGL4iqJuzH/6rKcD1ES6AhiHrm8UoufEbCEn4EuTbZIjM82k
	qvtw==
Received: by 10.204.141.18 with SMTP id k18mr6224334bku.27.1340752128896;
	Tue, 26 Jun 2012 16:08:48 -0700 (PDT)
Received: from [95.244.95.150]
	(host150-95-dynamic.244-95-r.retail.telecomitalia.it.
	[95.244.95.150])
	by mx.google.com with ESMTPS id n17sm52527468bkw.5.2012.06.26.16.08.46
	(version=SSLv3 cipher=OTHER); Tue, 26 Jun 2012 16:08:47 -0700 (PDT)
In-Reply-To: <20120626224053.GA7155@burratino>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 209.85.214.41
X-BeenThere: bug-autoconf@gnu.org
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Bug reports for autoconf <bug-autoconf.gnu.org>
List-Unsubscribe: <https://lists.gnu.org/mailman/options/bug-autoconf>,
	<mailto:bug-autoconf-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/bug-autoconf>
List-Post: <mailto:bug-autoconf@gnu.org>
List-Help: <mailto:bug-autoconf-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/bug-autoconf>,
	<mailto:bug-autoconf-request@gnu.org?subject=subscribe>
Errors-To: bug-autoconf-bounces+gnu-bug-autoconf=m.gmane.org@gnu.org
Sender: bug-autoconf-bounces+gnu-bug-autoconf=m.gmane.org@gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200701>

[Adding bug-autoconf]

On 06/27/2012 12:40 AM, Jonathan Nieder wrote:
> Hi,
> 
> Quick first impressions:
> 
> Anders Kaseorg wrote:
> 
>> Sidestep this problem by opening the backflow FIFO once for
>> read+write.
> 
> Is that portable?
>
According to the Autoconf manual, no:

    Some shells, like ash, don't recognize bi-directional redirection (‘<>’).
    And even on shells that recognize it, it is not portable to use on fifos:
    Posix does not require read-write support for named pipes, and Cygwin
    does not support it:

       $ mkfifo fifo
       $ exec 5<>fifo
       $ echo hi >&5
       bash: echo: write error: Communication error on send

But while the issue about Cygwin might still be relevant, the one about
ash seems to be out-of-date: I've verified that the "exec 5<>fifo"
command works with both dash 0.5.2 and dash 0.5.5.1 (that's why I'm
CC:ing bug-autoconf).

Regards,
  Stefano
