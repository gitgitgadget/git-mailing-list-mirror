From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Strange O(N^3) behavior in "git filter-branch"
Date: Wed, 03 Aug 2011 15:33:39 +0200
Message-ID: <4E394E33.4060107@alum.mit.edu>
References: <4E1E97C3.3030306@alum.mit.edu> <4E1EB5E9.1070902@alum.mit.edu> <4E200611.9010005@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 15:34:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qobab-0006yp-A3
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 15:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754790Ab1HCNeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 09:34:21 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:36718 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754625Ab1HCNeT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 09:34:19 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p73DXelK007571
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 3 Aug 2011 15:33:40 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.18) Gecko/20110617 Lightning/1.0b2 Thunderbird/3.1.11
In-Reply-To: <4E200611.9010005@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178572>

On 07/15/2011 11:19 AM, Michael Haggerty wrote:
> On 07/14/2011 11:24 AM, Michael Haggerty wrote:
>> On 07/14/2011 09:16 AM, Michael Haggerty wrote:
>>> I have noticed that "git filter-branch" gets pathologically slow when it
>>> operates on a repository that has many references in a complicated
>>> directory hierarchy.  The time seems to go like O(N^3), where N is the
>>> number of references being rewritten.
> [...]
> A many possible improvements come to mind, in increasing order of
> intrusiveness and generality:
> [...]
> 5. Organize the loose refs cache in memory as a tree, and only populate
> the parts of it that are accessed.  This should also speed up iteration
> through a subtree by avoiding a linear search through all loose references.

FYI: I am working on (5), namely storing a linked list of loose refs for
each directory and only populating those directories that are accessed.
 The directories themselves will be held in a tree/trie (AFAICT the
distinction is primarily whether each node holds its whole key or only
the part of the key relative to its parent, which is an implementation
detail).  As a bonus, the caches for submodules will be handled
correctly (they are currently never used).

It might be another week or so before I have patches ready.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
