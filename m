From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 10/12] ref_transaction_verify(): new function to check
 a reference's value
Date: Thu, 12 Feb 2015 10:21:46 -0800
Message-ID: <CAGZ79kbY94rPpL9Bv7PQ=ZLOQvY2Jy9OOw=xiNP1yoWHujaMtQ@mail.gmail.com>
References: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu>
	<1423739543-1025-11-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 12 19:21:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLyOd-0008EF-SJ
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 19:21:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbbBLSVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 13:21:47 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:44926 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbbBLSVq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 13:21:46 -0500
Received: by iecar1 with SMTP id ar1so13867113iec.11
        for <git@vger.kernel.org>; Thu, 12 Feb 2015 10:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=RH9yd4KYwnjIEYPmK6ZesB35yo41KUQg+J4GLs0+gic=;
        b=NTN19/57wQWL/8Qr2VKuG75zA0rcf39SekXBK2ICCgg0PNQTgzx52ikPoR7s3vFGb8
         dkcUoIStuRpK/L6Af7nvhzoZC6xxDY0J9pZRcu+oN/D2dMGEPun6wqzfX7yrglF164Ox
         vZKYrRa17ciN3GHZCd1/SK066i1wGxCK1rZXL/bbPC1kCKHVkPKqiHRYBoFor9I4Jjh7
         9g0/YdCLw4SX9rV1cVJI6xhOZgexerLAkqtdLxUY1CaZbSjTVDaWMVDFTc40AA0eN0S/
         Z5IevTryL5r7Wc93zE2Ov4zRB+CfbLXh/dI4Tne2ysxjAydj6l3QrAN+NQ8RhUgRV1Gm
         gyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=RH9yd4KYwnjIEYPmK6ZesB35yo41KUQg+J4GLs0+gic=;
        b=Ips4I5i/Ut91K9aAm3dLfP8XFFrAXW/MMt0q/jaaD+CYArU63BFN8ZE4WMNKY1o1Vf
         6gB9j6NX8UtyqB3xUvnvdlHw8xbFXMipy+h/sciFrzAGjEDbAnripOedo/b7Nq8CJPIB
         3IMasUSpwC0qLXPvxloQJsD1dTIdj69YhtyFJe+cEnsKvMpiwUWtqlh9/69NtmlfohdY
         NrwDO6rivQW0D0a50C5xsd0RAy3HrL67ftcXJBf4xgfqZw/Q2c92SynshzvblBjGMhQR
         TgIaidxvTr5syE33rXSzuqniMgr3+NxYwOTQ034X+nvnbFU4+6zj0sdbUmhDilsQhWgn
         ncRQ==
X-Gm-Message-State: ALoCoQnWaMdq6o1o2vxTcGiqQugloRWa+oYxVnqe/Y/Q9bHZPnSvmJ5ON606ow+rNLmvP3YrqTDV
X-Received: by 10.42.159.129 with SMTP id l1mr7877188icx.15.1423765306238;
 Thu, 12 Feb 2015 10:21:46 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Thu, 12 Feb 2015 10:21:46 -0800 (PST)
In-Reply-To: <1423739543-1025-11-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263749>

On Thu, Feb 12, 2015 at 3:12 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
Reviewed-by: Stefan Beller <sbeller@google.com>
