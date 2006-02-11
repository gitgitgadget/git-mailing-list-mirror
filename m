From: Marco Costalba <mcostalba@gmail.com>
Subject: Re: gitweb using "--cc"?
Date: Sat, 11 Feb 2006 10:17:19 +0100
Message-ID: <e5bfff550602110117i7b742351m14e908de10aac12c@mail.gmail.com>
References: <Pine.LNX.4.64.0602081532360.2458@g5.osdl.org>
	 <Pine.LNX.4.64.0602091029310.2458@g5.osdl.org>
	 <7v3bisb9qn.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0602091216460.2458@g5.osdl.org>
	 <Pine.LNX.4.64.0602091235210.2458@g5.osdl.org>
	 <7v8xsk9s3v.fsf@assigned-by-dhcp.cox.net>
	 <7v4q389rwi.fsf@assigned-by-dhcp.cox.net>
	 <7voe1g8air.fsf@assigned-by-dhcp.cox.net>
	 <7vk6c48a69.fsf@assigned-by-dhcp.cox.net>
	 <7v3bis88y9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 11 10:17:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7qsv-0003OS-PP
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 10:17:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbWBKJRW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 04:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWBKJRW
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 04:17:22 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:8882 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751311AbWBKJRV convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2006 04:17:21 -0500
Received: by wproxy.gmail.com with SMTP id 57so504226wri
        for <git@vger.kernel.org>; Sat, 11 Feb 2006 01:17:19 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o9w4OzSB37jh92Uu5QcuqiXBwH73i2gkTkgAJ46TGGAhAdD/4pAgyhLfQWt8EGYjV+Ys31Jq6CBi39kMQBPmOo5ufqKGfVOJyc3V/ZNN56nnbDt0r84KNsx4gitbZE5SgI4N/L95/d9MvLY6cUPA0OlHCZ28pxqnQSwuKs9uyWo=
Received: by 10.64.180.12 with SMTP id c12mr153074qbf;
        Sat, 11 Feb 2006 01:17:19 -0800 (PST)
Received: by 10.64.131.15 with HTTP; Sat, 11 Feb 2006 01:17:19 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bis88y9.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15934>

On 2/9/06, Junio C Hamano <junkio@cox.net> wrote:
>
> Does it matter?  I presume that a Porcelain that cares would
> rather use the traditional "diff-tree -m -r" to look at diff
> with each parent.  I dunno.
>

Yes, please preserve this behaviour.

I pulled today the diff-tree -c semantic change and now I see, in git archive:

$ git-diff-tree -r ca182053c7710a286d72102f4576cf32e0dafcfb
ca182053c7710a286d72102f4576cf32e0dafcfb
::100644 100644 100644 538d21d808b7ccc287e7bdd947f1583eadcda28b
30479b4a19805132a16facf6342b1438427486b7
59042d1bc9ee65063455b50a0968efb0b8182577 MM        Makefile

$ git-diff-tree -r -m ca182053c7710a286d72102f4576cf32e0dafcfb
ca182053c7710a286d72102f4576cf32e0dafcfb
:100644 100644 538d21d808b7ccc287e7bdd947f1583eadcda28b
59042d1bc9ee65063455b50a0968efb0b8182577 M      Makefile
:100644 100644 410b758aab7efc6d777f0344500f97b1cbc52946
6c47c3a3e1acb8badaadad42dfe3d0bd7a06cac3 M      entry.c
ca182053c7710a286d72102f4576cf32e0dafcfb
:100644 100644 30479b4a19805132a16facf6342b1438427486b7
59042d1bc9ee65063455b50a0968efb0b8182577 M      Makefile

Please _do not_ change this behaviour to make -m a no-op as stated in
"diff-tree -c raw output" patch message
(ee63802422af14e43eccce3c6dc4150a27ceb1a3).

qgit has the possibility to switch from "see all merge files" to "see
interesting only", so
we really need that difference between 'git-diff-tree -r' and
'git-diff-tree -r -m'

Anyhow I am very happy with this change because it broke qgit ;-) but when fixed
it will have a lot of code removed and will be faster too.

Thanks
Marco
