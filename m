From: Ye Xiaolong <xiaolong.ye@intel.com>
Subject: Re: [PATCH v6 0/4] Add --base option to git-format-patch to record
 base tree info
Date: Wed, 27 Apr 2016 15:33:50 +0800
Message-ID: <20160427073350.GA30342@yexl-desktop>
References: <1461657084-9223-1-git-send-email-xiaolong.ye@intel.com>
 <CAGZ79kajpAtbHaKLaLHN5+qUOvBofFs-q-vUYWua49GWK7FO9Q@mail.gmail.com>
 <xmqqlh40gs9o.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZg3OpR8k45=q1m-g=t+aGGs8VDYBrBYaBU_DbfuuoBig@mail.gmail.com>
 <xmqqd1pcgr3s.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZNV+g3_Rmpynh-WQVc3dW6nuNDsTM=gTxNuJnr3V3Azg@mail.gmail.com>
 <xmqq4maogpsw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Fengguang Wu <fengguang.wu@intel.com>, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 09:35:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avK0I-0002sy-TY
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 09:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365AbcD0HfR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 03:35:17 -0400
Received: from mga01.intel.com ([192.55.52.88]:42976 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752348AbcD0HfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 03:35:16 -0400
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP; 27 Apr 2016 00:35:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,540,1455004800"; 
   d="scan'208";a="793282281"
Received: from yexl-desktop.sh.intel.com (HELO localhost) ([10.239.159.139])
  by orsmga003.jf.intel.com with ESMTP; 27 Apr 2016 00:34:57 -0700
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Fengguang Wu <fengguang.wu@intel.com>, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
Content-Disposition: inline
In-Reply-To: <xmqq4maogpsw.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292712>

On Tue, Apr 26, 2016 at 11:58:39AM -0700, Junio C Hamano wrote:
>Stefan Beller <sbeller@google.com> writes:
>
>>> So from where are you proposing Git to grab that information if you
>>> do not tell it?  "If the HEAD is detached, assume that the base is
>>> where it was detached from" or something?
>>
>> That would also work for me. In my first mail I was proposing to take
>> the information from the format-patch argument, such that a one off fix
>> would be:
>>
>>     (1) git checkout origin/master
>>     (2) EDIT
>>     (3) git commit -a -m "fix"
>>     (4) git format-patch origin/master..  # <- This is the information.
>>
>> However you read it as taking the information from the first line,
>> which is also fine with me, as then the (4) can become
>>
>>     (4a) git format-patch HEAD^

Thanks for the suggestion, I think this feature would definitely save
effort for end users and help to improve the usage rate of this "--base"
option.

If I understand it correctly, we should try to parse the "revision range"
specified in the fomat-patch cmdline if format.useAutoBase is set and we
couldn't find the remote-tracking branch, if its pattern matches something
like "<branchname>..<rev2>", we will try to get base commit from it:

  - If it is a remote branch, just set its head as base
  - If it isn't, try to set branchname@{u} as base

Please correct me if I'm wrong.

>
>Either would work, but reading from (4) feels a lot less black magic
>to me.
>
>>> If you are doing "format-patch master..my-branch", what do you
>>> propose to set your base to?  master@{u}, perhaps?
>>
>> Yes. (I usually use that command with |s|master|origin/master|, so the
>> argument is the upstream already. A local master branch does not exist for me.)
>
>Let's hear from folks at Intel ;-) Both of the above sounds like
>sensible enhancements to me.

Shall I squash these enhancements in this series, or I need to make
another patch for them?

Thanks,
Xiaolong
