From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: Replacing large blobs in git history
Date: Tue, 06 Mar 2012 14:49:49 -0600
Message-ID: <4F56786D.60801@gmail.com>
References: <CAD-6W7byTiuE9MFZY1yG_ann-Ox7+wGjYduZ=Wwmw0ToF5Pynw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Barry Roberts <blr@robertsr.us>
X-From: git-owner@vger.kernel.org Tue Mar 06 21:50:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S51L6-0007ft-Fs
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 21:50:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031220Ab2CFUt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 15:49:56 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:52421 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031163Ab2CFUtw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 15:49:52 -0500
Received: by yenl12 with SMTP id l12so2525104yen.19
        for <git@vger.kernel.org>; Tue, 06 Mar 2012 12:49:52 -0800 (PST)
Received-SPF: pass (google.com: domain of nkreitzinger@gmail.com designates 10.101.142.6 as permitted sender) client-ip=10.101.142.6;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of nkreitzinger@gmail.com designates 10.101.142.6 as permitted sender) smtp.mail=nkreitzinger@gmail.com; dkim=pass header.i=nkreitzinger@gmail.com
Received: from mr.google.com ([10.101.142.6])
        by 10.101.142.6 with SMTP id u6mr7999630ann.40.1331066992332 (num_hops = 1);
        Tue, 06 Mar 2012 12:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=oY95ldfBaK7vkY0Jujcy1Zkod+ikIBJnfcfm4ogVPM8=;
        b=pNSEogrNGPEgZCbkdHdDd1H8zTk5w0djA5A9CJ+aQSK6pCcdWfKY82Udok4lq+TsOE
         W2C8T5tiDZf6D6b0rI7j6Uj0xeibhg524DNQ/fOlXKL7cLkh6FqcMF6BTpdxBZPWAZj1
         08VQXxaFgwVRlANm92aYmzn5Tj5rM9A/B43hhFFiKX56fQZ59EzeIHU2lsoxo9ZHAzky
         pIS8sO6sT6WUsloC6qxSZB0mhThVOM7BCR46OEVa+RlrX7Aqp00GoC4bWWbpPwdIVSli
         udlX33pMOhAwMxxLb8D2N0Q/MeFLXVAWILL7R1CbzvPYID5SmUOmo8v6aMiW+EyPvPIL
         HP9Q==
Received: by 10.101.142.6 with SMTP id u6mr6359569ann.40.1331066992249;
        Tue, 06 Mar 2012 12:49:52 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id j2sm32409598ani.19.2012.03.06.12.49.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 06 Mar 2012 12:49:51 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <CAD-6W7byTiuE9MFZY1yG_ann-Ox7+wGjYduZ=Wwmw0ToF5Pynw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192391>

On 3/6/2012 10:09 AM, Barry Roberts wrote:
> I started this question on #git last week, but this is getting long,
> and things have changed some, so I'm going to try here.
>
> I had a 3rd party jar file checked in to our git repository.  It was
> about 4 mb, so no big deal.  Then about 17 months ago somebody
> checked in a 550 mb version.  There were several versions of the
> original file in several different directories.  The large version
> replaced the small version in some of those directories (but not all
> of them). Then somebody found a "small" version that was only 110 mb
> and replaced some of the 550 mb files and some of the old 4 mb
> files. Finally several months after that we got the correct updated 5
> mb latest version.  But I'm still carrying around an extra 660 mb in
> my object database, and we are adding developers and moving to an
> off-site location with lower bandwidth and higher latency, so I
> would like to clean this up.
>
> My first attempt just removed the blob (by hash ID).  It's been over
> a year since the small correct file was checked in, so the odds of
> ever needing to build anything that old are very slim. But after
> thinking about it some, I came up with this to replace the blob with
> the correct one and wanted to see if this is a reasonable way to do
> this before I actually backup and then replace my central git
> repository.
>
> git filter-branch --index-filter 'killem=$(git ls-files --stage  |
> grep 7a36af54a6c47\\\|abe809091bcb3 ) ; if [ -n "$killem" ] ; then
> git ls-files --stage |grep 7a36af54a6c47\\\|abe809091bcb3 | sed -f
> /home/blr/tmp/chgblob.sed |  git update-index --index-info ; fi'
>
> chgblob.sed looks like this:
> s/7a36af54a6c47a29eb9690caefa132489d39c4d0/8924ef0f78b3d09957a8697ca93cce6700771071/g
>
>
s/abe809091bcb37a06284f8353366074622d72373/8924ef0f78b3d09957a8697ca93cce6700771071/g
>
> 7a36af is the 550 mb blob, abe80909 is the 110 mb, and 8924ef0f is
> the 5 mb new version.
>
> This isn't extremely efficient since it does the 'git ls-filess
> --stage' twice (once to see if the blob is used, then again to
> change it ONLY if the blob is referenced in the current index).  But
> that only adds a few seconds to the 28 minute runtime, so I'm not
> too worried about that.  And yes, I could just check for the return
> value of grep, but I did echo $killem while I was debugging and that
> was useful, so I just left it like that.
>
> Does this look like a reasonable way to accomplish what I'm trying
> to do, or am I doing something that's going to cause grief later?
>
Be aware that you are rewriting history.  I assume this is published
history that you are going to run filter-branch on.  That means everyone 
who cloned from the old history (pre-filter-branch), not to mention 
those who also have WIP based on the old history, will need to somehow 
adjust to the new history.  How do you plan on addressing that?  (see 
git-rebase manpage section "recovering from upstream rebase" for more 
info on the implications of rewriting history.)

(I have never done filter-branch, and am not an expert on git, but do 
find this subject relevant to normal use of git.)

v/r,
neal
