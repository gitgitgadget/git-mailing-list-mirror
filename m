From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 11/15] daemon: report connection from root-process
Date: Sat, 16 Oct 2010 21:43:56 -0700
Message-ID: <7v8w1x5sz7.fsf@alter.siamese.dyndns.org>
References: <1286833829-5116-1-git-send-email-kusmabite@gmail.com>
 <1286833829-5116-12-git-send-email-kusmabite@gmail.com>
 <7vlj61hfe7.fsf@alter.siamese.dyndns.org>
 <AANLkTinXNPWaGj2BUaSOJypzv-Sqts-zEdG886oT2YJB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	avarab@gmail.com, sunshine@sunshineco.com
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Sun Oct 17 06:44:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7L6d-0003Vu-Nf
	for gcvg-git-2@lo.gmane.org; Sun, 17 Oct 2010 06:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290Ab0JQEoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Oct 2010 00:44:13 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64179 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154Ab0JQEoL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Oct 2010 00:44:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 36D51DFC29;
	Sun, 17 Oct 2010 00:44:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=FYQs59LCXjEZ6hFuPAn0y2FEU3Q=; b=RcXHMUEBmIa1gJdVGhV0GTm
	A1OjkvBNwNDQM9HSCL8V2TNqy5VaChEi3gvZkkj2vjPc6OFaHomBka/fzb8JYJeX
	+sKaAuMiQgJHmPgH/8d4EHGzln+lP/T/qJxjeVufywfXs3lDM5o9ulCoueiJL77h
	g4D+fgSII2jrp4WLN6t4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=orsvfbf1A3yVWYAAfqUjSvPwPn/f/upbWe4ct0j8zY9kOSlIE
	9DA1I+EgtoDnah5AHWIfdZ018IDB7eVAy9g1V99DDZGEbb7lRuBq1U95rM9meFsL
	9K/EGxjLQNBCjHouKudlWy32UYvQihOBEU4obuWwm9lLGqzfEeRDDiqkI0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B1D16DFC26;
	Sun, 17 Oct 2010 00:44:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97B19DFC24; Sun, 17 Oct
 2010 00:43:57 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2B802B56-D9A9-11DF-BB93-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159196>

Erik Faye-Lund <kusmabite@gmail.com> writes:

>> Hmm, loginfo() calls logreport() and adds the process information as
>> necessary to the output.  Wouldn't this patch give the pid information
>> twice?
>>
>
> Close, but not quite. logreport() reports the current PID, while this
> call to loginfo reports the PID of the child process. So two
> non-identical PIDs are reported.

I know that; I was questioning if that change to the log output is really
what we want.  I do not deeply care myself, but people with scripts that
read logs might.

>
> The output becomes something like this:
>
> [6408] [3868] Connection from [::1]:55801
> [3868] Extended attributes (16 bytes) exist <host=localhost>
> [3868] Request upload-pack for '/some-repo.git'
> [3868] '/some-repo.git' does not appear to be a git repository
> [6408] [1876] Connection from [::1]:57311
> [1876] Extended attributes (16 bytes) exist <host=localhost>
> [1876] Request upload-pack for '/some-repo.git'
> [1876] '/some-repo.git' does not appear to be a git repository
