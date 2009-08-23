From: Adam Brewster <adambrewster@gmail.com>
Subject: Re: bundles with multiple branches
Date: Sun, 23 Aug 2009 16:52:40 -0400
Message-ID: <c376da900908231352o5c5746c0h9e39b80adede66e8@mail.gmail.com>
References: <30e395780908231336p403c2171ie383a81c3d1bb020@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeffrey Ratcliffe <jeffrey.ratcliffe@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 23 22:52:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfK3V-0001wf-9U
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 22:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755158AbZHWUwk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 16:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753944AbZHWUwk
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 16:52:40 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:59159 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753566AbZHWUwj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 16:52:39 -0400
Received: by ewy3 with SMTP id 3so1892491ewy.18
        for <git@vger.kernel.org>; Sun, 23 Aug 2009 13:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=87V5++Yz/bFvwPcdHJbi923koNX4+QQM2x6qP0ZRsbM=;
        b=NILB+Ia+Yqyefo1bW6G8hNH2h+Tqqi/Xv9R4FK0gZiGNQAXiKbzYIAfwTTUTOQNRv8
         4FqGHBlRdXgAIL1XZg6RFUn41ovnj8eT0GYg8+qRjdikDbNUAcT71MUXt7CxwQatgNsI
         bdst7xTlqh5yAiWA0WZbYZ6cX1eyESBwMvD6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uiGRnhNF0p2TRQkxv5d2oiDz0jcOXdxMhYiM/Pf5m21kzmXzoc6yn/dMKLbFk5Ukx1
         YrSVzuzdbJYwK1BQX3cf6eqtO9o5VxaOXGe4J/RJ/YhT3X4PvO43Y5BSvwO4OHyP02uS
         DAMX3tbhexlBsNWNsdWKUkp491EfSfjcHku+g=
Received: by 10.216.16.208 with SMTP id h58mr820639weh.60.1251060760231; Sun, 
	23 Aug 2009 13:52:40 -0700 (PDT)
In-Reply-To: <30e395780908231336p403c2171ie383a81c3d1bb020@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126877>

On Sun, Aug 23, 2009 at 4:36 PM, Jeffrey
Ratcliffe<jeffrey.ratcliffe@gmail.com> wrote:
> I tend to work on multiple machines that don't have direct access to
> each and therefore keep my git repositories in sync using bundles.
>
> This works fine for single branches - but how can I set things up so
> that I can just
>
> $ git pull <bundle>
>
> or
>
> $ git fetch <bundle>
>
> and have git update all branches?
>

1. Make sure you've got all of the refs you want in the bundle.  I
usually use `git bundle create ... --all`

2. Set up a remote on the destination side with a url of wherever you
keep bundles (like /media/cdrom) and a fetch line like
refs/heads/*:refs/remotes/source/*

git remote add bundle /media/cdrom
git config --replace-all remotes.bundle.fetch refs/heads/*:refs/remotes/bundle/*

Since your destination machine is likely not connected to the
internet, you may also want copy all of the remotes too.  I do that
with

git config --add remotes.bundle.fetch refs/remotes/*:refs/remotes/*

Beware of the use of the name "origin" with setups like this.  If you
have branches under refs/remotes/origin/ on the machine you use to
create the bundle, you will should make sure you don't try to copy
refs from refs/heads and refs/remotes/origin to the same place
(because refs/remotes/origin is the natural place to store both).

Adam
