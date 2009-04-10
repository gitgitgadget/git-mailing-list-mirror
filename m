From: Marius Storm-Olsen <marius@storm-olsen.com>
Subject: Re: [PATCH] MinGW readdir reimplementation to support
 d_type
Date: Fri, 10 Apr 2009 09:50:08 +0200
Message-ID: <49DEFA30.1000101@gmail.com>
References: <1239224507-5372-1-git-send-email-marius@trolltech.com> <49DE5BDE.9050709@kdbg.org>
Reply-To: marius@storm-olsen.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: marius@trolltech.com, git@vger.kernel.org, msysgit@googlegroups.com
To: j6t@kdbg.org
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Fri Apr 10 09:51:57 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gx0-f203.google.com ([209.85.217.203])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsBWm-0004L5-Md
	for gcvm-msysgit@m.gmane.org; Fri, 10 Apr 2009 09:51:56 +0200
Received: by gxk27 with SMTP id 27so255954gxk.21
        for <gcvm-msysgit@m.gmane.org>; Fri, 10 Apr 2009 00:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:received:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:reply-to:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        bh=b3HerQpReS7oQa83xi2+d69da5JT6GRdNe4jdK5IFQQ=;
        b=BgW5OiQLZurQLl7JgF+d45pWb3J7A2AJIgBAgPHrFJXAZbxBEnJKv31ipNq2VpwQYW
         ilH0SXxH1oJDGIjO0dkmnacTw1isbgYcPGD05IbyU4yltZP5CnMW1cfP2e8hGTnXkL9w
         3j27HUYgcu4jETBxQa9umamYxi0EWKDhnve48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :reply-to:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        b=58feUIMNIGgD3kWzljuKYe1mxax3UG2cZEVhY7k4Ll2ZN5uUM178EhE6bRlwf4GiGw
         1DgrmpWVCyX0Mmm43h9lGvcLLNeHrMVwQNYPxHILLoQmmzxZ0ZA9zGjDJPtQxUR40y8m
         5jPMP4nv224oY8OiIR7/R50scckHVsWK6UKtc=
Received: by 10.90.106.4 with SMTP id e4mr126520agc.3.1239349820478;
        Fri, 10 Apr 2009 00:50:20 -0700 (PDT)
Received: by 10.177.2.5 with SMTP id e5gr4756yqi.0;
	Fri, 10 Apr 2009 00:50:20 -0700 (PDT)
X-Sender: marius@storm-olsen.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.50.5 with SMTP id x5mr2093285agx.6.1239349819938; Fri, 10 Apr 2009 00:50:19 -0700 (PDT)
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28]) by gmr-mx.google.com with ESMTP id 7si69679yxg.4.2009.04.10.00.50.19; Fri, 10 Apr 2009 00:50:19 -0700 (PDT)
Received-SPF: neutral (google.com: 74.125.46.28 is neither permitted nor denied by best guess record for domain of marius@storm-olsen.com) client-ip=74.125.46.28;
Authentication-Results: gmr-mx.google.com; spf=neutral (google.com: 74.125.46.28 is neither permitted nor denied by best guess record for domain of marius@storm-olsen.com) smtp.mail=marius@storm-olsen.com
Received: by yw-out-2324.google.com with SMTP id 3so691232ywj.71 for <msysgit@googlegroups.com>; Fri, 10 Apr 2009 00:50:19 -0700 (PDT)
Received: by 10.100.207.14 with SMTP id e14mr1914058ang.139.1239349819724; Fri, 10 Apr 2009 00:50:19 -0700 (PDT)
Received: from ?192.168.0.196? (cm-84.215.55.206.getinternet.no [84.215.55.206]) by mx.google.com with ESMTPS id c14sm4378505ana.1.2009.04.10.00.50.17 (version=SSLv3 cipher=RC4-MD5); Fri, 10 Apr 2009 00:50:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.21) Gecko/20090302 Thunderbird/2.0.0.21 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <49DE5BDE.9050709@kdbg.org>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116244>


Johannes Sixt said the following on 09.04.2009 22:34:
> Marius Storm-Olsen schrieb:
>> +struct mingw_dirent
>> +{
>> +	long		d_ino;			/* Always zero. */
>> +	union {
>> +		unsigned short	d_reclen;	/* Always zero. */
>> +		unsigned char   d_type;		/* Reimplementation adds this */
>> +	};
> 
> VERY sneaky! I was wondering why you could get away without replacing
> opendir and closedir, and why you still defined a replacement
> mingw_DIR that contains the replacement mingw_dirent, until I noticed
> this unnamed union.
> 
> Since we don't use d_reclen anywhere in the code, wouldn't you get
> away with
> 
> #define d_type d_reclen
> 
> unless the type (short vs. char) makes a difference. Or would you say
> that doing that would be even more sneaky?

I'm sure it could be done just with a define. However, given the 
remaining unused variables, I was wondering about also packing in 
permission bits and file modification time in there, to optimize the 
status checking even further. That way, on Windows, we would only need 
one 'readdir' pass to check the whole repository, with no lstats 
whatsoever. So, this was patch was a 'primer' for that, hence the union 
with a proper uchar for the d_type.

However, that would also mean a significant change in the status 
checking code, as it first lstat's ever file in the index, then uses 
read_directory + lstat's for others. I guess that'll be too big of a 
change in core code, so the vision is moot?

I'd be ok to just use the define, provided that it compiles cleanly of 
course, if the above seems too ambitious. :-) I kinda feel like the 
current code is more clean though :)

--
.marius
