From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Problem: staging of an alternative repository
Date: Fri, 2 May 2014 13:20:55 +0700
Message-ID: <CACsJy8C4bO_ZB-DMOkbJc9cJd_LmR6z0RZ1UZB3wKPEX005xmA@mail.gmail.com>
References: <CAKpPgveXqraM4bXb499mJm5Ls+EinihfEJ6VgOFikC0_Qp8iTA@mail.gmail.com>
 <20140430213545.GV9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pasha Bolokhov <pasha.bolokhov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 08:21:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg6ql-00010l-0M
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 08:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbaEBGV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 02:21:27 -0400
Received: from mail-qc0-f180.google.com ([209.85.216.180]:54706 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbaEBGV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 02:21:26 -0400
Received: by mail-qc0-f180.google.com with SMTP id i17so3603283qcy.39
        for <git@vger.kernel.org>; Thu, 01 May 2014 23:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=KRT+zWkR4X5FoP/pr3lDzy6Y7WJ64FfHAIVK/oGRQ48=;
        b=u0WLKXnvuTNTZdqLYAZQzgwLjHjfDNoof/ec0m3O2mHaPL13navGIHUG1Taqnfe4/c
         7j9QxfZPGSArWqf3OnlOIHhef/thBL2ffrmd6Bgu7mcqLI6unRtAQq1dNzGeefSq6k0W
         rw3JAIOcUvCCm+JU3Ipbz2vOhoqHcg4x+bac3brvZmi/u7sTPSmitEhkZ7hQwopkouqS
         In/aPzB6NqFF2P2A3dCfJO2C2S6Ymdr07tNlfoQ6pSeXQhgxEQFivwOZdUjQ0+J1F7Ht
         3856Ul/qR+wBKvn+6dhdwyeYz4BeMVh1qf9rjbeCxOlrzwIO7U1lC6GxOfWGQAKj3Ul9
         6+8w==
X-Received: by 10.140.47.206 with SMTP id m72mr18107547qga.21.1399011685817;
 Thu, 01 May 2014 23:21:25 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Thu, 1 May 2014 23:20:55 -0700 (PDT)
In-Reply-To: <20140430213545.GV9218@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247925>

On Thu, May 1, 2014 at 4:35 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>>     Now I know, the '--git-dir' option may usually be meant to use
>> when the repository is somewhere outside of the work tree, and such a
>> problem would not arise. And even if it is inside, sure enough, you
>> can add this '.git_new' to the ignores or excludes. But is this really
>> what you expect?
>
> I think it's more that it never came up.  Excluding the current
> $GIT_DIR from what "git add" can add (on top of the current rule of
> excluding all instances of ".git") seems like a sensible change,
> assuming it can be done without hurting the code too much. ;-)

I think it came up before. Changes could be very messy (but I did not
check carefully) because right now we just compare $(basename $path)
with ".git", one path component, simple and easy. Checking against
$GIT_DIR means all path components. You also have to deal with
relative and absolute paths and symlinks in some path components. You
may also need to think if submodule detection code (checking ".git"
again) is impacted. On top of that, read_directory() code is already
messy (or at least scary to me) with all kinds of shortcuts we have
added over the years. A simpler solution may be ignoring all
directories whose last component is  "$GIT_DIR_NAME" (e.g.
GIT_DIR_NAME=.git_new).
-- 
Duy
