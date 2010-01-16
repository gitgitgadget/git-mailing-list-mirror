From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 13/14] daemon: use select() instead of poll()
Date: Sat, 16 Jan 2010 11:38:36 +0100
Message-ID: <201001161138.36535.j6t@kdbg.org>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com> <201001160906.26270.j6t@kdbg.org> <40aa078e1001160126q34bc066as3adb9b61eac690d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Cc: msysgit@googlegroups.com,
 git@vger.kernel.org
To: kusmabite@gmail.com
X-From: 3aJdRSwMIB5wFcPG97C.KNCIOUOCEPCKKCHACNKQLO.8KI@listserv.bounces.google.com Sat Jan 16 11:40:26 2010
Return-path: <3aJdRSwMIB5wFcPG97C.KNCIOUOCEPCKKCHACNKQLO.8KI@listserv.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gx0-f204.google.com ([209.85.217.204])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NW64Q-0001Ew-72
	for gcvm-msysgit@m.gmane.org; Sat, 16 Jan 2010 11:39:54 +0100
Received: by gxk28 with SMTP id 28sf3002503gxk.6
        for <gcvm-msysgit@m.gmane.org>; Sat, 16 Jan 2010 02:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:message-id
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe:content-type
         :content-transfer-encoding:content-disposition;
        bh=qkyCerG8hLXgrSEv0IfIIduS/oK/UAyiMS17peRlmlE=;
        b=7IinRx2Fkmz1pNM7yqy45/nzm1NZSJvPukapbnjg1JhvMh4uX3LyeoP89dlDrx2zAr
         sgBN7gFfAzguvko3GVJuCZ2Dto+rZBwY4uRFth3X4XScvbzzKkQkPNhmnfmGAdxMekj3
         GcK0jR+f8DKH2N4L1ckMFcx2eGIqmfy8KEvkk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:from:to:subject:date:user-agent:cc
         :references:in-reply-to:mime-version:message-id
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe:content-type
         :content-transfer-encoding:content-disposition;
        b=J5RuKGoL0Ervkbkyyy1FOMdg7qSgczHYqhC6LUVMzFV0yg1Nm4RmhlMzunwP5IxvgX
         OqIxTGmTEUbw5YwLwA3aDS3lXzfTvRCzs/c43tKxa0yC3VOmrtPoSS9I3VBUbL8HYMS4
         oYe3UTLemt/89XG5bhVOyhxY1z4DjF8nSxZK8=
Received: by 10.101.6.11 with SMTP id j11mr268229ani.30.1263638376765;
        Sat, 16 Jan 2010 02:39:36 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.204.16.66 with SMTP id n2ls362052bka.1.p; Sat, 16 Jan 2010 
	02:39:35 -0800 (PST)
Received: by 10.204.141.217 with SMTP id n25mr57161bku.13.1263638375535;
        Sat, 16 Jan 2010 02:39:35 -0800 (PST)
Received: by 10.204.141.217 with SMTP id n25mr57160bku.13.1263638375513;
        Sat, 16 Jan 2010 02:39:35 -0800 (PST)
Received: from bsmtp.bon.at (bsmtp4.bon.at [195.3.86.186])
        by gmr-mx.google.com with ESMTP id 12si250037bwz.6.2010.01.16.02.39.35;
        Sat, 16 Jan 2010 02:39:35 -0800 (PST)
Received-SPF: neutral (google.com: 195.3.86.186 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=195.3.86.186;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id C51F72C400C;
	Sat, 16 Jan 2010 11:39:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 9FAD519F6CB;
	Sat, 16 Jan 2010 11:38:36 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <40aa078e1001160126q34bc066as3adb9b61eac690d@mail.gmail.com>
X-Original-Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 
	195.3.86.186 is neither permitted nor denied by best guess record for domain 
	of j6t@kdbg.org) smtp.mail=j6t@kdbg.org
X-Original-Sender: j6t@kdbg.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=>
X-Thread-Url: http://groups.google.com/group/msysgit/t/43ea563cecdc45de
X-Message-Url: http://groups.google.com/group/msysgit/msg/dcc2832a9d5f768f
Sender: msysgit@googlegroups.com
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+subscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137217>

On Samstag, 16. Januar 2010, Erik Faye-Lund wrote:
> On Sat, Jan 16, 2010 at 9:06 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> > On Samstag, 16. Januar 2010, Erik Faye-Lund wrote:
> >> +static inline void mingw_fd_set(int fd, fd_set *set)
> >> +{
> >> +     FD_SET(_get_osfhandle(fd), set);
> >> +}
> >>  #undef FD_SET
> >> +#define FD_SET(a,b) mingw_fd_set(a,b)
> >> +
> >>  #undef FD_ISSET
> >>  #define FD_ISSET(fd, set) __WSAFDIsSet(_get_osfhandle(fd), (fd_set
> >> *)(set))
> >
> > Ah, yes, how obvious ;) You are going to do the same with FD_ISSET as
> > well, aren't you?
>
> Do I really need to? There's already a single function for that, with
> no "ugly hidden internals" there; __WSAFDIsSet() is documented in
> MSDN. I mean, Sure... I could... I just don't see the point.

__WSAFDIsSet is "ugly hidden internals" and we should not rely on it when we 
can use the official FD_ISSET for our own FD_ISSET.

-- Hannes
