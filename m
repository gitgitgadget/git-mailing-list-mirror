From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 2/2] t1500-rev-parse: rewrite each test to run in
 isolation
Date: Sun, 17 Apr 2016 17:05:33 +0200
Message-ID: <5713A63D.3060200@kdbg.org>
References: <1460823230-45692-1-git-send-email-rappazzo@gmail.com>
 <1460823230-45692-3-git-send-email-rappazzo@gmail.com>
 <20160417055955.GA13384@flurp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
	szeder@ira.uka.de, peff@peff.net
To: Eric Sunshine <sunshine@sunshineco.com>,
	Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 17:06:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aroGu-0000wW-FB
	for gcvg-git-2@plane.gmane.org; Sun, 17 Apr 2016 17:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbcDQPFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2016 11:05:38 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:47246 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750831AbcDQPFh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2016 11:05:37 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3qnvjB4281z5tlN;
	Sun, 17 Apr 2016 17:05:34 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id AC02D5245;
	Sun, 17 Apr 2016 17:05:33 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <20160417055955.GA13384@flurp.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291761>

Am 17.04.2016 um 07:59 schrieb Eric Sunshine:
> On Sat, Apr 16, 2016 at 12:13:50PM -0400, Michael Rappazzo wrote:
>> +test_expect_success 'GIT_DIR=../.git, core.bare = false: prefix' '
>> +	mkdir work &&
>> +	test_when_finished "rm -rf work" &&
>> +	test_config -C "$(pwd)"/.git core.bare false &&
>> +	GIT_DIR=../.git test_stdout "" git -C work rev-parse --show-prefix >actual
>
> Drop the unnecessary '>actual' redirection.

Not only that: setting an environment variable in front of a shell 
function invocation keeps the variable's value in some (most?) shells. 
This occurs frequently in the new code. I don't know whether we have a 
shorter pattern than

	(
		GIT_DIR=../.git &&
		export GIT_DIR &&
		test_stdout "" git -C work rev-parse --show-prefix
	)

-- Hannes
