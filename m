From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 8/8] Remove pack file handling dependency from wrapper.o
Date: Sun, 7 Nov 2010 12:23:41 -0600
Message-ID: <20101107182341.GA31470@burratino>
References: <20101106113905.GA27405@burratino>
 <20101106115237.GH27641@burratino>
 <4CD5996F.6010809@lsrfire.ath.cx>
 <20101106184251.GA14288@burratino>
 <4CD6CF59.5040801@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Nov 07 19:24:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PF9uM-0006aq-0W
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 19:24:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758Ab0KGSX5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Nov 2010 13:23:57 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49424 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501Ab0KGSX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Nov 2010 13:23:56 -0500
Received: by gyh4 with SMTP id 4so2989425gyh.19
        for <git@vger.kernel.org>; Sun, 07 Nov 2010 10:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=vkNZNF5rE16UpcbbYRWIkPtGTQEc5rIbazn3MdSD3NQ=;
        b=stlgz5DEFoszBKz1R/2Up/nN6R6PEpxHgAOPHYGF/T9uqnm7nKyIUyF/D0gGJh5wzY
         PjJtx0NoeGFE95XGhzkIP3n7O6YhHS3HaSV1V/dpV/SdYacUFzYLdURYe6LWRzHWzFIi
         n/He9RIb8GEuu3i5zk3gPek3TxP62pkl3wQwM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Xk9zjWb0LRZwSBgPj9boG0s7Gy1nWawKGIe0K7jJ1MpU8wgR9xq5pv26W9Kj4dARQJ
         vnaJwNVlYU+N3wd1OaFV22GCFdv3S6kmYlFFF0YiD2V7fts3x+MONfoJGlHozh3Fr7Fn
         3ycFI6jqr+ky05kb5qbDBYQcjdFG6r1jMjQSY=
Received: by 10.150.147.20 with SMTP id u20mr7087259ybd.117.1289154235841;
        Sun, 07 Nov 2010 10:23:55 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id q18sm1620029ybk.3.2010.11.07.10.23.54
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 07 Nov 2010 10:23:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CD6CF59.5040801@lsrfire.ath.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160894>

Ren=C3=A9 Scharfe wrote:
> Am 06.11.2010 19:42, schrieb Jonathan Nieder:

>> Maybe add_packed_git()?
>>=20
>> use_pack() is called by:
[...]
>> some of which would make me worry about thread-safety.
>
> Possibly, but if that's the case then we have a thread-safety issue
> already: use_pack() updates pack_mapped, which is used by
> release_pack_memory() to see how much can be freed.

Good point.  The threaded callers are probably protected by read_lock.

My other worry would be that try_to_free_pack_memory should not
override try_to_free_from_threads.  I guess some time documenting
these code paths will be needed. :(

Thanks for a sanity check,
Jonathan
