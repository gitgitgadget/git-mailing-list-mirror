From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/7] Add a memory pool library
Date: Sun, 30 May 2010 04:55:37 -0500
Message-ID: <20100530095537.GA6242@progeny.tock>
References: <1274650832-7411-1-git-send-email-artagnon@gmail.com>
 <1274650832-7411-5-git-send-email-artagnon@gmail.com>
 <20100529090609.GA7247@progeny.tock>
 <AANLkTiltqraEFzYohs_89VbJQsevQC3Yp5RYWSe4b3jd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 30 11:56:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIfFj-0001ik-Tb
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 11:56:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753121Ab0E3J4F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 May 2010 05:56:05 -0400
Received: from mail-yw0-f179.google.com ([209.85.211.179]:60317 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753066Ab0E3JzD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 May 2010 05:55:03 -0400
Received: by ywh9 with SMTP id 9so1797919ywh.17
        for <git@vger.kernel.org>; Sun, 30 May 2010 02:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=wvtBfbUqvCi7fnDIwAhrm//arp116ZRMXYjVrtTF5jI=;
        b=qRuHg/8v+tCOSeCbiAmIVUhrqjEGMnCgeX07NAdL9Nz4qIlP8uIrLXRQmp/Fvh0rYj
         ymZYtRnpl1JKAkjOYEI99uvypfGB31r60lQ7NY0Y6ktB5yebBRGduiDk0ObgBndyzjn2
         YwTfElba08rqRKOp+qA21RvCUMt7R17yMNPIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=t2C96OdvNiP21zjKTgxxkonBS3orN41nn82bNzVKLsw0nUS1EzMwXcpYHE4i/FK9FJ
         FFOs5NKRZ4PgQyCHRn5woRN5VJfNXJ7iSDU+6M1oB8LCteeGbXIiv/51gPDvHho0Ywtb
         ya9LR5vjC/9Pumh4ZeZUm3vT4EhKozINslby0=
Received: by 10.231.176.16 with SMTP id bc16mr3749060ibb.4.1275213300931;
        Sun, 30 May 2010 02:55:00 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id f1sm20418191ibg.9.2010.05.30.02.54.59
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 30 May 2010 02:55:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTiltqraEFzYohs_89VbJQsevQC3Yp5RYWSe4b3jd@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147996>

Hi Ram,

Ramkumar Ramachandra wrote:

> I've never used talloc. What basis can we use for the comparison?

Ah, a little explanation is in order.

You see, I read the commit message, having just looked at the treap
implementation, read the word =E2=80=9Callocator=E2=80=9D, and decided =
that a
mini-malloc was exactly the sort of thing I did not want to read right
then.  Hence the silly comment about some allocator that pools memory
for heterogeneous-sized blocks (which is very nice and convenient, but
not so relevant!).  Sorry --- I should not have been so lazy.

In fact, this patch just maintains a growing array of never-freed
fixed-size blocks.  It is very similar to the existing alloc.c but
with some small differences:

 . uses a single memory area that grows with realloc, so it can be
   freed for valgrind-cleanness if one wants.

 . grows a little more aggressively, as David pointed out

And it is much simpler than I was thinking, so honestly, I don=E2=80=99=
t
even mind the code duplication so much.

=46or interest, the analogous CCAN module is
http://ccan.ozlabs.org/info/block_pool.html

> On a related note, note that while compiling, a lot of
> unused functions are generated which pop up as compiler warnings

Maybe __attribute__((__unused__)) could work.

Sorry for the nonsense,
Jonathan
