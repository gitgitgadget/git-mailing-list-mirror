From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 1/3] After chdir to run grep, return to old directory
Date: Tue, 06 May 2014 17:06:51 -0700
Organization: Twitter
Message-ID: <1399421211.11843.53.camel@stross>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
	 <1399072451-15561-2-git-send-email-dturner@twopensource.com>
	 <xmqqtx92czqv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 07 02:07:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhpNz-00087k-8V
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 02:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208AbaEGAGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 20:06:55 -0400
Received: from mail-qc0-f178.google.com ([209.85.216.178]:41768 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbaEGAGy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 20:06:54 -0400
Received: by mail-qc0-f178.google.com with SMTP id l6so263085qcy.23
        for <git@vger.kernel.org>; Tue, 06 May 2014 17:06:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=6D819sdcu6ObKMyccS1BVpOzCDJrBKNwL6C6rm7h8xA=;
        b=aW/qMfBx1wu9eynvyjjbnxlpTP8XGy9zcyX8I5n5CJ5V8uysgf5vI++DK5k3fIY59m
         aqLFiQBBSbcB/0gE5t3fJAn5wss1kX9jS4n24QFM8Tcfj3eB/tPjATF/nWfrIuctQpgf
         Q4PrQ3RleHOFaiJasKgB+2LZbzCPl8kqLoz9nl3ktGuUC+EU16KGosbSvLvUVzROey3x
         7ujOUQCI8R5kK0T/epErDVxyZdRt6jdiXlh0U9wnqN0FMV/UnbIcSnPMZ2A0+ocyO7rI
         cenJX9cs+B9pGlrgZMUFXyfMBluT+1dN2I05IVUU0Zlj4suLfjrQCtXzin+XuoudgWOq
         lOag==
X-Gm-Message-State: ALoCoQloPtQ0bj3UB9l0iP213fy8UCJO/xuHnxoyKRp/pyu6JLM3rBDIeAoxouwWCCyaa0QPk8Db
X-Received: by 10.224.66.133 with SMTP id n5mr60915300qai.11.1399421213643;
        Tue, 06 May 2014 17:06:53 -0700 (PDT)
Received: from [172.25.144.67] ([8.25.197.27])
        by mx.google.com with ESMTPSA id 104sm17743273qgq.1.2014.05.06.17.06.52
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Tue, 06 May 2014 17:06:52 -0700 (PDT)
In-Reply-To: <xmqqtx92czqv.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248273>

On Tue, 2014-05-06 at 15:24 -0700, Junio C Hamano wrote:
> dturner@twopensource.com writes:
> 
> > From: David Turner <dturner@twitter.com>
> >
> > Signed-off-by: David Turner <dturner@twitter.com>
> 
> Ehh, why?

Briefly, because otherwise ./t7811-grep-open.sh fails when run under
watchman.

This is actually something that I think I'm doing wrong, but I can't see
what the sensible way to do it is.  When we go to write the fs_cache (in
an atexit hook), we use get_fs_cache_file() from environment.c.  This is
a relative path, because all of the other similar paths are.  So if we
have chdired, then we fail.
