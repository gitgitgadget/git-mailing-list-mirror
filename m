From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/9] ref-filter: implement %(if), %(then), and %(else) atoms
Date: Fri, 02 Oct 2015 13:45:23 -0700
Message-ID: <xmqqpp0x3spo.fsf@gitster.mtv.corp.google.com>
References: <1443807546-5985-1-git-send-email-Karthik.188@gmail.com>
	<1443807546-5985-2-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 02 22:45:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zi7Cv-0002VH-WB
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 22:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbbJBUp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 16:45:28 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35297 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbbJBUpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 16:45:25 -0400
Received: by pacfv12 with SMTP id fv12so118063646pac.2
        for <git@vger.kernel.org>; Fri, 02 Oct 2015 13:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=OepDNAFV+X++CL8o1doNDhgJL2S8BwyNPOCKf3Wue78=;
        b=vyNAo9j6BEIXTeEuwv97fq8FdZPKr/wUwlbuQ3ez9odlx+l9owGpRiDAgiKSrR7ADS
         prIcOp9HrG1vYoJUJjwrkvW5ICczuuKyCzF3zf1+NNFx7p61I03dAIgbYiJfNbndmEGi
         +wNRFVR8VQK68yksgk93E4elutVKG0Dx9IdNSr0KI+GneBke/yZn51Rt2tGt6l2R60Xk
         sx5EWXkQtWUAaTtNdGKS/ulj/fiV+Dq1MompVIaAjXbfbIop7Uza5beJtkodcwpwdriT
         1jWVYofznPhT1kPuKbyhfbdt1xpS7RqmkrpO5e/vPEOboFesuaRG62sY9PiAa/14mD/K
         lYLg==
X-Received: by 10.66.221.170 with SMTP id qf10mr21751712pac.134.1443818724635;
        Fri, 02 Oct 2015 13:45:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:5831:5c0e:ce5f:86ea])
        by smtp.gmail.com with ESMTPSA id by1sm13653310pab.6.2015.10.02.13.45.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 02 Oct 2015 13:45:24 -0700 (PDT)
In-Reply-To: <1443807546-5985-2-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Fri, 2 Oct 2015 23:08:58 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278946>

Karthik Nayak <karthik.188@gmail.com> writes:

> +static int is_empty(const char * s){
> +	while (*s != '\0') {
> +		if (!isspace(*s))
> +			return 0;
> +		s++;
> +	}
> +	return 1;
> +}

My knee-jerk reaction was "why is space so special?", but if a
caller really cared, it can do "%(if:not_equal=)%(something)%(then)"
to unignore spaces in %(something), so it is not a huge deal.  It
may be that ignoring spaces when checking if something is empty is
so common that this default is useful---I cannot tell offhand.


> +if::
> +	Used as %(if)..%(then)..(%end) or %(if)..%(then)..%(else)..%(end).
> +	If there is an atom with value or string literal after the
> +	%(if) then everything after the %(then) is printed, else if
> +	the %(else) atom is used, then everything after %(else) is
> +	printed.

I notice that "we ignore space when evaluating the string before
%(then)" is not mentioned here.  That fact, and an example or two
that illustrates the situation where this "ignore spaces" behaviour
is useful, would be a good thing to document here.

Thanks.
