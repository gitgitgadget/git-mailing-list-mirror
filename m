From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/7] sequencer: release a strbuf used in save_head()
Date: Tue, 22 May 2012 00:18:48 -0500
Message-ID: <20120522051827.GA4486@burratino>
References: <20120521143309.1911.94302.chriscool@tuxfamily.org>
 <20120521145610.1911.61154.chriscool@tuxfamily.org>
 <CALkWK0m9F6EU43v0HbJxWUVtHTiw+ZvjCjwqbSVdQfomb6f4Aw@mail.gmail.com>
 <20120522042316.GA3080@burratino>
 <CALkWK0kvjr3NSx6-8svz=PKb5ta_UwOUiF4uqh7GriwuJYncUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Nick Bowler <nbowler@elliptictech.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 22 07:19:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWhUq-00042B-H7
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 07:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753751Ab2EVFS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 01:18:56 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:45488 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265Ab2EVFSz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 01:18:55 -0400
Received: by gglu4 with SMTP id u4so5048732ggl.19
        for <git@vger.kernel.org>; Mon, 21 May 2012 22:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=oD9S5ga0JRiIsd6zlzeMrcEehj47z0pTG9hu8gyK6p8=;
        b=Otj86VxJ0qb+BNM9TgvRUzR42ip11W7kBbxswlzKaq8GgguNLInQ70xbP0zfIts1Eq
         20TyjkiywoaWljDnZCtFL/fbcA0whkGn8v9M6n4jp142GvH/6L4B4dBKh1o1uSHmil5U
         lquZVH9dBJ/1jbeFI8wEwnturlazYvIRec1mnql5XD8nFHwQnCWQ+CNcX06hB2wgDzxN
         t8v4JL+WoCQtUHqPJGsMneam8IFDyYsmBHdp1q6Zwy/WkBgddubfu0TfD0lBHNbpZLFp
         +CFbaWoKPDAGGihQhb2TVYE/yd5lCR0pw1Ypo2Lh3mWFnRGF7R4DPWJCFEXhzcLJUann
         GmVQ==
Received: by 10.50.187.164 with SMTP id ft4mr8612907igc.6.1337663934485;
        Mon, 21 May 2012 22:18:54 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ch5sm9449319igb.0.2012.05.21.22.18.53
        (version=SSLv3 cipher=OTHER);
        Mon, 21 May 2012 22:18:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0kvjr3NSx6-8svz=PKb5ta_UwOUiF4uqh7GriwuJYncUA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198176>

Ramkumar Ramachandra wrote:
> Jonathan Nieder wrote:

>> And
>> looking at it from the other side, doesn't using exit mean that you
>> cannot be valgrind-clean anyway, since allocations by functions higher
>> in the call chain do not get a chance to be freed?
>
> Good point; save_todo() sets a bad example.  For symmetry, should
> these two instances of strbuf_release() before die() be removed in a
> separate patch?

I can't find myself caring much either way. :)

A single free() doesn't hurt performance much, so my hunch would be to
leave it alone unless some other practical reason to keep or remove
the free()s comes up.
