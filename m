From: Marcus Brinkmann <m.brinkmann@semantics.de>
Subject: Re: [PATCH] contrib/subtree: Split history with empty trees correctly
Date: Thu, 28 Jan 2016 05:06:47 +0100
Message-ID: <56A993D7.3000107@semantics.de>
References: <56991CFC.7060705@ruhr-uni-bochum.de>
 <xmqq4meeflws.fsf@gitster.mtv.corp.google.com>
 <87twmbaizo.fsf@waller.obbligato.org> <569EE046.9040506@semantics.de>
 <871t9cvqsp.fsf@waller.obbligato.org> <56A4CC85.90705@semantics.de>
 <87fuxil8cw.fsf@waller.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Dave Ware <davidw@realtimegenomics.com>, <git@vger.kernel.org>
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Thu Jan 28 05:09:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOdsC-0006ae-Ju
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 05:07:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966688AbcA1EHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 23:07:34 -0500
Received: from smtp.semantics.de ([212.117.75.54]:4718 "EHLO
	flusser.semantics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965603AbcA1EHc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 23:07:32 -0500
Received: from tarski.semantics.de ([192.168.1.3])
	by flusser.semantics.de with esmtp (Exim 3.36 #1 (Debian))
	id 1aOduL-0006qC-00; Thu, 28 Jan 2016 05:10:09 +0100
Received: from LOCKE.semantics.de ([192.168.1.6]) by tarski.semantics.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 28 Jan 2016 05:06:50 +0100
Received: from [192.168.142.172] (80.147.161.94) by Locke.semantics.de
 (192.168.1.6) with Microsoft SMTP Server (TLS) id 14.0.722.0; Thu, 28 Jan
 2016 05:06:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <87fuxil8cw.fsf@waller.obbligato.org>
X-OriginalArrivalTime: 28 Jan 2016 04:06:50.0204 (UTC) FILETIME=[503949C0:01D15981]
X-semantics-MailScanner: Found to be clean
X-semantics-MailScanner-From: m.brinkmann@semantics.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284978>

On 01/28/2016 03:56 AM, David A. Greene wrote:
> Marcus Brinkmann <m.brinkmann@semantics.de> writes:
>
>> With my patch, "git subtree split -P" produces the same result (for my
>> data set) as "git filter-branch --subdirectory-filter", which is much
>> faster, because it selects the revisions to rewrite before rewriting.
>> As I am not using any of the advanced features of "git subtree", I will
>> just use "git filter-branch" instead.
>
> Heh.  :)
>
> I hope to replace all that ugly split code with filter-branch as you
> describe but there are some cases where it differs.  It may be that your
> changes fix some of that.
>
> Are you still able to do a re-roll on this?

I have to admit that my interest has declined steeply since discovering 
that subtree-split and filter-branch --subtree-filter give different 
results from "git svn" on the subdirectory.  The reason is that git-svn 
includes all commits for revisions that regular "svn log" gives on that 
directory, which includes commits that serve as branch points only or 
that are empty except for unhandled properties.

While empty commits for unhandled properties wouldn't be fatal, missing 
branch points make "git svn" really unhappy when asked to rebuild .git/svn.

As migration from SVN is my main motivation at this point to use a 
subtree filter at this point (git-svn is just very slow - about one week 
on our repository), I am somewhat stuck and back to using git-svn. 
Although hacking up something with filter-branch seems like a remote 
option, it's probably nothing that generalizes.

It didn't help that "make test" in contrib/subtree gives me 27 out of 29 
failed tests (with no indication how to figure out what exactly failed).

Oh well :)

Marcus
