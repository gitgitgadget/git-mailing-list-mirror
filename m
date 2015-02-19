From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Git Scaling: What factors most affect Git performance for a large repo?
Date: Fri, 20 Feb 2015 06:38:43 +0700
Message-ID: <CACsJy8Dortn4fHwF8xSgJ=KoJ9o1qzmc_UyaVq003D2sxFZEuQ@mail.gmail.com>
References: <CAH8BJxEr_v+aitpZduXPC4oiRhMuySpc7Wb1aGcYe_p3mWjn+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Stephen Morton <stephen.c.morton@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 00:39:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOagj-0005XL-8F
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 00:39:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117AbbBSXjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 18:39:17 -0500
Received: from mail-yh0-f43.google.com ([209.85.213.43]:34937 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343AbbBSXjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2015 18:39:16 -0500
Received: by yhoc41 with SMTP id c41so1810066yho.2
        for <git@vger.kernel.org>; Thu, 19 Feb 2015 15:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QiOInWek6uDIfcIdUybuhLzJHBt0L0MyOnwsXEDKwcY=;
        b=cdn3NuQVJyJSFD2z1xa8kHB9RpefHISse9w3L/mTNRbWXndD4XpvDvpMPMX/HDetGC
         KIScVV3dLx+cjvTx4C1GJ+Wczz9ZKdgC4wvgq8K9LC3d1AHKWd6LcbGReFoN2F3viF5Z
         hM+dlcCsOhXts2k6kfHXIOdsfSSexAqS+ECTVURe8nLNti2pCTTbKa8cqenRHbm2VSb4
         IVp9QaRQoSs1e+ARjlUzo7UmEzn5ybO33qTjajWWB9LS85zkdsQX/9I3QiUM4GRm2RiN
         1KWRK9mfL8ManAO2VxW03BLXMlSeq8dI2f+CsUgRdyAV0KfUCZlT3lk/Dctfk9ijJ3+A
         R/tg==
X-Received: by 10.170.38.5 with SMTP id 5mr5082722ykg.121.1424389154706; Thu,
 19 Feb 2015 15:39:14 -0800 (PST)
Received: by 10.170.63.135 with HTTP; Thu, 19 Feb 2015 15:38:43 -0800 (PST)
In-Reply-To: <CAH8BJxEr_v+aitpZduXPC4oiRhMuySpc7Wb1aGcYe_p3mWjn+w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264120>

On Fri, Feb 20, 2015 at 4:26 AM, Stephen Morton
<stephen.c.morton@gmail.com> wrote:
> By 'performance', I guess I mean speed of day to day operations for devs.
>
>    * (Obviously, trivially, a (non-local) clone will be slow with a large repo.)
>    * Will a few simultaneous clones from the central server also slow down
>      other concurrent operations for other users?

There are no locks in server when cloning, so in theory cloning does
not affect other operations. Cloning can use lots of memory though
(and a lot of cpu unless you turn on reachability bitmap feature,
which you should).

>    * Will 'git pull' be slow?

If we exclude the server side, the size of your tree is the main
factor, but your 25k files should be fine (linux has 48k files).

>    * 'git push'?

This one is not affected by how deep your repo's history is, or how
wide your tree is, so should be quick..

Ah the number of refs may affect both git-push and git-pull. I think
Stefan knows better than I in this area.

>    * 'git commit'? (It is listed as slow in reference [3].)
>    * 'git stautus'? (Slow again in reference 3 though I don't see it.)
(also git-add)

Again, the size of your tree. I'm trying to address problems in [3],
but at your repo's size, I don't think you need to worry about it.

>    * Some operations might not seem to be day-to-day but if they are called
>      frequently by the web front-end to GitLab/Stash/GitHub etc then
>      they can become bottlenecks. (e.g. 'git branch --contains' seems terribly
>      adversely affected by large numbers of branches.)
>    * Others?

git-blame could be slow when a file is modified a lot.
-- 
Duy
