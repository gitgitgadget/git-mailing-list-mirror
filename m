X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [StGIT PATCH] Bash snippet to show branch and patch in bash
 prompt
Date: Mon, 30 Oct 2006 10:24:50 +0000
Message-ID: <tnxlkmy2j9p.fsf@arm.com>
References: <20061029233745.24899.1470.stgit@lathund.dewire.com>
	<4545CC6F.90001@tromer.org>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 30 Oct 2006 10:25:38 +0000 (UTC)
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <4545CC6F.90001@tromer.org> (Eran Tromer's message of "Mon, 30
 Oct 2006 11:57:03 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 30 Oct 2006 10:24:52.0502 (UTC) FILETIME=[A2EF8B60:01C6FC0D]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30492>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeUKZ-0003y3-Ma for gcvg-git@gmane.org; Mon, 30 Oct
 2006 11:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161203AbWJ3KZS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 05:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161208AbWJ3KZR
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 05:25:17 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:32244 "EHLO
 cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP id
 S1161203AbWJ3KZQ (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006
 05:25:16 -0500
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.255.63]) by
 cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id k9UAOqQb009163;
 Mon, 30 Oct 2006 10:24:52 GMT
Received: from localhost.localdomain ([10.1.255.211]) by
 cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0); Mon, 30 Oct 2006
 10:24:52 +0000
To: Eran Tromer <git2eran@tromer.org>
Sender: git-owner@vger.kernel.org

Eran Tromer <git2eran@tromer.org> wrote:
> On 2006-10-30 01:37, Robin Rosenberg wrote:
>> +# include this in your bashrc or copy to /etc/bash_completions.d
>> +
>> +if [ "$PS1" ]; then
>> +    # trap 'PS1="\u@\h [$(stg top)] \w]\$ "' DEBUG
>> +    function stgtag
>> +    {
>> +	br=$(stg branch 2>/dev/null)
>> +	top=$(stg top 2>/dev/null)
>> +	if [[ -n "$br$top" ]];then
>> +	    echo "[$top@$br]"
>> +	    return
>> +	fi
>> +    }
>> +    PS1='\u@\h$(stgtag)\w\$ '
>> +
>> +fi
>
> That's an annoying 430ms delay at every prompt, on my box. Does StGIT do
> something expensive on every invocation?

Well, there are some forks. For every "stg" command, "git-symbolic-ref
HEAD" and "git-rev-parse --git-dir" are invoked to get the name of the
main branch and the .git directory. There is also the delay of
invoking python and loading the command modules in main.py (maybe I
should modify this to import the modules on demand, based on what
command was given).

Since the repository format is stable, you could use something like
this (it should be faster):

git_dir=$(git-rev-parse --git-dir 2> /dev/null)
ref=$(git-symbolic-ref HEAD 2> /dev/null)
br=${ref##*/}
top=$(cat $git_dir/patches/$br/current)

-- 
