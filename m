From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] index-pack: Use the new worker pool
Date: Tue, 25 Aug 2015 14:12:37 -0700
Message-ID: <xmqq37z7xebe.fsf@gitster.dls.corp.google.com>
References: <1440523706-23041-1-git-send-email-sbeller@google.com>
	<1440523706-23041-5-git-send-email-sbeller@google.com>
	<20150825190329.GA11271@sigill.intra.peff.net>
	<xmqqfv37xfrc.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZ9V35KmJSExt=EqYFcyOSysaFsJA0E+dx46Qg+Pm+Ybg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 23:12:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZULWN-0006py-MR
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 23:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755940AbbHYVMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 17:12:39 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34754 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059AbbHYVMj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 17:12:39 -0400
Received: by pabzx8 with SMTP id zx8so45076410pab.1
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 14:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=1P4s4GpyS5r+8mcPHuDojBuhoErY3ZLvZ2MbEGMhlpA=;
        b=Bfyzngfw9tSxfJmixndEvMrDEq6j7T9A4fi94wXDQc6lcdGIuYITDd8JBktmIo4erP
         MYHg51nJ6WICWOwhicFH+qJmQgF7ezVwADmfr1HLoAsIvS9axIr/5dnyOUbPPk3/CbS5
         bx4CwI21PksYYvQ02qSkAkVYPtEXntUE8BlAOiAKLQvvvC9fFpYTPBo2GYBJ+EQ/p/1g
         mBX2Sg+C0BI4Mn64BtDQEa1F+RVpHq2HEAOWYu0+SqcckHm4BPiGS6qErdtpkwag83Ww
         osnz1TxasJNaoYjRg0cVfDU3pWzStst+xP3XKXE8fRUxOLVz4alKkDJ6RhbwzNJ9JMIJ
         GinA==
X-Received: by 10.66.192.130 with SMTP id hg2mr59744079pac.114.1440537158804;
        Tue, 25 Aug 2015 14:12:38 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:cdc0:fd6d:4069:6223])
        by smtp.gmail.com with ESMTPSA id r6sm22148662pdj.39.2015.08.25.14.12.37
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 25 Aug 2015 14:12:38 -0700 (PDT)
In-Reply-To: <CAGZ79kZ9V35KmJSExt=EqYFcyOSysaFsJA0E+dx46Qg+Pm+Ybg@mail.gmail.com>
	(Stefan Beller's message of "Tue, 25 Aug 2015 13:59:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276575>

Stefan Beller <sbeller@google.com> writes:

> Not sure I follow there.
>
> Original implementation:
> We have M threads sitting around the table, all of them trying to obtain food
> from the one bowl on the table and then eating it.
> Once the bowl is all eaten, we can stop.
>
> New pattern:
> One cook puts all the food items on the sushi-go-round-belt with a fancy plate
> and the threads grab them one by one still using locks (but they are internal to
> the belt).
>
> Are you saying we're content with just a bowl and everyone helps themselves
> for getting food?

No.  I am questioning how big overhead is for having the
go-round-belt that must hold all dishes to be eaten, which did not
exist in the original arrangement.
