From: "Francesco Pretto" <ceztkoml@gmail.com>
Subject: Re: [PATCH] Implement selectable group ownership in git-init
Date: Sat, 3 Nov 2007 20:36:07 +0100
Message-ID: <b13782500711031236k6b4faef9oe5780cb39afe25db@mail.gmail.com>
References: <472CC676.3000603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 03 20:36:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoOnB-0004Kj-9q
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 20:36:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756724AbXKCTgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 15:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756657AbXKCTgK
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 15:36:10 -0400
Received: from rv-out-0910.google.com ([209.85.198.187]:31036 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756287AbXKCTgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 15:36:09 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1116308rvb
        for <git@vger.kernel.org>; Sat, 03 Nov 2007 12:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=fdJEGwzs8Gkn9cxXQCGgBDpbC7Hi2psNw4WWYN6V2Qg=;
        b=oqOFQ/8RpLWPo0yubO6vV0tqGhK7I9S488cV02qqBzz60TVO/uJLJwuHcklL5HGHrmQpuXPUhlI1ovze0OCWgevEkheSRuPkLri2qfE9qQeL/baqgBsOMZ9/JkGx9I6xhXx4ig1xbmlYdYPgK2ywMg2LQzm9T3byvEmEhSIlo1k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SD+/MemCfB1Hxa7LG2tWFKAVTVNBGknEaTdRCyJ2n6IZnm0Rl9MxVopJB+u1GEcu8cElT09qSDfopdpUi106ktIWIa9xy4hR8Ua/EnqgckHC54MKl08E3HJi4GUfrTKB+1Ci53sQCwfv8RTDKMK857Q6V18KyyQz5bhv1tdmX88=
Received: by 10.142.230.11 with SMTP id c11mr784527wfh.1194118567760;
        Sat, 03 Nov 2007 12:36:07 -0700 (PDT)
Received: by 10.142.50.2 with HTTP; Sat, 3 Nov 2007 12:36:07 -0700 (PDT)
In-Reply-To: <472CC676.3000603@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63303>

2007/11/3, Francesco Pretto <ceztkoml@gmail.com>:
> Rationale ...

Just to point, I wrote this patch for usability purpose and because i
think git still need a strong imprinting about its correct usage
pattern (i've read around that people using it with shared
repositories are already having problems with file permissions,
wrongly thinking it's inflexible for their needs). If you stand with
my reasoning, please help me to integrate this patch :-), I have other
ideas following this. NB: i'm not a C developer (that was my first
patch in pure C), have mercy...

The function adjust_shared_perm is used in other places: is there
other git commands that maybe needs to create files/dirs of a specific
group (not being in a g+sx dir)? Hopefully not, but i don't know git
source much. These are the occurrences (with the exclusion of
builtin-init-db.c):

refs.c: adjust_shared_perm(log_file);
refs.c: if (adjust_shared_perm(git_HEAD)) {
..
builtin-pack-objects.c: return adjust_shared_perm(path);
...
builtin-rerere.c:           (mkdir(rr_cache, 0777) ||
adjust_shared_perm(rr_cache)))
...
lockfile.c:             if (adjust_shared_perm(lk->filename))
...
sha1_file.c:            else if (adjust_shared_perm(path)) {
