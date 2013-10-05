From: Wataru Noguchi <wnoguchi.0727@gmail.com>
Subject: Re: [PATCH] mingw-multibyte: fix memory acces violation and
 path length limits.
Date: Sat, 05 Oct 2013 20:39:58 +0900
Message-ID: <524FFA8E.70009@gmail.com>
References: <1380403036-20413-1-git-send-email-wnoguchi.0727@gmail.com> <alpine.DEB.1.00.1309290112380.1191@s15462909.onlinehome-server.info> <524796DC.5020302@gmail.com> <5249AE2A.3050302@web.de> <524ACFAE.4040701@gmail.com> <524C9D8F.2090107@gmail.com> <CALWbr2zDi6XjMCRimUHu2=1qrA_=3ATq+50KBa1aNoBf4X_L9g@mail.gmail.com> <CABPQNSaqjKPGAQ4EKBSk+bQP2WMksc6M0YQxSkB91UrnFF28xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Antoine Pelisse <apelisse@gmail.com>, =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?=
 <l.s.r@web.de>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 git <git@vger.kernel.org>,
 msysGit <msysgit@googlegroups.com>
To: kusmabite@gmail.com
X-From: msysgit+bncBDD7TRGTWYIBBEXVX6JAKGQEU5FOLSA@googlegroups.com Sat Oct 05 13:40:04 2013
Return-path: <msysgit+bncBDD7TRGTWYIBBEXVX6JAKGQEU5FOLSA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vb0-f60.google.com ([209.85.212.60])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDD7TRGTWYIBBEXVX6JAKGQEU5FOLSA@googlegroups.com>)
	id 1VSQDL-0003m2-SO
	for gcvm-msysgit@m.gmane.org; Sat, 05 Oct 2013 13:40:04 +0200
Received: by mail-vb0-f60.google.com with SMTP id g17sf1041416vbg.15
        for <gcvm-msysgit@m.gmane.org>; Sat, 05 Oct 2013 04:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=+xftF4ua2lvu1RD54XMna1rYfamXYRtVeN0s1IPko2s=;
        b=q6YZ7GEQVE8nDXgewxEbGsLHZsUveMMsXGkEGgnvo2585Vpl65Hs0DMgngGf2msIS4
         kw5V0PiCPkK9KESfZ0O69DohN76HrTF12T0mz+LhTbm8vdK46phUP2uwmDmamxBxAHgD
         YiYsNTJll6DOqr+iCOq22LFzpZt/6gLaAJMJddX96gzoSwhrUzvYTaoCIF2krnh6IG3j
         1gfV/t5ozhZQNvHIdY8xRaO92cfXv/ZIW/0htAIcNcZUYeLHEjbIvntLksam+LxHChIo
         HOEjZSX8nl66gHStDlFqNJt7gHjQ0JtO8chSf0/BgOg8lwmoP/oxhE+FOSCgUw0XMNbN
         cbdA==
X-Received: by 10.50.170.228 with SMTP id ap4mr485554igc.16.1380973202878;
        Sat, 05 Oct 2013 04:40:02 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.118.97 with SMTP id kl1ls1856404igb.35.canary; Sat, 05 Oct
 2013 04:40:02 -0700 (PDT)
X-Received: by 10.66.27.42 with SMTP id q10mr4594943pag.14.1380973202127;
        Sat, 05 Oct 2013 04:40:02 -0700 (PDT)
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com [2607:f8b0:400e:c03::231])
        by gmr-mx.google.com with ESMTPS id ax8si2490332pbd.0.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 05 Oct 2013 04:40:02 -0700 (PDT)
Received-SPF: pass (google.com: domain of wnoguchi.0727@gmail.com designates 2607:f8b0:400e:c03::231 as permitted sender) client-ip=2607:f8b0:400e:c03::231;
Received: by mail-pa0-f49.google.com with SMTP id ld10so5273445pab.36
        for <msysgit@googlegroups.com>; Sat, 05 Oct 2013 04:40:02 -0700 (PDT)
X-Received: by 10.66.67.6 with SMTP id j6mr1026819pat.165.1380973201882;
        Sat, 05 Oct 2013 04:40:01 -0700 (PDT)
Received: from [192.168.1.39] (p4168-ipbf905akatuka.ibaraki.ocn.ne.jp. [219.114.17.168])
        by mx.google.com with ESMTPSA id qf7sm24874970pac.14.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 05 Oct 2013 04:40:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <CABPQNSaqjKPGAQ4EKBSk+bQP2WMksc6M0YQxSkB91UrnFF28xQ@mail.gmail.com>
X-Original-Sender: wnoguchi.0727@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of wnoguchi.0727@gmail.com designates 2607:f8b0:400e:c03::231
 as permitted sender) smtp.mail=wnoguchi.0727@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235726>

Hi,

I put following printf logs.

int checkout_entry(struct cache_entry *ce,
		   const struct checkout *state, char *topath)
{
	static char path[PATH_MAX + 1];
	struct stat st;
	int len = state->base_dir_len;

	if (topath)
		return write_entry(ce, topath, state, 1);

	memcpy(path, state->base_dir, len);
	fprintf(stderr, "path: %s\n", path);
	fprintf(stderr, "len: %d\n", len);
	strcpy(path + len, ce->name);
	len += ce_namelen(ce);
	fprintf(stderr, "path: %s\n", path);
	fprintf(stderr, "len: %d\n", len);
	fprintf(stderr, "path_max: %d\n", PATH_MAX);
	

--------------------------------------------------------------------------------------


crash result

wnoguchi@WIN-72R9044R72V /usr/tmp (master)
$ git clone https://github.com/wnoguchi/mingw-checkout-crash.git a2
Cloning into 'a2'...
remote: Counting objects: 8, done.
remote: Compressing objects: 100% (7/7), done.
remote: Total 8 (delta 0), reused 8 (delta 0)
Unpacking objects: 100% (8/8), done.
Checking connectivity... done
path:
len: 0
path: dummy 1-long-long-long-dirname/dummy 2-long-long
-long-dirname/dummy 3-long-long-long-dirname/dummy 4-l
ong-long-long-dirname/dummy 5-long-long-long-dirname/aaaaaaaaaaaa.txt
len: 302
path_max: 259

crash!!

--------------------------------------------------------------------------------------

build with

CFLAGS = -g -O2 -fno-inline-small-functions -Wall


wnoguchi@WIN-72R9044R72V /usr/tmp (master)
$ git clone https://github.com/wnoguchi/mingw-checkout-crash.git a3
Cloning into 'a3'...
remote: Counting objects: 8, done.
remote: Compressing objects: 100% (7/7), done.
remote: Total 8 (delta 0), reused 8 (delta 0)
Unpacking objects: 100% (8/8), done.
Checking connectivity... done
path:
len: 0
path: dummy 1-long-long-long-dirname/dummy 2-long-long
-long-dirname/dummy 3-long-long-long-dirname/dummy 4-l
ong-long-long-dirname/dummy 5-long-long-long-dirname/aaaaaaaaaaaa.txt
len: 302
path_max: 259

Warning: Your console font probably doesn't support Unicode. If you experience s
trange characters in the output, consider switching to a TrueType font such as L
ucida Console!

works fine.

------------------------------------------------------------------------------------

this result means actual path byte length over run path buffer?

	static char path[PATH_MAX + 1];

hmmm...

I'm not sure why -fno-inline-small-functions works.


(2013/10/04 2:36), Erik Faye-Lund wrote:
> On Thu, Oct 3, 2013 at 7:25 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
>> I've not followed the thread so much but, in that
>> entry.c::checkout_entry,() we do:
>>
>> memcpy(path, state->base_dir, len);
>> strcpy(path + len, ce->name);
>>
>> which can of course result in memory violation if PATH is not long enough.
>>
>
> ...aaand you're spot on. The following patch illustrates it:
>
> $ /git/git-clone.exe mingw-checkout-crash.git
> Cloning into 'mingw-checkout-crash'...
> done.
> fatal: argh, this won't work!
> warning: Clone succeeded, but checkout failed.
> You can inspect what was checked out with 'git status'
> and retry the checkout with 'git checkout -f HEAD'
>
> ---
>
> diff --git a/entry.c b/entry.c
> index acc892f..505638e 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -244,6 +244,9 @@ int checkout_entry(struct cache_entry *ce,
>    if (topath)
>    return write_entry(ce, topath, state, 1);
>
> + if (len > PATH_MAX || len + strlen(ce->name) > PATH_MAX)
> + die("argh, this won't work!");
> +
>    memcpy(path, state->base_dir, len);
>    strcpy(path + len, ce->name);
>    len += ce_namelen(ce);
>
>
>> On Thu, Oct 3, 2013 at 12:26 AM, Wataru Noguchi <wnoguchi.0727@gmail.com> wrote:
>>> Hi,
>>>
>>> At last, I foundfollowing Makefile optimization suppression works fine in my
>>> case.
>>>
>>> CFLAGS = -g -O2 -fno-inline-small-functions -Wall
>>>
>>> Following optimization option cause crash,
>>>
>>> -finline-small-functions
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
================================
   Wataru Noguchi
   wnoguchi.0727@gmail.com
   http://wnoguchi.github.io/
================================

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
