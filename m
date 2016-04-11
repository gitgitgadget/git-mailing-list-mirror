From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3 03/16] index-helper: new daemon for caching index and
 related stuff
Date: Mon, 11 Apr 2016 19:27:12 -0400
Organization: Twitter
Message-ID: <1460417232.5540.53.camel@twopensource.com>
References: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
	 <1459980722-4836-4-git-send-email-dturner@twopensource.com>
	 <CACsJy8C5NhaAAW=wzpwkBdLvVZz8wVM7QX==n_CL5g+LLAKY=A@mail.gmail.com>
	 <1460153784.5540.19.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, aevarb@gmail.com,
	jeffhost@microsoft.com
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 01:27:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aplEv-0002sX-6Q
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 01:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754760AbcDKX1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2016 19:27:18 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:33724 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754702AbcDKX1P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2016 19:27:15 -0400
Received: by mail-qg0-f47.google.com with SMTP id j35so1788407qge.0
        for <git@vger.kernel.org>; Mon, 11 Apr 2016 16:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=d/xRNzDOmGqAgtxWmYn2HizZ1ctppsxdDnVkjekm9Wc=;
        b=aGBOopsBO3+nfgepbh3nRc0Lg5q1vZQaG2xVEJHJvO3ZGHOQIowE+1WkuF8GleQPK+
         cA1lIhSWcFdPY2ElOKLUIKVkeQlD8wHRTqzV8XQ0w52hEX80Tt/qr9DOiUTia2t4YzDF
         h4WZKaln7FkmDP6E/i6jgFMmPsy4R+EHHwMOyG0039J2UeNUtnAKynhSfFWHNjID0nBb
         oP256d6jtck3C4q56NmvYyne6WlL9wEXWYSaZ5PE99GnNqrOaSiPgpoajFGnlKYCimZp
         S/v1dNxPhN/W11V2XTg0JtHsKrWxv8bQegzktgxl3BVl6k80lc7rSckDpBLNIChVfPCr
         ORzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=d/xRNzDOmGqAgtxWmYn2HizZ1ctppsxdDnVkjekm9Wc=;
        b=DxAm3mSDwlk1ZF/pm9MWWQVhORqcEe9yQryYIoibE2qIiXD+Qi5EbIM3Eq7j6QM5pt
         dJl8u4Rz+y0rM5pcdML3zAmfQB/L/xsXxD50EE8n8r8FQIRC/l6h/OmuVmZt4Hl1aS6t
         YrMeuWun3zxDnFO5QsS+KFrP9zDdXL0ArMPtMUxqVLTj+Qgbh7O8PbckvHLj83Vypq+Z
         HAhHd5cf/pwMWkbHLcA3DCjB2Ulh0HxyD0V2SlDWAYevxxbi02UIjanJQAGy8VpHSjDV
         JUqI5lB7aF2wcYejARwk6ggbe60e6EIo0AZ2P9G5XxQuqgsRtGJ6u9mGTfH8X/sxBZK8
         x1Bw==
X-Gm-Message-State: AOPr4FWRVBi12YE0T+2ZgWE3kzNurncvwHHQAz6JFCFdNorUs9G36x3lesHPNahF0MvYYA==
X-Received: by 10.140.158.68 with SMTP id e65mr245800qhe.4.1460417234310;
        Mon, 11 Apr 2016 16:27:14 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id b187sm7383587qkc.9.2016.04.11.16.27.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Apr 2016 16:27:13 -0700 (PDT)
In-Reply-To: <1460153784.5540.19.camel@twopensource.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291238>

On Fri, 2016-04-08 at 18:16 -0400, David Turner wrote:
> And SHM on Macs works a bit differently than on Linux in at least two
> irritating ways. 
> 
> So, uh, new version to come once I actually make it work on Mac.
> Probably Monday.

I was chatting with a friend about this and he mentioned that SHM does
not really fit well into the Unix "everything is a file" model.  It
lives in a separate namespace, and still requires most of the file-like
operations just with funny names and a separate namespace: shm_open,
shm_unlink.  This weirdness is something I noticed in my porting work:
on OS X, a shm name can only be 32 bytes long, requiring weird hacks.
And on OSX, fstat on a shm fd is rounded up to the page size (!). 
 There may also be other portability issues that I have not yet
discovered.

Instead, my friend suggests that we should just use files.  For
instance, we could do $TMPDIR/$index_helper_pid/shm-index.$sha.  

(I'm proposing $TMPDIR because it's cleaned up on reboot so we don't
need any manual intervention or complicated gc schemes)

What do folks think of this?
