From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] progress: no progress in background
Date: Tue, 19 May 2015 09:12:29 -0700
Message-ID: <xmqqwq048s2a.fsf@gitster.dls.corp.google.com>
References: <20150415093418.GH23475@mewburn.net>
	<20150519051752.GA16173@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Luke Mewburn <luke@mewburn.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 19 18:12:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yuk8D-0001Xu-Cj
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 18:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755941AbbESQMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 12:12:32 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36383 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753804AbbESQMb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 12:12:31 -0400
Received: by igbpi8 with SMTP id pi8so79773647igb.1
        for <git@vger.kernel.org>; Tue, 19 May 2015 09:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=QpLnEkQYx8r0IQlIZt6AH2d1GcMnU+lNh1QMU/4JfPE=;
        b=vdEik04xRH+eHTtzpLZaNK6125MCrlYlRRHQMVEWiOQ3EY53kn0W3+2AiGI4GIGybs
         qmYHsIHjZ4j51FhRQ/2pbaO/HpO5o8CB+UkbiOfZHSGHUzrPAHXr7Svi/m70lRZbZWQh
         zMxfTGeJumwntcrGg3lqXWZ0An3dek1mJ8UiMyNrajPMAHVPbFmwARObxv/3OX7b81uP
         LHV59Aar+41UKgsUBYi/iHo4Irr2XHlJAhLQHfVFL5R0TAB7n8JOTTU2YAP9qRh3zwAa
         qragxqwL8I0dUI9sfmHufTGIeyq0LsuqmzhAc7klzD1nNr3h/52+7xNbZdUIzI9zWl7F
         8+Jg==
X-Received: by 10.43.178.195 with SMTP id ox3mr6316654icc.10.1432051951318;
        Tue, 19 May 2015 09:12:31 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:799e:649b:b86b:7c03])
        by mx.google.com with ESMTPSA id qs10sm8148041igb.14.2015.05.19.09.12.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 May 2015 09:12:30 -0700 (PDT)
In-Reply-To: <20150519051752.GA16173@peff.net> (Jeff King's message of "Tue,
	19 May 2015 01:17:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269367>

Jeff King <peff@peff.net> writes:

>> +static int is_foreground_fd(int fd)
>> +{
>> +	return getpgid(0) == tcgetpgrp(fd);
>> +}
>
> I've noticed that this patch causes a regression when we are
> transmitting progress over the sideband channel of the git protocol.

Yeah, thanks.  The other day when an unrelated progress issues came,
I realized that this patch has that breakage (and immediately forgot
about it ;-).

> ... Whatever the reason, it probably makes sense to err on the
> side of printing the progress.

Yup.  Thanks.
