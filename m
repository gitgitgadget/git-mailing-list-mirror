From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] gc: config option for running --auto in background
Date: Mon, 10 Feb 2014 11:11:07 -0800
Message-ID: <CAPc5daW3VwLutU8JZu9fBbGtihw5X_bE9M31ugzqN9mEnFYNNQ@mail.gmail.com>
References: <xmqqd2j2afup.fsf@gitster.dls.corp.google.com> <1391843332-20583-1-git-send-email-pclouds@gmail.com>
 <1391843332-20583-2-git-send-email-pclouds@gmail.com> <CABPQNSb3=i8F+vPEG3RmH+snZVZ-xrPtcVY2Nx9uvyTCLXcy6g@mail.gmail.com>
 <CACsJy8BBQ3Bh6q6JM8V-QVKfzwp1w99+u4_55jjGbHLV3c62gA@mail.gmail.com> <xmqqob2est9c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	chris <jugg@hotmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 10 20:11:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCwGU-00017H-UU
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 20:11:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136AbaBJTLa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Feb 2014 14:11:30 -0500
Received: from mail-la0-f41.google.com ([209.85.215.41]:53262 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622AbaBJTL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Feb 2014 14:11:29 -0500
Received: by mail-la0-f41.google.com with SMTP id mc6so5124761lab.14
        for <git@vger.kernel.org>; Mon, 10 Feb 2014 11:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=0cCj5Hp6ftBRhWTZnXYdHxzbF+n4OEw4ISG2yjQDJog=;
        b=VTxAEg9s136nXZ7yHkcQMhT7pScXdgTeiVcIOxAWlgjnBkh8+cOSz4FY4jBWaw6RXl
         hygN4w/33IVKa0w5rtrm+hMgKePoa/bnZOOpDDr6J9nYi0PMOPTqZsS4UME6mZ8MtsLN
         t+89WF6EkkeE5dUpZ68z4sliGZ5YKRtKHMRMBRjdXrC8/VoVw/+q7I1OImz99V6uS4zL
         COzkwXtPI5+BNsBq1Agt7OAQeK+LyLyFLI0VnUl1P0liH3BdIlSXLi+uoEJza0tctEg7
         2bep6fHwRt0nbyQcuoSx1ulF8UWLkM7dghjFDxf1Qi2hEAymkP0Zcn7IQjT9YQEOZGxf
         I9CQ==
X-Received: by 10.112.201.164 with SMTP id kb4mr6758194lbc.32.1392059487796;
 Mon, 10 Feb 2014 11:11:27 -0800 (PST)
Received: by 10.112.180.130 with HTTP; Mon, 10 Feb 2014 11:11:07 -0800 (PST)
In-Reply-To: <xmqqob2est9c.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: XQ6tgGQ5PSuxsUYqhnAOSbDW1YE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241924>

On Mon, Feb 10, 2014 at 10:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> If --quiet is set, we should not be printing anyway. If not, I thinkg
>> we could only print "auto packing in background.." when we actually
>> can do that, else just print the old message. It means an #ifdef
>> NO_POSIX_GOODIES here again though..
>
> Didn't you change it not to die but return nosys or something?

Ah, the problem is that it is too late to take back "... will do so in
the background" when you noticed that daemonize() did not succeed, so
you would need a way to see if we can daemonize() before actually
doing so if you want to give different messages.

"int can_daemonize(void)" could be an answer that is nicer than
NO_POSIX_GOODIES, but I am not sure if it is worth it.
