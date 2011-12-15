From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: process committed files in post-receive hook
Date: Wed, 14 Dec 2011 19:04:03 -0600
Message-ID: <4EE94783.1010805@gmail.com>
References: <loom.20111210T111457-837@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Hao <billhao@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 15 02:04:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Razk6-0008JW-4p
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 02:04:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755659Ab1LOBEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 20:04:09 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60605 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755531Ab1LOBEH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 20:04:07 -0500
Received: by yenm11 with SMTP id m11so1108638yen.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 17:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=0COXEHccP+8oMKYMtfJNnhh2pClAGc2YVLecx0YN0UI=;
        b=KXQcd5gZByzBUbicHRXh0ZqjLzJgQG0w6r8mKC1G6hDpbEvnADf2y2pBkGMlQlEcE1
         XRQTGPRmgVMRIe1yogXjZWKN0H7InniRYYoHQqbWTzWLYVLvmMtB5LTmlpNjzzN5x6+v
         9UA1bWEd8vkf7aFVv3E2pzQ5/4XeRlrEgS4Xk=
Received: by 10.236.128.242 with SMTP id f78mr2940576yhi.7.1323911047079;
        Wed, 14 Dec 2011 17:04:07 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id y58sm6307874yhi.17.2011.12.14.17.04.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 17:04:06 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.24) Gecko/20111103 Thunderbird/3.1.16
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <loom.20111210T111457-837@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187180>

On 12/10/2011 4:29 AM, Hao wrote:
> Hi guys,
>
> I am writing a post-receive hook in Python that examines the content
> of some files (the HEAD rev). Because the repo is a bare one on the
> server. My current approach is to check out a working copy on the
> server and run 'git pull' in post- receive to get the most up-to-date
> version, and then process files in the working copy.
>
> I have two questions. First, is there a way that I can access file
> content in a bare repo without checking out a working copy? If this
> is not possible, my approach would be reasonable. However, when 'git
> pull' was called in the python script post-receive when a commit
> occurs, it gives an error.
>
> remote: fatal: Not a git repository: '.'
>
> The call in python is
>
> subprocess.Popen(["git", "pull"],
> cwd="/Users/git/ts.git.workingcopy")
>
> I read from a post (http://stackoverflow.com/questions/4043609/) that
> GIT_DIR is causing this error. Is it safe to unset GIT_DIR in
> post-receive?
>
The specific processing you intend to perform on the files would
determine which of the access techniques is appropriate for you.
Generally speaking, I think a checkout in a non-bare repo makes sense. 
You could limit it to a shallow clone (see git-clone manpage) to save space.

Another way to get the files is git-archive (creates tar file), that you 
could extract to a dir for processing.

In both cases, you need to consider the default permissions in play with 
git-checkout and git-archive if permissions are important in your 
processing.

v/r,
neal
