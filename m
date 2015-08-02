From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH/RFC 0/9] Pseudorefs
Date: Mon, 03 Aug 2015 00:48:05 +0200
Message-ID: <55BE9E25.6050902@alum.mit.edu>
References: <1437713129-19373-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 03 00:48:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZM23K-0004wi-EJ
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 00:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbbHBWsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Aug 2015 18:48:17 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:42929 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752083AbbHBWsQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Aug 2015 18:48:16 -0400
X-AuditID: 12074411-f797e6d000007df3-d3-55be9e27d0f0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 36.D8.32243.72E9EB55; Sun,  2 Aug 2015 18:48:07 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB03A9.dip0.t-ipconnect.de [93.219.3.169])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t72Mm5C0021006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 2 Aug 2015 18:48:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <1437713129-19373-1-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsUixO6iqKs+b1+owckuMYv5m04wWnRd6WZy
	YPJY8Pw+u8fnTXIBTFHcNkmJJWXBmel5+nYJ3Bkzjz1mKXgjWDHvzELmBsabfF2MnBwSAiYS
	ey68ZoewxSQu3FvP1sXIxSEkcJlR4tz86UwQzlkmibmHfjCDVPEKaEu0T33ACGKzCKhKvFh6
	kA3EZhPQlVjU0wzUwMEhKhAk8fplLkS5oMTJmU9YQGwRAQeJy7uOgo0RFlCX2PrnHBOILSTg
	IfH4dyPYEZwCnhIvf60Es5kF9CR2XP/FCmHLSzRvnc08gZF/FpKxs5CUzUJStoCReRWjXGJO
	aa5ubmJmTnFqsm5xcmJeXmqRrqlebmaJXmpK6SZGSEAK7mCccVLuEKMAB6MSD6+A295QIdbE
	suLK3EOMkhxMSqK886v3hQrxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4b2YDpTjTUmsrEotyodJ
	SXOwKInz8i1R9xMSSE8sSc1OTS1ILYLJynBwKEnwnp8D1ChYlJqeWpGWmVOCkGbi4AQZziUl
	Upyal5JalFhakhEPisj4YmBMgqR4gPa+B2nnLS5IzAWKQrSeYlSUEucVnguUEABJZJTmwY2F
	pZlXjOJAXwrz+oNU8QBTFFz3K6DBTECDL2fsARlckoiQkmpgVBJ9GvMnqIjF8Mq0jPa+9IMx
	HeWHb6x5LSS5dfFdhvdHphUVPv/AHeKgr1GW/1fQtL331IU0R87TR9ZqcD7ceSIqZO7p+HID
	+e1Twlc1tCc6hr3Y2HG55pcdm/3MHZO8ZKrjrDhfmj0PPeHauWKP4yyVSU4cfFOr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275151>

On 07/24/2015 06:45 AM, David Turner wrote:
> This series is another chunk of the pluggable refs backend work.  The
> major reason it is listed as "PATCH/RFC" is beacuse it breaks
> t9300-fast-import.sh, because fast-import wants to create a ref called
> TEMP_TAG, which would now be a pseudoref.  The commit that introduces
> this test says that cvs2svn creates a tag called TAG_FIXUP "as a branch
> name for temporary work needed to cleanup the tree prior to creating
> an annotated tag object."
> 
> It appears that cvs2svn still does this.  So I'm not quite sure what to
> do about this particular case.
> 
> As we discussed earlier, the motivation for this series is that refs
> backends other than the files-based backend need to treat per-worktree
> refs (HEAD) and pseudorefs (FETCH_HEAD) differently from other refs;
> other refs are per-repo rather than per-worktree.

Sorry, I missed this email while on vacation.

cvs2git needs to create a temporary reference for cobbling together
tagged commits. Originally I was going to use the name `TAG_FIXUP`, as
suggested by git-fast-import(1) [1]. But that functionality turned out
to be buggy in `git fast-import` at the time. So I reported the bug but
changed cvs2git to use `refs/heads/TAG.FIXUP` [2]. The bug in `git
fast-import` was fixed, including the test case that you found, but I
never changed cvs2git back to using the originally-planned name. The
fact that the test case uses a name different than `TAG_FIXUP` probably
means that Shawn thought that any references named similarly should be
allowed.

Summary: support for a reference named `TAG_FIXUP` is not needed by
cvs2git. However, its use is a documented recommendation of `git
fast-import`, so it is quite possible that other importers are using
this name.

I expect that such importers would slightly prefer that this reference
be worktree-specific, but I doubt that anybody really cares that much.
It seems unlikely that people will run `git fast-import` in multiple
worktrees simultaneously.

Michael

[1] http://git-scm.com/docs/git-fast-import#_use_tag_fixup_branches
[2]
https://github.com/mhagger/cvs2svn/blob/master/cvs2svn_lib/git_output_option.py#L502-L509

-- 
Michael Haggerty
mhagger@alum.mit.edu
