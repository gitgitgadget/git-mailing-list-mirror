From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH v3 3/8] imap-send: use run-command API for 
 tunneling
Date: Fri, 16 Oct 2009 16:27:33 +0200
Message-ID: <40aa078e0910160727g2ebc1e6qe0c3a00186e38569@mail.gmail.com>
References: <1255461925-2244-1-git-send-email-kusmabite@gmail.com> <200910132159.11616.j6t@kdbg.org> <40aa078e0910131327q682c7044x854fec4de60b0c43@mail.gmail.com> <200910142158.59073.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Fri Oct 16 16:27:51 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-px0-f152.google.com ([209.85.216.152])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MynmY-000127-D4
	for gcvm-msysgit@m.gmane.org; Fri, 16 Oct 2009 16:27:50 +0200
Received: by mail-px0-f152.google.com with SMTP id 16so346824pxi.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 16 Oct 2009 07:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=wdu2bCBvhB/1Wie6TVmUnudB6bQ2TM3zgCd5dUffSEo=;
        b=SAWfyg3HYyFFotMJYR85QFzYiNk4BV5G1+NtbKPoTZ1HFbDOwf+u0Ot3MWzCpPmYB2
         A6amFu57oUfuTtkgB1XAH4oDzBkrhi45uEKavzbJUTI1J5rwzoPZkVbeUjD3Q1x6hTJt
         JlH//CwMqS5auDgRpD3NtdVlNBy7zamo5+4SM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:mime-version:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        b=vTV54fWz1A5ExaYptGeJEdpa64g2pieuOUczfg0prN52D4znsmA2r5NYpdeOFD4BFK
         59jevJbs3aYkJefQ6zGlsZKgkXwCXmfG8Utw0t8fbYHamHbyRz8IzsnG/RsavabEOFoS
         wrgLLN81xqb73UViULx+2EQ7umaaUGZ6m4jhg=
Received: by 10.142.4.4 with SMTP id 4mr37348wfd.40.1255703263542;
        Fri, 16 Oct 2009 07:27:43 -0700 (PDT)
Received: by 10.176.233.14 with SMTP id f14gr7432yqh.0;
	Fri, 16 Oct 2009 07:27:36 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.86.232.35 with SMTP id e35mr47007fgh.27.1255703254870; Fri, 16 Oct 2009 07:27:34 -0700 (PDT)
Received: by 10.86.232.35 with SMTP id e35mr47006fgh.27.1255703254852; Fri, 16 Oct 2009 07:27:34 -0700 (PDT)
Received: from mail-fx0-f221.google.com (mail-fx0-f221.google.com [209.85.220.221]) by gmr-mx.google.com with ESMTP id 14si222388fxm.7.2009.10.16.07.27.33; Fri, 16 Oct 2009 07:27:33 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.220.221 as permitted sender) client-ip=209.85.220.221;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 209.85.220.221 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by mail-fx0-f221.google.com with SMTP id 21so2478180fxm.9 for <msysgit@googlegroups.com>; Fri, 16 Oct 2009 07:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:mime-version:received:reply-to:in-reply-to :references:date:message-id:subject:from:to:cc:content-type; bh=l3WMnTg+cB1bsTEg9XG1XSclBmjUGGc6laF8T6T5wLw=; b=LII5noMULUGmA3QoAWbTDFs5irWezugaomg/okwJOEmYJ3UcDDOdiyW9/kTkHTVBsL VEcGKU7hFNAhnvcZGAOuVbtLITXgkd7Kd87WI72EnZc+Cczd3mIZT9dwmvhHEbbul1rZ sPn9ZAuFWWqNOdLBr6wxjWhzIbaNcX1AQHpWs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=mime-version:reply-to:in-reply-to:references:date:message-id :subject:from:to:cc:content-type; b=CMS+3ufR9IaRpODULFBqgAQOkyj38Y3Uve3rJP+VN6YXKOVUWkC5O+aA2zpR3TLyfe VMKWa/jSAxeONLCbM+i9yil4YAZrrP9+7o8bS+kC4wbQDxLcmw1A3ef/KqARanqAl396 1SsZvv3QXBdIbOcYbZ4dseaqw6sbFv+MPQBqc=
Received: by 10.204.34.78 with SMTP id k14mr1394010bkd.106.1255703253680; Fri,  16 Oct 2009 07:27:33 -0700 (PDT)
In-Reply-To: <200910142158.59073.j6t@kdbg.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130498>


Sorry about the late reply, lots of things to do.
On Wed, Oct 14, 2009 at 9:58 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Dienstag, 13. Oktober 2009, Erik Faye-Lund wrote:
>> I'm really unsure if it's worth the hassle.
>
> We already depend on the existence of a Bourne shell for our scripted
> commands. There are already more places in the code that run "sh"
> than "/bin/sh".

OK, you've got me convinced. I'll update the patch with this tweak.

-- 
Erik "kusma" Faye-Lund
