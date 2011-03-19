From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3 (alternate)] gitweb: Mark "atnight" author/committer
 times also for 'localtime'
Date: Fri, 18 Mar 2011 18:25:39 -0700
Message-ID: <7vaagrsxyk.fsf@alter.siamese.dyndns.org>
References: <c8621826e0576e3e31240b0205e7e3d0@localhost>
 <201103181846.04979.jnareb@gmail.com>
 <7vmxksw3x8.fsf@alter.siamese.dyndns.org>
 <201103182328.19141.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Cernekee <cernekee@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 02:25:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0kvV-0003UZ-32
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 02:25:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757181Ab1CSBZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 21:25:52 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57847 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756600Ab1CSBZv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 21:25:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9DC64403D;
	Fri, 18 Mar 2011 21:27:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rYOBUEOW4Qa4YY+1siAlG8QRB/M=; b=PBdHZm
	b3Yq4LxN4oEfbUNjUh5Z0AY0MiYkAB6ch37M5MKUcWsZTe0ZeRV1YsOj8pyxcxGS
	GPWO3fKmCJZIxZrtBXYGM0VcSYe90NDDiBFRtUaRoCXH7L72D9KYNJfitNVwWqRy
	YSe7lLjrRL4qg8Sg7kn1UQ0Ibs62lfHQ6FDoY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hE0YSTF0hzEhVoelQaiQp0iZk2M0RL3y
	wjdoy/lEoRBRXJ1Knc5mIBixdp5Ka5ltQ/FZXs97TCLcQhERiHdj1+f5ljiJf+lp
	A1vrcCLh3DtGSR225s+C+WnXnguATy8UNADnV4hqGQDv3WDqHfvCV3Hmd5qEoe6o
	zVNXTfbNhak=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6BF254038;
	Fri, 18 Mar 2011 21:27:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 462F44030; Fri, 18 Mar 2011
 21:27:18 -0400 (EDT)
In-Reply-To: <201103182328.19141.jnareb@gmail.com> (Jakub Narebski's message
 of "Fri, 18 Mar 2011 23:28:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 09F6FF72-51C8-11E0-B948-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169383>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
> ...
>> and format_timestamp would be like
>> 
>> 	sub format_timestamp {
>> 		my %date = %$_[0];
>>       	my $use_localtime = $_[1];
>> 		my $localtime, $ret, $nite;
>> 
>> 		$nite = ($date{'hour_local'} < 6);
>> 
>> 		if ($use_localtime) {
>> 			$ret = $date{'rfc2822_local'};
>>       		if ($nite) {
>>                         	$ret = sprintf("<span class='atnight'>%s</span>", $ret);
>> 			}
>> 		} else {
>> 			... what the current format_local_time does to set
>> 	        	... including the spanning part
>>               	$ret = "$date{'rfc2822'} ($localtime)";
>> 		}
>> 		return $ret;
>> 	}
>
> Well, if we go this route, and assuming that parse_date does only parsing
> and we use separate subroutine for generating date in an rfc2822 format,
> then we could mark only time with "atnight" also when 'localtime' feature
> is enabled.
>  
>> Wouldn't it be much cleaner?  You can then clean up the other call site of
>> print_local_time in git_print_authorship using the same helper function
>> (presumably you would always pass 0 to $use_localtime there), no?
>
> Right.  Well, I'd have to think a bit about API for format_timestamp,
> but it looks like good direction.

I don't think there is much to think about for format_timestamp, as I was
suggesting to keep what comes in %date more or less the same as what the
current parse_date() generates.  I was only hinting that parse_date() is
misnamed.
