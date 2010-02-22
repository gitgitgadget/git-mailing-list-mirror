From: =?UTF-8?B?IkFsZWphbmRybyBSLiBTZWRlw7FvIg==?= <asedeno@MIT.EDU>
Subject: Re: Storing (hidden) per-commit metadata
Date: Mon, 22 Feb 2010 17:13:34 -0500
Message-ID: <4B83018E.3020608@mit.edu>
References: <1266599485.29753.54.camel@ganieda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Jelmer Vernooij <jelmer@samba.org>
X-From: git-owner@vger.kernel.org Mon Feb 22 23:18:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njgc3-0003Wh-1s
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 23:18:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754602Ab0BVWSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 17:18:42 -0500
Received: from DMZ-MAILSEC-SCANNER-1.MIT.EDU ([18.9.25.12]:61334 "EHLO
	dmz-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754498Ab0BVWSl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Feb 2010 17:18:41 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Feb 2010 17:18:41 EST
X-AuditID: 1209190c-b7cfcae00000096b-01-4b8301940f24
Received: from mailhub-auth-2.mit.edu (MAILHUB-AUTH-2.MIT.EDU [18.7.62.36])
	by dmz-mailsec-scanner-1.mit.edu (Symantec Brightmail Gateway) with SMTP id D4.9D.02411.491038B4; Mon, 22 Feb 2010 17:13:40 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id o1MMDduD004343;
	Mon, 22 Feb 2010 17:13:40 -0500
Received: from darkmatter.mit.edu (DARKMATTER.MIT.EDU [18.238.2.175])
	(authenticated bits=0)
        (User authenticated as smtp/darkmatter.mit.edu@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o1MMDwC0016327
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Feb 2010 17:13:59 -0500 (EST)
Received: by darkmatter.mit.edu (Postfix, from userid 108)
	id 0626E14C010; Mon, 22 Feb 2010 17:13:38 -0500 (EST)
Received: from [18.238.2.136] (JABUN.MIT.EDU [18.238.2.136])
	by darkmatter.mit.edu (Postfix) with ESMTPSA id 95DC814C00F;
	Mon, 22 Feb 2010 17:13:37 -0500 (EST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
In-Reply-To: <1266599485.29753.54.camel@ganieda>
X-Enigmail-Version: 1.0.1
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140720>

On 02/19/2010 12:11 PM, Jelmer Vernooij wrote:
> To allow round-tripping pushes from Bazaar into Git, I'm looking for a
> good place to store Bazaar semantics that can not be represented in Git
> at the moment. This data should ideally be hidden from the user as much
> as possible; it would e.g. contain mappings from git hashes to Bazaar
> ids.

I've been having similar thoughts for git-svn, since I am working with a
very large svn repository that uses svn:keywords and svn:externals in a
few places. I've written some scripts to parse the git-svn
unhandled.log, but that does not propagate to other git clones of the
repo, and rebuilding the log is about as expensive as cloning the svn
repo again. Also, querying for externals is slow, presumably because
git-svn needs to talk to svn to fetch them.

So far, I have been leaning towards having an optional tree associated
with commits, in which metadata could be stored. This metadata tree
would be propagated by git clone, used by remote helper scripts, and be
quite ignorable if unneeded. The metadata tree would use sub-trees for
namespaces. For instance, a sub-tree called git-svn would contain the
revision map, externals, ignores, properties, etc.

This isn't fully thought out yet, and I'm not even sure if it would
work, or be backwards-compatible. However, since the topic came up, I
figured I should mention what I had so far.

Preemptive: No, I don't like svn:keywords, but I can't just ignore them.

Preemptive: Yes, I considered notes in a different GIT_NOTES_REF, but I
feel those are too loosely coupled to the commits. I could be wrong, and
have not completely dismissed them yet.

-Alejandro
