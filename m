From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/14] t7800-difftool.sh: Fix a test failure on Cygwin
Date: Fri, 17 Dec 2010 11:59:16 -0800
Message-ID: <7vwrn8i31n.fsf@alter.siamese.dyndns.org>
References: <4D07B724.8000901@ramsay1.demon.co.uk>
 <20101217023357.GA30083@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 17 20:59:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTgSl-0000Wc-BR
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 20:59:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754764Ab0LQT73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Dec 2010 14:59:29 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53497 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538Ab0LQT73 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Dec 2010 14:59:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4834C3094;
	Fri, 17 Dec 2010 14:59:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5kYIMq71s9CQTAwAI9BCwclba60=; b=uzJ3SH
	YSkpGOhR1CxEw3LI8T6cDZncMUxkORB00W/vfBJAxUK8eZUQ3rbCJnWWP3oXclMa
	ENt1yX3G37XCaHdMnemJl3kWedbxeVsqvgwA5T6pUs+9gcTpexFBMlK2j7CrQ5j4
	riA9/1UdVzBR4CykhNOhfJS7PTES8DdG4J3rw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dUncuFSBGAIHxRmdFPjcF9sueG/bjtc+
	OkRV3aa+kPz7IGUFr8UVvWJJtHt4h157hjRZFnZi/6nMs6xGaDLVO16wxEzIRjMU
	OvXZMsIK1fdeuHToBxNZEw8ut0OJ8zLQJTLQM2q/MUoMnUZMhzxiFVmVLHMDmcKS
	JNFcZZy8KKQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 149633091;
	Fri, 17 Dec 2010 14:59:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B95383090; Fri, 17 Dec 2010
 14:59:45 -0500 (EST)
In-Reply-To: <20101217023357.GA30083@gmail.com> (David Aguilar's message of
 "Thu\, 16 Dec 2010 18\:33\:59 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 35442166-0A18-11E0-B390-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163885>

David Aguilar <davvid@gmail.com> writes:

>> diff --git a/git-difftool.perl b/git-difftool.perl
>> index e95e4ad..ced1615 100755
>> --- a/git-difftool.perl
>> +++ b/git-difftool.perl
>> @@ -52,6 +52,7 @@ sub generate_command
>>  	my @command = (exe('git'), 'diff');
>>  	my $skip_next = 0;
>>  	my $idx = -1;
>> +	my $prompt = '';
>
> Would it be simpler to set $prompt = 1 and then
> flip it to 0 when -y | or --no-prompt is supplied?
> ...
>
> This would become:
>
> 	if ($prompt) {
> 		...
> 	}
> 	else {
> 		...
> 	}

But that is not what the patch does, is it?

Isn't it more like initializing $prompt to undef and then the above
condition becomes:

	if (!defined $prompt) {
        	; # nothing
        elsif ($prompt) {
		setenv PROMPT true
	} else {
		setenv NO_PROMPT true
	}

no?
