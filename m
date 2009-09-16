From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [RFC/PATCH v2] fetch: Speed up fetch by rewriting
 find_non_local_tags
Date: Thu, 17 Sep 2009 00:46:02 +0100 (BST)
Message-ID: <alpine.LNX.2.00.0909170039410.14993@reaper.quantumfyre.co.uk>
References: <20090916074737.58044.42776.julian@quantumfyre.co.uk> <7vbplb2pi7.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.00.0909162141140.13697@reaper.quantumfyre.co.uk> <20090916225350.45746.85139.julian@quantumfyre.co.uk>
 <7veiq6wkfu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 01:48:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mo4EN-0005Zw-9a
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 01:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760345AbZIPXsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 19:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760316AbZIPXsA
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 19:48:00 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:36475 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755047AbZIPXr7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Sep 2009 19:47:59 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 75EB5E8914
	for <git@vger.kernel.org>; Thu, 17 Sep 2009 00:48:02 +0100 (BST)
Received: (qmail 20166 invoked by uid 103); 17 Sep 2009 00:46:02 +0100
Received: from reaper.quantumfyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.94.2/9808. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.025801 secs); 16 Sep 2009 23:46:02 -0000
Received: from reaper.quantumfyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 17 Sep 2009 00:46:02 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <7veiq6wkfu.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128698>

On Wed, 16 Sep 2009, Junio C Hamano wrote:

> Julian Phillips <julian@quantumfyre.co.uk> writes:
>
>> When trying to get a list of remote tags to see if we need to fetch
>> any we were doing a linear search for the matching tag ref for the
>> tag^{} commit entries.  This proves to be incredibly slow for large
>> numbers of tags.  Rewrite the function so that we can do lookup in
>> string_lists instead.
>>
>> For a repository with 50000 tags (and just a single commit on a single
>> branch), a fetch that does nothing goes from ~ 1m50s to ~4.2s.
>>
>> Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
>> ---
>>
>> Not only does this not require a custom hash table, it is also slightly
>> faster than the last version (~4.2s vs ~4.5s).
>
> I am just curious.  How would a "just one item lookbehind" code perform
> compared to this one?

The code you wrote ealier is almost the same as the string_list version, 
~4.3s, so very marginally slower but a lot less code change.  Personally 
I'd be happy with any of the three, so long as I don't have to wait 30s to 
find out that nothing's happened at $dayjob anymore ;)

-- 
Julian

  ---
QOTD:
 	If it's too loud, you're too old.
