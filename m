From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Prevent buffer overflows when path is too big
Date: Mon, 21 Oct 2013 08:31:09 +0700
Message-ID: <CACsJy8BQ=qzXbMT9OSeQ+aDjLe5ogkUMZzdUhK0ObJP+VHkYvQ@mail.gmail.com>
References: <CABPQNSaqjKPGAQ4EKBSk+bQP2WMksc6M0YQxSkB91UrnFF28xQ@mail.gmail.com>
 <1382179954-5169-1-git-send-email-apelisse@gmail.com> <52636E5A.1080909@web.de>
 <CACsJy8AXV=KJtTWxp6dpfa_Pr81h3YwW5EK=c_dV=F7tr7ChWQ@mail.gmail.com> <CALWbr2z1RmLLNa3Cj+n6g=zu5FB4VZSmRTU1qYb86pXLfYGJGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>, 
	Git Mailing List <git@vger.kernel.org>, Wataru Noguchi <wnoguchi.0727@gmail.com>, 
	Erik Faye-Lund <kusmabite@gmail.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	msysGit <msysgit@googlegroups.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: msysgit+bncBC2ZN5PHQUMBB64HSKJQKGQE743PRYQ@googlegroups.com Mon Oct 21 03:31:42 2013
Return-path: <msysgit+bncBC2ZN5PHQUMBB64HSKJQKGQE743PRYQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pb0-f64.google.com ([209.85.160.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBC2ZN5PHQUMBB64HSKJQKGQE743PRYQ@googlegroups.com>)
	id 1VY4LN-0004GE-6W
	for gcvm-msysgit@m.gmane.org; Mon, 21 Oct 2013 03:31:41 +0200
Received: by mail-pb0-f64.google.com with SMTP id xa7sf1182691pbc.29
        for <gcvm-msysgit@m.gmane.org>; Sun, 20 Oct 2013 18:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=c2FMfxf4Jv805YwqGf6/4Iqc89j+uYcWCLVf50EE8Bw=;
        b=Dx6oaZEtgVk6HN4N13RpD1bgkMz35DRQyvrDT9BtF0H4ffp+b6fX9tfXZkhVkwTimr
         01vGjLP7gSlPEhbihRSzAS9tbwceHwPW8Vyh6Cc4S1sebGiuyUX5+aIKgOJuebWiGeLJ
         xd3kKWZwivsjjMKfug0Z7+wZ1YcIJIlinOOhFr9vYhuvqVIORMjHclMZkCa/wmqAqy36
         YkbtrbSVzdf+To5qJ6sIYc0/z2fRgyhB/xQw41qNSFqK9oCf42JEKITDwUPQwN08iDm9
         XigVQuQcfjTtLsjcp3JuciVUSSuzwe0C14b2wHMXzbSM+FIxigS17DLo5fEVUwK6IcK5
         kOdA==
X-Received: by 10.50.3.70 with SMTP id a6mr176718iga.16.1382319100023;
        Sun, 20 Oct 2013 18:31:40 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.118.97 with SMTP id kl1ls1429140igb.35.canary; Sun, 20 Oct
 2013 18:31:39 -0700 (PDT)
X-Received: by 10.42.207.206 with SMTP id fz14mr4719653icb.2.1382319099183;
        Sun, 20 Oct 2013 18:31:39 -0700 (PDT)
Received: from mail-qc0-x232.google.com (mail-qc0-x232.google.com [2607:f8b0:400d:c01::232])
        by gmr-mx.google.com with ESMTPS id gs8si2562827qcb.0.2013.10.20.18.31.39
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 20 Oct 2013 18:31:39 -0700 (PDT)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 2607:f8b0:400d:c01::232 as permitted sender) client-ip=2607:f8b0:400d:c01::232;
Received: by mail-qc0-f178.google.com with SMTP id x19so4120129qcw.37
        for <msysgit@googlegroups.com>; Sun, 20 Oct 2013 18:31:39 -0700 (PDT)
X-Received: by 10.49.26.6 with SMTP id h6mr19523800qeg.75.1382319099086; Sun,
 20 Oct 2013 18:31:39 -0700 (PDT)
Received: by 10.96.27.202 with HTTP; Sun, 20 Oct 2013 18:31:09 -0700 (PDT)
In-Reply-To: <CALWbr2z1RmLLNa3Cj+n6g=zu5FB4VZSmRTU1qYb86pXLfYGJGg@mail.gmail.com>
X-Original-Sender: pclouds@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of pclouds@gmail.com designates 2607:f8b0:400d:c01::232
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236423>

On Mon, Oct 21, 2013 at 12:57 AM, Antoine Pelisse <apelisse@gmail.com> wrote:
> My main motive was to not *stop* the process when a long path is met.
> Because somebody created a repository on Linux with a long file-name
> doesn't mean you should not be able to clone it *at all* on Windows.

That should be handled at the Windows compatibility layer if Windows
cannot handle long paths as Linux (or maybe at higher level to skip
checking out those paths). For PATH_MAX value, see [1].

[1] http://thread.gmane.org/gmane.comp.version-control.git/169012/focus=169310
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
