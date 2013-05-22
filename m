From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Reading commit objects
Date: Tue, 21 May 2013 22:59:33 -0700
Message-ID: <CAJo=hJtqACW+CR5FkmDfwyK1Wg3Kcppy6DbW7P=On_qJyvsYvQ@mail.gmail.com>
References: <CABx5MBQ57-=MPamvV-peZUdD_KDLX+5cy9vD7CL7p_Vz9BkvTg@mail.gmail.com>
 <CAEBDL5XwrD8ZbRRSrM1iJGtcRgziH5bFVwRHzg9=_PYzaTfgAg@mail.gmail.com> <CABx5MBSnpZTthOHECqkbpdbFfkb4e_uSo-rh4owBc8B_oSKjJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: John Szakmeister <john@szakmeister.net>, git <git@vger.kernel.org>
To: Chico Sokol <chico.sokol@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 22 08:00:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uf25o-0003Vm-3Y
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 08:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755115Ab3EVF76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 01:59:58 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:42272 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132Ab3EVF7y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 01:59:54 -0400
Received: by mail-ie0-f171.google.com with SMTP id e11so4371099iej.16
        for <git@vger.kernel.org>; Tue, 21 May 2013 22:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cMVA23TuwVjQmIR6vBhr1ubDEgWkBFBDxnReNkyMGfU=;
        b=GnaxhRn2OTpft7cBQxUP5KNi1Am2MYB9HpFaWkfP3MiCJS36L4t9SE2p1c1EmWhqdz
         gbUuOFYW0Ro4USsSZMj1rN2Dm4BDJylwgiuEwRfcWs7n4ZTzkIAvF52TBtjkyUbkRQGP
         6vC5/fCPgt5GQdFDB+yWaXKQUnIt0RtjRWEbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=cMVA23TuwVjQmIR6vBhr1ubDEgWkBFBDxnReNkyMGfU=;
        b=Ro9LZQX8OLVQQBNbocxlSTCIreiEynT6e3gAw37/sYNEHQrKngGNDEKJjhAn/WjDB/
         Q3phJ/YBtg/mxXAjFtCmtHmU/GhL2Y2gfO0hoK3KqKWZ5q+dXDU26KVsPU20uemM8zDn
         fdr/RD24P3NZgV5BFsDXstwjl/Ffn4/pZzkaE22LJU94KhORA/gpFsRIWLHNm5tOt0dw
         V+CyhspV7deDNVJ+34RmPESPKxOVtCuh9hGjz1mFuzmC3eHFMv/EcNezj5XXrLI1X+xD
         ZgLAWfE830CFMmUQDHaddrR2VzRE0Fwce0dYi5YtyCtXrdcCFL5zrSGR2MLHWVOtEL4b
         zLIA==
X-Received: by 10.43.133.134 with SMTP id hy6mr2862168icc.57.1369202393694;
 Tue, 21 May 2013 22:59:53 -0700 (PDT)
Received: by 10.64.82.38 with HTTP; Tue, 21 May 2013 22:59:33 -0700 (PDT)
In-Reply-To: <CABx5MBSnpZTthOHECqkbpdbFfkb4e_uSo-rh4owBc8B_oSKjJQ@mail.gmail.com>
X-Gm-Message-State: ALoCoQlCBYt+gsco5rFC6N11l79rdizVTcmyBmw/t3h9rdSWbCzcLPf2HEcwGiozzntWjqQYAwyd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225131>

On Tue, May 21, 2013 at 3:18 PM, Chico Sokol <chico.sokol@gmail.com> wrote:
> Ok, we discovered that the commit object actually contains the tree
> object's sha1, by reading its contents with python zlib library.
>
> So the bug must be with our java code (we're building a java lib).
>
> Is there any non-standard issue in git's zlib compression? We're
> decompressing its contents with java default zlib api, so it should
> work normally, here's our code, that's printing that wrong output:
>
> import java.io.File;
> import java.io.FileInputStream;
> import java.util.zip.InflaterInputStream;
> import org.apache.commons.io.IOUtils;
> ...
> File obj = new File(".git/objects/25/0f67ef017fcb97b5371a302526872cfcadad21");
> InflaterInputStream inflaterInputStream = new InflaterInputStream(new
> FileInputStream(obj));
> System.out.println(IOUtils.readLines(inflaterInputStream));
...
>>> Currently, we're trying to parse commit objects. After decompressing
>>> the contents of a commit object file we got the following output:
>>>
>>> commit 191
>>> author Francisco Sokol <chico.sokol@gmail.com> 1369140112 -0300
>>> committer Francisco Sokol <chico.sokol@gmail.com> 1369140112 -0300
>>>
>>> first commit

Your code is broken. IOUtils is probably corrupting what you get back.
After inflating the stream you should see the object type ("commit"),
space, its length in bytes as a base 10 string, and then a NUL ('\0').
Following that is the tree line, and parent(s) if any. I wonder if
IOUtils discarded the remainder of the line after the NUL and did not
consider the tree line.

And you wonder why JGit code is confusing. We can't rely on "standard
Java APIs" to do the right thing, because commonly used libraries have
made assumptions that disagree with the way Git works.
