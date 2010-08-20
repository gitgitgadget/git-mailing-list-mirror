From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Out of memory error during git push
Date: Fri, 20 Aug 2010 07:51:19 -0500
Message-ID: <20100820125119.GA9762@burratino>
References: <4C6E46A4.8050502@kinet.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Thomas Jampen <jampen@kinet.ch>
X-From: git-owner@vger.kernel.org Fri Aug 20 14:53:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmR5u-0007wJ-Er
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 14:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335Ab0HTMxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 08:53:08 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65219 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970Ab0HTMxH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 08:53:07 -0400
Received: by iwn5 with SMTP id 5so817188iwn.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 05:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=kGjTH89Q8LhViAmsyKX9yWWQqxrXX/P5Jw2X/EyHf0s=;
        b=snQgdOo7GK2moMbfDfSXWo66Y5CGfl5M1/BHvXDk2Kz9/SmSs4Gvt7eq5WoXl3hBH9
         CF98hskDnly8xRdU2YBt9z4qtXemeqQJMQakX07RULchcPfE01ieu405DXOomvrfZtfW
         LoVAHHeau0hDFLVg33KBP3boidSupi15o+F4E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Tgkoj5x/4Oe60ITe0PH5Z+mgX7Nj09YHFoOS46rnOpYvhBHIJmaWg4NNQou4I4Ova+
         vYTNJClDvHc2AlbAIf8WCH7eGsCAJdhz1wLqKZ5GAVOoUzfYrhPXT4z+2JHJzrBJLJU6
         mhkyv5RZxCUZYey2MLQv0N4HUj9aEGxMmGnR4=
Received: by 10.231.154.75 with SMTP id n11mr1689375ibw.40.1282308787193;
        Fri, 20 Aug 2010 05:53:07 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id e8sm2600663ibb.14.2010.08.20.05.53.06
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 05:53:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C6E46A4.8050502@kinet.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154027>

(+cc: Nicolas, who knows the packing code pretty well)

Hi,

Thomas Jampen wrote:

> I'm experiencing the following error while pushing a git repo (home
> directory) to my QNAP TS-210:
> 
> user@mypc:~$ git push origin master
> Counting objects: 12532, done.
> Delta compression using up to 2 threads.
> Compressing objects: 100% (8974/8974), done.
> fatal: Out of memory, malloc failed, 986.06 MiB | 1.65 MiB/s
> error: pack-objects died of signal 13

What version of git are you using?  Do you have overcommit accounting
enabled?

I am not sure this is the problem you are running into, but pack-objects
like many other parts of git uses mmap() to read packfiles, which can
make the address space usage high.

> I've searched the internet and found suggestions to try to repack with
> lower values for 'depth', 'window' and 'windowMemory'. I used 3, 3, 50
> respectively, but a push after the repack command resulted in the same
> error.
> 
> I tried git fsck which reported a few dangling blobs only and I got the
> same error again during the next push.
> 
> I watched /proc/meminfo and /proc/swaps on the NAS while pushing and saw
> that there are always 20-50MB of free RAM and that from 512MB swap space
> only about 180MB are used.

I don't know --- this is out of my depth. :)

Good luck,
Jonathan
