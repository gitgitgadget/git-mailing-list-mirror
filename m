From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: inotify support, nearly there
Date: Wed, 23 Jul 2014 06:27:34 +0700
Message-ID: <CACsJy8B=XLPOj0YNwdmmFtOaVBXDR1UN+k-vz9M+nRsTGUHHxA@mail.gmail.com>
References: <CACsJy8CG5QUqYOM46mOHOWDKB-A45B2-fj1uS9OtgniV+P8Ktg@mail.gmail.com>
 <loom.20140721T070730-175@post.gmane.org> <CAL=YDWk90x0XBjj7rkSaeTZ-pwSj=vktvOYbyivpqqwJVAGMRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Juan P <juandavid1707@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 01:28:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9jTg-00077t-9l
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 01:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757141AbaGVX2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 19:28:07 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:56733 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757117AbaGVX2G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 19:28:06 -0400
Received: by mail-qg0-f50.google.com with SMTP id q108so501435qgd.23
        for <git@vger.kernel.org>; Tue, 22 Jul 2014 16:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pWU292XBoIJNQxAh+/7epjb/mXWTbCRp3nX48bwhnwE=;
        b=sEEa5/fcA4StG6KClQqRJvqFAA1eEuYqOT56cLZz8ESFDgSOYAbcOElDWSIvsIEItJ
         Mu7Exg2zOr6lK7ex3P8fEt1bwC+aLRckxA0d7fQWsSn3Jc2GDL6Gdf644u0Q02TfdL6N
         5jRo9pgM/H3u5RhPg8/VTKGTYQ+/yRgcKZjpAO2u3jLATenQ7hv4xUKf/n8/pSiM2Itc
         c8Vib+RRZW/fnmk/5AMv8OaJfB+xe5t8iXFbhg+64N2d1DMatGQ88+KshOzAUw406AZY
         IAUYfzPMm3FcPPP9/QqcbgA+iIDfyOZFPhdjEg0P5fsKMFsXyck//5JgorTRZkq54kKt
         CuQg==
X-Received: by 10.224.103.134 with SMTP id k6mr17749740qao.24.1406071685684;
 Tue, 22 Jul 2014 16:28:05 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Tue, 22 Jul 2014 16:27:34 -0700 (PDT)
In-Reply-To: <CAL=YDWk90x0XBjj7rkSaeTZ-pwSj=vktvOYbyivpqqwJVAGMRw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254049>

On Tue, Jul 22, 2014 at 11:39 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:
> Duy, keep up the good work.
> Once you are ready I am more than happy to help out reviewing the patches.

The road I'm taking is:

1) split-index to speed up index writing time
2) add index-helper daemon to speed up index reading time
3) speed up .gitignore processing by caching the results and validate
using directory stat info
4) make sure 3) works (e.g. index extension data..) with another
source than directory stat info, like inotify
5) finally put inotify in place to kill lstat in index refresh and .gitignore

1) is entering next (or master) now. I need to submit 2) again and get
Windows guys' opinion (up to 3 it should work on Windows). As you can
see it'll like take a lot more months to get to 5). I feel a bit
guilty of "blocking" David Turner's inotify support series, which does
not require so many changes like this (but only benefits *nix),
because I _think_ this road is better. If you have time, maybe you can
have a look at his series and push it forward?
-- 
Duy
