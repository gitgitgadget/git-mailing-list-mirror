From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: GSoC - Some questions on the idea of
Date: Sat, 31 Mar 2012 15:28:06 -0500
Message-ID: <4F7768D6.3010400@gmail.com>
References: <CA+M5ThS2iS-NMNDosk2oR25N=PMJJVTi1D=zg7MnMCUiRoX4BQ@mail.gmail.com> <CACsJy8APtMsMJ=FrZjOP=DbzuFoemSLJTmkjaiK5Wkq9XtA4rg@mail.gmail.com> <loom.20120328T131530-717@post.gmane.org> <CA+M5ThTPyic=RhFL2SvuNB0xBWOHxNTaUZrYMB144UjpjCiLoQ@mail.gmail.com> <20120330203430.GB20376@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Bo Chen <chen@chenirvine.org>, Sergio <sergio.callegari@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 31 22:28:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SE4uI-0002dW-KM
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 22:28:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903Ab2CaU2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Mar 2012 16:28:14 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35637 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166Ab2CaU2N (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2012 16:28:13 -0400
Received: by obbtb18 with SMTP id tb18so470734obb.19
        for <git@vger.kernel.org>; Sat, 31 Mar 2012 13:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=FhTLrHjXi0b7GrXQXzBeMMxhrm7kpcfG6mmxMeSYE5Y=;
        b=E6202FlVqpSmiVGEP+muG5/oVqjlfBDxqNOYWxvXiVWZmIaLWiS18JBywxX4UdvPgl
         GUFpnmYsBpa0xzQpMVqvrZ4Yf/xS8QV92JrOkDGkffjKIwYHguTlTltSxyDzAUF+5B9P
         b2Ht0uUNRNGPbvzj9luubJvJ/zJFlo4sJF7fAg06IUMsLEJmazbh6NfuE48YChCfXXz8
         Cqrq1QS4v/64pKIbAwmVr93d2iKH1d+lA7xjdEiMzGLONwPowCIrRggoXIOsJQ4RSLL5
         RURpY25ZIHMmg5MOVXe+E45hlup6dWo/aPmgNWzjqfkCG486buC0idHWdKsGNNrqM+WJ
         oq9w==
Received: by 10.60.25.162 with SMTP id d2mr4243677oeg.30.1333225692747;
        Sat, 31 Mar 2012 13:28:12 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id vk10sm13105359obb.8.2012.03.31.13.28.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 31 Mar 2012 13:28:11 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.28) Gecko/20120306 Thunderbird/3.1.20
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20120330203430.GB20376@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194463>

On 3/30/2012 3:34 PM, Jeff King wrote:
> On Fri, Mar 30, 2012 at 03:51:20PM -0400, Bo Chen wrote:
>
>> The sub-problems of "delta for large file" problem.
>>
>> 1 large file
>>
> But let's take a step back for a moment. Forget about whether a file is
> binary or not. Imagine you want to store a very large file in git.
>
> What are the operations that will perform badly? How can we make them
> perform acceptably, and what tradeoffs must we make? E.g., the way the
> diff code is written, it would be very difficult to run "git diff" on a
> 2 gigabyte file. But is that actually a problem? Answering that means
> talking about the characteristics of 2 gigabyte files, and what we
> expect to see, and to what degree our tradeoffs will impact them.
>
> Here's a more concrete example. At first, even storing a 2 gigabyte file
> with "git add" was painful, because we would load the whole thing in
> memory. Repacking the repository was painful, because we had to rewrite
> the whole 2G file into a packfile. Nowadays, we stream large files
> directly into their own packfiles, and we have to pay the I/O only once
> (and the memory cost never). As a tradeoff, we no longer get delta
> compression of large objects. That's OK for some large objects, like
> movie files (which don't tend to delta well, anyway). But it's not for
> other objects, like virtual machine images, which do tend to delta well.
>
> So can we devise a solution which efficiently stores these
> delta-friendly objects, without losing the performance improvements we
> got with the stream-directly-to-packfile approach?
>
> One possible solution is breaking large files into smaller chunks using
> something like the bupsplit algorithm (and I won't go into the details
> here, as links to bup have already been mentioned elsewhere, and Junio's
> patches make a start at this sort of splitting).
>
(I'm no expert on "big-files" in git or elsewhere, but this thread is 
immensely interesting to me as a git user who wants to track all sorts 
of binary files and possibly large text files in the very near future, 
ie. all components tied to a server build and upgrades beyond the 
linux-distro/rpms and perhaps including them also.)

Let's take an even bigger step back for a moment.  Who determines if a 
file shall be a big-file or not?  Git or the user?  How is it determined 
if a file shall be a "big-file" or not?

Who decides bigness:
Bigness seems to be relative to system resources.  Does the user crunch 
the numbers to determine if a file is big-file, or does git?  If the 
numbers are relative then should git query the system and make the 
determination?  Either way, once the system-resources are upgraded and 
formerly "big-files" are no longer considered "big" how is the previous 
history refactored to behave "non-big-file-like"?  Conversely, if the 
system-resources are re-distributed so that formerly non-big files are 
now relatively big (ie, moved from powerful central server login to 
laptops), how is the history refactored to accommodate the 
newly-relative-bigness?

How bigness is decided:
There seems to be two basic types of big-files:  big-worktree-files, and 
big-history-files.  A big-worktree-file that is delta-friendly is not a 
big-history-file.  A non-big-worktree-file that is delta-unfriendly is a 
big-file-history problem.  If you are working alone on an old computer 
you are probably more concerned about big-worktree-files (memory).  If 
you are working in a large group making lots of changes to the same 
files on a powerful server then you are probably more concerned about 
big-history-file-size (diskspace).  Of course, all are concerned about 
big-worktree-files that are delta-unfriendly.

At what point is a delta-friendly file considered a "big-file"?  I 
assume that may depend on the degree delta-friendliness.  I imagine that 
a text file and vm-image differ in delta-friendliness by several degrees.

At what point(s) is a delta-unfriendly file considered a "big-file"?  I 
assume that may depend on the degree(s) of delta-unfriendliness.  I 
imagine a compiled program and compressed-container differ in 
delta-unfriendliness by several degrees.

My understanding is that git does not ever delta-compress binary files. 
  That would mean even a small-worktree-binary-file becomes a 
big-history-file over time.

v/r,
neal
