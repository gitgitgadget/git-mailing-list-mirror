From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH v2 13/14] daemon: use select() instead of poll()
Date: Sat, 16 Jan 2010 12:43:36 +0100
Message-ID: <40aa078e1001160343t3001c6e1r89f793ac2cb3aebc@mail.gmail.com>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
	 <201001160906.26270.j6t@kdbg.org>
	 <40aa078e1001160126q34bc066as3adb9b61eac690d@mail.gmail.com>
	 <201001161138.36535.j6t@kdbg.org>
	 <40aa078e1001160305y17b46a6dtc4959e5255c7acae@mail.gmail.com>
	 <m26372uw5k.fsf@igel.home>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j6t@kdbg.org>, msysgit@googlegroups.com, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: 3aqZRSwkOB60XhfZNOVgRTbbTYRZNVY.PbZZflfTVgTbbTYRTebhcf.PbZ@listserv.bounces.google.com Sat Jan 16 12:43:56 2010
Return-path: <3aqZRSwkOB60XhfZNOVgRTbbTYRZNVY.PbZZflfTVgTbbTYRTebhcf.PbZ@listserv.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gx0-f204.google.com ([209.85.217.204])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NW74N-0004b0-Qx
	for gcvm-msysgit@m.gmane.org; Sat, 16 Jan 2010 12:43:55 +0100
Received: by gxk28 with SMTP id 28sf3093683gxk.6
        for <gcvm-msysgit@m.gmane.org>; Sat, 16 Jan 2010 03:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:mime-version:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe:content-type;
        bh=7itxpwXJEY3/I3kYQYh8fOTbBjxjb2epy9gMUWS4KdQ=;
        b=D11LQlzKipNrYZpm2cEwvw9qyYlbeO6urEFEvWWDNiJWv4Xx4MPGOJ+3FP/WhA1Cyg
         7B+5OpWWnn5SUmGnYzhiq+GqVuACnat0GzszHgEsfeKMb67FBueDhfBGAM7jB5ndNkCx
         kWEvV610aYNKjllWgcQzifxIXcYUzv92YiMrA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe:content-type;
        b=GHyTtv7oZgrIgpvkP6vmyr9lS1Q+Xr84jm4tQ3SnDbb3SMSPf0CVlMHU/7ZNuPgRqW
         zKcSQ6K3LlN+FpOuCYtg7mtOJWZLFHNlK34fSfkk/dG4or55S9gBCYDgFSmBTxY+vljT
         SgUPKNGfZXqOA9ROo1DMUnLXJhhSoK5XyyrV0=
Received: by 10.101.5.7 with SMTP id h7mr275541ani.14.1263642218363;
        Sat, 16 Jan 2010 03:43:38 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.213.62.209 with SMTP id y17ls259486ebh.1.p; Sat, 16 Jan 2010 
	03:43:37 -0800 (PST)
Received: by 10.213.24.24 with SMTP id t24mr611047ebb.10.1263642217363;
        Sat, 16 Jan 2010 03:43:37 -0800 (PST)
Received: by 10.213.24.24 with SMTP id t24mr611046ebb.10.1263642217333;
        Sat, 16 Jan 2010 03:43:37 -0800 (PST)
Received: from mail-ew0-f209.google.com (mail-ew0-f209.google.com [209.85.219.209])
        by gmr-mx.google.com with ESMTP id 11si234817ewy.1.2010.01.16.03.43.36;
        Sat, 16 Jan 2010 03:43:36 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.209 as permitted sender) client-ip=209.85.219.209;
Received: by ewy1 with SMTP id 1so1077875ewy.28
        for <msysgit@googlegroups.com>; Sat, 16 Jan 2010 03:43:36 -0800 (PST)
Received: by 10.216.88.75 with SMTP id z53mr87520wee.46.1263642216108; Sat, 16 
	Jan 2010 03:43:36 -0800 (PST)
In-Reply-To: <m26372uw5k.fsf@igel.home>
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of kusmabite@googlemail.com designates 209.85.219.209 as permitted 
	sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) 
	header.i=@googlemail.com
X-Original-Sender: kusmabite@googlemail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=>
X-Thread-Url: http://groups.google.com/group/msysgit/t/43ea563cecdc45de
X-Message-Url: http://groups.google.com/group/msysgit/msg/8b97c12eb39ed295
Sender: msysgit@googlegroups.com
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+subscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137224>

(Note: I'll argue only for the sake for the argument here, I've
already pretty much decided to follow Hannes' suggestion)

On Sat, Jan 16, 2010 at 12:27 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> The fact that it starts with two underscores suggests that it is kinda
> internal.
>

But the fact that it is documented more than suggests that it isn't.
Not any more, anyhow. This is pretty much how winapi works. Internal
stuff isn't documented, once it's documented it isn't internal
anymore. In fact, winapi doesn't really deal with "internal" and
"external" functions, it deals with documented and undocumented. Some
documented functions/features have documented compatibility issues.

-- 
Erik "kusma" Faye-Lund
