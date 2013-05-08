From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: `git prune` doc or implementation defect, or user misunderstanding
Date: Wed, 08 May 2013 16:41:56 +0200
Message-ID: <518A6434.20300@viscovery.net>
References: <CAJELnLF_oFcoqhRmzWwFne=8D5kwt8izk5fCDqmxPrROnOxh8g@mail.gmail.com> <CAJELnLFpOT=V4f-pthDHkGqVWR7zSS=QYgMz35LWTUB9KvKNUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matt McClure <matthewlmcclure@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 08 16:42:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ua5ZI-000584-8H
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 16:42:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756262Ab3EHOmB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 10:42:01 -0400
Received: from so.liwest.at ([212.33.55.13]:7445 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756135Ab3EHOmA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 10:42:00 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Ua5Z6-0003Q7-5v; Wed, 08 May 2013 16:41:56 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id E887E1660F;
	Wed,  8 May 2013 16:41:55 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <CAJELnLFpOT=V4f-pthDHkGqVWR7zSS=QYgMz35LWTUB9KvKNUQ@mail.gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223670>

Am 5/8/2013 16:19, schrieb Matt McClure:
> My interpretation of that is that `git prune` will not prune packed objects
> by default. The following behavior seems inconsistent with that
> interpretation.
> 
> [git@438587-beefcake01 panama.git]$ git prune -n | wc -l
> 9210

You have 9210 unreachable, loose objects.

> [git@438587-beefcake01 panama.git]$ git fsck --unreachable | wc -l
> 9468

You have 9468 unreachable objects in total.

> [git@438587-beefcake01 panama.git]$ git gc --no-prune
> Counting objects: 531223, done.
> Delta compression using up to 24 threads.
> Compressing objects: 100% (109848/109848), done.
> Writing objects: 100% (531223/531223), done.
> Total 531223 (delta 405288), reused 530894 (delta 404961)

Only reachable objects go into the new pack. Unreachable objects that were
in the pack before, are evicted and are now loose.

> [git@438587-beefcake01 panama.git]$ git prune -n | wc -l
> 9468
> [git@438587-beefcake01 panama.git]$ git fsck --unreachable | wc -l
> 9468

Now all 9468 unreachable objects are loose and eligible for being pruned.

> It looks like `git prune -n` is telling me that it would prune the objects
> that I just packed. What am I misunderstanding?

git gc moves unreachable objects that were packed before to the loose
object store, from where they can be pruned.

-- Hannes
