From: Shawn Pearce <spearce@spearce.org>
Subject: Re: how to keep git-fetch from running out of memory?
Date: Sun, 15 May 2011 12:13:55 -0700
Message-ID: <BANLkTinRkePRMQzQS7k=3bSTxTJRVpG39Q@mail.gmail.com>
References: <BANLkTinnOTr+PUzBMpx1DLcxs8CVWjy33A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kartik Agaram <ak@akkartik.com>
X-From: git-owner@vger.kernel.org Sun May 15 21:14:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLgli-0005Xb-64
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 21:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567Ab1EOTOQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 May 2011 15:14:16 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42983 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378Ab1EOTOQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2011 15:14:16 -0400
Received: by vws1 with SMTP id 1so2733955vws.19
        for <git@vger.kernel.org>; Sun, 15 May 2011 12:14:15 -0700 (PDT)
Received: by 10.52.114.104 with SMTP id jf8mr5084021vdb.193.1305486855122;
 Sun, 15 May 2011 12:14:15 -0700 (PDT)
Received: by 10.52.157.73 with HTTP; Sun, 15 May 2011 12:13:55 -0700 (PDT)
In-Reply-To: <BANLkTinnOTr+PUzBMpx1DLcxs8CVWjy33A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173645>

On Sat, May 14, 2011 at 22:24, Kartik Agaram <ak@akkartik.com> wrote:
> I have a git repo with some large files that I'm no longer able to
> update. git fetch keeps running out of memory:
>
> =A0fatal: Out of memory, malloc failed
> =A0fatal: unpack-objects died with error code 128
>
> Anybody know how to keep it from compressing the refs into packfiles?
> I've experimented with core.compression, pack.compression,
> pack.windowMemory, pack.packSizeLimit, all without luck :(

Instead of playing with these settings, try transfer.unpackLimit 1. It
will force the code to use index-pack rather than unpack-objects,
which has a different memory profile.

However, that may still be insufficient. A big object must still be
allocated in memory in order to compute its SHA-1. If you don't have
sufficient memory, you need to increase your ulimits, or reconfigure
your system to have more virtual memory available to the process.

--=20
Shawn.
