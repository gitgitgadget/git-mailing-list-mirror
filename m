From: Geoff Russell <geoffrey.russell@gmail.com>
Subject: Re: Tracking the untracked
Date: Thu, 7 May 2009 17:28:59 +0930
Message-ID: <93c3eada0905070058g7f619a56jfb9b49f02bb92f9b@mail.gmail.com>
References: <93c3eada0905051819l92dc7ey331d69f009cc9c8b@mail.gmail.com>
	 <200905061522.56981.trast@student.ethz.ch>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 09:59:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1yVZ-00040w-LS
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 09:59:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175AbZEGH7B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 03:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753082AbZEGH7A
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 03:59:00 -0400
Received: from mail-qy0-f125.google.com ([209.85.221.125]:38787 "EHLO
	mail-qy0-f125.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232AbZEGH67 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 03:58:59 -0400
Received: by qyk31 with SMTP id 31so1094933qyk.33
        for <git@vger.kernel.org>; Thu, 07 May 2009 00:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=0a4p6wJrqZUjiRN7NHHl46a3w9saYeA0tdc0jK7zwvw=;
        b=bC1kzAjXT6r2HHiCtfuixEYCJVxCY166Ns3KLCKDUmSu1IwmlDHD7cdcoAFDQhhlZw
         0mBw+wCAOI9klJl86prqHopiPhm4IRMn9cKN/gMy3VbFYCZ0Zxx2LOO70WEbrOisQqx+
         W/NHGEByxpy09CzOX6vkJl/qSdGIOVCGIwgHc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        b=lSZUX8+zjJnNkLSeSudrcomadETaCx6bG7WdNnckVhzXHPkpiZ6FlPSPdjw1sy02wn
         34Y/fELzjgADu2jBLlhhDxlv7Gv7mXayJ1eExCazVlv7oCUHDsEa0gn+tjvGmsKiFWnN
         EN/C18pKPQ7fTMgDV7ZHYYU90oAiWImPcc+as=
Received: by 10.220.92.80 with SMTP id q16mr4809692vcm.58.1241683139168; Thu, 
	07 May 2009 00:58:59 -0700 (PDT)
In-Reply-To: <200905061522.56981.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118437>

On 5/6/09, Thomas Rast <trast@student.ethz.ch> wrote:
> Geoff Russell wrote:
>  > Bug or feature? I don't know.
>
>
> Feature.
>
>
>  > On the master branch I have some untracked files e.g., object modules,
>  > executables.
>  >
>  > I create a branch B1 and add+commit the untracked files.
>  >
>  > When I switch back to the master (git checkout master), the untracked
>  > files are no longer where I left them.
>
> [...]
>
> > One solution would be to have a class of files that is "unversioned
>  > but tracked".
>
>
> Note that "versioned" and "tracked" mean the same thing in Git --
>  both denote the class of files it cares about.
>
>  Your build products became tracked (w.r.t. the then-state of the
>  repository, on branch B1) the second you added them to the index with
>  'git add'.  Git then cares about them, and among many other things
>  will look at them whenever you change branches.  Since they're not
>  present in the target branch 'master', they are removed from the work
>  tree.
>
>
>  > Basically, I'm trying to find a way of having a huge bunch of stuff in
>  > my repository and
>  > tracked, but which doesn't get pushed to the central program repository .. which
>  > has always just been source for us .. I figured I could stick it on a
>  > branch which doesn't get pushed.
>  > But that doesn't work for the reason mentioned.
>
>
> Most people just put their build products in .gitignore so that they
>  stop showing up under "untracked files" in 'git status'.  (They'll
>  still be untracked!)
>
>  Of course this means the object files for source that actually changed
>  between the branches have to be rebuilt.  However, Git takes great
>  care to not touch any source files that are the same, so that the
>  builds are usually quite fast even after a branch switch.
>

Ok, its clearly a policy choice.  But suppose I have an untracked
file and I do "git some-command" then I don't expect git to touch what
it doesn't know about. I.e., "git add x" shouldn't delete the untracked
file y. That seems sensible. But now "git checkout branch" behaves
quite differently in just deleting stuff that it doesn't own (i.e., is
untracked).

Anyway, I'll rethink.

Cheers,
Geoff.

>
>  --
>  Thomas Rast
>  trast@{inf,student}.ethz.ch
>
>


-- 
6 Fifth Ave,
St Morris, S.A. 5068
Australia
Ph: 041 8805 184 / 08 8332 5069
