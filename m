From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH/RFC 1/7] imap-send: use separate read and write
 fds
Date: Sat, 3 Oct 2009 11:44:50 -0700
Message-ID: <40aa078e0910031144r735a6fdq25efc1e57a1d4c33@mail.gmail.com>
References: <1254530385-2824-1-git-send-email-kusmabite@gmail.com> <20091003094049.GA17873@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sat Oct 03 20:45:08 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vw0-f159.google.com ([209.85.212.159])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mu9bP-0004LD-SK
	for gcvm-msysgit@m.gmane.org; Sat, 03 Oct 2009 20:45:08 +0200
Received: by vws31 with SMTP id 31so3569356vws.21
        for <gcvm-msysgit@m.gmane.org>; Sat, 03 Oct 2009 11:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=bvSf/a19SDj1hUemkO2RrQKK1XUNGhb4pgJcVpwfqFA=;
        b=k6miiaowgAY+xCX+dCpJUFHG75khjOJ2UiSGD+LKwv5k26hGjHtpFcEE5shpjfOQBK
         AooBaohMLnYUA0DOE5u6C/HkUq5485crGUpYNl+fTWt7HkjmOg299BTP4AEPBCUubeyE
         RQ5dyMTlOV9UmDZZjiYkwD9LK2gYFCh9IACsk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:mime-version:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=36mUFrmIpa7DGDMgTidq/GVey8MlMWREuXtbhHsEJZlsdkKcxfDf0ZbKhdNEzzz2TA
         Gj41VcmNg1BBxpZiq/DPy45HmDTg0fznS5+CopHwcfzyL4UPKkdgcOcQXa1nlts65teA
         CFnKzZF6pKUV58a8X3dkkadpZ5hV7pNJFnl2M=
Received: by 10.220.110.148 with SMTP id n20mr853741vcp.1.1254595500752;
        Sat, 03 Oct 2009 11:45:00 -0700 (PDT)
Received: by 10.176.58.28 with SMTP id g28gr7241yqa.0;
	Sat, 03 Oct 2009 11:44:54 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.204.19.131 with SMTP id a3mr110263bkb.3.1254595492273; Sat, 03 Oct 2009 11:44:52 -0700 (PDT)
Received: by 10.204.19.131 with SMTP id a3mr110262bkb.3.1254595492216; Sat, 03 Oct 2009 11:44:52 -0700 (PDT)
Received: from mail-bw0-f209.google.com (mail-bw0-f209.google.com [209.85.218.209]) by gmr-mx.google.com with ESMTP id 15si378545bwz.2.2009.10.03.11.44.51; Sat, 03 Oct 2009 11:44:51 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.218.209 as permitted sender) client-ip=209.85.218.209;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 209.85.218.209 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by bwz5 with SMTP id 5so1655152bwz.3 for <msysgit@googlegroups.com>; Sat, 03 Oct 2009 11:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:mime-version:received:in-reply-to:references :date:message-id:subject:from:to:cc:content-type; bh=VwaVWQyzcxoMhL5rHOYTDeFwMQAMfdVanyTIsFdLepk=; b=RWxKYPvtJ8UqKxcMp4iZYzHiBGcbHl89k5HfesVcjBsRt7xIkB+EtjjCh3bH+krQ6/ e+miftTL7FRgIpa5dZYk5YTX5BE5ogXfUHUaGwfwwW/YGdvrMG6LgqNLx1cnYKqEx9jN 7XoAP3uWZXMoNEGPoOs7OptfMwVsa5HUnuoM0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=mime-version:in-reply-to:references:date:message-id:subject:from:to :cc:content-type; b=XX0xE7M612gSLTzGIksUB7dC7Yf3zIaJzJrthUbYl6c/0Iq3ErStFj3hk32hFQlHT3 FiPdeuJYEg0K1p4cfeoeXFCRoA5qYQHRBMPM1ay13KkEX6eIBKzQme7RWWvpyU7N1VE/ UtvykXn+8yo8GF7vi50dtSyjoDoV78IYj1sEg=
Received: by 10.204.11.18 with SMTP id r18mr2394469bkr.15.1254595490833; Sat,  03 Oct 2009 11:44:50 -0700 (PDT)
In-Reply-To: <20091003094049.GA17873@coredump.intra.peff.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129493>


On Sat, Oct 3, 2009 at 2:40 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Oct 03, 2009 at 12:39:39AM +0000, Erik Faye-Lund wrote:
>
>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
>
> Why? Given its presence in this series, I can only assume it has to do
> with windows portability, but it would be helpful to give a little bit
> of the reasoning in the commit message.
>
> -Peff
>

Yeah, this is about Windows portability.

I'll add something like "This is a patch that enables us to use the
run-command API, which is supported on Windows." to the commit-message
in the next round. Is that enough?

I also guess I should have made a cover letter for this series, making
it apparent to reviewers that:
- This patch series is about supporting imap-send on Windows
- It needs some additional patching to get tunnelling support working
on Windows, because we can't exec "/bin/sh" there. Changing it to
"c:\\msysgit\\bin\\sh.exe" makes tunneling work for me, but isn't
exactly portable across installations.

I'll write one up for the next round.

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
