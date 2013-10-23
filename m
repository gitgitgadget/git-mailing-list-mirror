From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Prevent buffer overflows when path is too big
Date: Wed, 23 Oct 2013 19:55:09 +0700
Message-ID: <CACsJy8AooiUNRfnqDLBmx=KPnztjdNuF4bYY2b=Egs3gdiW6KA@mail.gmail.com>
References: <CABPQNSaqjKPGAQ4EKBSk+bQP2WMksc6M0YQxSkB91UrnFF28xQ@mail.gmail.com>
 <1382179954-5169-1-git-send-email-apelisse@gmail.com> <52636E5A.1080909@web.de>
 <CACsJy8AXV=KJtTWxp6dpfa_Pr81h3YwW5EK=c_dV=F7tr7ChWQ@mail.gmail.com>
 <CALWbr2z1RmLLNa3Cj+n6g=zu5FB4VZSmRTU1qYb86pXLfYGJGg@mail.gmail.com>
 <CACsJy8BQ=qzXbMT9OSeQ+aDjLe5ogkUMZzdUhK0ObJP+VHkYvQ@mail.gmail.com> <52657A3D.8090609@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Antoine Pelisse <apelisse@gmail.com>, =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>, 
	Git Mailing List <git@vger.kernel.org>, Wataru Noguchi <wnoguchi.0727@gmail.com>, 
	Erik Faye-Lund <kusmabite@gmail.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	msysGit <msysgit@googlegroups.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: msysgit+bncBC2ZN5PHQUMBBTEOT6JQKGQEHUGV3BY@googlegroups.com Wed Oct 23 14:55:42 2013
Return-path: <msysgit+bncBC2ZN5PHQUMBBTEOT6JQKGQEHUGV3BY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ie0-f189.google.com ([209.85.223.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBC2ZN5PHQUMBBTEOT6JQKGQEHUGV3BY@googlegroups.com>)
	id 1VYxyP-00049F-Gg
	for gcvm-msysgit@m.gmane.org; Wed, 23 Oct 2013 14:55:41 +0200
Received: by mail-ie0-f189.google.com with SMTP id at1sf172185iec.26
        for <gcvm-msysgit@m.gmane.org>; Wed, 23 Oct 2013 05:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=fLAJqMpxTErktqjzlOrcl3J4AWDNmzZUFS5606CixdI=;
        b=QvGa6rD56Des912t/+tXfC4BGCJp/mu5oNYA2DhVX4THfhArkh0RK1uttaUH5rL8cD
         21c0S9YnCLMMr9S4gDzer0cvFx1nCQKGDhwWlv81+7iYFoltzJa6Y3b+FYz+Bs7LM116
         b+i6SiywP5XkzMi2H6UUbd/sef1NKa/SDtI16QiqW9aGCWjuvotqEaNpHlC+y78yRGrx
         /Lpn/pXegllJKP93Ncbhv6xizC6rHuH+RzAMLyGqIhvyI+gOXoIGPgRMpzVyii7gJlM+
         govtHSSab3m0F3blobI7uQY1dyM5MYEBFyVHei9/3GiK0NGvCMuTs2E+/PxK/5wQllha
         v7Mg==
X-Received: by 10.49.81.162 with SMTP id b2mr1914qey.41.1382532940466;
        Wed, 23 Oct 2013 05:55:40 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.99.67 with SMTP id eo3ls464036qeb.41.gmail; Wed, 23 Oct
 2013 05:55:40 -0700 (PDT)
X-Received: by 10.58.147.41 with SMTP id th9mr579428veb.8.1382532940014;
        Wed, 23 Oct 2013 05:55:40 -0700 (PDT)
Received: from mail-qa0-x231.google.com (mail-qa0-x231.google.com [2607:f8b0:400d:c00::231])
        by gmr-mx.google.com with ESMTPS id bc1si960804qcb.1.2013.10.23.05.55.39
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Oct 2013 05:55:40 -0700 (PDT)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 2607:f8b0:400d:c00::231 as permitted sender) client-ip=2607:f8b0:400d:c00::231;
Received: by mail-qa0-f49.google.com with SMTP id i13so474119qae.8
        for <msysgit@googlegroups.com>; Wed, 23 Oct 2013 05:55:39 -0700 (PDT)
X-Received: by 10.224.16.8 with SMTP id m8mr3831726qaa.28.1382532939910; Wed,
 23 Oct 2013 05:55:39 -0700 (PDT)
Received: by 10.96.27.202 with HTTP; Wed, 23 Oct 2013 05:55:09 -0700 (PDT)
In-Reply-To: <52657A3D.8090609@kdbg.org>
X-Original-Sender: pclouds@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of pclouds@gmail.com designates 2607:f8b0:400d:c00::231
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236507>

On Tue, Oct 22, 2013 at 2:02 AM, Johannes Sixt <j6t@kdbg.org> wrote:
>> (or maybe at higher level to skip checking out those paths).
>
> More like this, yeah.

The good thing is we do not stop checking out if one entry fails. But
due to the lack of worktree entries, one may accidentally remove files
in new commits. So setting CE_VALID on failed-to-checkout entries
might help. I'm not sure. But I won't pursue because Windows is not
really my itch.
-- 
Duy

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
