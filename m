From: Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH v3 02/14] mingw: implement syslog
Date: Sun, 10 Oct 2010 19:20:35 -0400
Message-ID: <4CB24A43.9090501@gmail.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com> <1286716854-5744-3-git-send-email-kusmabite@gmail.com> <4CB2190F.6000908@gmail.com> <AANLkTinsqAOj7LtACpbcOrVZfeUApDjmQe2uYLH8npBF@mail.gmail.com> <4CB22FF3.5070503@gmail.com> <AANLkTinBE14dWCecXvpH=8N1b0H=9j9tc=t07d_MHEFF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org, 
 Mike Pape <dotzenlabs@gmail.com>
To: kusmabite@gmail.com
X-From: msysgit+bncCPSUiZjBDBDNlMnlBBoEQTAZHA@googlegroups.com Mon Oct 11 01:21:12 2010
Return-path: <msysgit+bncCPSUiZjBDBDNlMnlBBoEQTAZHA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-px0-f186.google.com ([209.85.212.186])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCPSUiZjBDBDNlMnlBBoEQTAZHA@googlegroups.com>)
	id 1P55CZ-00019w-TJ
	for gcvm-msysgit@m.gmane.org; Mon, 11 Oct 2010 01:21:12 +0200
Received: by pxi18 with SMTP id 18sf2810640pxi.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 10 Oct 2010 16:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:received:received:message-id:date
         :from:user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=wYgKv4EqV0k6jOjhpppuyLGE89IKBAsX+XoakeOw1lU=;
        b=mn/FL+TX2ZVcFXUWnLS4QaX6ALWy8m7CBdhyzgWmyz7d+Dg6RAtRQWXciXq4mOVW6z
         +LkqmCuYdKd1E90dzmwyMVX2Bds1+cNnSx90cEe02YpP0BHpCmiAZ9LS0hKP47SjrW6I
         NZxAT2bgbDctCgxsT4yPc7SnvjLWJq8dfJNZA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:message-id:date:from:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        b=EM6IV5Ho340CCpQDA63W5O/6ZKSCYJHI/B+hx1w0gdaZVon9B0H0F9aypM+LBb6Vnt
         J0UW7bt4zoPvlEYnKNk/r0P/z+DrbytNJP23WqQX1DWVlPRPRHDb33UAFaSS+q9A7Ott
         CNAhobOrbSZHB3VcP63NB1K+KHVj1IawRMtO8=
Received: by 10.114.54.5 with SMTP id c5mr428581waa.2.1286752845246;
        Sun, 10 Oct 2010 16:20:45 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.115.98.19 with SMTP id a19ls2900502wam.1.p; Sun, 10 Oct 2010
 16:20:43 -0700 (PDT)
Received: by 10.114.67.11 with SMTP id p11mr2249361waa.38.1286752843040;
        Sun, 10 Oct 2010 16:20:43 -0700 (PDT)
Received: by 10.114.67.11 with SMTP id p11mr2249360waa.38.1286752843012;
        Sun, 10 Oct 2010 16:20:43 -0700 (PDT)
Received: from mail-px0-f180.google.com (mail-px0-f180.google.com [209.85.212.180])
        by gmr-mx.google.com with ESMTP id t26si6336014wak.1.2010.10.10.16.20.41;
        Sun, 10 Oct 2010 16:20:42 -0700 (PDT)
Received-SPF: pass (google.com: domain of ericsunshine@gmail.com designates 209.85.212.180 as permitted sender) client-ip=209.85.212.180;
Received: by pxi5 with SMTP id 5so19579pxi.39
        for <msysgit@googlegroups.com>; Sun, 10 Oct 2010 16:20:41 -0700 (PDT)
Received: by 10.114.75.17 with SMTP id x17mr6160355waa.66.1286752841858;
        Sun, 10 Oct 2010 16:20:41 -0700 (PDT)
Received: from [192.168.1.1] (user-12l2cil.cable.mindspring.com [69.81.50.85])
        by mx.google.com with ESMTPS id d31sm9339637wam.5.2010.10.10.16.20.39
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 16:20:40 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <AANLkTinBE14dWCecXvpH=8N1b0H=9j9tc=t07d_MHEFF@mail.gmail.com>
X-Original-Sender: ericsunshine@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of ericsunshine@gmail.com designates 209.85.212.180 as permitted
 sender) smtp.mail=ericsunshine@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158728>

On 10/10/2010 6:16 PM, Erik Faye-Lund wrote:
> On Sun, Oct 10, 2010 at 11:28 PM, Eric Sunshine<ericsunshine@gmail.com>  wrote:
>> On 10/10/2010 4:37 PM, Erik Faye-Lund wrote:
>>> This is the result of the feed-back in v1, where we tried to implement
>>> all format strings. But that turned out to be very complex (due to the
>>> lack of a portable va_copy()) and since we control all call-sites for
>>> syslog and already only use "%s" as the format, it should be OK.
>>
>> Do you mean vsnprintf() rather than va_copy()?
>
> The problem was lack of portable va_copy, because I tried to add a
> non-variadic version of strbuf_addf(), namely strbuf_vaddf() to do the
> work.
>
> I guess it could be implemented pretty easily with vsnprintf(),
> though. I was afraid of doing that originally because I know there's
> portability issues with the return value of snprintf. Luckily it seems
> that we have a fix for that in compat/sprintf.c, and we rely on the
> return value being correct in strbuf_addf() so it would probably be
> safe.
>
> Something like this (on top)
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index bbe45d0..e3f3f92 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1435,17 +1435,24 @@ void openlog(const char *ident, int logopt,
> int facility)
>   		warning("RegisterEventSource() failed: %lu", GetLastError());
>   }
>
> -void syslog(int priority, const char *fmt, const char *arg)
> +void syslog(int priority, const char *fmt, ...)
>   {
>   	WORD logtype;
> +	char *str;
> +	int str_len;
> +	va_list ap;
>
>   	if (!ms_eventlog)
>   		return;
>
> -	if (strcmp(fmt, "%s")) {
> -		warning("format string of syslog() not implemented");
> -		return;
> -	}
> +	va_start(ap, fmt);
> +	str_len = vsnprintf(NULL, 0, fmt, ap);
> +	va_end(ap);

vsnprintf() can return -1 on error (even the compat/snprintf.c version 
can do so), so perhaps check for this condition before the subsequent 
malloc(str_len+1)?

> +
> +	str = malloc(str_len + 1);
> +	va_start(ap, fmt);
> +	vsnprintf(str, str_len, fmt, ap);
> +	va_end(ap);
>
>   	switch (priority) {
>   	case LOG_EMERG:
> @@ -1478,8 +1485,9 @@ void syslog(int priority, const char *fmt, const
> char *arg)
>   	    NULL,
>   	    1,
>   	    0,
> -	    (const char **)&arg,
> +	    (const char **)&str,
>   	    NULL);
> +	free(str);
>   }

Other than the note about -1 return value, this revision looks fine.

>> (On the other hand, for the '%s' check above, the code does report a warning
>> and then exits, so it is not inconceivable that a '%n' could also emit a
>> warning.)
>
> I guess I could add something like this:
>
> if (strstr(arg, "%1"))
> 	warning("arg contains %1, message might be corrupted");
>
> I don't want to return in that case, because I think some output is
> better than no output, and it seems to work on Vista.

Rather than emitting a warning, it might be reasonable to perform a 
simple transformation on the string if it contains a %1 (or %n 
generally) in order to avoid ReportEvent()'s shortcoming. Even something 
as simple as inserting a space between '%' and '1' might be sufficiently 
defensive.

-- ES
