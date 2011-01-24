From: Shuang He <shuang.he@intel.com>
Subject: Re: [RFC] Add bad-branch-first option for git-bisect
Date: Mon, 24 Jan 2011 19:05:09 +0800
Message-ID: <4D3D5CE5.4050108@intel.com>
References: <4D3CDDF9.6080405@intel.com> <AANLkTimUkv9+g_+wFcyGhwMjE9zYAKjMn32GL-WOVmoe@mail.gmail.com> <4D3D54D3.7040801@intel.com> <4D3D5989.50903@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"apenwarr@gmail.com" <apenwarr@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jan 24 12:05:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhKEz-0007SR-Rz
	for gcvg-git-2@lo.gmane.org; Mon, 24 Jan 2011 12:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913Ab1AXLFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jan 2011 06:05:20 -0500
Received: from mga03.intel.com ([143.182.124.21]:42746 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751526Ab1AXLFT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jan 2011 06:05:19 -0500
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101.ch.intel.com with ESMTP; 24 Jan 2011 03:05:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.60,369,1291622400"; 
   d="scan'208";a="379010430"
Received: from she4-mobl3.ccr.corp.intel.com (HELO [10.254.208.56]) ([10.254.208.56])
  by azsmga001.ch.intel.com with ESMTP; 24 Jan 2011 03:05:13 -0800
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <4D3D5989.50903@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165447>

On 2011/1/24 18:50, Johannes Sixt wrote:
> Am 1/24/2011 11:30, schrieb Shuang He:
>> It's recursively applying bad branch first algorithm, not just constantly
>> stick to first parent.
>> Given this condition:
>>      A ->  B ->  C ->  D ->  E ->  F ->  G ->  H   (master)
>>           \ a  ->  b ->  c ->  d ->  e /  (feature 1)
>>                \ x ->  y ->  z/      (feature 2)
>> start with H as bad commit, and A as good commit, if y is the target bad
>> commit. bad-branch-first algorithm will do it like this:
>>      1. In first round stick to master branch, so it will locate G as first
>> bad commit
>>      2. In second round stick to feature1 branch, then it will locate d as
>> first bad commit
>>      3. In third round stick to feature2 branch, then it will finally
>> locate y as first bad commit
>> So you could see, it's always sticking to branch where current bad commit sit
> Ok, so you explain what your algorithm does.
>
> But you did not illustrate your problem. The history above is ordinary,
> somewhat branchy, has *ONE* commit that introduces a regression, and *NO*
> commit that fixes the regression. But in your rationale you said something
> about "feature1 is fixed just a moment later after feature2 branch is
> created". How does this fit into the picture, where is the problem, and
> how does your algorithm solve it?
>
> -- Hannes

If A is bad commit, and C fixed it, and then F is bad again,

A ->  B ->  C ->  D ->  E ->  F ->  G ->  H   (master)
   \                    \      /
     a  ->  b... c ->  d ->  e->f  (feature 1)

Start with H as bad commit, and D as good commit, it's possible git-bisect would jump to c, and it will lead to wrong direction

If bad-branch-first is used, it would be:
1. first round found F
2. end

Thanks
	--Shuang

Thanks
	--Shuang
