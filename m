From: David Turner <dturner@twopensource.com>
Subject: Re: git reset for index restoration?
Date: Thu, 22 May 2014 19:02:26 -0400
Organization: Twitter
Message-ID: <1400799746.18134.48.camel@stross>
References: <1400775763.1933.5.camel@stross>
	 <CABPp-BHtYnput7SiAbnqUjpDibTi5o_2MAXfSj17fCdKSC7Hjg@mail.gmail.com>
	 <1400782642.18134.8.camel@stross>
	 <20140522183930.GB1167@sigill.intra.peff.net>
	 <1400785669.18134.21.camel@stross>
	 <20140522190959.GA18785@sigill.intra.peff.net>
	 <20140522193030.GA22383@sigill.intra.peff.net>
	 <xmqqha4hmr9d.fsf@gitster.dls.corp.google.com>
	 <1400795586.18134.40.camel@stross>
	 <xmqqd2f5mq5h.fsf@gitster.dls.corp.google.com>
	 <1400796077.18134.41.camel@stross>
	 <xmqq61kxmphw.fsf@gitster.dls.corp.google.com>
	 <xmqqwqddla63.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 23 01:02:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wnc0R-0002ys-Gb
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 01:02:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbaEVXC3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 19:02:29 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:45561 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196AbaEVXC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 19:02:28 -0400
Received: by mail-qg0-f44.google.com with SMTP id i50so6982469qgf.31
        for <git@vger.kernel.org>; Thu, 22 May 2014 16:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=AeTSqTBUrh4Rad3PoQjVpUU4ZbbJtOnl3vowzRvKzPc=;
        b=Vp7trD18+WKRUXKpo+ixKcklTNJ3XL7X09NRei90c5rdEtt8ysLTKAtY2N1F5zXvJr
         aapwvQEq8B5Ok4j/M8P5vDGoVVYHd4IScxaAwpxK9Ahzgy5p2iJaLgTjAAiqzsYKvcHz
         idH0G6SZGU6fVsAj6jRw0oLiYNgObfVd5wmJ8YD/RNZZkqYPKUqeZUX3QJhFR5ORKJ24
         xBZY9E9XBpRSVg9sWanAytx7+7eLIdjPDoPVmbDNJGU4LgFkwcxtoBgoxWwQI/gwKq8Q
         RjQQitMDm6K//hQQyT0juEBNRJk2jYOtID9I6ZV9D3bFI67LZjJ/TLFSrixwrRGpm+6H
         ymZA==
X-Gm-Message-State: ALoCoQkFF9x0rQIxjzVjwOGDeu53twOZUA2A6K8biAcNFu4RfYSjLW0pYwjnP88uJsPdGkHUcZf0
X-Received: by 10.224.68.2 with SMTP id t2mr1005202qai.71.1400799747932;
        Thu, 22 May 2014 16:02:27 -0700 (PDT)
Received: from [172.17.3.46] ([38.104.173.198])
        by mx.google.com with ESMTPSA id i9sm1893920qaq.14.2014.05.22.16.02.26
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 22 May 2014 16:02:27 -0700 (PDT)
In-Reply-To: <xmqqwqddla63.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249957>

On Thu, 2014-05-22 at 15:29 -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > But at least my understanding has been that "git commit" (no partial
> > commit, write the whole index as a commit) which uses the "git
> > write-tree" machinery knows which subtree has what tree object name
> > and populates the cache-tree fully.
> 
> Here is what I tried just now.
> 
>     $ rm .git/index
>     $ git read-tree HEAD HEAD
> 
> Note that a single-tree read-tree will populate the cache-tree and
> that is why I am forcing "switch branches" 2-way read-tree here,
> which I know will discard the cache-tree fully.
> 
>     $ ls -l .git/index
>     -rw-r----- 1 jch eng 249440 May 22 15:20 .git/index
>     $ git checkout HEAD^0
>     $ ls -l .git/index
>     -rw-r----- 1 jch eng 249440 May 22 15:21 .git/index
> 
> Still the same size, without cache-tree.
> 
>     $ git write-tree
>     57361c4add61b638dad1c1c2542edf877f515c48
>     $ ls -l .git/index
>     -rw-r----- 1 jch eng 254383 May 22 15:21 .git/index
> 
> The size differences come from the recomputation of the cache tree.
> The result is the same if we replace "git write-tree" with a
> whole-index commit, e.g.
> 
>     $ git commit --allow-empty -m foo
> 
> and test-dump-cache-tree seem to see a fully populated cache-tree
> after these steps.

I get the same results as you with git write-tree.  But I do not get the
same results from a whole-index git commit (I tried your exact
command-line).  That is, when I do git commit with no cache-tree in
place, it does not create one. 

To expand: even if git commit did work for me the way it seems to work
for you, I still believe that the cache-tree behavior would be
suboptimal, because every time a user switches branches, they lose their
cache-tree, and thus all of their git status commands are slow until
their first commit. But I am willing to believe that my workflow is
atypical, and that most people commit enough soon after switching
branches.
