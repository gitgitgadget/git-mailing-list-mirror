From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH/RFC 07/11] run-command: support input-fd
Date: Tue, 8 Dec 2009 14:46:19 +0100
Message-ID: <40aa078e0912080546v544451c6yd3a3b15cb05a08ed@mail.gmail.com>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>
	 <200911262253.59641.j6t@kdbg.org>
	 <40aa078e0911270639n1de36517w5fdf6ef38e931b19@mail.gmail.com>
	 <200911272114.13107.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: msysgit@googlegroups.com, git@vger.kernel.org, dotzenlabs@gmail.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: 3r1geSwkOB3EZjhbPQXiTVddVaTbPXa.RdbbhnhVXiVddVaTVgdjeh.Rdb@listserv.bounces.google.com Tue Dec 08 14:46:43 2009
Return-path: <3r1geSwkOB3EZjhbPQXiTVddVaTbPXa.RdbbhnhVXiVddVaTVgdjeh.Rdb@listserv.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gx0-f190.google.com ([209.85.217.190])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI0Op-0001Ak-2l
	for gcvm-msysgit@m.gmane.org; Tue, 08 Dec 2009 14:46:43 +0100
Received: by gxk6 with SMTP id 6sf8649587gxk.13
        for <gcvm-msysgit@m.gmane.org>; Tue, 08 Dec 2009 05:46:41 -0800 (PST)
Received: by 10.91.181.17 with SMTP id i17mr196226agp.7.1260279983834;
        Tue, 08 Dec 2009 05:46:23 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.213.37.194 with SMTP id y2ls209828ebd.3.p; Tue, 08 Dec 2009 
	05:46:20 -0800 (PST)
Received: by 10.213.41.5 with SMTP id m5mr966940ebe.26.1260279980617;
        Tue, 08 Dec 2009 05:46:20 -0800 (PST)
Received: by 10.213.41.5 with SMTP id m5mr966939ebe.26.1260279980589;
        Tue, 08 Dec 2009 05:46:20 -0800 (PST)
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.144])
        by gmr-mx.google.com with ESMTP id 18si667902ewy.8.2009.12.08.05.46.19;
        Tue, 08 Dec 2009 05:46:19 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 74.125.78.144 as permitted sender) client-ip=74.125.78.144;
Received: by ey-out-1920.google.com with SMTP id 5so545308eyb.20
        for <msysgit@googlegroups.com>; Tue, 08 Dec 2009 05:46:19 -0800 (PST)
Received: by 10.216.87.209 with SMTP id y59mr3139716wee.21.1260279979289; Tue, 
	08 Dec 2009 05:46:19 -0800 (PST)
In-Reply-To: <200911272114.13107.j6t@kdbg.org>
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of kusmabite@googlemail.com designates 74.125.78.144 as permitted 
	sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) 
	header.i=@googlemail.com
X-Original-Sender: <kusmabite@googlemail.com>
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=>
X-Thread-Url: http://groups.google.com/group/msysgit/t/15f3dd983aa85143
X-Message-Url: http://groups.google.com/group/msysgit/msg/8ced271e6016d90d
Sender: msysgit+owner@googlegroups.com
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+subscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134871>

On Fri, Nov 27, 2009 at 9:14 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Freitag, 27. November 2009, Erik Faye-Lund wrote:
>> What do you find confusing about it? The idea is to use a provided
>> bi-directional fd instead of a pipe if async->out is non-zero. The
>> currently defined rules for async is that async->out must be zero
>> (since the structure should be zero-initialized).
>
> It is just the code structure that is confusing. It should be
>
> =A0 =A0 =A0 =A0if (async->out) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* fd was provided */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0do all that is needed in this case
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* fd was requested */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0do all for this other case
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0/* nothing to do anymore here */
>
> (Of course, this should only replace the part that is cited above, not th=
e
> whole function.)
>

OK. I've reimplemented the change for the next round, taking this into acco=
unt.

>> Indeed it does. Do we want to extend it to support a set of
>> unidirectional channels instead?
>
> Yes, I think so. We could pass a regular int fd[2] array around with the =
clear
> definition that both can be closed independently, i.e. one must be a dup(=
) of
> the other. struct async would also have such an array.
>

OK. This has been included for the next round. Instead of an array,
I've tried to be consistent with start_command, and used two
variables, "in" and "out".

> Speaking of dup(): The underlying function is DuplicateHandle(), and its
> documentation says:
>
> "You should not use DuplicateHandle to duplicate handles to the following
> objects: ... o Sockets. ... use WSADuplicateSocket."
>
> But then the docs of WSADuplicateSocket() talk only about duplicating a s=
ocket
> to a separate process. Perhaps DuplicateHandle() of a socket within the s=
ame
> process Just Works?
>

It seems the rest of the Windows-world depends on DuplicateHandle()
working for sockets, so I'm not too worried. I can't find anything
documentation(1) for _dup, and I don't think we have our own
dup()-implementation.

(1) http://msdn.microsoft.com/en-us/library/8syseb29(VS.71).aspx

--=20
Erik "kusma" Faye-Lund
