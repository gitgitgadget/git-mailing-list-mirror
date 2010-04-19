From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/2] test bundle --stdin, fix
 objects_array_remove_duplicates()
Date: Mon, 19 Apr 2010 02:14:49 -0500
Message-ID: <20100419071449.GA23166@progeny.tock>
References: <20100119002641.GA31434@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 19 09:14:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3lBw-0001dh-V9
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 09:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529Ab0DSHOn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Apr 2010 03:14:43 -0400
Received: from mail-qy0-f182.google.com ([209.85.221.182]:33631 "EHLO
	mail-qy0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075Ab0DSHOm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 03:14:42 -0400
Received: by qyk12 with SMTP id 12so4924925qyk.21
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 00:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=oHm5Il5yKTVhBkT1D5dnjT0MuIy5YQ07y/GocFcrK9g=;
        b=BiumgEYG/dBHd0tvmworPnoMdlxgqQrQE6SI/KptVDkP8IrEGbb4RSmpy1yPq7gWhT
         QYKQ9Cfd3Aq9cen1msJqPesFUpyQkOyywNyCjLN28i/e6dLFw7Mp0i+ewJSWR5a6TjGY
         3PXfSL/42CcwEL+Cz2/OHtbK2AravnQTMW2+8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=prrrANwff7K1cj8As0JJ+zSKkrzonOALEDZ+SnrPTsbbkyMSfAgOAyQnGa7RyGwwXf
         lfV3pm4QELW3wPMrVdy3AwysyejX3AYWwYXVtjHX0ry4CDQYKJTtf8YrRRWR/DPv90ff
         YI3ny4//OPrZe59ktT0xN3yDxMHzKYRje1J4o=
Received: by 10.229.218.2 with SMTP id ho2mr2184799qcb.51.1271661281437;
        Mon, 19 Apr 2010 00:14:41 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm4722272iwn.7.2010.04.19.00.14.40
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 19 Apr 2010 00:14:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100119002641.GA31434@gnu.kitenet.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145269>

This series does not make =E2=80=98git bundle --stdin=E2=80=99 work.  I=
n fact,
the bug that it does fix would not be visible if bundle --stdin
worked as it was supposed to.

Instead, this fixes a segfault that the bug triggers.  The
patches have been sitting in my git tree for a while.  They fix
a real problem regardless, and maybe they would help someone
to get bundle --stdin working properly.

Thoughts welcome, as always.
Jonathan Nieder (2):
  t5704 (bundle): add tests for bundle --stdin
  fix "bundle --stdin" segfault

 object.c          |    4 ++--
 t/t5704-bundle.sh |   16 ++++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

As for how to fix bundle --stdin, Joey Hess wrote:

> I also tried going back to 22568f0a336ac37ae7329c917857b455839d1d09, =
but
> still see a bug with Adam Brewster's initial code to add --stdin to
> git-bundle. That code still tries to read stdin twice. If it sees
> "master" both times, it does create a bundle.

and Johannes Schindelin suggested slurping up the input and explicitly
using it twice, or:

> Alternatively, you can try to implement the rev-list --boundary by
> hand (the --pretty=3Doneline is only needed to get a boundary marker
> IIRC), taking care to reset the commit flags that were set in the
> process.
[...]
> If you want to go that route (which is arguably more elegant anyway),
> I suggest having a look at the merge_bases() and get_merge_bases()
> functions in commit.c

Dscho=E2=80=99s full message is pretty helpful:
http://thread.gmane.org/gmane.comp.version-control.git/137414/focus=3D1=
37503
