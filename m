From: Ye Xiaolong <xiaolong.ye@intel.com>
Subject: Re: [PATCH v5 2/4] format-patch: add '--base' option to record base
 tree info
Date: Sun, 24 Apr 2016 12:36:14 +0800
Message-ID: <20160424043614.GC1258@yexl-desktop>
References: <1461303756-25975-1-git-send-email-xiaolong.ye@intel.com>
 <1461303756-25975-3-git-send-email-xiaolong.ye@intel.com>
 <xmqqfuudnw35.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, fengguang.wu@intel.com, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 24 06:37:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auBnQ-00087t-Gc
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 06:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbcDXEhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 00:37:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:25349 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750711AbcDXEhU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 00:37:20 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP; 23 Apr 2016 21:37:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,525,1455004800"; 
   d="scan'208";a="965247140"
Received: from yexl-desktop.sh.intel.com (HELO localhost) ([10.239.159.139])
  by fmsmga002.fm.intel.com with ESMTP; 23 Apr 2016 21:37:17 -0700
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	fengguang.wu@intel.com, ying.huang@intel.com, philip.li@intel.com,
	julie.du@intel.com
Content-Disposition: inline
In-Reply-To: <xmqqfuudnw35.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292313>

On Fri, Apr 22, 2016 at 02:59:42PM -0700, Junio C Hamano wrote:
>Xiaolong Ye <xiaolong.ye@intel.com> writes:
>
>> +test_expect_success 'format-patch --base' '
>> +	git checkout side &&
>> +	git format-patch --stdout --base=HEAD~~~ -1 >patch &&
>> +	grep -e "^base-commit:" -A3 patch >actual &&
>
>The -A3 is GNUism.  To do this portably, perhaps you can do
>
>	sed -n -e "/^base-commit:/,+3p"
>
>or something like that.
>
>But more importantly, grabbing 3 lines (and always 3 lines) will not
>catch a future bug that somebody else may introduce to this code
>that shows extra "prerequisite-patch-id:" after them.

I'll try to improve the testcase to make it more sensible.

Thanks,
Xiaolong
>
>> +	echo "base-commit: $(git rev-parse HEAD~~~)" >expected &&
>> +	echo "prerequisite-patch-id: $(git show --patch HEAD~~ | git patch-id --stable | awk "{print \$1}")" >>expected &&
>> +	echo "prerequisite-patch-id: $(git show --patch HEAD~ | git patch-id --stable | awk "{print \$1}")" >>expected &&
>> +	test_cmp expected actual
>> +'
