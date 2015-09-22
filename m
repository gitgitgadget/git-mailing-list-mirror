From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 06/13] run-command: add an asynchronous parallel child processor
Date: Tue, 22 Sep 2015 12:53:07 -0700
Message-ID: <xmqqtwqm2puk.fsf@gitster.mtv.corp.google.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
	<1442875159-13027-7-git-send-email-sbeller@google.com>
	<xmqqfv276z1q.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbUkUSAP+muhYxTwHZdD+ojJYXjogZfRXs0PemEdcqfbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 21:53:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeTcx-0007Q6-CK
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 21:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759708AbbIVTxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 15:53:12 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35327 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759706AbbIVTxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 15:53:09 -0400
Received: by pacfv12 with SMTP id fv12so18154464pac.2
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 12:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=b185eKy8xAanfL67K1IZJhJ/CUAxCUVRTnwhFNp9tBU=;
        b=ImJZRgBzd4jrpzn6wrRBXpAeWu/W8Q6AObOC3tofA6ZpXrMaFSBjg/FZx51Y5Lw+tT
         y6P7ZGqKdhqGPtIrsmmXMjZgWxM1m45u2U+/O3zK6/cZVVmE94Pj8L1368ZBJ+JIXejI
         he6nHyKPxWDd7CQGWcd9NmVNunUavsRj2uu4ycC7Jih4A8FmOlHUcVbw7odhRHHAE3BU
         xwu05fja4YfxrGdThaHdBMnCV1HWEa10qEuaiyQAJZ/9VIwdm6nuqjHFFRVkwHFJTqf3
         DY/PMoueu+vofpIOKCaSDE36F+JISyFTTRfTxGD7H0lgwsm5MSgqFj6K6hJf7V8X9rrl
         8/xQ==
X-Received: by 10.68.95.225 with SMTP id dn1mr20950452pbb.103.1442951588886;
        Tue, 22 Sep 2015 12:53:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:fd7e:7071:2eda:9c63])
        by smtp.gmail.com with ESMTPSA id yi8sm3819858pab.22.2015.09.22.12.53.08
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 22 Sep 2015 12:53:08 -0700 (PDT)
In-Reply-To: <CAGZ79kbUkUSAP+muhYxTwHZdD+ojJYXjogZfRXs0PemEdcqfbA@mail.gmail.com>
	(Stefan Beller's message of "Tue, 22 Sep 2015 11:28:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278425>

Stefan Beller <sbeller@google.com> writes:

> So how would you find out when we are done?

	while (1) {
		if (we have available slot)
			ask to start a new one;
		if (nobody is running anymore)
                	break;
		collect the output from running ones;
                drain the output from the foreground one;
		cull the finished process;
        }
