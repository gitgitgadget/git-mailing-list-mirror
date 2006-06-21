From: David Lang <dlang@digitalinsight.com>
Subject: Re: packs and trees
Date: Wed, 21 Jun 2006 08:32:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0606210830140.6305@qynat.qvtvafvgr.pbz>
References: <9e4733910606192257y1516e966t848a3b1e29e5667f@mail.gmail.com> 
 <46a038f90606192313l16b16132r1523f5e05ae1566a@mail.gmail.com> 
 <Pine.LNX.4.64.0606201102410.3377@localhost.localdomain><46a038f90606201241
 x3dec242dicde245a24c3ab9ab@mail.gmail.com> <Pine.LNX.4.64.0606202046290.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Nicolas Pitre <nico@cam.org>, Jon Smirl <jonsmirl@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 21 17:33:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ft4hm-0005Vw-Q2
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 17:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWFUPdU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 11:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWFUPdU
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 11:33:20 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:59875 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932189AbWFUPdT
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jun 2006 11:33:19 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Wed, 21 Jun 2006 08:33:19 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Wed, 21 Jun 2006 08:32:58 -0700
X-X-Sender: dlang@dlang.diginsite.com
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606202046290.5498@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22279>

there are performance penalties in some cases when you use directory hashing. I 
did some tests last year of lots of small files in a directory tree (X/X/X/XXX 
of 1k files) and I found that turning on directory hashing actually slowed down 
the creation of this tree from a tarball significantly (I also found that in 
this case the ext2 allocation strategy was significantly better then the ext3 
one), so test on your system.

David Lang


  On Tue, 20 Jun 2006, Linus Torvalds wrote:

> Date: Tue, 20 Jun 2006 20:54:01 -0700 (PDT)
> From: Linus Torvalds <torvalds@osdl.org>
> To: Martin Langhoff <martin.langhoff@gmail.com>
> Cc: Nicolas Pitre <nico@cam.org>, Jon Smirl <jonsmirl@gmail.com>,
>     git <git@vger.kernel.org>
> Subject: Re: packs and trees
> 
>
>
> On Wed, 21 Jun 2006, Martin Langhoff wrote:
>>
>> If you are asking about the ext3 performance problems, I think Linus
>> discussed that a while ago, why unpacked repos are slow (in addition
>> to huge), and there were some suggestions of using hashed directory
>> indexes.
>
> Yes. I think most distros still default to nonhashed directories, but for
> any large-directory case you really want to turn on hashing.
>
> I forget the exact details, it's somethng like
>
> 	tune2fs -O dir_index
>
> or something to turn it on (if I remember correctly, that will only affect
> any directories then created after that, but you can effect that by just
> doing a "git repack -a -d" which will remove all old object directories,
> and now subsequent directories will be done with indexing on).
>
> Personally, I just ended up using packs extensively, so I think I'm still
> running without indexing on all my machines ;)
>
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
