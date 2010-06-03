From: =?iso-8859-1?Q?Henrik_Grubbstr=F6m?= <grubba@roxen.com>
Subject: Re: [PATCH v4 0/5] Patches to avoid reporting conversion changes.
Date: Thu, 3 Jun 2010 18:00:38 +0200 (CEST)
Organization: Roxen Internet Software AB
Message-ID: <Pine.GSO.4.63.1006031543340.22466@shipon.roxen.com>
References: <cover.1275309129.git.grubba@grubba.org> <7vfx16oxmz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-342241519-1275580838=:22466"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 18:23:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKDCT-0003fN-EE
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 18:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755525Ab0FCQXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 12:23:16 -0400
Received: from mail.roxen.com ([212.247.29.220]:51529 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755257Ab0FCQXP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 12:23:15 -0400
X-Greylist: delayed 1355 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Jun 2010 12:23:15 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id 0F780628291;
	Thu,  3 Jun 2010 18:00:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CllDDtLv-aTs; Thu,  3 Jun 2010 18:00:38 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id 491E3628227;
	Thu,  3 Jun 2010 18:00:38 +0200 (CEST)
In-Reply-To: <7vfx16oxmz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148344>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-342241519-1275580838=:22466
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 1 Jun 2010, Junio C Hamano wrote:

> "Henrik Grubbström (Grubba)" <grubba@grubba.org> writes:
>
>> This is useful for repositorys not containing fully normalized files
>> (eg containing CRLF's or expanded $Id$ strings), where a later attribute
>> change implies a conversion mode change. Without this set of patches
>> the user would need to recommit semantically unchanged files to get
>> a clean index.
>
> A more fundamental (or perhaps "silly") question is if that "user would
> need to" is necessarily a bad thing.  If the user wants to cleanse such
> abnormality in the recorded blobs, shouldn't there be a conscious act,
> iow, a commit that records that "I am fixing that mistake, and from now
> on, the recorded data are normalized"?

I believe that users typically aren't interested in if data in the 
repository is on normalized form or not (witness the autocrlf=true 
discussion a few weeks ago, where one of the main complaints was
that it required a renormalization (which fg/autocrlf attempts to
solve for that specific case by not normalizing)), as long as they
get the expected content on checkout.

This set of patches allows for an incremental, on-demand normalization.
Eg the user could switch the attributes for a group of files from

   *.bat -crlf

(let's assume *.bat files use crlf linebreaks) to

   *.bat -crlf text eol=crlf

and then have git normalize the individual files when there's actually a 
semantic reason for a change. With the current eb/core-eol patches this
change would cause a dirty index on checkout. The user who committed the 
change however has a clean index until any of the files affected is 
touched.

In my case, I have repositories containing files both requiring crlf and 
lf line endings, and additionally have expanded $Id$-strings that I want 
changed on first semantic change (but not before). To be able to use a
git binary without this patchset I'd have to do a

   git commit -a -m 'Normalized'

as the first thing after a checkout.

I could of course add a config option to control the behaviour (hmm, or 
maybe an attribute?).

> Perhaps I am missing something very trivial that you have already
> explained to the list but I forgot amid my moving and other confusion, and
> if that is the case I apologize in advance ;-).

No problem.

--
Henrik Grubbström					grubba@grubba.org
Roxen Internet Software AB				grubba@roxen.com
---559023410-342241519-1275580838=:22466--
