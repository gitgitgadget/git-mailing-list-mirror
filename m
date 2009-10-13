From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH v3 3/8] imap-send: use run-command API for 
 tunneling
Date: Tue, 13 Oct 2009 22:27:37 +0200
Message-ID: <40aa078e0910131327q682c7044x854fec4de60b0c43@mail.gmail.com>
References: <1255461925-2244-1-git-send-email-kusmabite@gmail.com> <1255461925-2244-3-git-send-email-kusmabite@gmail.com> <1255461925-2244-4-git-send-email-kusmabite@gmail.com> <200910132159.11616.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Oct 13 22:28:07 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f161.google.com ([209.85.211.161])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxnyX-0007iN-BJ
	for gcvm-msysgit@m.gmane.org; Tue, 13 Oct 2009 22:28:05 +0200
Received: by ywh33 with SMTP id 33so5114457ywh.24
        for <gcvm-msysgit@m.gmane.org>; Tue, 13 Oct 2009 13:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        bh=rr9xHjfKoOG2xTIPATVqTQn3R8DBW322nov+QGJF2Kk=;
        b=rDDJG0uEZcvu+AhJnNbzbWJB8g7Hq7qvsHfg++bcqYXpi2/rkbnOyLBglTCzX4xOUI
         B5Zc/6NZ1hZF83riXx/Z31wGwNRIN+SoID0jeHutzxU2h76GVryICYtxx10lYbjp/kXZ
         I09oJ+dL96J6NlVF9qLXt25JVO+5m01GnnPdU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:mime-version:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=DGvzZsZs+C5hf03pmlTz0xHWHGLtRGLmv2pXQ6y2MvyfmjaBshes3ML3DIeVWImzGH
         zwDbXwAMRIydbx47w4Chdi78Phye31xQ5iUwv2u8J4nCq36XdbXSBoX4/3Ac4onUDi2J
         jbVWwE+ZDaJMtPtaCx2TBC95by+I+GbZW6wgw=
Received: by 10.220.78.89 with SMTP id j25mr162148vck.21.1255465669348;
        Tue, 13 Oct 2009 13:27:49 -0700 (PDT)
Received: by 10.176.181.37 with SMTP id d37gr7407yqf.0;
	Tue, 13 Oct 2009 13:27:39 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.223.24.218 with SMTP id w26mr101679fab.13.1255465658490; Tue, 13 Oct 2009 13:27:38 -0700 (PDT)
Received: by 10.223.24.218 with SMTP id w26mr101678fab.13.1255465658457; Tue, 13 Oct 2009 13:27:38 -0700 (PDT)
Received: from mail-fx0-f207.google.com (mail-fx0-f207.google.com [209.85.220.207]) by gmr-mx.google.com with ESMTP id 16si310892fxm.6.2009.10.13.13.27.37; Tue, 13 Oct 2009 13:27:37 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.220.207 as permitted sender) client-ip=209.85.220.207;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 209.85.220.207 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by mail-fx0-f207.google.com with SMTP id 3so10362403fxm.20 for <msysgit@googlegroups.com>; Tue, 13 Oct 2009 13:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:mime-version:received:reply-to:in-reply-to :references:date:message-id:subject:from:to:cc:content-type :content-transfer-encoding; bh=rPn7eKp8cXeP0kBWRGI51ZimqSh9zbkmavEUZVhT/Zk=; b=cNI80GYLmjTR5dV7xp3fSMtZf9RLhbEqnTKGpGrAxuk0moIrW8SlinrePxQHCAB/yt mxp0LmX+MDFQ5bNFB25EtlmX6mImUnTxkbrvvzSNTKUfr2ZJJZYlLGDBcqkHzuGxhDk2 Aw/4eG6Qj8+gcWStG9yOFV8Xr7vqvyAJIrr1s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=mime-version:reply-to:in-reply-to:references:date:message-id :subject:from:to:cc:content-type:content-transfer-encoding; b=l73hsc69qwovgn2Mk3c8Bmo9hB8FcjR8AQcz6bhZX18A0GRaRowmlCfGdKZwkXL5ye ygkWqbv5RpzEqFsHBrAt9eEEwFPRvdJfTh5PFinsOzz2tkVjlRKTVv6//mRj6pEFJ1k+ 3MvyLzR7WdlzA0lHQIg0BAGQ+Iz4HsCIgOG8Y=
Received: by 10.204.162.137 with SMTP id v9mr6537285bkx.60.1255465657120; Tue,  13 Oct 2009 13:27:37 -0700 (PDT)
In-Reply-To: <200910132159.11616.j6t@kdbg.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130205>


On Tue, Oct 13, 2009 at 9:59 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Dienstag, 13. Oktober 2009, Erik Faye-Lund wrote:
>> + =A0 =A0 =A0 =A0 =A0 =A0 argv[0] =3D "/bin/sh";
>> + =A0 =A0 =A0 =A0 =A0 =A0 argv[1] =3D "-c";
>> + =A0 =A0 =A0 =A0 =A0 =A0 argv[2] =3D srvc->tunnel;
>> + =A0 =A0 =A0 =A0 =A0 =A0 argv[3] =3D NULL;
>
> Is there a particular reason that you run "/bin/sh" with a path? I doubt =
that
> this works on Windows.
>
> -- Hannes
>

It doesn't - I was being conservative. Getting tunneling to work on
Windows hasn't been a part of  my priorities (even though I did
briefly test it at some point and got it working, provided a patch
that changed the path to sh to a windows-path). Changing it to "sh -c"
(as was suggested earlier) could AFAIK break something for people who
have other 'sh's in path before /bin -- not that I think it would
matter terribly much.

If I were to fix this, I'd prefer not using sh at all on Windows. I've
seen that connect.c doesn't prepend "/bin/sh -c" at all, requiring
tunnels to be self-contained scripts or native binaries, unless I'm
mistaken. I'm not sure if this works at all on Windows, though. I just
think that the assumption that sh is the shell that is going to run
the tunnel is wrong to make, especially on Windows.

I'm really unsure if it's worth the hassle.

--=20
Erik "kusma" Faye-Lund
