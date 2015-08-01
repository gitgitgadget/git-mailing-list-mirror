From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH/RFC 0/2] bisect per-worktree
Date: Sat, 01 Aug 2015 05:59:52 +0200
Message-ID: <55BC4438.8060709@alum.mit.edu>
References: <1438387012-29229-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	pclouds@gmail.com, chriscool@tuxfamily.org
X-From: git-owner@vger.kernel.org Sat Aug 01 06:00:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLNy7-0003Q8-AG
	for gcvg-git-2@plane.gmane.org; Sat, 01 Aug 2015 06:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbbHAEAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2015 00:00:11 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:49631 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750789AbbHAEAK (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Aug 2015 00:00:10 -0400
X-AuditID: 1207440c-f79e16d000002a6e-ff-55bc443ba843
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 62.55.10862.B344CB55; Fri, 31 Jul 2015 23:59:55 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB00E7.dip0.t-ipconnect.de [93.219.0.231])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t713xq4V000712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 31 Jul 2015 23:59:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <1438387012-29229-1-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42IRYndR1LV22RNqMOs6q8Wm5xOZLeZvOsFo
	0XWlm8mie8pbRgcWj52z7rJ7LH/wit1jwfP77B6fN8kFsERx2yQllpQFZ6bn6dslcGf8OfeK
	sWA6b8XOaxtYGhjvc3UxcnJICJhIzGz/zwZhi0lcuLceyObiEBK4zCgx8eUvRgjnHJPE/z9r
	GUGqeAW0JbZ3X2IGsVkEVCV+X+kFs9kEdCUW9TQzdTFycIgKBEm8fpkLUS4ocXLmExYQW0Sg
	VGL9nF9sICXCAgYSC64ygYSFBDwkJmxfxAwS5hTwlJh3WxskzCygJ7Hj+i9WCFteonnrbOYJ
	jPyzkAydhaRsFpKyBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0DfVyM0v0UlNKNzFCgpZn
	B+O3dTKHGAU4GJV4eH+w7AkVYk0sK67MPcQoycGkJMr7VwYoxJeUn1KZkVicEV9UmpNafIhR
	goNZSYQ3xRwox5uSWFmVWpQPk5LmYFES51Vdou4nJJCeWJKanZpakFoEk5Xh4FCS4M1yBmoU
	LEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB0VjfDEwHkFSPEB7lUDaeYsLEnOBohCt
	pxgVpcR5XUASAiCJjNI8uLGwVPSKURzoS2HeqU5AVTzANAbX/QpoMBPQ4L72HSCDSxIRUlIN
	jJN/XVwRxBhoGNf7PiD3/G+HujUbbl6Z9cn1tMC7F5bKdcdvxLTv0DkmU3n67zLm/K9mFpcE
	C3IW93xw8mpP748JVMtfEcPR9an+WUbaSScJ03KGh9b3Oy7s/RXyyNB/5lZ2JTEV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275104>

On 08/01/2015 01:56 AM, David Turner wrote:
> This is RFC because I'm not sure why show-ref only works on refs/ (and
> whether it should learn to look in worktree-refs/).  I'm also not sure
> whether there are other changes I should make to refs.c to handle
> per-worktree refs; I basically did the simplest thing I could think of
> to start with.

It seems to me that adding a new top-level "worktree-refs" directory is
pretty traumatic. Lots of people and tools will have made the assumption
that all "normal" references live under "refs/".

Each worktree has a name, right? What if worktree-specific refs were
stored under "refs/worktree/<name>/" or something? This would require
the name to be a valid reference name component, but I think that is a
prudent idea anyway.

Of course that doesn't answer the question: where should the refs for
the main repository go? I suppose either in the current place, or maybe
the main repository should have a name too (e.g. "main") and its
references should be stored under "refs/worktree/main/".

These worktree-specific refs should presumably be deleted automatically
when the worktree is deleted.

Either way, there's also the question of who should know how to find the
worktree-specific references--the program that wants to access them, or
should there be a secret invisible mapping that is done on lookup, and
that knows the full list of references that want to be worktree-specific
(for example, that in a linked worktree, "refs/bisect/*" should be
silently redirected to "refs/worktree/<name>/bisect/*")?

It's all a bit frightening, frankly.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
