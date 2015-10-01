From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH] clone --dissociate: avoid locking pack files
Date: Thu, 1 Oct 2015 07:39:36 +0300
Message-ID: <20151001043936.GB26154@wheezy.local>
References: <682991036f1e8e974ed8ecd7d20dbcc6fb86c344.1443469464.git.johannes.schindelin@gmx.de>
 <20150930192814.GA26154@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 01 06:39:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhVek-0004Lp-TA
	for gcvg-git-2@plane.gmane.org; Thu, 01 Oct 2015 06:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbbJAEjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2015 00:39:43 -0400
Received: from p3plsmtpa08-07.prod.phx3.secureserver.net ([173.201.193.108]:52598
	"EHLO p3plsmtpa08-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750834AbbJAEjm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Oct 2015 00:39:42 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa08-07.prod.phx3.secureserver.net with 
	id Pgfd1r00E5B68XE01gfg07; Wed, 30 Sep 2015 21:39:41 -0700
Content-Disposition: inline
In-Reply-To: <20150930192814.GA26154@wheezy.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278886>

On Wed, Sep 30, 2015 at 10:28:14PM +0300, Max Kirillov wrote:
> On Mon, Sep 28, 2015 at 09:44:57PM +0200, Johannes Schindelin wrote:
>> -	if (option_dissociate)
>> +	if (option_dissociate) {
>> +		struct packed_git *p;
>> +
>> +		for (p = packed_git; p; p = p->next) {
>> +			close_pack_windows(p);
>> +			close_pack_index(p);
>> +		}
>>  		dissociate_from_references();
>> +	}

> This does not seem to close handles to the pack files
> themseves, does Windows still allow removing the files? I
> probably did not tried that, because I started from handles,
> and discovered mapped files only later.

Apparently, pack file is closed just after mapping if it's
smaller than core.packedGitWindowSize. Could it be the
reason that this patch worked in you test case?

-- 
Max
