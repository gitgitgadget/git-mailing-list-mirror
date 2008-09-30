From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How Blobs Work ( Blobs Vs. Deltas)
Date: Tue, 30 Sep 2008 11:54:21 -0700 (PDT)
Message-ID: <m3y719qxc9.fsf@localhost.localdomain>
References: <16946e800809300814v134a42dft37becdbd8aa7669a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Feanil Patel" <feanil@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 30 20:55:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkkNk-00026c-TY
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 20:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675AbYI3SyZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 14:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752444AbYI3SyZ
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 14:54:25 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:32100 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097AbYI3SyY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 14:54:24 -0400
Received: by ey-out-2122.google.com with SMTP id 6so69511eyi.37
        for <git@vger.kernel.org>; Tue, 30 Sep 2008 11:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=dtIu+pSThP5v9Mvt8QTH7CzgbkWFZ+yGgaY5ijKsMDs=;
        b=Y9GXVrH0Llb6wO3EsZA/pSSUXuZrTiKmd/z+3MAguc5oHbHFkkYM9v4ahKkLmEyz39
         dDLcfdpCQ1VIirZGr/Og+saltjWrBTgeOlZXKeB43zyPXsmZWl9VS1hF9CdHc6Cr4i1i
         bD3eeRdYfmkEg6Lm9kNIUs1RZpq/EjzPe/Vsk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=N0qBwEZVg+UB8nnzuWuOquupuRiSVWlBpZlup3vpBPvxeXuYTVzbGEX8szKpSXSA5L
         0r7EsXkp6H2vnWVgDDrZSMU+Y7mHVl+bLonz8dZ4YGX3H6MR/dzIzBA3Hkz1yXRO6PzP
         GCk67Qcv/wVpnitATU/upKM+l5aDwvNaVS/oI=
Received: by 10.86.33.19 with SMTP id g19mr6141108fgg.13.1222800862883;
        Tue, 30 Sep 2008 11:54:22 -0700 (PDT)
Received: from localhost.localdomain (abvo173.neoplus.adsl.tpnet.pl [83.8.212.173])
        by mx.google.com with ESMTPS id l12sm4965243fgb.6.2008.09.30.11.54.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Sep 2008 11:54:21 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m8UIrsNE010739;
	Tue, 30 Sep 2008 20:54:05 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m8UIrhm5010735;
	Tue, 30 Sep 2008 20:53:43 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <16946e800809300814v134a42dft37becdbd8aa7669a@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97142>

"Feanil Patel" <feanil@gmail.com> writes:

> Hello,
> 
> I was reading about git objects in "The Git Community Book"
> (http://book.git-scm.com/1_the_git_object_model.html), which was
> posted on the mailing list a while back, and I was wondering something
> about blobs and how files are stored in any particular version.  If
> file A is changed from version one to version two there are two
> different blobs that exist for the two versions of the file, is that
> correct?  The Book was saying Git does not use delta storage so does
> this mean that there are two almost identical copies of the file with
> the difference being the change that was put in from version one to
> version two?

In Git there are two kinds of storage: loose objects and packs. Each
object generally starts as a loose object; for those it is like you
wrote: if you have two versions of some file, you would have both
of those contents of a file stored as separate objects (blobs).  Note
that those 'blob' objects are compressed, so they usually don't take
more time than current version of file and its backup.

But there exists also other type of storage, namely packed.  In the
past you had to pack (repack) objects by invoking "git repack" and
"git prune", and in more modern times by calling "git gc"; nowadays
this should be taken care of by git using "git gc --auto" behind.
When packing git tries to find objects which are close contents,
and store them as base object and binary delta (based on LibXDiff).
So you get benefits of delta storage, while on the API and script
level you always see single objects.

Note that explicit repacking allow git to not only consider versions
of the same file to diff against, tree and not only linear chains of
deltas (think branches), and while recency order is preferred it is
not enforced; objects and deltas are then compressed individually.

HTH
-- 
Jakub Narebski
Poland
ShadeHawk on #git
