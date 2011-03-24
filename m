From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pathspec: reserve some letters after a colon pathspec
Date: Thu, 24 Mar 2011 07:46:57 -0700
Message-ID: <7vei5wa84e.fsf@alter.siamese.dyndns.org>
References: <bc49592f5e524a0d12aa55eeca1c5ca659b6525f.1298974647.git.git@drmicha.warpmail.net> <1300894353-19386-1-git-send-email-pclouds@gmail.com> <7vvcz9emrn.fsf@alter.siamese.dyndns.org> <4D8AEF9B.9050001@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 24 15:47:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2loj-00052i-Ux
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 15:47:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310Ab1CXOrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 10:47:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58561 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756953Ab1CXOrL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 10:47:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E9D5C45ED;
	Thu, 24 Mar 2011 10:48:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7tAB2pz6KRV6NgKsFtKW3QHByJE=; b=TBAN2z
	ZR0EkiNw2DdyE9jajDpuYVOat2M8KgSkIOZ9pXcpM2xp+Moach4BTXDgUvbwzCgt
	sHIBaQDOBZuSLwXMI+KsJjJkjmRuxEyebgHpSjzS3eWBaDtzjN/wVPWoQH5oOEJe
	5erKbyOVW/VPDxbfbTox9GtamFzCqH90pF4GE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jsVvZcO/GqdZxWjDRU7LKKIZ4nTrdUCE
	XvVZ1zLqrHj4nguvC+ALir4OzdpfB5a1FtDhflGxl/de6OblQpOpA87Lev5yqAT7
	y+TAfZZMgUaud9WSq48gH79QcyNKfi5SbLPLo0UPMhv4qDsmr8s6BpITXwsCsRjH
	AVILDgKanQo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B79A745EC;
	Thu, 24 Mar 2011 10:48:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6E17945EB; Thu, 24 Mar 2011
 10:48:40 -0400 (EDT)
In-Reply-To: <4D8AEF9B.9050001@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Thu, 24 Mar 2011 08:15:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D15230D0-5625-11E0-9B5E-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169919>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 23.03.2011 19:04:
> ...
>> Here is a weather-baloon.  I will use colon below as the magic introducer,
>> as I don't care very deeply about the choice of it.
>> 
>>  - "^:([^\w\d]+)(.*)$", that is "a magic introducer followed by a sequence
>>    of non-alnum followed by the remainder" means that the part that is
>>    given to the matching engine is $2, and each gibberish character in $1
>>    determines what magic is requested when the matching engine does its
>>    work.  Among the gibberish that can be in $1, we currently would want
>>    to support:
>> 
>>     . '/' denotes that $2 is relative to root of the working tree, i.e. do
>>       not add 'prefix' to it at the left.
>> 
>>     . '!' denotes that the matching with $2 should not honor globbing.
>> 
>>    e.g.
>> 
>>     ":/*lib/**/foo.h", if '*' denoted recursive glob support for '**/' to
>>     mean "zero-or-more levels of any directory" [*1*], it would find any
>>     foo.h in a directory 'lib' or its subdirectory that is found in
>>     anywhere in the working tree.
>> 
>>  - "^:((?:[-a-z]+)(?:,[-a-z+]+)*):(.*)$", that is "a magic introducer,
>>    followed by one or more alpha-string separated with comma, followed
>>    by a magic terminator, and the remainder" means that the remainder is
>>    what is given to the matching engine, and the alpha-strings spell out
>>    the name of the magic.  We currently would want to support:
>> 
>>     . 'full-tree' means exactly the same as '/' mnemonic above.
>>     . 'noglob' means exactly the same as '!' mnemonic.
>> 
>>    e.g.
>> 
>>    ":full-tree,recursive-glob:lib/**/foo.h" would be how you fully spell
>>    the above example in the mnemonic section [*2*].
>
> I like this a lot, especially the fact that we would have descriptive
> long names as well as short versions for a subset! Two remarks:
>
> :(symlink|submodule|directory|file): would fit into that scheme (for use
> in .gitattributes), though I'm not sure we want that for general
> pathspecs.

I do not offhand think it is a good idea.  While traversing history the
pathspec matcher often does not have the mode information extracted from
the tree object in the codepath it inspects the name, so it would be very
costly, I don't think it would particularly be useful, and pathspec is
about names and not about types.

A magic that says "please match case insensitively", so that we do not
have to write "git log -- '[Rr][Ee][Aa][Dd][Mm][Ee]'" would be very
useful.  Perhaps "gibberish" is not a good long term solution after all,
as a natural short-hand for that magic would be a single letter 'i'
somewhere, similar to (?i) in pcre.
