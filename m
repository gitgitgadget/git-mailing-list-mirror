From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Prevent buffer overflows when path is too big
Date: Mon, 21 Oct 2013 21:02:21 +0200
Message-ID: <52657A3D.8090609@kdbg.org>
References: <CABPQNSaqjKPGAQ4EKBSk+bQP2WMksc6M0YQxSkB91UrnFF28xQ@mail.gmail.com> <1382179954-5169-1-git-send-email-apelisse@gmail.com> <52636E5A.1080909@web.de> <CACsJy8AXV=KJtTWxp6dpfa_Pr81h3YwW5EK=c_dV=F7tr7ChWQ@mail.gmail.com> <CALWbr2z1RmLLNa3Cj+n6g=zu5FB4VZSmRTU1qYb86pXLfYGJGg@mail.gmail.com> <CACsJy8BQ=qzXbMT9OSeQ+aDjLe5ogkUMZzdUhK0ObJP+VHkYvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>, 
 Git Mailing List <git@vger.kernel.org>,
 Wataru Noguchi <wnoguchi.0727@gmail.com>, 
 Erik Faye-Lund <kusmabite@gmail.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, =?ISO-8859-1?Q?Ren=E9_?=
 =?ISO-8859-1?Q?Scharfe?= <l.s.r@web.de>, 
 msysGit <msysgit@googlegroups.com>
To: Duy Nguyen <pclouds@gmail.com>, Antoine Pelisse <apelisse@gmail.com>
X-From: msysgit+bncBCJYV6HBKQIL55EVSMCRUBAXZDXVK@googlegroups.com Mon Oct 21 21:02:24 2013
Return-path: <msysgit+bncBCJYV6HBKQIL55EVSMCRUBAXZDXVK@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f59.google.com ([74.125.82.59])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQIL55EVSMCRUBAXZDXVK@googlegroups.com>)
	id 1VYKkB-0004yL-NF
	for gcvm-msysgit@m.gmane.org; Mon, 21 Oct 2013 21:02:23 +0200
Received: by mail-wg0-f59.google.com with SMTP id z12sf746589wgg.4
        for <gcvm-msysgit@m.gmane.org>; Mon, 21 Oct 2013 12:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=6sJX2eKEyc32EhMyZS8Cik5nY8KONt+m9jbXnnlWkPE=;
        b=RPLIuVRMaZ4sLMNjhz6TKRLYoXGOgGEBv0qf6XNt4gXpeiTAS5wGkdH2uP59v7Nb5C
         99HxnY2EyiXC4xEeQK6p8eU6VjcxaqR+VjDf0vgNRwn6QiprHfszjvCGb1b6JQvHZxS8
         39YPpJYnPKuQXqa7/fTypiL+NK41Xut3XWPSCAAGdn9SeSCXj69gj22STlu05cUUXMQD
         qHkjovgUSydf/c7q4eHwkWNOH3mgzzpW7e2NpoV6oGT7zlZgAr56s7pHvLI6GhQc639c
         5ov2Q9j7+ecdStubEoUBbz87eYcSe0DvqbGM2PYQIS8Fwbwg7/I2RiJixYjhH2Rg3hLx
         /ndA==
X-Received: by 10.180.108.100 with SMTP id hj4mr150436wib.9.1382382143415;
        Mon, 21 Oct 2013 12:02:23 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.92.197 with SMTP id co5ls566862wib.16.gmail; Mon, 21 Oct
 2013 12:02:22 -0700 (PDT)
X-Received: by 10.180.212.76 with SMTP id ni12mr5638566wic.1.1382382142624;
        Mon, 21 Oct 2013 12:02:22 -0700 (PDT)
Received: from bsmtp.bon.at (bsmtp5.bon.at. [195.3.86.187])
        by gmr-mx.google.com with ESMTP id cd45si3234641eeb.0.2013.10.21.12.02.22
        for <msysgit@googlegroups.com>;
        Mon, 21 Oct 2013 12:02:22 -0700 (PDT)
Received-SPF: neutral (google.com: 195.3.86.187 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=195.3.86.187;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id F1BDE130047;
	Mon, 21 Oct 2013 21:02:21 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 6A67F19F5CF;
	Mon, 21 Oct 2013 21:02:21 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <CACsJy8BQ=qzXbMT9OSeQ+aDjLe5ogkUMZzdUhK0ObJP+VHkYvQ@mail.gmail.com>
X-Original-Sender: j6t@kdbg.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 195.3.86.187 is neither permitted nor denied by best guess
 record for domain of j6t@kdbg.org) smtp.mail=j6t@kdbg.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236444>

Am 21.10.2013 03:31, schrieb Duy Nguyen:
> On Mon, Oct 21, 2013 at 12:57 AM, Antoine Pelisse <apelisse@gmail.com> wrote:
>> My main motive was to not *stop* the process when a long path is met.
>> Because somebody created a repository on Linux with a long file-name
>> doesn't mean you should not be able to clone it *at all* on Windows.
> 
> That should be handled at the Windows compatibility layer if Windows
> cannot handle long paths as Linux

Naah... PATH_MAX is a silly, arbitrary limit. The Git data model does
not forbid paths longer than PATH_MAX, be it 4096 or 260. A generic
solution is needed.

> (or maybe at higher level to skip
> checking out those paths).

More like this, yeah.

-- Hannes

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
