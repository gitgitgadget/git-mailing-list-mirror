From: david@lang.hm
Subject: Re: Git-aware HTTP transport
Date: Mon, 25 Aug 2008 20:59:33 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0808252052350.29665@asgard.lang.hm>
References: <20080826012643.GD26523@spearce.org> <48B36BCA.8060103@zytor.com> <20080826034544.GA32334@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 06:00:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXpj6-0007li-0D
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 06:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753961AbYHZD7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 23:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753959AbYHZD7I
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 23:59:08 -0400
Received: from mail.lang.hm ([64.81.33.126]:38470 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753844AbYHZD7H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 23:59:07 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m7Q3x4pM017925;
	Mon, 25 Aug 2008 20:59:04 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20080826034544.GA32334@spearce.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93705>

On Mon, 25 Aug 2008, Shawn O. Pearce wrote:

> "H. Peter Anvin" <hpa@zytor.com> wrote:
>> So don't implement things as GET requests unless you genuinely can deal
>> with the request being cached.  Using POST requests throughout seems
>> like a safer bet to me; on the other hand, since the only use of GET is
>> obtaining a list of refs the worst thing that can happen, I presume, is
>> additional latency for the user behind the proxy.
>
> This is a good point.  There is probably not any reason to cache the
> refs content if we don't also support caching the pack files.  So in
> this latest draft I have moved the ref listing to also be a POST.

on the other hand, it would be a good thing if pack files could be cached.

in a peer-peer git environment the cache would not be used very much, but 
when you have a large number of people tracking a central repository (or 
even a pseudo-central one like the kernel) you have a lot of people 
upgrading from one point to the next point.

and for cloneing (and especially thing like linux-next where you 
essentially re-clone daily) letting the pack get cached is probably a very 
good thing.

I know it would be another round-trip, but how painful would it be to 
compute what the contents of a pack would be (what objects would be in it, 
not calculating the deltas nessasary for a full pack file), and return 
that to the client so that the client could do a GET for the pack itself.

if that exact pack happens to be in the cache, great, if not the server 
takes the data from the client and creates a pack file with those objects 
in it.

David Lang
