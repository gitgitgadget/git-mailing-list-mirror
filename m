From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re: [PATCH] git tag --contains : avoid stack overflow
Date: Mon, 12 Nov 2012 20:51:37 -0800
Message-ID: <7vwqxqf6li.fsf@alter.siamese.dyndns.org>
References: <1352568970-4669-1-git-send-email-jeanjacques.lafay@gmail.com>
 <03ED9D50D1F64467863C051959CFC433@PhilipOakley>
 <d9843c09-3ca9-406e-9df8-78603235d985@googlegroups.com>
 <509FD668.20609@lsrfire.ath.cx>
 <20121111165431.GA25884@sigill.intra.peff.net>
 <CA+TMuX2p4ck0qXijH+OOcBoveBC42U8PqnXdisau57RXwt1isg@mail.gmail.com>
 <20121112231453.GA21679@sigill.intra.peff.net>
 <alpine.DEB.1.00.1211130114180.13573@bonsai2>
 <20121113034605.GB8387@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Jean-Jacques Lafay
 <jeanjacques.lafay@gmail.com>,  =?utf-8?Q?Ren=C3=A9?= Scharfe
 <rene.scharfe@lsrfire.ath.cx>,  msysgit@googlegroups.com,  Git List
 <git@vger.kernel.org>,  Philip Oakley <philipoakley@iee.org>
To: Jeff King <peff@peff.net>
X-From: msysgit+bncBCG77UMM3EJRBXFDQ6CQKGQEWCP4MRI@googlegroups.com Tue Nov 13 05:51:53 2012
Return-path: <msysgit+bncBCG77UMM3EJRBXFDQ6CQKGQEWCP4MRI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f186.google.com ([209.85.216.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBXFDQ6CQKGQEWCP4MRI@googlegroups.com>)
	id 1TY8TY-0008Ev-In
	for gcvm-msysgit@m.gmane.org; Tue, 13 Nov 2012 05:51:52 +0100
Received: by mail-qc0-f186.google.com with SMTP id y9sf5516430qcp.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 12 Nov 2012 20:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version:x-pobox-relay-id
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type;
        bh=7IzQV/PfMYxk2ezpGn2cH3Edd5z+4NRpzCQQGeBehZU=;
        b=rEKVSmFORl1kyQ5Qu7eHshbY5lwRkoiHSJqdI5dnzZOna7MdTTdUvvjIkMO1AsoZs0
         H7py3IScJ6vpu2Cut3j6P4iP8YXrnbmLaB8EDRGQTeBG597aJCY7Fm3x0vcDbcejKTHz
         niNEX3RzvSCYD0NIArAMsDwbAcr2pk7qk0/3CORw/lnZzH7AO8ANXZMBs4AeTgwJjGAm
         JFv2eIG23VV2ez2+iMRh+w8mluKK3ZREMVNDt8H+laMooJyLpzak1oRFRidxu0UZ3Wxm
         NawJ7qRKON2a0p0vhefqfGaEx3y2P1HsVA0y8VUzeTBm5Pg6yHoYmZV7GzLBzz3qmYb 
Received: by 10.52.71.82 with SMTP id s18mr4163160vdu.9.1352782302308;
        Mon, 12 Nov 2012 20:51:42 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.52.65.108 with SMTP id w12ls8613469vds.4.gmail; Mon, 12 Nov
 2012 20:51:40 -0800 (PST)
Received: by 10.58.246.37 with SMTP id xt5mr7090374vec.13.1352782300517;
        Mon, 12 Nov 2012 20:51:40 -0800 (PST)
Received: by 10.58.246.37 with SMTP id xt5mr7090372vec.13.1352782300508;
        Mon, 12 Nov 2012 20:51:40 -0800 (PST)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id q19si3035640vds.3.2012.11.12.20.51.40;
        Mon, 12 Nov 2012 20:51:40 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D39839D98;
	Mon, 12 Nov 2012 23:51:39 -0500 (EST)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BFACB9D97;
	Mon, 12 Nov 2012 23:51:39 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 347CE9D95; Mon, 12 Nov 2012
 23:51:39 -0500 (EST)
In-Reply-To: <20121113034605.GB8387@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 12 Nov 2012 22:46:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CF8EDAA4-2D4D-11E2-8FB3-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209571>

Jeff King <peff@peff.net> writes:

> Yeah. We tolerate a certain amount of skew (24 hours for --name-rev, and
> 5 broken commits in a row for --since). But the big ones are usually
> software bugs (the big kernel ones were from broken "guilt", I think) or
> broken imports (when I published a bunch of skew statistics last year,
> the interesting ones were all imports; I don't know if they were
> software bugs, or just garbage in, garbage out).

I was hoping that 2e6bdd3 (test-generation: compute generation
numbers and clock skews, 2012-09-04) may be a good first step to
come up with a practical and cheap solution on top of it.

The traversal can be fooled by clock skews when it sees a commit
that has a timestamp that is older than it should, causing it to
give up, incorrectly thinking that there won't be newer commits that
it is interested in behind the problematic commit.

The logic implemented by the change is to identify these problematic
commits, and we could record these commits with the value of the
timestamps they should have had (e.g. the timestamp of the newest
ancestor for each of these commits) in a notes tree.  Then the
traversal logic (commit-list-insert-by-date) could be updated use
that "corrected" timestamp instead not to be fooled by the clock
skew.

Such a notes tree can be built once and updated by only "appending",
as a commit will never acquire more ancestors in its parents chain
once it is made.

Is it too simplistic, or too costly?  In git.git we have three such
commits whose timestamp need to be corrected, while in the Linux
kernel there were 2.2k skewed commits when I counted them a few
months ago.

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
