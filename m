From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] Prevent buffer overflows when path is too long
Date: Fri, 29 Nov 2013 13:12:02 +0100
Message-ID: <CALWbr2wNNxkFrzxVvCzkQkm34M=6CiBvmnqjm+p73H1MoFoD7A@mail.gmail.com>
References: <CACsJy8AooiUNRfnqDLBmx=KPnztjdNuF4bYY2b=Egs3gdiW6KA@mail.gmail.com>
	<1385491163-18407-1-git-send-email-apelisse@gmail.com>
	<xmqqwqjvuelv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>, =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>, 
	Wataru Noguchi <wnoguchi.0727@gmail.com>, Erik Faye-Lund <kusmabite@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBD3NZH6HQMJBBE4J4KKAKGQEZCHB7WQ@googlegroups.com Fri Nov 29 13:12:04 2013
Return-path: <msysgit+bncBD3NZH6HQMJBBE4J4KKAKGQEZCHB7WQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ea0-f186.google.com ([209.85.215.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBD3NZH6HQMJBBE4J4KKAKGQEZCHB7WQ@googlegroups.com>)
	id 1VmMvU-00057v-0N
	for gcvm-msysgit@m.gmane.org; Fri, 29 Nov 2013 13:12:04 +0100
Received: by mail-ea0-f186.google.com with SMTP id k10sf974863eaj.23
        for <gcvm-msysgit@m.gmane.org>; Fri, 29 Nov 2013 04:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=2oivnrV1ZABzETnw6rmjFbz6OkD5kUkE02/Gdraapo0=;
        b=Npz9mobNSp9Nwz0+q0UfYVPxpelp/3kd1cDjNxAgy5InSC64pfOGUTznsM8N/IbKXn
         O1KVD07i9S6ViGV8tGuLAaFWBeVZflbVmYsp044wgiqHkS74DFVWXoicC8qCOMFjUT+s
         VhIeLWbbBGC3R74Qugm6sYzkufn6qP9O2r0zlACleBN3SuW15lmy4eyy8oDZbNlKosTy
         IpMfmRg/ZwtyAua5uvkjZKqS/1ClswVlS4BxsGjINdhEgi2ix6BgVLAxK2+IMkBdyvPW
         a2Ns3qcBZBNdPt8on4xdr/93S/jabX8RemEtlLO1iyuoSLamM8cVbJ/xOlY7PwbnwoWu
         0pqA==
X-Received: by 10.180.206.164 with SMTP id lp4mr57735wic.2.1385727123706;
        Fri, 29 Nov 2013 04:12:03 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.91.135 with SMTP id ce7ls278902wib.45.gmail; Fri, 29 Nov
 2013 04:12:02 -0800 (PST)
X-Received: by 10.204.123.8 with SMTP id n8mr9545232bkr.7.1385727122889;
        Fri, 29 Nov 2013 04:12:02 -0800 (PST)
Received: from mail-la0-x229.google.com (mail-la0-x229.google.com [2a00:1450:4010:c03::229])
        by gmr-mx.google.com with ESMTPS id h3si6089946bki.0.2013.11.29.04.12.02
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 29 Nov 2013 04:12:02 -0800 (PST)
Received-SPF: pass (google.com: domain of apelisse@gmail.com designates 2a00:1450:4010:c03::229 as permitted sender) client-ip=2a00:1450:4010:c03::229;
Received: by mail-la0-f41.google.com with SMTP id eo20so6756982lab.14
        for <msysgit@googlegroups.com>; Fri, 29 Nov 2013 04:12:02 -0800 (PST)
X-Received: by 10.112.53.134 with SMTP id b6mr34394597lbp.5.1385727122573;
 Fri, 29 Nov 2013 04:12:02 -0800 (PST)
Received: by 10.112.134.135 with HTTP; Fri, 29 Nov 2013 04:12:02 -0800 (PST)
In-Reply-To: <xmqqwqjvuelv.fsf@gitster.dls.corp.google.com>
X-Original-Sender: apelisse@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of apelisse@gmail.com designates 2a00:1450:4010:c03::229
 as permitted sender) smtp.mail=apelisse@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238526>

On Tue, Nov 26, 2013 at 8:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Antoine Pelisse <apelisse@gmail.com> writes:
>
>> Some buffers created with PATH_MAX length are not checked when being
>> written, and can overflow if PATH_MAX is not big enough to hold the
>> path.
>
> Perhaps it is time to update all of them to use strbuf?  The callers
> of prefix_filename() aren't that many, and all of them are prepared
> to stash the returned value away when they keep it longer term, so
> they would not notice if we used "static struct strbuf path" and
> gave back "path.buf" (without strbuf_detach() on it).  The buffer
> used in clear_ce_flags() and passed to clear_ce_flags_{1,dir} are
> not seen outside the callchain, and can safely become strbuf, I
> think.

Let's do that, but shouldn't we also modify those that are currently
safe, like absolute_path() just above prefix_filename() ?

>>  abspath.c        | 10 ++++++++--
>>  diffcore-order.c | 14 +++++++++-----
>>  unpack-trees.c   |  2 ++
>>  3 files changed, 19 insertions(+), 7 deletions(-)
>>
>> diff --git a/abspath.c b/abspath.c
>> index e390994..29a5f9d 100644
>> --- a/abspath.c
>> +++ b/abspath.c
>> @@ -216,11 +216,16 @@ const char *absolute_path(const char *path)
>>  const char *prefix_filename(const char *pfx, int pfx_len, const char *arg)
>>  {
>>       static char path[PATH_MAX];
>> +
>> +     if (pfx_len >= PATH_MAX)
>> +             die("Too long prefix path: %s", pfx);
>
> I do not think this is needed, and will reject a valid input that
> used to be accepted (e.g. arg is absolute so pfx does not matter).

My mistake

>> -     strcpy(path + pfx_len, arg);
>> +     if (strlcpy(path + pfx_len, arg, PATH_MAX - pfx_len) > PATH_MAX)
>> +             die("Too long path: %s", path);
>>       for (p = path + pfx_len; *p; p++)
>>               if (*p == '\\')
>>                       *p = '/';
>
> The above is curious. Unless we are doing the short-cut for "no
> prefix so we can just return arg" codepath, we know that the
> resulting length is always pfx_len + strlen(arg), no?

If you mean that the test should be more like the following:
+     if (strlcpy(path + pfx_len, arg, PATH_MAX - pfx_len) > PATH_MAX - pfx_len)

Then of course, you are right, that's my mistake.

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
