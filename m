From: Simon Brenner <olsner@gmail.com>
Subject: Re: [RFC] deprecating and eventually removing "git relink"?
Date: Mon, 14 Nov 2011 09:48:07 +0100
Message-ID: <CAD=rjTXgH+AivmK+zLurQVC+=p1UYqFy_p=wBF-1-TOQ=Cqjtw@mail.gmail.com>
References: <7v4ny7mtbx.fsf@alter.siamese.dyndns.org>
	<buomxbzutjm.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 09:48:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPsD9-0000hl-1v
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 09:48:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753203Ab1KNIsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 03:48:09 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42024 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723Ab1KNIsI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 03:48:08 -0500
Received: by yenr9 with SMTP id r9so4911517yen.19
        for <git@vger.kernel.org>; Mon, 14 Nov 2011 00:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=cEgm3Cpcj8gMbvXMCmt53SgwKm0YdSf4DxQLOdEtrH4=;
        b=aZ6yxrdvNar8m41zQ0jGpE8hHrP7BalQ2pPqTatCCsJiyptrpxwUDmL2t14eS7R+AB
         oZb3OzNGcJEKIJT7HQQ0oBHSf33h5HaUmqU7yTSWwcF45gnmFRgK3rdU6H3FyNwZexsM
         vnf/oJ+lnNO33UP2MpTk4ixmqd56YuehGnDuo=
Received: by 10.147.157.21 with SMTP id j21mr2472662yao.36.1321260487740; Mon,
 14 Nov 2011 00:48:07 -0800 (PST)
Received: by 10.146.155.12 with HTTP; Mon, 14 Nov 2011 00:48:07 -0800 (PST)
In-Reply-To: <buomxbzutjm.fsf@dhlpc061.dev.necel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185369>

I think one of the most annoying aspects of alternates (beyond the
hassle of adding/removing them except using clone --reference) is the
danger of losing data if you aren't absolutely sure that your
alternate is stable and won't ever lose references to objects.

If the alternate just had links to the referring repositories, I think
this hole could be neatly closed.

On Mon, Nov 14, 2011 at 7:06 AM, Miles Bader <miles@gnu.org> wrote:
> It might be nice to have a mechanism where new objects would update
> the _alternate_ rather than the object-store in the tree where the
> command was run... then you could easily have a bunch of trees using a
> central object store without needing to update the central store
> occasionally by hand (and do gc in its "clients")...

This sounds like a nice way forward: replace/extend the current
alternates system with support for a shared object store that is
"intelligently" shared so that it can be gc:d based on all refs from
all referring repositories. I imagine it would be something very much
like a bare repository - except it wouldn't have any refs of its own,
just a list of other repositories it should search for refs when
GC:ing.

The object store currently built into each git repository could even
become a special case of that: a shared object store (that happens to
reside under .git) with a single referring repository (the parent .git
dir). If the location of the object store is configurable, clone
--reference could simply point the new repository directly to the
shared store instead of ever setting up a local object store.

// Simon
