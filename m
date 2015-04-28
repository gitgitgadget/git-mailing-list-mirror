From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 1/5] setup: add gentle version of read_gitfile
Date: Tue, 28 Apr 2015 13:42:13 -0700
Message-ID: <20150428204213.GO5467@google.com>
References: <xmqqfv7nzf56.fsf@gitster.dls.corp.google.com>
 <1430030985-14499-1-git-send-email-erik.elfstrom@gmail.com>
 <1430030985-14499-2-git-send-email-erik.elfstrom@gmail.com>
 <20150428061741.GL24580@peff.net>
 <CAMpP7Nb3aiMoTjtPJNJPv38G54ZawS8B+NDX0x2iNe6FA-L+Lw@mail.gmail.com>
 <20150428201918.GA10902@peff.net>
 <20150428203400.GN5467@google.com>
 <20150428203645.GA11473@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: erik =?iso-8859-1?Q?elfstr=F6m?= <erik.elfstrom@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 28 22:42:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnCKk-0006c7-01
	for gcvg-git-2@plane.gmane.org; Tue, 28 Apr 2015 22:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965926AbbD1UmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2015 16:42:17 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:33249 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965904AbbD1UmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2015 16:42:16 -0400
Received: by igbpi8 with SMTP id pi8so95670307igb.0
        for <git@vger.kernel.org>; Tue, 28 Apr 2015 13:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=f9MQuUdg8q6Sqt21IwxQCq4JVNdSkC2LJKMjgWFVT9M=;
        b=ogFHqETPV3SDnufxzsIUtyVG3IxuVTIy0qNWlC/PJr3lVnM+IFWjHA0VhUdbL3AXyp
         r3oAnO15K5bF2sJ1qZNRRiXGaybl4adx0BzglRDehhiCLBlHjWmFBBDwi92tUDaFYKvF
         0ESwPpagdH9jkfUv+xLoXlpeF7Fo8b6WTgB8yoJzIznZIxP0B/yqiGdooJNE3Sbc2bSC
         8U+LVDGSVVhHHoU+rCcCLK2843N0h2mXbbfwfujjPBfL5KRDVNZWrz/fNjQV4k7as/CH
         Uvcq8LW1a8Zkw/wPwfXlQpm6SQauAQgaLgJNOko/S7WBmNGWv+0l8Lf/E5LgJir44nPm
         /fDw==
X-Received: by 10.107.7.87 with SMTP id 84mr1809449ioh.76.1430253736142;
        Tue, 28 Apr 2015 13:42:16 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:c979:ad68:d2ca:9e9e])
        by mx.google.com with ESMTPSA id k74sm14601844iok.30.2015.04.28.13.42.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 Apr 2015 13:42:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150428203645.GA11473@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267943>

Jeff King wrote:

> But the NULL does not carry the information about _which_ error, and
> Erik is suggesting that the caller may need to change behavior based on
> that information. IOW, his current patch (return NULL and set the
> specific integer code in a variable) allows this, but switching the
> integer code out for a human-readable strbuf does not.

Right.  Two ways to handle that are:

 - two out parameters: an integer code and a human-readable string, or

 - an integer code returned using the ERR_PTR method and a
   human-readable string out parameter

The point I was trying to make clear is that the human-readable error
message and the integer to affect control flow have different purposes
and are not tightly related except in that they are produced at the
same time.

Using an integer to convey the human-readable error message (like errno
does) unnecessarily forces the message to be more vague (by not being
parameterized, and by always using the same error message for the same
integer error).
