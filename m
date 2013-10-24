From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] entry.c: convert write_entry to use strbuf
Date: Thu, 24 Oct 2013 08:23:41 +0700
Message-ID: <CACsJy8Ap005pUBZH0k=7F9nON9Vb5SoO-1McPAwRkLCC0YoPMQ@mail.gmail.com>
References: <20131021193223.GC29681@sigill.intra.peff.net> <1382532907-30561-1-git-send-email-pclouds@gmail.com>
 <1382532907-30561-2-git-send-email-pclouds@gmail.com> <xmqqeh7bri1h.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Git Mailing List <git@vger.kernel.org>, Erik Faye-Lund <kusmabite@gmail.com>, 
	Johannes Sixt <j6t@kdbg.org>, Antoine Pelisse <apelisse@gmail.com>, 
	=?UTF-8?Q?Torsten_B=C3=83=C2=B6gershausen?= <tboegi@web.de>, 
	Wataru Noguchi <wnoguchi.0727@gmail.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?UmVuw4PCqSBTY2hhcmZl?= <l.s.r@web.de>, 
	msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBC2ZN5PHQUMBBO7NUGJQKGQEXGJ3VRA@googlegroups.com Thu Oct 24 03:24:13 2013
Return-path: <msysgit+bncBC2ZN5PHQUMBBO7NUGJQKGQEXGJ3VRA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ob0-f186.google.com ([209.85.214.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBC2ZN5PHQUMBBO7NUGJQKGQEXGJ3VRA@googlegroups.com>)
	id 1VZ9em-0006Ai-VW
	for gcvm-msysgit@m.gmane.org; Thu, 24 Oct 2013 03:24:13 +0200
Received: by mail-ob0-f186.google.com with SMTP id gq1sf324533obb.13
        for <gcvm-msysgit@m.gmane.org>; Wed, 23 Oct 2013 18:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=OpGKA5eai0fSZzo6Rg9aShFJf2zRKYnjukwg+1ESY5I=;
        b=SSnFDjpFyUbqLTv2FefRW6eLYcPLbx0CwSA0SMBAK3Ke63sPO5T7R04/1BLf4oB6Ma
         p5QtFBonfDIUZDyPXQUlXrK0nXKph5D+U4vR85lDo4rzcSNrcLTf0imlg6f84+y/Mq72
         FILvDefYlVYFC1WY3if3VQepru2os0zsf2/neaTMaPZNAxchlR+vsQLkT0vTMQwB+W5d
         3oYctR97LByALcXzXLCXSk+iNDymV6R68jOu+Xr4MZGl2sfjRIX5OVR2h0NP6HbwEEXf
         9BaxW3JrYbQxBo2DBs92FqsUCLWj01WquEsoFDj7nE8uOVN5Xnm0jhaRZ0FXMeBxqmIm
         HZmw==
X-Received: by 10.49.75.168 with SMTP id d8mr2717qew.3.1382577851773;
        Wed, 23 Oct 2013 18:24:11 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.70.228 with SMTP id p4ls651735qeu.43.gmail; Wed, 23 Oct
 2013 18:24:11 -0700 (PDT)
X-Received: by 10.236.26.202 with SMTP id c50mr251953yha.14.1382577851166;
        Wed, 23 Oct 2013 18:24:11 -0700 (PDT)
Received: from mail-qe0-x234.google.com (mail-qe0-x234.google.com [2607:f8b0:400d:c02::234])
        by gmr-mx.google.com with ESMTPS id bc1si1629804qcb.1.2013.10.23.18.24.11
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Oct 2013 18:24:11 -0700 (PDT)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 2607:f8b0:400d:c02::234 as permitted sender) client-ip=2607:f8b0:400d:c02::234;
Received: by mail-qe0-f52.google.com with SMTP id w7so1040420qeb.11
        for <msysgit@googlegroups.com>; Wed, 23 Oct 2013 18:24:11 -0700 (PDT)
X-Received: by 10.49.15.129 with SMTP id x1mr158890qec.49.1382577851091; Wed,
 23 Oct 2013 18:24:11 -0700 (PDT)
Received: by 10.96.27.202 with HTTP; Wed, 23 Oct 2013 18:23:41 -0700 (PDT)
In-Reply-To: <xmqqeh7bri1h.fsf@gitster.dls.corp.google.com>
X-Original-Sender: pclouds@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of pclouds@gmail.com designates 2607:f8b0:400d:c02::234
 as permitted sender) smtp.mail=pclouds@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236559>

On Thu, Oct 24, 2013 at 12:52 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> The strcpy call in open_output_fd() implies that the output buffer
>> must be at least 25 chars long.
>
> Hmph, where does that 25 come from?
>
> [snipped]

Much better. Thanks.
--=20
Duy

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
