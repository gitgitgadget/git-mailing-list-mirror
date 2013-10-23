From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] entry.c: convert checkout_entry to use strbuf
Date: Wed, 23 Oct 2013 11:09:27 -0700
Message-ID: <xmqqa9hzrh9k.fsf@gitster.dls.corp.google.com>
References: <20131021193223.GC29681@sigill.intra.peff.net>
	<1382532907-30561-1-git-send-email-pclouds@gmail.com>
	<20131023172914.GA6824@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
  git@vger.kernel.org,  Erik Faye-Lund <kusmabite@gmail.com>,  Johannes
 Sixt <j6t@kdbg.org>,  Antoine Pelisse <apelisse@gmail.com>,  Torsten
 =?utf-8?Q?B=C3=83=C2=B6gershausen?= <tboegi@web.de>,  Wataru Noguchi
 <wnoguchi.0727@gmail.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  =?utf-8?B?UmVuw4PCqQ==?= Scharfe
 <l.s.r@web.de>,  msysGit <msysgit@googlegroups.com>
To: Jeff King <peff@peff.net>
X-From: msysgit+bncBCG77UMM3EJRBWVBUCJQKGQEUWFGT4Q@googlegroups.com Wed Oct 23 20:09:34 2013
Return-path: <msysgit+bncBCG77UMM3EJRBWVBUCJQKGQEUWFGT4Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gg0-f187.google.com ([209.85.161.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBWVBUCJQKGQEUWFGT4Q@googlegroups.com>)
	id 1VZ2s8-0000Nn-9m
	for gcvm-msysgit@m.gmane.org; Wed, 23 Oct 2013 20:09:32 +0200
Received: by mail-gg0-f187.google.com with SMTP id s5sf253191ggc.4
        for <gcvm-msysgit@m.gmane.org>; Wed, 23 Oct 2013 11:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=tPiWbw22Ce1n25hJuzUQxTaDeUoPFTTXkHVlCrD+dWU=;
        b=N7EPTZOhMfnU8eDMvvklV60LxfRwCUdACgsRdFDVlcKufixRgXLKkwSGZVQVROCIUP
         vtlleAL8GJZVhgpyNV2Bq01cDoR8YYL6Xe7P0tzWVyhgniQMYLFsc6fxmlKUnuFn/xhL
         3NIkyNdKf0AjW3oE5C8tBY/dlQ9oZyE4+O7p172dnHyCawiARaxJkaQAulDz7DEP9X7A
         CTM9c/vYkS+eQVkrSemCgX40uJM2rsAYQ5UEe1/A2ZE116yNvBomXaOWA+/u3fsr0Uig
         R55s3xB77m+xyrC8GHVJhBXsedNzRjcGTCsBeGpxMk96aFKQXNecTdYssVbiAx7nkOCY
         WeSg==
X-Received: by 10.50.80.78 with SMTP id p14mr97686igx.6.1382551771323;
        Wed, 23 Oct 2013 11:09:31 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.101.51 with SMTP id fd19ls3124418igb.10.canary; Wed, 23 Oct
 2013 11:09:30 -0700 (PDT)
X-Received: by 10.66.218.99 with SMTP id pf3mr1725709pac.8.1382551770381;
        Wed, 23 Oct 2013 11:09:30 -0700 (PDT)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id r18si2585365vds.2.2013.10.23.11.09.30
        for <msysgit@googlegroups.com>;
        Wed, 23 Oct 2013 11:09:30 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of jch@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A3CC4D4EE;
	Wed, 23 Oct 2013 18:09:30 +0000 (UTC)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED4554D4ED;
	Wed, 23 Oct 2013 18:09:29 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 339094D4E9;
	Wed, 23 Oct 2013 18:09:29 +0000 (UTC)
In-Reply-To: <20131023172914.GA6824@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 23 Oct 2013 13:29:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 426D9FD6-3C0E-11E3-A438-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: best guess record for domain of jch@b-sasl-quonix.pobox.com
 designates 208.72.237.35 as permitted sender) smtp.mail=jch@b-sasl-quonix.pobox.com;
       dkim=pass header.i=@pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236541>

Jeff King <peff@peff.net> writes:

> On Wed, Oct 23, 2013 at 07:55:06PM +0700, Nguyen Thai Ngoc Duy wrote:
> ...
>> -	memcpy(path, state->base_dir, len);
>> -	strcpy(path + len, ce->name);
>> -	len += ce_namelen(ce);
>> +	strbuf_reset(&path_buf);
>> +	strbuf_addf(&path_buf, "%.*s%s", state->base_dir_len, state->base_dir, ce->name);
>> +	path = path_buf.buf;
>> +	len = path_buf.len;
>
> This is not something you introduced, but while we are here, you may
> want to use ce->namelen, which would be a little faster than treating it
> as a string (especially for strbuf, as it can then know up front how big
> the size is).

Hmmmm, do you mean something like this on top?

diff --git a/entry.c b/entry.c
index d955af5..0d48292 100644
--- a/entry.c
+++ b/entry.c
@@ -246,7 +246,9 @@ int checkout_entry(struct cache_entry *ce,
 		return write_entry(ce, topath, state, 1);
 
 	strbuf_reset(&path_buf);
-	strbuf_addf(&path_buf, "%.*s%s", state->base_dir_len, state->base_dir, ce->name);
+	strbuf_addf(&path_buf, "%.*s%.*s",
+		    state->base_dir_len, state->base_dir,
+		    ce_namelen(ce), ce->name);
 	path = path_buf.buf;
 	len = path_buf.len;
 

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
