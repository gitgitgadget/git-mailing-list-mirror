From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH/RFC 1/7] imap-send: use separate read and write
 fds
Date: Sat, 3 Oct 2009 23:34:15 +0200
Message-ID: <200910032334.16757.j6t@kdbg.org>
References: <1254530385-2824-1-git-send-email-kusmabite@gmail.com> <20091003094049.GA17873@coredump.intra.peff.net> <40aa078e0910031144r735a6fdq25efc1e57a1d4c33@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, Jeff King <peff@peff.net>, git@vger.kernel.org
To: "Erik Faye-Lund" <kusmabite@googlemail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sat Oct 03 23:34:34 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f161.google.com ([209.85.211.161])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuCFN-0003Hp-Qe
	for gcvm-msysgit@m.gmane.org; Sat, 03 Oct 2009 23:34:33 +0200
Received: by ywh33 with SMTP id 33so1578451ywh.24
        for <gcvm-msysgit@m.gmane.org>; Sat, 03 Oct 2009 14:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:from:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=7UNz8IZuVMnm6sEsr/zTlTE4K/GRbKXHy/YC5U9fbWE=;
        b=vEpmqZAqpdaZCdgL3lcy1QfvcnHL/S0UYxtJ7bVoQ+JB3DJ465bIYjbP2vbl75gPY6
         LogQe5c2JgrRBuD3CjSHFHAwFoRuxmwVB/K9QhS9gg5/qmNleSLQ2w1SNBYk+Go7uppZ
         AjOUhBjnSF3D9zj7g/xrXKSnSJDP3pp9KriN0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        b=1esjiZtWL9RCVGXQQKwIpaW6VPQ8PGmauqhHhcvaCe/p7kFYuJQhlAKBKxfXYw12/s
         YyRtRxm68n46BnULzcLn2NTjr70TB+HqvArTISQhH3xs030EXc0/xbiQvb3Nbwe0s9LY
         CyCSxVg1UbMT6phchOyGFw9oWv8TXD3OMWkNA=
Received: by 10.100.230.3 with SMTP id c3mr497389anh.23.1254605666761;
        Sat, 03 Oct 2009 14:34:26 -0700 (PDT)
Received: by 10.176.149.32 with SMTP id w32gr7248yqd.0;
	Sat, 03 Oct 2009 14:34:13 -0700 (PDT)
X-Sender: j6t@kdbg.org
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.146.33 with SMTP id y33mr635155ebn.6.1254605651246; Sat, 03 Oct 2009 14:34:11 -0700 (PDT)
Received: by 10.211.146.33 with SMTP id y33mr635154ebn.6.1254605651230; Sat, 03 Oct 2009 14:34:11 -0700 (PDT)
Received: from dx.sixt.local ([93.83.142.38]) by gmr-mx.google.com with ESMTP id 14si592696ewy.1.2009.10.03.14.34.10; Sat, 03 Oct 2009 14:34:11 -0700 (PDT)
Received-SPF: neutral (google.com: 93.83.142.38 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=93.83.142.38;
Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 93.83.142.38 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) smtp.mail=j6t@kdbg.org
Received: from localhost (localhost [127.0.0.1]) by dx.sixt.local (Postfix) with ESMTP id 0C63519F5FD; Sat,  3 Oct 2009 23:34:17 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <40aa078e0910031144r735a6fdq25efc1e57a1d4c33@mail.gmail.com>
Content-Disposition: inline
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129506>


On Samstag, 3. Oktober 2009, Erik Faye-Lund wrote:
> - It needs some additional patching to get tunnelling support working
> on Windows, because we can't exec "/bin/sh" there. Changing it to
> "c:\\msysgit\\bin\\sh.exe" makes tunneling work for me, but isn't
> exactly portable across installations.

It should be fine to just exec "sh" (without a path).

-- Hannes
