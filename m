From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] config: use chmod() instead of fchmod()
Date: Wed, 16 Jul 2014 15:16:00 -0700
Message-ID: <xmqqlhrtq7a7.fsf@gitster.dls.corp.google.com>
References: <20140712075035.GA12400@ucw.cz>
	<1405431797-20899-1-git-send-email-kasal@ucw.cz>
	<xmqq38e2wkkh.fsf@gitster.dls.corp.google.com>
	<53C5B0A1.4060502@gmail.com> <53C5B126.6020404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stepan Kasal <kasal@ucw.cz>,  Johannes Sixt <j6t@kdbg.org>,  GIT Mailing-list <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRBKHTTOPAKGQE3B6WEWQ@googlegroups.com Thu Jul 17 00:16:10 2014
Return-path: <msysgit+bncBCG77UMM3EJRBKHTTOPAKGQE3B6WEWQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yh0-f63.google.com ([209.85.213.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBKHTTOPAKGQE3B6WEWQ@googlegroups.com>)
	id 1X7XUf-0001YR-TP
	for gcvm-msysgit@m.gmane.org; Thu, 17 Jul 2014 00:16:10 +0200
Received: by mail-yh0-f63.google.com with SMTP id b6sf251543yha.18
        for <gcvm-msysgit@m.gmane.org>; Wed, 16 Jul 2014 15:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=H+6ZxS5tAqKQHgDkFZn19zwX3jiRQ3FWWAEPFMAQDZM=;
        b=KqnzdI28zVmZNMszbXln8y7hELLAaC3LuXq9AOeVT94nuHF8bW03M77QUiNPeFNFF5
         qotbTzKMqKHQ0MLbn8khcxgh7Raw55WhB7rpddtaX5SoNzZqNIdi+lW7rQqJIldURPHv
         XiSMZhf1YtWrL2VqPq7YsSpu/+kyPy4w8oXWz3XnjZ3nNpFZKjxYJKBCn08m9+Khhwqc
         Nzgglm28dFGqYToWcj4zRrKbsgRDKmvrKEDwiJod7jh2I5K0V5DXr6UeaUiEhOO0RXHH
         3JYR2l3jmdlhyunfvi8ngfFGamMhRESoapeD94H9v9U7/jWi+ugeoulDm1W9jQ1Xg5M9
         W+aw==
X-Received: by 10.182.3.2 with SMTP id 2mr244226oby.10.1405548968946;
        Wed, 16 Jul 2014 15:16:08 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.5.103 with SMTP id r7ls553728obr.9.gmail; Wed, 16 Jul 2014
 15:16:07 -0700 (PDT)
X-Received: by 10.182.197.204 with SMTP id iw12mr15490580obc.17.1405548967903;
        Wed, 16 Jul 2014 15:16:07 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id l23si73756yhg.1.2014.07.16.15.16.07
        for <msysgit@googlegroups.com>;
        Wed, 16 Jul 2014 15:16:07 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8EFAF2A9F9;
	Wed, 16 Jul 2014 18:16:07 -0400 (EDT)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 858922A9F8;
	Wed, 16 Jul 2014 18:16:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DA01B2A9F0;
	Wed, 16 Jul 2014 18:16:01 -0400 (EDT)
In-Reply-To: <53C5B126.6020404@gmail.com> (Karsten Blees's message of "Wed, 16
	Jul 2014 00:54:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C5652D7E-0D36-11E4-8BF0-9903E9FBB39C-77302942!pb-smtp0.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted
 sender) smtp.mail=junio@pobox.com;       dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253699>

Karsten Blees <karsten.blees@gmail.com> writes:

> There is no fchmod() on native Windows platforms (MinGW and MSVC), and the
> equivalent Win32 API (SetFileInformationByHandle) requires Windows Vista.
>
> Use chmod() instead.
>
> Signed-off-by: Karsten Blees <blees@dcon.de>
> ---

I am wondering if it is saner to just revert the fchmod() patch and
replace it with something along the lines of

http://thread.gmane.org/gmane.comp.version-control.git/251682/focus=253219

Having said that, these are the only two callers of fchmod()
currently in our code base, so I'll queue this patch to allow us to
kick the problem-can down the road ;-)

Thanks.

>  config.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/config.c b/config.c
> index ba882a1..9767c4b 100644
> --- a/config.c
> +++ b/config.c
> @@ -1636,8 +1636,8 @@ int git_config_set_multivar_in_file(const char *config_filename,
>  			MAP_PRIVATE, in_fd, 0);
>  		close(in_fd);
>  
> -		if (fchmod(fd, st.st_mode & 07777) < 0) {
> -			error("fchmod on %s failed: %s",
> +		if (chmod(lock->filename, st.st_mode & 07777) < 0) {
> +			error("chmod on %s failed: %s",
>  				lock->filename, strerror(errno));
>  			ret = CONFIG_NO_WRITE;
>  			goto out_free;
> @@ -1815,8 +1815,8 @@ int git_config_rename_section_in_file(const char *config_filename,
>  
>  	fstat(fileno(config_file), &st);
>  
> -	if (fchmod(out_fd, st.st_mode & 07777) < 0) {
> -		ret = error("fchmod on %s failed: %s",
> +	if (chmod(lock->filename, st.st_mode & 07777) < 0) {
> +		ret = error("chmod on %s failed: %s",
>  				lock->filename, strerror(errno));
>  		goto out;
>  	}
> -- 
> 2.0.1.779.g26aeac4.dirty
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
For more options, visit https://groups.google.com/d/optout.
