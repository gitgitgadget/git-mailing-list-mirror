From: david@lang.hm
Subject: Re: Git Large Object Support Proposal
Date: Thu, 19 Mar 2009 16:52:19 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0903191650160.16753@asgard.lang.hm>
References: <d411cc4a0903191514n1e524ebava5895d708a2927c4@mail.gmail.com> <7veiwt6t6a.fsf@gitster.siamese.dyndns.org> <d411cc4a0903191618x503db946n62d3132eece69175@mail.gmail.com> <7vzlfh5b7y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 00:55:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkS4o-0005xM-Dr
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 00:55:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761475AbZCSXwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 19:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760650AbZCSXwY
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 19:52:24 -0400
Received: from mail.lang.hm ([64.81.33.126]:49175 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757102AbZCSXwY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 19:52:24 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n2JNqJYo011510;
	Thu, 19 Mar 2009 15:52:19 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <7vzlfh5b7y.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113866>

On Thu, 19 Mar 2009, Junio C Hamano wrote:

> Scott Chacon <schacon@gmail.com> writes:
>
>> The point is that we don't keep this data as 'blob's - we don't try to
>> compress them or add the header to them, they're too big and already
>> compressed, it's a waste of time and often outside the memory
>> tolerance of many systems. We keep only the stub in our db and stream
>> the large media content directly to and from disk.  If we do a
>> 'checkout' or something that would switch it out, we could store the
>> data in '.git/media' or the equivalent until it's uploaded elsewhere.
>
> Aha, that sounds like you can just maintain a set of out-of-tree symbolic
> links that you keep track of, and let other people (e.g. rsync) deal with
> the complexity of managing that side of the world.
>
> And I think you can start experimenting it without any change to the core
> datastructures.  In your single-page web site in which its sole html file
> embeds an mpeg movie, you keep track of these two things in git:
>
> 	porn-of-the-day.html
>        porn-of-the-day.mpg -> ../media/6066f5ae75ec.mpg
>
> and any time you want to feed a new movie, you update the symlink to a
> different one that lives outside the source-controlled tree, while
> arranging the link target to be updated out-of-band.

that would work, but the proposed change has some advantages

1. you store the sha1 of the real mpg in the 'large file' blob so you can 
detect problems

2. since it knows the sha1 of the real file, it can auto-create the real 
file as needed, without wasting space on too many copies of it.

David Lang
