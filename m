From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH jk/prune-mtime] prune: close directory earlier
 during loose-object directory traversal
Date: Mon, 14 Dec 2015 11:02:25 -0800
Message-ID: <xmqqvb80kg5a.fsf@gitster.mtv.corp.google.com>
References: <55CA5EB0.1000308@kdbg.org>
	<b9cf9e2168c3b2476bb5bb134a1528be@www.dscho.org>
	<55CB85A5.5040802@kdbg.org>
	<20150812175629.GA24964@sigill.intra.peff.net>
	<xmqqvb84epyl.fsf@gitster.mtv.corp.google.com>
	<20151211194103.GA5834@sigill.intra.peff.net>
	<alpine.DEB.2.20.1512131425300.21630@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,  Johannes Sixt <j6t@kdbg.org>,  Git Mailing List <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBCG77UMM3EJRBRFEXSZQKGQETYKGNKI@googlegroups.com Mon Dec 14 20:02:31 2015
Return-path: <msysgit+bncBCG77UMM3EJRBRFEXSZQKGQETYKGNKI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ig0-f187.google.com ([209.85.213.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBRFEXSZQKGQETYKGNKI@googlegroups.com>)
	id 1a8YOD-0002hX-Sn
	for gcvm-msysgit@m.gmane.org; Mon, 14 Dec 2015 20:02:30 +0100
Received: by igbfn5 with SMTP id fn5sf28838431igb.1
        for <gcvm-msysgit@m.gmane.org>; Mon, 14 Dec 2015 11:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=EpNa/Nzdrjo/Uxz/wfKWOyBMJehZ/LjEMMnw3Oh0lIw=;
        b=p1P9Glb0nHcrWWLiXoDVFXOwd5A7pW+WPZvfKD2+QaNX7WSW/qG7FypQ1DOpU8fylD
         al53A5NboExe2zH+H1Q5cO84x3JSRSjlZgNeJbbpMQw5GXF1c3MtyXnu5MqCg2ifoKVA
         Mj9SQsT6WU5hCs3WB5oEiRu3m+ACevdKF8whBJYyHMOQ0sOxVz0+gLZg64iw1a5AmfTN
         6VAUAnBRhacS6gkaPhon52rEgW4j0tkkZQxNrZuzAzArS7np0tzlowD9Jju7FrHKYhyG
         y9IfS4u3mGZcKHr1fFWiSDulpJVp/oJvyiUn+faol7lR3MWAy7/ufX+kdDMVB1yagcv5
         rmgQ==
X-Received: by 10.182.24.8 with SMTP id q8mr418708obf.15.1450119749195;
        Mon, 14 Dec 2015 11:02:29 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.24.6 with SMTP id q6ls1766272obf.75.gmail; Mon, 14 Dec
 2015 11:02:28 -0800 (PST)
X-Received: by 10.182.22.200 with SMTP id g8mr30633494obf.0.1450119748427;
        Mon, 14 Dec 2015 11:02:28 -0800 (PST)
Received: from sasl.smtp.pobox.com (pb-smtp0.int.icgroup.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTPS id g66si376980ywf.4.2015.12.14.11.02.28
        for <msysgit@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Dec 2015 11:02:28 -0800 (PST)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A00903148B;
	Mon, 14 Dec 2015 14:02:27 -0500 (EST)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 974103148A;
	Mon, 14 Dec 2015 14:02:27 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CFE6F31489;
	Mon, 14 Dec 2015 14:02:26 -0500 (EST)
In-Reply-To: <alpine.DEB.2.20.1512131425300.21630@virtualbox> (Johannes
	Schindelin's message of "Sun, 13 Dec 2015 14:26:07 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 377AC780-A295-11E5-B60A-6BD26AB36C07-77302942!pb-smtp0.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted
 sender) smtp.mailfrom=junio@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <https://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <https://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282378>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > Sorry for reviving this old thread, but I noticed that we do not
>> > have this patch in our tree yet.  I'll queue to 'pu' for now lest I
>> > forget.  If I missed a good argument or concensus against the change
>> > please let me know, otherwise I'll fast track the change to 2.7 final
>> 
>> Ah, thanks for doing that. I noticed it when picking through "git branch
>> --no-merged pu" of your workspace a few weeks ago, but forgot to follow
>> up. I certainly have no objections.
>
> Git for Windows carries this patch since Git for Windows v2.5.0. So: no
> objection from my side, either.

Thanks!

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
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
