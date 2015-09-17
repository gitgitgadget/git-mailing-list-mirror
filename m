From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/10] strbuf: Add strbuf_read_noblock
Date: Thu, 17 Sep 2015 10:57:54 -0700
Message-ID: <xmqqk2rphqsd.fsf@gitster.mtv.corp.google.com>
References: <1442453948-9885-1-git-send-email-sbeller@google.com>
	<1442453948-9885-2-git-send-email-sbeller@google.com>
	<xmqqtwqtja6j.fsf@gitster.mtv.corp.google.com>
	<20150917163012.GB25837@sigill.intra.peff.net>
	<xmqq6139j84n.fsf@gitster.mtv.corp.google.com>
	<20150917171308.GA28046@sigill.intra.peff.net>
	<CAGZ79kaZOyqwbf+BpG2oPBBt5zj3=q-abk+F-HdkZPL3GzTzsw@mail.gmail.com>
	<20150917173536.GA28987@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 17 19:58:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcdRZ-0003fy-ET
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 19:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225AbbIQR55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 13:57:57 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33221 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196AbbIQR54 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 13:57:56 -0400
Received: by pacex6 with SMTP id ex6so25897617pac.0
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 10:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=8eAjQGBB2wwT178Y1cJFYpF+ZcZHz4RgXLzOVCDHiwQ=;
        b=BwLh4nxJU+x/Ybgbp+gnAAT+VXzjI/PjT+8XSCtu5yMQn6sQBlFZiVXtINds6B68Ef
         gcvdvk4FH5r3S+BiT1yZemceLa6KJ2OV5Wh4uSc4aYIsfbjRkPFsGpHFIdCcnU7bnEC7
         jni0tTOHh6BDqSf1GNrbG3cCvPsJ06cXez/AUuYXYkohiSdnKzG6BEQ/Mkn33vvpRdaY
         ITn1CzAQNhA7JuJTWZJOLDQGfEi7VEbL1E6gFWd2GZyr+FiahkmIvtylvwahH7U6cIZE
         XWuXADPgvGC2Bk2NkzDA1BOKGSFRaUVpcVW7P9KE4H+6LbYcUP9IMMmrsuGZvs4wXb9H
         A7Rw==
X-Received: by 10.66.229.67 with SMTP id so3mr839272pac.66.1442512675958;
        Thu, 17 Sep 2015 10:57:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:25ac:307e:6383:2d03])
        by smtp.gmail.com with ESMTPSA id uh10sm4603666pab.41.2015.09.17.10.57.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 17 Sep 2015 10:57:55 -0700 (PDT)
In-Reply-To: <20150917173536.GA28987@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 17 Sep 2015 13:35:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278155>

Jeff King <peff@peff.net> writes:

> I actually wonder if callers who are _expecting_ non-blocking want to
> loop in strbuf_read() at all.
>
> strbuf_read() is really about reading to EOF, and growing the buffer to
> fit all of the input. But that's not at all what you want to do with
> non-blocking. There you believe for some reason that data may be
> available (probably due to poll), and you want to read one chunk of it,
> maybe act, and then go back to polling.

I think I could have gone to grab a cup of coffee instead of typing
another message that essentially said the same thing ;-)
