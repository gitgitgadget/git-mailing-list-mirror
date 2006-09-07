From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: A look at some alternative PACK file encodings
Date: Wed, 06 Sep 2006 17:19:18 -0700
Message-ID: <44FF6586.8080206@gmail.com>
References: <44FF41F4.1090906@gmail.com> <9e4733910609061623k73086dbey4a600ecf2852c024@mail.gmail.com> <44FF5C27.2040300@gmail.com> <Pine.LNX.4.64.0609061651500.27779@g5.osdl.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jon Smirl <jonsmirl@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 02:19:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GL7c6-0004LJ-Ex
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 02:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbWIGATX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 20:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWIGATX
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 20:19:23 -0400
Received: from nz-out-0102.google.com ([64.233.162.198]:39024 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964818AbWIGATW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 20:19:22 -0400
Received: by nz-out-0102.google.com with SMTP id n1so11841nzf
        for <git@vger.kernel.org>; Wed, 06 Sep 2006 17:19:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Un+KxRwYALWRWabW2NpBTNUpvuz7GspITcKyp4jW6FUpkczZ4+BPEQXBXf6C0ndAP0cGISFb3P4G2NUZuGAhFj48m5lE6pZeOj7n4DtYGLiU4PtNfg1G6Up9mMi/mq45/ts2zNsb4WuL9OjwzIpy8fVuNmRBxE2n6vsphWIaXY8=
Received: by 10.65.98.4 with SMTP id a4mr43415qbm;
        Wed, 06 Sep 2006 17:19:21 -0700 (PDT)
Received: from ?10.0.0.6? ( [24.55.157.69])
        by mx.gmail.com with ESMTP id f14sm31493qba.2006.09.06.17.19.20;
        Wed, 06 Sep 2006 17:19:21 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609061651500.27779@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26576>

Linus Torvalds wrote:
> 
> On Wed, 6 Sep 2006, A Large Angry SCM wrote:
> 
>> Jon Smirl wrote:
>>> On 9/6/06, A Large Angry SCM <gitzilla@gmail.com> wrote:
>>>> TREE objects do not delta or deflate well.
>>> I can understand why they don't deflate, the path names are pretty
>>> much unique and the sha1s are incompressible. By why don't they delta
>>> well? Does sorting them by size mess up the delta process?
>> My guess would be the TREEs would only delta well against other TREE
>> versions for the same path.
> 
> That's what you'd normally have in a real project, though. I wonder if 
> your "pack mashup" lost the normal behaviour: we very much sort trees 
> together normally, thanks to the "sort-by-filename, then by size" 
> behaviour that git-pack-objects should have (for trees, the size normally 
> shouldn't change, so the sorting should basically boil down to "sort the 
> same directory together, keeping the ordering it had from git-rev-list").

The mashup is just all the projects in a single repository with a bushy
refs tree so I can view the updates in a single gitk window.

The sorting by name, then by path may be breaking the object version
relationship for wide graphs.

> Btw, that "keeping the ordering it had" part I'm not convinced we actually 
> enforce. That would depend on the sort algorithm used by "qsort()", I 
> think. So there might be room for improvement there in order to keep 
> things in recency order.

qsort() is not stable.

>> Just looking at the structures in non-BLOBS, I see a lot of potential
>> for the use of a set dictionaries when deflating TREEs and another set
>> of dictionaries when deflating COMMITs and TAGs. The low hanging fruit
>> is to create dictionaries of the most referenced IDs across all TREE or
>> COMMIT/TAG objects.
>
> Is there any way to get zlib to just generate a suggested dictionary from 
> a given set of input?

The docs suggest "no".
