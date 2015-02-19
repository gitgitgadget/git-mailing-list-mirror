From: Stephen Morton <stephen.c.morton@gmail.com>
Subject: Re: Git Scaling: What factors most affect Git performance for a large repo?
Date: Thu, 19 Feb 2015 18:06:29 -0500
Message-ID: <CAH8BJxEK1xwGMsR3JKe72AVS7+5-aaQA4_Q8fpuZndSh1-mong@mail.gmail.com>
References: <CAH8BJxEr_v+aitpZduXPC4oiRhMuySpc7Wb1aGcYe_p3mWjn+w@mail.gmail.com>
	<CAGZ79kaPhuCXgYvZ49NwVRvrKLVJLTWd0oWHv3jX31sOVCWKVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 00:06:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOaB2-0007Th-9S
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 00:06:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753628AbbBSXGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 18:06:32 -0500
Received: from mail-we0-f170.google.com ([74.125.82.170]:39086 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490AbbBSXGb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2015 18:06:31 -0500
Received: by wesx3 with SMTP id x3so2608752wes.6
        for <git@vger.kernel.org>; Thu, 19 Feb 2015 15:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UoAmH6ZumLQ/EUiHFewfOLrRYK+L6ow6zg+7v6b3SYM=;
        b=g8UFV4tqx4QpmhWNf5IfkTHZm3KXhDINZ/J49GGDgICb+cPwG/bDo35LQmW+M/rU/l
         RljWvIzK51JMLKCu+Xs5ff5HKDLW3g56cdSjt4HZG8JFX3bklHU9X7BDVUP9GIEO9BcU
         Qe4gS5qLeTPsqZSyUK5mR1iKGzS/iDTdMdiIhDXG1UYMxqAWxlI5+7w+LBOj6m17wJCI
         NFDEv5rBwdDqsnLs1Jo5qjlhfypPbZGFIv4JqGQuiA8zP9+y9mrpuCiUemi6hwg4ZlLk
         rMXDR2SR8zvfbQTZY1WIuF2bp/wFFhPYfI4VvjCJ6GrL6TQdblQdOw/WS9l/p3x8S5j3
         kMUw==
X-Received: by 10.180.87.33 with SMTP id u1mr433488wiz.20.1424387190052; Thu,
 19 Feb 2015 15:06:30 -0800 (PST)
Received: by 10.194.239.228 with HTTP; Thu, 19 Feb 2015 15:06:29 -0800 (PST)
In-Reply-To: <CAGZ79kaPhuCXgYvZ49NwVRvrKLVJLTWd0oWHv3jX31sOVCWKVQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264117>

On Thu, Feb 19, 2015 at 5:21 PM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Feb 19, 2015 at 1:26 PM, Stephen Morton
> <stephen.c.morton@gmail.com> wrote:
>> I posted this to comp.version-control.git.user and didn't get any response. I
>> think the question is plumbing-related enough that I can ask it here.
>>
>> I'm evaluating the feasibility of moving my team from SVN to git. We have a very
>> large repo. [1]
>>
>> [1] (Yes, I'm investigating ways to make our repo not so large etc. That's
>>     beyond the scope of the discussion I'd like to have with this
>>     question. Thanks.)
>
> What do you mean by large?
> * lots of files
> * large files
> * or even large binary files (bad to diff/merge)
> * long history (i.e. lots of small changes)
> * impactful history (changes which rewrite nearly everything from scratch)
>
> For reference, the linux
> * has 48414 files, in 3128 directories
> * the largest file is 1.1M, the whole repo is 600M
> * no really large binary files
> * more than 500051 changes/commits including merges
> * started in 2004 (when git was invented essentially)
> * the .git folder is 1.4G compared to the 600M files,
>    indicating it may have been rewritting 3 times (well this
>    metric is bogus, there is lots of compression
>    going on in .git)
>
> and linux seems to be doing ok with git.
>
> So as long as you cannot pinpoint your question on what you are exactly
> concerned about, there will be no helpful answer I guess.
>
> linux is by no means a really large project, there are other projects way
> larger than that (I am thinking about the KDE project for example)
> and they do fine as well.
>
> Thanks,
> Stefan

Hi Stefan,

I think I addressed most of this in my original post with the paragraph

 "Assume ridiculous numbers. Let me exaggerate: say 1 million commits,
15 GB repo,
  50k tags, 1,000 branches. (Due to historical code fixups, another
5,000 "fix-up
  branches" which are just one little dangling commit required to
change the code
  a little bit between a commit and a tag that was not quite made from it.)"

To that I'd add 25k files,
no major rewrites,
no huge binary files, but lots of a few MB binary files with many revisions.

But even without details of my specific concerns, I thought that
perhaps the git developers know what limits git's performance even if
large projects like the kernel are not hitting these limits.

Steve
