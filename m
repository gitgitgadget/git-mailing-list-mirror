From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [BUG] git_path() returns relative paths
Date: Sun, 28 Jul 2013 16:06:23 +0700
Message-ID: <CACsJy8CAfCVtTmgtEaix6RwYm4Sj7Ot_BjuObS+qvQ=QNnQ0OA@mail.gmail.com>
References: <CALkWK0m-4wtpTAcePPWFLT7iwXdcpp+nOy9oG2iFHLsp9XdKZQ@mail.gmail.com>
 <CALkWK0k-23rTohYvNWP_XbuUCSGUE+G_e_7cBbPP5C9OzsJ4XQ@mail.gmail.com>
 <CALkWK0kBesC2=kyygMCt61Fm5GGqX+yF6sbkCRcGYZ=ovgtTAQ@mail.gmail.com>
 <CACsJy8C5Du8zcqVeN7EGuyUxgSZaRq-X8y_hQvqQedYWfP8p+A@mail.gmail.com>
 <CALkWK0kWnge7fVtTXRgTiK1NbyN8X=bmqfPTc+Mp=BCssPc1og@mail.gmail.com>
 <CACsJy8CDg2ORKrpwiph=WdW5GPUYEwT1CSCttQ4fagQoMP4QGA@mail.gmail.com>
 <CALkWK0=xuNGM54=Kodfi9L8_yUOaXrWvqiMHbx2SRTH1CmZxLA@mail.gmail.com>
 <CACsJy8AuAy7PnEU20k23gVRQoFrLhJrM6hfESZKshUA578c3Ew@mail.gmail.com> <CALkWK0nFDyFqBPatsbQ-0mGXQ-6N5Xs9gKioknuGX9a7UiD4Fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Xin Jiang <worldhello.net@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 28 11:06:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3MwM-0000AQ-ET
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jul 2013 11:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752916Ab3G1JGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jul 2013 05:06:55 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:51054 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300Ab3G1JGy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jul 2013 05:06:54 -0400
Received: by mail-oa0-f46.google.com with SMTP id h1so10785406oag.19
        for <git@vger.kernel.org>; Sun, 28 Jul 2013 02:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=r6Sm99qaMgOrZtokk5JLyiSlUwhlJEJBF+1uR6VbFnM=;
        b=htqGbsQ1m/maxVpNKkr3BvEJffQzqQ6uEL6cHi1CehPbt5oZBGM3le9i2da6ISof3Y
         TO+/duC6jfY7mbOg1Z7i7E88gP8K3AVleBG+f5BWVV2r5LVUGG6qPqlLiP8CvSSqB62W
         aCRZtdO3iwvdkRak6B2ks+aecux4ZqBgEx8bXRjDkRCShFPfZ28y6ysj56KDU4iY/P6r
         zctQMu+zl1m8lWLlA3TsGrNZe1zgNI/cUYa+HrzWW9gTVlHGb93rubtd6LKwu5mYPzdE
         lDoAYSPzV9N5Ox7MhVfifNYw2fHN9SrV7OKgncQe0rOQ1wncUyzYfbadLWo1OjRaCLdv
         Dmqw==
X-Received: by 10.182.165.133 with SMTP id yy5mr48980776obb.89.1375002413711;
 Sun, 28 Jul 2013 02:06:53 -0700 (PDT)
Received: by 10.182.240.168 with HTTP; Sun, 28 Jul 2013 02:06:23 -0700 (PDT)
In-Reply-To: <CALkWK0nFDyFqBPatsbQ-0mGXQ-6N5Xs9gKioknuGX9a7UiD4Fg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231263>

On Sun, Jul 28, 2013 at 3:49 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Duy Nguyen wrote:
>> I think instead of letting the kernel walk the path, emacs does it by
>> itself.
>
> If this were true, shouldn't we be able to reproduce the behavior with
> my no-submodules symlink testcase?  How can it resolve symlinks in one
> case, and not in the other case?

In the no-submodules symlink test case, the path given to the editor
is .git/COMMIT_EDITMSG, no following ".." back in the symlink target.
This bug can be reproduced without git involved:

mkdir z z/a z/b
echo ha >z/a/file
ln -s z/b
cd b
cat ../a/file
emacs ../a/file # fail to open 'file'
-- 
Duy
