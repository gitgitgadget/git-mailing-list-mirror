From: Bo Chen <chen@chenirvine.org>
Subject: Re: GSoC - Some questions on the idea of "Better big-file support".
Date: Fri, 30 Mar 2012 15:11:40 -0400
Message-ID: <CA+M5ThS1XiaGJWmSvfwXoqebnH6fK3h6cC7OnQQi=LXzcA0GRw@mail.gmail.com>
References: <CA+M5ThS2iS-NMNDosk2oR25N=PMJJVTi1D=zg7MnMCUiRoX4BQ@mail.gmail.com>
	<CACsJy8APtMsMJ=FrZjOP=DbzuFoemSLJTmkjaiK5Wkq9XtA4rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, peff@peff.net
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 21:11:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDhEi-0000wy-17
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 21:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761285Ab2C3TLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 15:11:43 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:44686 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756859Ab2C3TLl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 15:11:41 -0400
Received: by wibhr17 with SMTP id hr17so934582wib.1
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 12:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:in-reply-to:references:date
         :message-id:subject:from:to:cc:x-gm-message-state:content-type;
        bh=2xEh1DpNtHXGI/n+vgSpNUp6ZWpO+bURXOIHNgwvW7s=;
        b=jyUXK5TA0UNCmoGhBpVk/G5PRPQUjjrCNpWYJMj38SgdiXVSdwbfV4nJGl4/eDBcS8
         T5OgAFgF6FESDUg6sLLynJ9OZv30qQh2jaIIQ4/d3VMaCzH6x2noZRvJvgcky2N2tAwW
         sKLKklVO0p3NuUBAd3SHpiMxUHzqlKoQ/RsVuUuzOfCCLpN8fVFqx+CUqoGfQ1gsAhRK
         vb+OrbMG20hQX3vlol8BReJoyqq/lqsCvbuxFUMTVLrJVQuRNM+0awXO6QGK3EwwYm0U
         959GbNmyJXEiEd/MnBBuMMJFfbNJRJkM7zeNngdDm+mPpEP+n6ITcvRYS1hKOsWdm+MM
         BZYw==
Received: by 10.180.98.8 with SMTP id ee8mr946700wib.14.1333134700664; Fri, 30
 Mar 2012 12:11:40 -0700 (PDT)
Received: by 10.180.81.70 with HTTP; Fri, 30 Mar 2012 12:11:40 -0700 (PDT)
X-Originating-IP: [128.235.34.66]
In-Reply-To: <CACsJy8APtMsMJ=FrZjOP=DbzuFoemSLJTmkjaiK5Wkq9XtA4rg@mail.gmail.com>
X-Gm-Message-State: ALoCoQneiNDSUdahujD45twxzNDd+f7e6Q+GBq1fCbJjJ2LF3/e4vlD5vcLY1/y8mxJWqOlNRSwD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194386>

Sorry for replying late.

My questions are inline in the following.


On Wed, Mar 28, 2012 at 2:19 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Wed, Mar 28, 2012 at 11:38 AM, Bo Chen <chen@chenirvine.org> wrote:
>> Hi, Everyone. This is Bo Chen. I am interested in the idea of "Better
>> big-file support".
>>
>> As it is described in the idea page,
>> "Many large files (like media) do not delta very well. However, some
>> do (like VM disk images). Git could split large objects into smaller
>> chunks, similar to bup, and find deltas between these much more
>> manageable chunks. There are some preliminary patches in this
>> direction, but they are in need of review and expansion."
>>
>> Can anyone elaborate a little bit why many large files do not delta
>> very well?
>
> Large files are usually binary. Depends on the type of binary, they
> may or may not delta well. Those that are compressed/encrypted
> obviously don't delta well because one change can make the final
> result completely different.

Just make clear one of my confusions. Delta operation is to find out
the differences between different versions of the same file, right?
As I know, delta encoding is to re-encode a file based on the
differences between neighboring blocks, thus can help compress a file
since after delta encoding, we will have more similar data within the
file. Can anyone elaborate a little bit what is the relation between
delta operation in git and delta encoding listed above? Thanks.

>
> Another problem with delta-ing large files with git is, current code
> needs to load two files in memory for delta. Consuming 4G for delta 2
> 2GB files does not sound good.


I am wondering why we cannot divide the 2  2GB files into chunks and
delta chunks by chunks. Is that any difference, except a little more
IOs?

>
>> Is it a general problem or a specific problem just for Git?
>> I am really new to Git, can anyone give me some hints on which source
>> codes I should read to learn more about the current code on delta
>> operation? It is said that "there are some preliminary patches in this
>> direction", where can I find these patches?
>
> Read about rsync algorithm [2]. Bup [1] implements the same (I think)
> algorithm, but on top of git. For preliminary patches, have a look at
> jc/split-blob series at commit 4a1242d in git.git.

Make clear my another confusion. The file which has been updated
(added, deleted, and modified) is first delta-compressed, and then
synchronize to the remote repo by some mechanism (rsync?). I am
wondering what is the the relationship between delta operation and
rsync.

>
> [1] https://github.com/apenwarr/bup
> [2] http://en.wikipedia.org/wiki/Rsync#Algorithm
> --
> Duy

Bo
