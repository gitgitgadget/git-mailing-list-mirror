From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Make GIT_USE_LOOKUP default?
Date: Mon, 18 Mar 2013 10:08:11 -0700
Message-ID: <7vli9kocuc.fsf@alter.siamese.dyndns.org>
References: <CACsJy8AihriCDfN=cz7FjdHzZAhnPPGML_w8yWcVVrmTQLZyjw@mail.gmail.com>
 <7vd2uxrdh7.fsf@alter.siamese.dyndns.org>
 <20130318073229.GA5551@sigill.intra.peff.net>
 <7vtxo8ody3.fsf@alter.siamese.dyndns.org>
 <20130318164950.GA14844@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>, Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 18 18:09:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHdYN-0005jy-UH
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 18:08:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754325Ab3CRRIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 13:08:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54429 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751894Ab3CRRIO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 13:08:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ACA19A062;
	Mon, 18 Mar 2013 13:08:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NHyTVUAVr2Ag2llygldUcgY4DGg=; b=idSIvJ
	H4E+3DHqnYQICEvwzyzwOqDGsRDGitwTT6sKZUdvUXBINdm2PNjI4eoQu8N0pq+e
	otf4vpUk9ZVlFLqyocxyV/rENxgmTnfDIbZeTZtA/+lXETXlvoPxEAypm/h3bV1/
	9gKzScBjXVDHHFelrgnSXeyKbx9lTi7D8kjb0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JERG9zWd+T+MWlGD4VbtZSDMS2U6UqvG
	JKun5fi1ibFMSYG25Ggwf4SfU+xv4uO2Qz/Yf9DwoVYl9BT1G8x7TjVRqmK1Bpgz
	QKla5ABlg2iOedIvWXNPlFaeGEBpby3kBITS53D9oW/5rme5XDdZ3IEVL7Mr34x0
	uGRouicR684=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0A0EA060;
	Mon, 18 Mar 2013 13:08:13 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 065AFA05C; Mon, 18 Mar 2013
 13:08:12 -0400 (EDT)
In-Reply-To: <20130318164950.GA14844@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 18 Mar 2013 12:49:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6ABDE044-8FEE-11E2-9D14-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218431>

Jeff King <peff@peff.net> writes:

> On Mon, Mar 18, 2013 at 09:44:20AM -0700, Junio C Hamano wrote:
>
>> FWIW, I am getting something like this on my
>> 
>> $ grep 'model name' /proc/cpuinfo | uniq -c
>>   4 model name      : Intel(R) Core(TM)2 Quad  CPU   Q9450  @ 2.66GHz
>> 
>> The same "rev-list --objects --all >/dev/null", best of five:
>> 
>> [current master, compiled with -O2]
>> real    0m39.956s
>> user    0m39.562s
>> sys     0m0.396s
>> 
>> [revert 1a812f3 (i.e., go back to memcmp), -O2]
>> real    0m42.161s
>> user    0m41.879s
>> sys     0m0.284s
>> 
>> It could be that the difference may be how well memcmp() is
>> optimized, no?  My box runs Debian with libc6 2.11.3-4 and gcc
>> 4.4.5.
>
> Yeah, that would make sense. I have libc6 2.13-38 and gcc 4.7.2 (debian
> unstable).

Just for fun, here is a totally unrelated comparison, both with
current master, compiled with -O2 and running on the same box.

[without GIT_USE_LOOKUP]
real    0m39.906s
real    0m40.020s
real    0m40.022s
real    0m40.027s
real    0m40.146s

[with GIT_USE_LOOKUP]
real    0m40.336s
real    0m40.376s
real    0m40.452s
real    0m40.503s
real    0m40.572s

Maybe the Newton-Raphson is right as a concept (it does seem to
result in fewer minor-faults) but the current code is implemented
poorly and has a huge room for improvement?

[without GIT_USE_LOOKUP]
0inputs+0outputs (0major+182895minor)pagefaults 0swaps
0inputs+0outputs (0major+182920minor)pagefaults 0swaps
0inputs+0outputs (0major+183004minor)pagefaults 0swaps
0inputs+0outputs (0major+183006minor)pagefaults 0swaps
0inputs+0outputs (0major+183036minor)pagefaults 0swaps

[with GIT_USE_LOOKUP]
0inputs+0outputs (0major+182803minor)pagefaults 0swaps
0inputs+0outputs (0major+182886minor)pagefaults 0swaps
0inputs+0outputs (0major+182967minor)pagefaults 0swaps
0inputs+0outputs (0major+182997minor)pagefaults 0swaps
0inputs+0outputs (0major+182998minor)pagefaults 0swaps
