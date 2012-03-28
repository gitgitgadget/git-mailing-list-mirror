From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: GSoC - Some questions on the idea of "Better big-file support".
Date: Wed, 28 Mar 2012 13:19:54 +0700
Message-ID: <CACsJy8APtMsMJ=FrZjOP=DbzuFoemSLJTmkjaiK5Wkq9XtA4rg@mail.gmail.com>
References: <CA+M5ThS2iS-NMNDosk2oR25N=PMJJVTi1D=zg7MnMCUiRoX4BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, peff@peff.net
To: Bo Chen <chen@chenirvine.org>
X-From: git-owner@vger.kernel.org Wed Mar 28 08:20:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCmFE-0000Km-0B
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 08:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365Ab2C1GU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 02:20:26 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:56033 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850Ab2C1GU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 02:20:26 -0400
Received: by wibhr17 with SMTP id hr17so5345710wib.1
        for <git@vger.kernel.org>; Tue, 27 Mar 2012 23:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Y/NxaiW+8j+07JzOOQhWPeS6+AhERFeFGfe66TNwUVs=;
        b=K85S8kP+FNWJ0W0PSc3gmSdNEalSF9ai0ghns2Ly+z+AW8Ofvqrd/nEWpcyOQit0c+
         yq72yPPn5FXkfltDt8H7ubrvq/HPzjLgI7waDC6ch+u7yG0aG3n/xO6co5EQUFi2kA8K
         frGiBQhzdJmPr+woGz+JTvBLv4RtynsNh5UMvdMEPoeWZ0LIh9AduyG892dRKWfobhF/
         JcLu0LLdsuZXrvr2i+wehe0usbpl4cZ+6k0qstY/1TnBJqGTaXNvJN6F5/8bLF+w3/NF
         Nu5NaGxIEPBM0sq8lxcta47+Bg8y41TaVrRpIteuNWY9yP2eqYpDC68rIH0Vckn2112k
         /wxQ==
Received: by 10.180.107.101 with SMTP id hb5mr4069332wib.7.1332915624570; Tue,
 27 Mar 2012 23:20:24 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Tue, 27 Mar 2012 23:19:54 -0700 (PDT)
In-Reply-To: <CA+M5ThS2iS-NMNDosk2oR25N=PMJJVTi1D=zg7MnMCUiRoX4BQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194108>

On Wed, Mar 28, 2012 at 11:38 AM, Bo Chen <chen@chenirvine.org> wrote:
> Hi, Everyone. This is Bo Chen. I am interested in the idea of "Better
> big-file support".
>
> As it is described in the idea page,
> "Many large files (like media) do not delta very well. However, some
> do (like VM disk images). Git could split large objects into smaller
> chunks, similar to bup, and find deltas between these much more
> manageable chunks. There are some preliminary patches in this
> direction, but they are in need of review and expansion."
>
> Can anyone elaborate a little bit why many large files do not delta
> very well?

Large files are usually binary. Depends on the type of binary, they
may or may not delta well. Those that are compressed/encrypted
obviously don't delta well because one change can make the final
result completely different.

Another problem with delta-ing large files with git is, current code
needs to load two files in memory for delta. Consuming 4G for delta 2
2GB files does not sound good.

> Is it a general problem or a specific problem just for Git?
> I am really new to Git, can anyone give me some hints on which source
> codes I should read to learn more about the current code on delta
> operation? It is said that "there are some preliminary patches in this
> direction", where can I find these patches?

Read about rsync algorithm [2]. Bup [1] implements the same (I think)
algorithm, but on top of git. For preliminary patches, have a look at
jc/split-blob series at commit 4a1242d in git.git.

[1] https://github.com/apenwarr/bup
[2] http://en.wikipedia.org/wiki/Rsync#Algorithm
-- 
Duy
