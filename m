From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] prefer xwrite instead of write
Date: Fri, 17 Jan 2014 11:07:34 -0800
Message-ID: <xmqq4n52xw95.fsf@gitster.dls.corp.google.com>
References: <1389968230-1224-1-git-send-email-kusmabite@gmail.com>
	<20140117182148.GY18964@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Erik Faye-Lund <kusmabite@gmail.com>,  git@vger.kernel.org,  msysgit@googlegroups.com,  Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRB6764WLAKGQEG2DB36A@googlegroups.com Fri Jan 17 20:07:41 2014
Return-path: <msysgit+bncBCG77UMM3EJRB6764WLAKGQEG2DB36A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f184.google.com ([209.85.216.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRB6764WLAKGQEG2DB36A@googlegroups.com>)
	id 1W4ElZ-0000Un-4W
	for gcvm-msysgit@m.gmane.org; Fri, 17 Jan 2014 20:07:41 +0100
Received: by mail-qc0-f184.google.com with SMTP id c9sf895335qcz.21
        for <gcvm-msysgit@m.gmane.org>; Fri, 17 Jan 2014 11:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=migu94PKwM0sSquc08XWMkBncYafE/UOWU16juPunFQ=;
        b=gK3Fzi2blBDwXkIBdFWgDvrNYBjG8u/8HTpjLTczdvb6VbV1fpLqvxWfWbxa/vR1/e
         nVNJSLGal0lmqhFNPlKJNkFl8GIKvnlPG3GUHrfM11KLe8lL13LM5WuJIXglR3IpUUby
         i9xf9ReKLaTt0yJYdriVMAk8ZDYjpGg5U84YHSAUK5FoKwZUD/cx4t5IxmAg27DhciYo
         eeuPIMCPfJNXKpKQoQzN8a8ZEgzFMR0IVdaMctAJ38FGC0zG5uB09FaPa5syOfUxRQTe
         YzU767QYO81JX0g9bEt9+7/pR7I81yk9QPTkYie6FYl0wSE07OXnFZWsbAGhn11+oCQW
         glIA==
X-Received: by 10.182.199.39 with SMTP id jh7mr35438obc.25.1389985659972;
        Fri, 17 Jan 2014 11:07:39 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.121.193 with SMTP id lm1ls602528obb.35.gmail; Fri, 17 Jan
 2014 11:07:39 -0800 (PST)
X-Received: by 10.182.88.200 with SMTP id bi8mr1359636obb.43.1389985659039;
        Fri, 17 Jan 2014 11:07:39 -0800 (PST)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id pt3si2580430pac.0.2014.01.17.11.07.38
        for <msysgit@googlegroups.com>;
        Fri, 17 Jan 2014 11:07:38 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of jch@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DADA46270E;
	Fri, 17 Jan 2014 14:07:37 -0500 (EST)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9059F6270C;
	Fri, 17 Jan 2014 14:07:37 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BFA3A6270A;
	Fri, 17 Jan 2014 14:07:36 -0500 (EST)
In-Reply-To: <20140117182148.GY18964@google.com> (Jonathan Nieder's message of
	"Fri, 17 Jan 2014 10:21:48 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A0AAB00E-7FAA-11E3-AABC-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240609>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi,
>
> Erik Faye-Lund wrote:
>
>> --- a/builtin/merge.c
>> +++ b/builtin/merge.c
>> @@ -367,7 +367,7 @@ static void squash_message(struct commit *commit, struct commit_list *remotehead
>>  			sha1_to_hex(commit->object.sha1));
>>  		pretty_print_commit(&ctx, commit, &out);
>>  	}
>> -	if (write(fd, out.buf, out.len) < 0)
>> +	if (xwrite(fd, out.buf, out.len) < 0)
>>  		die_errno(_("Writing SQUASH_MSG"));
>
> Shouldn't this use write_in_full() to avoid a silently truncated result? (*)

Meaning this?  If so, I think it makes sense.

 builtin/merge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 6e108d2..a6a38ee 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -367,7 +367,7 @@ static void squash_message(struct commit *commit, struct commit_list *remotehead
 			sha1_to_hex(commit->object.sha1));
 		pretty_print_commit(&ctx, commit, &out);
 	}
-	if (xwrite(fd, out.buf, out.len) < 0)
+	if (write_in_full(fd, out.buf, out.len) != out.len)
 		die_errno(_("Writing SQUASH_MSG"));
 	if (close(fd))
 		die_errno(_("Finishing SQUASH_MSG"));



>
> [...]
>> --- a/streaming.c
>> +++ b/streaming.c
>> @@ -538,7 +538,7 @@ int stream_blob_to_fd(int fd, unsigned const char *sha1, struct stream_filter *f
>>  			goto close_and_exit;
>>  	}
>>  	if (kept && (lseek(fd, kept - 1, SEEK_CUR) == (off_t) -1 ||
>> -		     write(fd, "", 1) != 1))
>> +		     xwrite(fd, "", 1) != 1))
>
> Yeah, if we get EINTR then it's worth retrying.
>
> [...]
>> --- a/transport-helper.c
>> +++ b/transport-helper.c
>> @@ -1129,9 +1129,8 @@ static int udt_do_write(struct unidirectional_transfer *t)
>>  		return 0;	/* Nothing to write. */
>>  
>>  	transfer_debug("%s is writable", t->dest_name);
>> -	bytes = write(t->dest, t->buf, t->bufuse);
>> -	if (bytes < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
>> -		errno != EINTR) {
>> +	bytes = xwrite(t->dest, t->buf, t->bufuse);
>> +	if (bytes < 0 && errno != EWOULDBLOCK) {
>
> Here the write is limited by BUFFERSIZE, and returning to the outer
> loop to try another read when the write returns EAGAIN, like the
> original code does, seems philosophically like the right thing to do.
>
> Luckily we don't use O_NONBLOCK anywhere, so the change shouldn't
> matter in practice.  So although it doesn't do any good, using xwrite
> here for consistency should be fine.
>
> So my only worry is the (*) above.  With that change,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> -- 

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
