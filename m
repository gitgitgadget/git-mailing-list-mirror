From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH v2 13/14] daemon: use select() instead of poll()
Date: Sat, 16 Jan 2010 12:05:09 +0100
Message-ID: <40aa078e1001160305y17b46a6dtc4959e5255c7acae@mail.gmail.com>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
	 <201001160906.26270.j6t@kdbg.org>
	 <40aa078e1001160126q34bc066as3adb9b61eac690d@mail.gmail.com>
	 <201001161138.36535.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: 3aJ1RSwkOB6IMWUOCDKVGIQQINGOCKN.EQOOUaUIKVIQQINGITQWRU.EQO@listserv.bounces.google.com Sat Jan 16 12:05:30 2010
Return-path: <3aJ1RSwkOB6IMWUOCDKVGIQQINGOCKN.EQOOUaUIKVIQQINGITQWRU.EQO@listserv.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f161.google.com ([209.85.211.161])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NW6TB-0000xJ-LC
	for gcvm-msysgit@m.gmane.org; Sat, 16 Jan 2010 12:05:29 +0100
Received: by ywh33 with SMTP id 33sf3190091ywh.24
        for <gcvm-msysgit@m.gmane.org>; Sat, 16 Jan 2010 03:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:mime-version:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe:content-type
         :content-transfer-encoding;
        bh=8odfWy4ydxiqZCSOA/OjHgg/o9AEB15kL3ZeYqORlZs=;
        b=p5Bl7f8o2mlwxAOafdwgPq6KEo3GFA9GNbJETmgcRJDbDLY29zbEHJDGdL0sjNTW0W
         qcKPuMj4QmAiKVchn6mNyolAZCk3SXIuYsF+o5DYgX/tqe6FObSUkayUVzkTZfHHTvG8
         e5zGJwylXIPu5ItC3N7nlTPvvdZUf8dmape4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:sender:list-unsubscribe:list-subscribe:content-type
         :content-transfer-encoding;
        b=Q2fznByNmG7w9z9WfxvSgbUMEjQQN7NZ3OtMPHCT9IMHMpNH6o64Abg18kG7z6TI99
         1zk9/j8JRA94mIn3oHLt9B7UXf3x4Saz83AILebiMD5KdLOtrlbAzs3RiXgrTCQkqBAA
         pHxYIj/+P+NBMyJgkMJv7/64DcEdmd4+mTLeU=
Received: by 10.101.141.11 with SMTP id t11mr270446ann.12.1263639912377;
        Sat, 16 Jan 2010 03:05:12 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.213.39.202 with SMTP id h10ls798418ebe.2.p; Sat, 16 Jan 2010 
	03:05:11 -0800 (PST)
Received: by 10.213.50.137 with SMTP id z9mr24099ebf.3.1263639911025;
        Sat, 16 Jan 2010 03:05:11 -0800 (PST)
Received: by 10.213.50.137 with SMTP id z9mr24098ebf.3.1263639910998;
        Sat, 16 Jan 2010 03:05:10 -0800 (PST)
Received: from mail-ew0-f214.google.com (mail-ew0-f214.google.com [209.85.219.214])
        by gmr-mx.google.com with ESMTP id 17si92069ewy.15.2010.01.16.03.05.09;
        Sat, 16 Jan 2010 03:05:09 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.219.214 as permitted sender) client-ip=209.85.219.214;
Received: by ewy6 with SMTP id 6so1755186ewy.29
        for <msysgit@googlegroups.com>; Sat, 16 Jan 2010 03:05:09 -0800 (PST)
Received: by 10.216.86.80 with SMTP id v58mr1176029wee.40.1263639909578; Sat, 
	16 Jan 2010 03:05:09 -0800 (PST)
In-Reply-To: <201001161138.36535.j6t@kdbg.org>
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of kusmabite@googlemail.com designates 209.85.219.214 as permitted 
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
X-Message-Url: http://groups.google.com/group/msysgit/msg/cea5bde711022641
Sender: msysgit@googlegroups.com
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+subscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137222>

On Sat, Jan 16, 2010 at 11:38 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Samstag, 16. Januar 2010, Erik Faye-Lund wrote:
>> On Sat, Jan 16, 2010 at 9:06 AM, Johannes Sixt <j6t@kdbg.org> wrote:
>> > On Samstag, 16. Januar 2010, Erik Faye-Lund wrote:
>> >> +static inline void mingw_fd_set(int fd, fd_set *set)
>> >> +{
>> >> + =A0 =A0 FD_SET(_get_osfhandle(fd), set);
>> >> +}
>> >> =A0#undef FD_SET
>> >> +#define FD_SET(a,b) mingw_fd_set(a,b)
>> >> +
>> >> =A0#undef FD_ISSET
>> >> =A0#define FD_ISSET(fd, set) __WSAFDIsSet(_get_osfhandle(fd), (fd_set
>> >> *)(set))
>> >
>> > Ah, yes, how obvious ;) You are going to do the same with FD_ISSET as
>> > well, aren't you?
>>
>> Do I really need to? There's already a single function for that, with
>> no "ugly hidden internals" there; __WSAFDIsSet() is documented in
>> MSDN. I mean, Sure... I could... I just don't see the point.
>
> __WSAFDIsSet is "ugly hidden internals" and we should not rely on it when=
 we
> can use the official FD_ISSET for our own FD_ISSET.
>
> -- Hannes
>

...but __WSAFDIsSet() seems to be every bit as official on Windows as
FD_ISSET() (documented in msdn, without any notes not to use it), so I
still don't really see the point.

However, I don't personally care one way or the other, so just doing
it is probably less work than convincing you that I don't have to ;)

--=20
Erik "kusma" Faye-Lund
