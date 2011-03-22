From: Shawn Pearce <spearce@spearce.org>
Subject: Re: calculating a git packfile sha1 checksum in java
Date: Tue, 22 Mar 2011 07:01:12 -0700
Message-ID: <AANLkTimWt4P3qtR3b6YfRJ=Tx69EL+9+oXhD_2c9O6JX@mail.gmail.com>
References: <1300786044816-6195501.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: madmarcos <fru574@my.utsa.edu>
X-From: git-owner@vger.kernel.org Tue Mar 22 15:03:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q22Ar-0007Bl-2X
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 15:03:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754020Ab1CVOCt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 10:02:49 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:62204 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753666Ab1CVOCr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 10:02:47 -0400
Received: by vxi39 with SMTP id 39so5524343vxi.19
        for <git@vger.kernel.org>; Tue, 22 Mar 2011 07:02:47 -0700 (PDT)
Received: by 10.52.91.166 with SMTP id cf6mr5278802vdb.192.1300802567145; Tue,
 22 Mar 2011 07:02:47 -0700 (PDT)
Received: by 10.52.164.105 with HTTP; Tue, 22 Mar 2011 07:01:12 -0700 (PDT)
In-Reply-To: <1300786044816-6195501.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169949>

On Tue, Mar 22, 2011 at 02:27, madmarcos <fru574@my.utsa.edu> wrote:
> I am learning about the Git packfile and currently trying to reproduce (in
> Java) what I believe to be the SHA1 20-byte checksum for the entire
> packfile. I take the byte array from, and including, the "PACK" 4-byte
> header to the end of the last packaged object's compressed data. Everything
> I have read indicates that the next 20 bytes is the SHA1 checksum for the
> entire packfile.

That is correct.

> The 20-byte checksum that is part of the byte array received from Git is:
> B910248BF9B63AC53595E3835CA57BDAF08DA830
>
> I use the following to calculate my own SHA1 checksum:
> crypt = MessageDigest.getInstance("SHA-1");
> crypt.reset();
> crypt.update(testData);
> byte [] result = crypt.digest();

Looks right, assuming that testData is "PACK..." up to but not
including the last 20 bytes. :-)

> My result ends up as: B910248BF9B63AC53595E3835CA57BDAF08DA813
>
> I am baffled at how only the last byte of my result can be different from
> Git's (if I am using the correct part of the byte stream). If the only
> problem was the range of data passed to digest() then the entire calculated
> checksum would most likely look different.

I've never seen SHA-1 produce a value this close to the expected value
before. My first guess is that its a problem elsewhere in your code,
like your byte[]->hex formatter, or the code that is reading in the 20
bytes from Git that has the trailer is reading the wrong thing.

> Note: I use the same code to generate test SHA1 ids for each contained
> object and they match the references in the tree objects. This problem
> currently only involves calculating the checksum over the entire packfile.

But aside from just learning about Git, if you want to work with Git
in Java... use JGit[1].  :-)

[1] http://www.eclipse.org/jgit/

-- 
Shawn.
