From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] patch-ids: check modified paths before calculating
 diff
Date: Sun, 19 May 2013 23:36:23 -0700
Message-ID: <20130520063623.GB2919@elie.Belkin>
References: <a7088a74742b71a01423f3ddc1a6c7fd89474ed8.1368969438.git.john@keeping.me.uk>
 <20130519193612.GH3362@elie.Belkin>
 <20130519220206.GK27005@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Kevin Bracey <kevin@bracey.fi>,
	Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon May 20 08:36:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeJhx-00066m-AC
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 08:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130Ab3ETGg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 02:36:29 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:59020 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362Ab3ETGg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 02:36:28 -0400
Received: by mail-pd0-f171.google.com with SMTP id t12so3375117pdi.30
        for <git@vger.kernel.org>; Sun, 19 May 2013 23:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=L7FcOChUFP1G1N3xPifWb5PCqyCCfXFq5MpiV16QrK0=;
        b=pKfdF2lglV0lWGws3bMDFuyZsndQeo8d3eURtAH1dqPnOEQlmRDMhtEZfxzXDo8mqp
         gewV9I0fTS6TBjv1iKYhCxmq3gYipw9tHvL53PeGCLHUWThi+yvtoTgXr06JeVFyWY9k
         o/L6dUlPXT11sVCq9ux0c5l2ZidaThGm0fvVh0g1JVzVtpZDZv5cixsVgb8DwZ3nM+RI
         2eoGUESwDEz/fDvIhsIuld0PyiFwi5nBZVORxFhCRSOdhEG3aKTeu0QraQvwEb6eP92e
         i8pe8LXt3uigCuPBBZptaguaEc3OVMP1/wq0aEMGzRSMiF6cHwL8mLZg1XaoAaH/NVDI
         xT8w==
X-Received: by 10.68.244.134 with SMTP id xg6mr53316895pbc.188.1369031787971;
        Sun, 19 May 2013 23:36:27 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id wp6sm22772219pbc.29.2013.05.19.23.36.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 19 May 2013 23:36:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130519220206.GK27005@serenity.lan>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224940>

John Keeping wrote:
> On Sun, May 19, 2013 at 12:36:12PM -0700, Jonathan Nieder wrote:

>>                                        Who is responsible for freeing
>> "path"?  Would it make sense to use a strbuf here?
>>
>> 	strbuf_setlen(&buf, traverse_path_len(info, n));
>> 	make_traverse_path(&buf.buf, info, n);
>
> Perhaps alloc_traverse_path?  I'm not sure the strbuf buys us much for
> this case, since we only use the result for a few lines before freeing
> it.

Good idea.  Generally strbufs are nice for this kind of thing because
they make it easy to reuse buffers, but in this case there's no
opportunity for that.

[...]
> then this is "process_changed_path".

Sounds good.

[...]
>> What should happen for commits with more than 1 parent?  If they're
>> supposed to not enter this codepath because of a previous check, a
>> die("BUG: ...") could be a good way to make reading easier.
>
> Currently the patch ID code compares the commit with its first parent,
> so I think this should do the same.

Ok.  I guess a comment nearby would help future readers avoid the same
question.

I don't know what it should mean to try to use --cherry without
--no-merges or --first-parent, so I guess this is harmless.

[...]
> Thanks for the review.

No problem.  Thanks for a pleasant read.

Ciao,
Jonathan
