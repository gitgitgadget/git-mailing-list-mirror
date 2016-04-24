From: Ye Xiaolong <xiaolong.ye@intel.com>
Subject: Re: [PATCH v5 2/4] format-patch: add '--base' option to record base
 tree info
Date: Sun, 24 Apr 2016 11:05:47 +0800
Message-ID: <20160424030547.GA31188@yexl-desktop>
References: <1461303756-25975-1-git-send-email-xiaolong.ye@intel.com>
 <1461303756-25975-3-git-send-email-xiaolong.ye@intel.com>
 <xmqqshydnx0v.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, fengguang.wu@intel.com, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 24 05:07:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auAO1-0005c7-Cb
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 05:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752605AbcDXDG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2016 23:06:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:63558 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752600AbcDXDGz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2016 23:06:55 -0400
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP; 23 Apr 2016 20:06:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,525,1455004800"; 
   d="scan'208";a="938898790"
Received: from yexl-desktop.sh.intel.com (HELO localhost) ([10.239.159.139])
  by orsmga001.jf.intel.com with ESMTP; 23 Apr 2016 20:06:51 -0700
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	fengguang.wu@intel.com, ying.huang@intel.com, philip.li@intel.com,
	julie.du@intel.com
Content-Disposition: inline
In-Reply-To: <xmqqshydnx0v.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292309>

On Fri, Apr 22, 2016 at 02:39:28PM -0700, Junio C Hamano wrote:
>Xiaolong Ye <xiaolong.ye@intel.com> writes:
>
>> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
>> index eed2981..a6ce727 100755
>> --- a/t/t4014-format-patch.sh
>> +++ b/t/t4014-format-patch.sh
>> @@ -1460,4 +1460,19 @@ test_expect_success 'format-patch -o overrides format.outputDirectory' '
>>  	test_path_is_dir patchset
>>  '
>>  
>> +test_expect_success 'format-patch --base' '
>> +	git checkout side &&
>> +	git format-patch --stdout --base=HEAD~~~ -1 >patch &&
>> +	grep -e "^base-commit:" -A3 patch >actual &&
>> +	echo "base-commit: $(git rev-parse HEAD~~~)" >expected &&
>
>HEAD~3 would be easier to read (and HEAD~2 is easier than HEAD~~).
>
>> +	echo "prerequisite-patch-id: $(git show --patch HEAD~~ | git patch-id --stable | awk "{print \$1}")" >>expected &&
>> +	echo "prerequisite-patch-id: $(git show --patch HEAD~ | git patch-id --stable | awk "{print \$1}")" >>expected &&
>> +	test_cmp expected actual
>> +'
>> +
>> +test_expect_success 'format-patch --base error handling' '
>> +	! git format-patch --base=HEAD~ -2 &&
>> +	! git format-patch --base=HEAD~ -3
>> +'
>
>When making sure that "git" exits with a failure in a controlled way
>(i.e. you want to consider "git" that segfaults as not passing the
>test), do not use "! git cmd", but use "test_must_fail git cmd"
>instead.

Thanks for the reminder, I misunderstood the guide in t/README before.

>
>You now have a quite elaborate logic in base validation in this
>rounhd.  Is the topology of the history used in this test still
>complex enough to make sure the logic is being tested?

I'll try to set up more complex topology of the history for the
testcase.

Thanks,
Xiaolong.
