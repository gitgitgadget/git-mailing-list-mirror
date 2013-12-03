From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Segfault when fetching from current git.git on GitHub
Date: Tue, 3 Dec 2013 11:20:18 -0800
Message-ID: <20131203192018.GD29959@google.com>
References: <CAN0XMOKPWm1CzS3289SHpH=N0osFszuvnK6e9BVxwtQe3b2YJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>,
	=?iso-8859-1?B?QW5kculzIEcu?= Aragoneses <knocte@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 20:20:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnvWF-0004cO-Aq
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 20:20:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754537Ab3LCTUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 14:20:23 -0500
Received: from mail-yh0-f48.google.com ([209.85.213.48]:56721 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753800Ab3LCTUW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 14:20:22 -0500
Received: by mail-yh0-f48.google.com with SMTP id f73so10423874yha.35
        for <git@vger.kernel.org>; Tue, 03 Dec 2013 11:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ChOhIkwkaztbiVia7hRdJ29SoCTiKQikn0VazMBW0Io=;
        b=KkXGQ2fYKZKfWZUmB+VmvjRGbE5VjbAkFrrRYbt+mPEmKWzuhWphjBaiB1RDT/YkF1
         8ybCyOt7b0R1Sncq5Gc4l/vt/V1hiEbGCg97v240C6xSpnMoip58UXGiPE1s3GAqz1OX
         C6eVLo8TVpUVwgKX0p1BSLmIazEZWoWCYxcuuRJKc55Ck01LlDfI3FDb71PFRD7oil/N
         yQhXtuv7Fj8GbnbypUP2XVq3vjWeBRTo9zOzsi7brVqAfP4WPrmtJYKMAHYoGGm5nJK0
         Jfrjtdjki0dv74pOVDsD6ox3w2dcU7WZiGVhXc5lf8jV1TazGKniiPjvF0/lP/E/mjkV
         rF1Q==
X-Received: by 10.236.86.42 with SMTP id v30mr3621451yhe.92.1386098422190;
        Tue, 03 Dec 2013 11:20:22 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id h23sm77175023yhc.0.2013.12.03.11.20.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 03 Dec 2013 11:20:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAN0XMOKPWm1CzS3289SHpH=N0osFszuvnK6e9BVxwtQe3b2YJg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238720>

Hi,

Ralf Thielow wrote:

> I've fetched from the current git.git on GitHub minutes ago and got a
> segfault. I could reproduce it with the Git version of the current "next" branch
> (1.8.5.392.gf545f4d) with the steps below. The segfault does not appear with
> version 1.8.5.

Yep, I can reproduce this.

  (gdb) bt
  #0  next_quote_pos (s=0x0, maxlen=-1) at quote.c:168
  #1  0x00000000004ca2bb in quote_c_style_counted (name=0x0, maxlen=-1, sb=0x7fffffffe290, fp=0x0, no_dq=0) at quote.c:215
  #2  0x00000000004fd4c0 in set_helper_option (transport=<optimized out>, name=0x525f89 "depth", value=0x0) at transport-helper.c:307
  #3  0x00000000004fb57f in transport_set_option (transport=0x7d5740, name=<optimized out>, value=0x0) at transport.c:1004
  #4  0x000000000042de10 in backfill_tags (ref_map=0x806a50, transport=0x7d5740) at builtin/fetch.c:791

It's fallout from 0f284b11 (transport: catch non positive --depth
option value, 2013-11-26).
