From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3] http.c: use CURLOPT_RANGE for range requests
Date: Mon, 02 Nov 2015 17:41:24 -0500
Organization: Twitter
Message-ID: <1446504084.4131.33.camel@twopensource.com>
References: <1446492986-32350-1-git-send-email-dturner@twopensource.com>
	 <20151102201831.GA10722@sigill.intra.peff.net> <87mvuwcbql.fsf@igel.home>
	 <20151102221027.GA13996@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 02 23:41:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtNnR-00007G-3f
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 23:41:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbbKBWl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 17:41:28 -0500
Received: from mail-qg0-f44.google.com ([209.85.192.44]:34570 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbbKBWl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 17:41:27 -0500
Received: by qgem9 with SMTP id m9so128769223qge.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2015 14:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=/qGCBpTUy2DtRJ/jaOBkZf9VTfzrMhQWV4+QedMMH30=;
        b=NHkERm1dlt+t2NS/SoELrEr1RMMwsyj0hUEunCr81CLTv9mXfvsz890nv0an54wYV+
         7xS+pMKtB7tGKftEhnbOs2x9ZDjvTfkVCVVUNLJ0QgvAzcT3wJWsdwdq+ICYWGdxTw6J
         tKgMIHn9ZevZFoGlJi+wF39wkCR78Idbh6E6Lo4p3mLEeZhaftzHI+Bz/vEf2KGhXRMX
         X94gr6RIDEzxEdptMgRaPNi/iQkpOCNalx2+f/4WBqIv3nHls8OLteAtothZbSaXJRxn
         WVhQO+5flWVC4IRwGxo3DJtfqgJ78izwMSHDUOh/9U2NW6hHa/TwaurxtNN951tFQDys
         RVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=/qGCBpTUy2DtRJ/jaOBkZf9VTfzrMhQWV4+QedMMH30=;
        b=FbyPFZp5PNQCe8Yxfr2yVQxF0pEp3xHF+ZpE+U+Bo8Bxz0DNoVlGGU7VGS78m5OAA5
         nHimFcF+G2ryEim96Q5za6rEjW3L7dFPAPMKdl4I5qBtjO0lmX95ClUfwFMb6nXqyl3b
         RS0xfDzjO1raEfowLlmVF8GzP/NI2gJv26Nt6jwzziyaQGJ44+vp1aw52s5InrJe7MMh
         RqZY6nfmj70cDQw09VJhvdZe1TxkjpBiWgxH2lDMYkfo0PXi3CyOPL7k+NmLnHlQHk7m
         Kkuhvoi8F6sLAMza2xmBbivKVpZ1VftvRxbSeBX+bRYxYcM8pwVY2oSOyyEuuG4puq0d
         p9BQ==
X-Gm-Message-State: ALoCoQloMT0hejmqrNsaBpG3VokxLwpQ4r93J77z3Aimb8TuZsR9mcgf87IEoNLJ7ZJlkWxu6OPf
X-Received: by 10.140.194.8 with SMTP id p8mr35350214qha.63.1446504086731;
        Mon, 02 Nov 2015 14:41:26 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z194sm8172927qhz.10.2015.11.02.14.41.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2015 14:41:25 -0800 (PST)
In-Reply-To: <20151102221027.GA13996@sigill.intra.peff.net>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280732>

On Mon, 2015-11-02 at 17:10 -0500, Jeff King wrote:
> On Mon, Nov 02, 2015 at 10:50:10PM +0100, Andreas Schwab wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > >   4. Fix all of the callers. I suspect this would involve calling
> > >      fstat(fileno(fh)) to get a real off_t.
> > 
> > You can also use ftello which returns off_t.
> 
> Thanks, I forgot about that function. That would probably be the sanest
> path forward.
> 
> I think it is as simple as this (on top of David's patch):
> 
> -- >8 --
> Subject: [PATCH] http: use off_t to store partial file size
> 
> When we try to resume transfer of a partially-downloaded
> object or pack, we fopen() the existing file for append,
> then use ftell() to get the current position. We use a
> "long", which can hold only 2GB on a 32-bit system, even
> though packfiles may be larger than that.
> 
> Let's switch to using off_t, which should hold any file size
> our system is capable of storing. We need to use ftello() to
> get the off_t. This is in POSIX and hopefully available
> everywhere; if not, we should be able to wrap it by falling
> back to ftell(), which would presumably return "-1" on such
> a large file (and we would simply skip resuming in that case).

It would skip resuming, but would still maybe write to the end of the
existing file, right?  So I think we would need to seek to the beginning
of the file in that case.

(other than that, lgtm)
