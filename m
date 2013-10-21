From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] Prevent buffer overflows when path is too big
Date: Mon, 21 Oct 2013 21:07:26 +0200
Message-ID: <CABPQNSZku9RtwKe2r=zpGrNcHRDD_Ct7C+=x8UcNhJeJDn-oqQ@mail.gmail.com>
References: <CABPQNSaqjKPGAQ4EKBSk+bQP2WMksc6M0YQxSkB91UrnFF28xQ@mail.gmail.com>
 <1382179954-5169-1-git-send-email-apelisse@gmail.com> <52636E5A.1080909@web.de>
 <CACsJy8AXV=KJtTWxp6dpfa_Pr81h3YwW5EK=c_dV=F7tr7ChWQ@mail.gmail.com>
 <CALWbr2z1RmLLNa3Cj+n6g=zu5FB4VZSmRTU1qYb86pXLfYGJGg@mail.gmail.com>
 <CACsJy8BQ=qzXbMT9OSeQ+aDjLe5ogkUMZzdUhK0ObJP+VHkYvQ@mail.gmail.com> <52657A3D.8090609@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Duy Nguyen <pclouds@gmail.com>, Antoine Pelisse <apelisse@gmail.com>, 
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>, 
	Git Mailing List <git@vger.kernel.org>, Wataru Noguchi <wnoguchi.0727@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, =?ISO-8859-1?Q?Ren=E9_Scharfe?= <l.s.r@web.de>, 
	msysGit <msysgit@googlegroups.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: msysgit+bncBDR53PPJ7YHRBF7XSWJQKGQEAXBW7MI@googlegroups.com Mon Oct 21 21:08:10 2013
Return-path: <msysgit+bncBDR53PPJ7YHRBF7XSWJQKGQEAXBW7MI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ob0-f184.google.com ([209.85.214.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBF7XSWJQKGQEAXBW7MI@googlegroups.com>)
	id 1VYKpk-0008PN-W4
	for gcvm-msysgit@m.gmane.org; Mon, 21 Oct 2013 21:08:09 +0200
Received: by mail-ob0-f184.google.com with SMTP id uy5sf874675obc.21
        for <gcvm-msysgit@m.gmane.org>; Mon, 21 Oct 2013 12:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=9egXbFqZwNNQyllPuMPHRVjnubgU8IAFV7gPJxbFb/M=;
        b=Nh455GV7JNAteujE/AzKbwSO8Q7QwT6GOJCojMOkvDmmsCDRakXBkrJ5KiD0/0/jlU
         sWwlSmpRFP+aDfOSK0T2FMXlbYACc1S1pifKWLweejEi2k0Yk54H4dsSw1zD0oaqJNBA
         RbNYJIYxDfwVxwRUh3Uh8wB2HufeGh2McJJo6VnB/KabQXA/F6KoNr7W/xBuJWyIf2H/
         xALHHSwiEU+Upt2ZYPUH0MNiepgqx3ENuYSQH7jOzv90rEwVv6XQPFPN9LkI8PHHNQJr
         xrc0B7EHQhTnrp3YvhVuZRqxhMnrc3Vjh/xEey+bOrv+klbFCDp+VRb/0Oq+8Kpvmm5U
         Sk8w==
X-Received: by 10.49.88.40 with SMTP id bd8mr92909qeb.27.1382382488029;
        Mon, 21 Oct 2013 12:08:08 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.84.1 with SMTP id u1ls2162069qey.8.gmail; Mon, 21 Oct 2013
 12:08:07 -0700 (PDT)
X-Received: by 10.58.187.197 with SMTP id fu5mr2914424vec.34.1382382487491;
        Mon, 21 Oct 2013 12:08:07 -0700 (PDT)
Received: from mail-ie0-x234.google.com (mail-ie0-x234.google.com [2607:f8b0:4001:c03::234])
        by gmr-mx.google.com with ESMTPS id vn2si3414374igb.2.2013.10.21.12.08.07
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Oct 2013 12:08:07 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::234 as permitted sender) client-ip=2607:f8b0:4001:c03::234;
Received: by mail-ie0-f180.google.com with SMTP id e14so12057605iej.39
        for <msysgit@googlegroups.com>; Mon, 21 Oct 2013 12:08:07 -0700 (PDT)
X-Received: by 10.50.118.105 with SMTP id kl9mr10548756igb.3.1382382487018;
 Mon, 21 Oct 2013 12:08:07 -0700 (PDT)
Received: by 10.64.249.33 with HTTP; Mon, 21 Oct 2013 12:07:26 -0700 (PDT)
In-Reply-To: <52657A3D.8090609@kdbg.org>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::234
 as permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236445>

On Mon, Oct 21, 2013 at 9:02 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 21.10.2013 03:31, schrieb Duy Nguyen:
>> On Mon, Oct 21, 2013 at 12:57 AM, Antoine Pelisse <apelisse@gmail.com> wrote:
>>> My main motive was to not *stop* the process when a long path is met.
>>> Because somebody created a repository on Linux with a long file-name
>>> doesn't mean you should not be able to clone it *at all* on Windows.
>>
>> That should be handled at the Windows compatibility layer if Windows
>> cannot handle long paths as Linux
>
> Naah... PATH_MAX is a silly, arbitrary limit. The Git data model does
> not forbid paths longer than PATH_MAX, be it 4096 or 260. A generic
> solution is needed.
>
>> (or maybe at higher level to skip
>> checking out those paths).
>
> More like this, yeah.

I would argue that this is probably even a bug on Linux, only harder
(if not impossible) to trigger by accident as there's probably no
git-client that will generate such trees. But a "malicious" client
might.

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
