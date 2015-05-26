From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] http-backend: spool ref negotiation requests to buffer
Date: Mon, 25 May 2015 20:43:08 -0700
Message-ID: <xmqqk2vw80mr.fsf@gitster.dls.corp.google.com>
References: <20150520073526.GA16784@peff.net> <20150520073709.GC9818@peff.net>
	<CAMwyc-Tn+Sw67z9zTPsPU7SQP7PDzJhoJn30utQ0OWhKe_xbuA@mail.gmail.com>
	<20150526022401.GA1725@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 26 05:47:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yx5qP-0006xf-Bh
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 05:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbbEZDnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 23:43:11 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:36423 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbbEZDnK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2015 23:43:10 -0400
Received: by igbpi8 with SMTP id pi8so48281969igb.1
        for <git@vger.kernel.org>; Mon, 25 May 2015 20:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ZGrnc49mNktIRSYDmUFxJst1pHt5Fd/G9QCv7XE7uXs=;
        b=X7dUaMKsXSxUVZiv6wLxFFMgWvy5nkrR2Q6y+Jcr81FaLNs3XDk9I5hnSK3vfNotDW
         4fJXHq/LaCyJ4QzDlsZDUEXIIzgGYMo1kg9uTpmleeQzSIJR1Or7xkpyXeik2St0/tdC
         oettlhNkoX2a3Wr8/+a26/YJ6rGzdSqcMsMm6ifZ2Xh8HVCROVdccFNVQI4h2iA2HhsF
         CZRt8n+YZIV1mhU82kcbtc42mZFoYlBvsS7UT9ovd23FE8nO0sk5aqxJLgYq+wwBIJL/
         du0XOmJT52xtpzgDM8mbogKsAjwlIw4rjq/HYwm4hb0mjm5IIgGVl1pXm/b5uRVclsCX
         JiXA==
X-Received: by 10.50.72.8 with SMTP id z8mr27484903igu.36.1432611789739;
        Mon, 25 May 2015 20:43:09 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f93e:abc0:fe54:4a5a])
        by mx.google.com with ESMTPSA id o21sm10178072ioo.31.2015.05.25.20.43.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 May 2015 20:43:09 -0700 (PDT)
In-Reply-To: <20150526022401.GA1725@peff.net> (Jeff King's message of "Mon, 25
	May 2015 22:24:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269928>

Jeff King <peff@peff.net> writes:

> Whoops, yeah, it was just for debugging. I missed that one when sending
> out the patch.
>
> Junio, the squashable patch is below (on jk/http-backend-deadlock-2.2),
> and it looks like nothing has hit "next" yet. But you did do some
> up-merging of the topic. Let me know if you would prefer to just have a
> patch on top.

Sorry, I missed that, too (actually I saw warning() and said "Heh,
OK", without realizing that this is a normal return path).

Thanks.

>
> diff --git a/http-backend.c b/http-backend.c
> index d1333b8..6bf139b 100644
> --- a/http-backend.c
> +++ b/http-backend.c
> @@ -295,7 +295,6 @@ static ssize_t read_request(int fd, unsigned char **out)
>  		len += cnt;
>  		if (len < alloc) {
>  			*out = buf;
> -			warning("request size was %lu", (unsigned long)len);
>  			return len;
>  		}
>  
>
> -Peff
