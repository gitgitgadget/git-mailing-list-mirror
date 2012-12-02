From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 1/5] mingw: make fgetc raise SIGINT if apropriate
Date: Sun, 02 Dec 2012 02:42:07 -0800
Message-ID: <7vfw3oka68.fsf@alter.siamese.dyndns.org>
References: <1352815447-8824-1-git-send-email-kusmabite@gmail.com>
 <1352815447-8824-2-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org,  msysgit@googlegroups.com,  peff@peff.net
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRBAXB5SCQKGQEWIFYIEA@googlegroups.com Sun Dec 02 11:42:27 2012
Return-path: <msysgit+bncBCG77UMM3EJRBAXB5SCQKGQEWIFYIEA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gg0-f186.google.com ([209.85.161.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBAXB5SCQKGQEWIFYIEA@googlegroups.com>)
	id 1Tf70C-0008VB-06
	for gcvm-msysgit@m.gmane.org; Sun, 02 Dec 2012 11:42:24 +0100
Received: by mail-gg0-f186.google.com with SMTP id y6sf1810484ggc.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 02 Dec 2012 02:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version:x-pobox-relay-id
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type;
        bh=g2IfoQ/gKTEbmZMM7qENivIazryHl1jNxU9d2uyh9z0=;
        b=p2IF4zOJAwIpLlPYnrpUmi3E7c3qHaOhaUBLmqtywtlqqwUjES6cY+dAP4cEZi29L5
         yoQFPFnBykhyeJ2nDZ7cQfmESA6uGxLdlcZiV3apkFk07BcE1l1+eP6wtj/Remj4rSzk
         y6uenlFAxBaHnNZfQKiRDCi1cS51InwdxrhKnBAq0iEdPSQd8hKaQlwohUIxqTBgjwTe
         evdfy+rCHwIJ6EJ7LMbR7vkQUGRyUINTP7r/pi/sVdmBrBx9GSh5ZQRDdspdcGFJmf7n
         iTtKiYEn9NjuNVwGYfGB0HNAG0c8z7MkVq1IGKSZIAGXDeve/01XBAFKDZZw7ONF130W
         9 
Received: by 10.49.95.68 with SMTP id di4mr1603998qeb.0.1354444931775;
        Sun, 02 Dec 2012 02:42:11 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.37.105 with SMTP id x9ls1170243qej.56.gmail; Sun, 02 Dec
 2012 02:42:10 -0800 (PST)
Received: by 10.58.132.145 with SMTP id ou17mr2279610veb.41.1354444930297;
        Sun, 02 Dec 2012 02:42:10 -0800 (PST)
Received: by 10.58.132.145 with SMTP id ou17mr2279609veb.41.1354444930287;
        Sun, 02 Dec 2012 02:42:10 -0800 (PST)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id q13si2165529vdh.0.2012.12.02.02.42.10;
        Sun, 02 Dec 2012 02:42:10 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05D0F6663;
	Sun,  2 Dec 2012 05:42:10 -0500 (EST)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5F4E6662;
	Sun,  2 Dec 2012 05:42:09 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 639B86661; Sun,  2 Dec 2012
 05:42:09 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EC5C85C2-3C6C-11E2-82E9-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 best guess record for domain of junio@b-sasl-quonix.pobox.com designates
 208.72.237.35 as permitted sender) smtp.mail=junio@b-sasl-quonix.pobox.com;
 dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211009>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> @@ -1538,13 +1563,7 @@ static sig_handler_t timer_fn = SIG_DFL;
>  static unsigned __stdcall ticktack(void *dummy)
>  {
>  	while (WaitForSingleObject(timer_event, timer_interval) == WAIT_TIMEOUT) {
> -		if (timer_fn == SIG_DFL) {
> -			if (isatty(STDERR_FILENO))
> -				fputs("Alarm clock\n", stderr);
> -			exit(128 + SIGALRM);
> -		}
> -		if (timer_fn != SIG_IGN)
> -			timer_fn(SIGALRM);
> +		mingw_raise(SIGALRM);
>  		if (one_shot)
>  			break;
>  	}

This hunk seems to have been based on a slightly newer codebase than
what I have, and I had to wiggle the patch a bit to make the series
apply.  Please double check the result when I push out the 'pu'
branch.

Thanks.

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
